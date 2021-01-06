<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:template match="/">
		<html>
			<head>
				<title><xsl:value-of select="collection/description"/></title>
			</head>
			<body>
				<h1><xsl:value-of select="collection/description"/></h1>
				
				<h2>Table of Contents</h2>
				<ol>
					<xsl:apply-templates select="collection/recipe" mode="toc"/>
				</ol>
				
				<xsl:apply-templates select="collection/recipe" mode="detail"/>

				
				<h2>Index of Ingredients</h2>
				<table>
					<xsl:for-each select="collection/recipe/ingredient">
						<xsl:sort select="@name"/>
						<tr>
							<td><a href="#{generate-id()}"><xsl:value-of select="@name"/></a></td>
						</tr>
					</xsl:for-each>
				</table>
				
			</body>
		</html>
	</xsl:template>
	
	
	<xsl:template match="recipe" mode="toc">
		<li><a href="#{generate-id()}"><xsl:value-of select="title"/></a></li>
	</xsl:template>
	
	
	<xsl:template match="recipe" mode="detail">
		<h2 id="{generate-id()}"><xsl:value-of select="title"/></h2>
		
		<xsl:if test="@author-id">
			<p xml:space="preserve">by
			 	<xsl:value-of select="id(@author-id)/@title"/>
			 	<xsl:value-of select="id(@author-id)"/>
			</p>
		</xsl:if>
		
		<img src="{image}" width="50%"/>
		
		<h3>Ingredients</h3>
		<ul>
			<xsl:for-each select="ingredient">
                <li id="{generate-id()}" xml:space="preserve">
             		<xsl:value-of select="@amount"/>
					<xsl:value-of select="@unit"/>
					<xsl:value-of select="@name"/>
				</li>
			</xsl:for-each>
		</ul>
		
		<h3>Preparation</h3>
		<xsl:apply-templates select="preparation"/>
	</xsl:template>
	
	
	<xsl:template match="preparation">
		<ol>
			<xsl:for-each select="step">
				<li><xsl:value-of select="."/></li>
			</xsl:for-each>
		</ol>				
	</xsl:template>
	
</xsl:stylesheet>