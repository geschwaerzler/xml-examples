<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:output method="html"/>


	<xsl:template match="/collection">
		<html>
			<head>
				<title><xsl:value-of select="description"/></title>
			</head>
			<body>
				<h1><xsl:value-of select="description"/></h1>
				
				<h2>Table of Contents</h2>
				
				<!-- iterative Lösung -->
				<ol>
					<xsl:for-each select="recipe">
						<li><a href="#{generate-id()}"><xsl:value-of select="title"/></a></li>					
					</xsl:for-each>
				</ol>
				
				<!-- Lösung mit subtemplate -->
				<ol>
					<xsl:apply-templates select="recipe" mode="table-of-contents"/>
				</ol>
				
				<!-- Details der Rezepte -->
				<xsl:apply-templates select="recipe" mode="detail"/>
				
				<!-- Index -->
				<hr/>
				
				<h2>Index of Ingredients</h2>
				<xsl:for-each select="//ingredient" xml:space="preserve">
					<xsl:sort select="upper-case(@name)"/>
					<p>
						<a href="#{generate-id()}"><xsl:value-of select="@name"/></a>
						<xsl:value-of select="ancestor::recipe/title"/>
					</p>
				</xsl:for-each>
				
			</body>
		</html>
	</xsl:template>
	
	<xsl:template name="ingredient-list" xml:space="preserve">
		<xsl:param name="list"/>
		
		<xsl:for-each select="$list">
			<xsl:choose>
				<xsl:when test="not(./*)">
					<p id="{generate-id()}">
						<i>
							<xsl:value-of select="@amount"/>
							<xsl:value-of select="@unit"/>
						</i>
						<xsl:value-of select="@name"/>
					</p>
				</xsl:when>
				<xsl:otherwise>
					<h4 id="{generate-id()}"><xsl:value-of select="@name"/></h4>
					
					<xsl:call-template name="ingredient-list">
						<xsl:with-param name="list" select="ingredient"/>
					</xsl:call-template>
					
					<h4>Preparation of <xsl:value-of select="@name"/></h4>
					<ol>
						<xsl:apply-templates select="preparation/step"/>
					</ol>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:for-each>
	</xsl:template>
	
	
	<xsl:template match="recipe" mode="table-of-contents">
		<li><xsl:value-of select="title"/></li>					
	</xsl:template>
	
	
	<xsl:template match="recipe" mode="detail" xml:space="preserve">
		<hr/>
		
		<h2 id="{generate-id()}"><xsl:value-of select="title"/></h2>
		
		<xsl:if test="@author-id">
			<xsl:value-of select="id(@author-id)/@title"/>
			<xsl:value-of select="id(@author-id)/text()"/>
		</xsl:if>
		
		<h3>Ingredients</h3>
		<xsl:call-template name="ingredient-list">
			<xsl:with-param name="list" select="ingredient"/>
		</xsl:call-template>
		
		<h3>Preparation</h3>
		<ol>
			<xsl:apply-templates select="preparation/step"/>
		</ol>
		
	</xsl:template>
	
	
	<xsl:template match="step">
		<li><xsl:value-of select="."/></li>
	</xsl:template>
	
	
	
</xsl:stylesheet>