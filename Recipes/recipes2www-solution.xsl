<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<!-- Root Template
		Produces the html skeleton, applies/calls additional tempplates and produces the index.
	-->
	<xsl:template match="/">
		<html>
			<head>
				<title><xsl:value-of select="collection/description"/></title>
				
				<!-- some minimal css styling -->
				<style>
					p.ingredient {
						margin-top: 2px;
						margin-bottom: 2px;
					}
					span.amount {
						font-style: italic;
						color: grey;
					}
					h1 {font-size: 240%; }
					h2 {font-size: 200%; }
					h3 {font-size: 160%; }
					h4 {font-size: 140%; }
					h5 {font-size: 120%; }
					h6 {font-size: 100%; }
				</style>
			</head>
			
			<body>
				<h1><xsl:value-of select="collection/description"/></h1>
				
				<h2>Table of Contents</h2>
				<ol>
					<!-- The expression 'collection/recipe' return all 5 recipes of the collection.
					This results in the application of the recipe template 5 times: once for each recipe. -->
					<xsl:apply-templates select="collection/recipe" mode="toc"/>
				</ol>
				
				<!-- we have two templates that match recipe-elements. By using 'mode',
				we can control with template will be used. -->
				<xsl:apply-templates select="collection/recipe" mode="detail"/>

				
				<h2>Index of Ingredients</h2>
				<table>
					<!-- The expression '//ingredient' will return all ingredient-elements,
					regardless of the nesting. -->
					<xsl:for-each select="//ingredient" xml:space="preserve">
						<!-- sorting without the upper-case function would result in
						all lower-case ingredients to be placed befor the upper-case one. -->
						<xsl:sort select="@name"/>
						<tr>
							<td>
								<a href="#{generate-id()}"><xsl:value-of select="@name"/></a>
								<i>in: <xsl:value-of select="ancestor::recipe/title"/></i>
							</td>
						</tr>
					</xsl:for-each>
				</table>
				
			</body>
		</html>
	</xsl:template>
	
	<!-- Produce a list-item in the table of contents of recipes. -->
	<xsl:template match="recipe" mode="toc">
		<li><a href="#{generate-id()}"><xsl:value-of select="title"/></a></li>
	</xsl:template>
	
	<!-- Produce the detailed presentation of a recipe. -->
	<xsl:template match="recipe" mode="detail">
		<hr/>
		
		<h2 id="{generate-id()}"><xsl:value-of select="title"/></h2>
		
		<xsl:if test="@author-id">
			<p xml:space="preserve">by
			 	<xsl:value-of select="id(@author-id)/@title"/>
			 	<xsl:value-of select="id(@author-id)"/>
			</p>
		</xsl:if>
		
		<img src="{image}" width="50%"/>
		
		<h3>Ingredients</h3>
		<xsl:call-template name="ingredient-list">
			<xsl:with-param name="ingredients" select="ingredient"/>
			<xsl:with-param name="header-level" select="4"/>
		</xsl:call-template>
		
		<h3>Preparation</h3>
		<xsl:apply-templates select="preparation"/>
	</xsl:template>
	
	<!-- Produce a list of ingredients. -->
	<xsl:template name="ingredient-list">
        <xsl:param name="ingredients"/>  <!-- a list of ingredient elelemts -->
        <xsl:param name="header-level"/> <!-- header level to be used for recursive calls -->
		
		<xsl:for-each select="ingredient">
			
			<xsl:choose>
				<xsl:when test="./*"> <!-- the test './*' is true, if the current node '.' has child elements. -->
					<!-- generate a html header tag h4 or h5 or ... -->
					<xsl:element name="h{$header-level}">
						<xsl:attribute name="id" select="generate-id()"/>
						<xsl:value-of select="@name"/>
					</xsl:element>
					<!-- recursive call to produce the list of ingrediens of this ingredient -->
					<xsl:call-template name="ingredient-list">
						<xsl:with-param name="ingredients" select="ingredient"/>
						<xsl:with-param name="header-level" select="$header-level+1"/>
					</xsl:call-template>
					<xsl:if test="preparation">
						<p><i>Preparation of <xsl:value-of select="@name"/></i></p>
						<xsl:apply-templates select="preparation"/>
					</xsl:if>
				</xsl:when>
				<xsl:otherwise>
					<!-- this template will be used in the non-recursive case -->
					<p id="{generate-id()}" class="ingredient" xml:space="preserve">
						<span class="amount">
							<xsl:value-of select="@amount"/>
							<xsl:value-of select="@unit"/>
						</span>
						<xsl:value-of select="@name"/>
					</p>
				</xsl:otherwise>
			</xsl:choose>
			
		</xsl:for-each>
		
	</xsl:template>
	
	<!-- Generate a numbered list of preparation steps. -->
	<xsl:template match="preparation">
		<ol>
			<xsl:for-each select="step">
				<li><xsl:value-of select="."/></li>
			</xsl:for-each>
		</ol>				
	</xsl:template>


</xsl:stylesheet>