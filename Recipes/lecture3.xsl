<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:template match="/collection">
		<html>
			<head>
				<title><xsl:value-of select="description"/></title>
			</head>
			<body>
				<h1><xsl:value-of select="description"/></h1>
				
				<!-- tabel of contents -->
				<h2>Table of Contents</h2>
				<ul>
					<xsl:apply-templates select="recipe" mode="toc"/>					
				</ul>
				
				<!-- detail for each recipe -->
				<xsl:apply-templates select="recipe" mode="detail"/>
				
				<!-- index of ingredients -->
				<h2>Index of Ingredients</h2>
				<ol>
					<xsl:for-each select="//ingredient">
					<xsl:sort select="@name"/>
						<li><xsl:value-of select="@name"/></li>
					</xsl:for-each>
				</ol>
			</body>
		</html>
	</xsl:template>
	
	
	<xsl:template match="recipe" mode="toc">
		<li><a href="#{generate-id()}"><xsl:value-of select="title"/></a></li>
	</xsl:template>
	
	
	<xsl:template match="recipe" mode="detail">
		<hr/>
		
		<h2 id="{generate-id()}"><xsl:value-of select="title"></xsl:value-of></h2>
		
		<xsl:if test="@author-id">
			<p xml:space="preserve">Author:
				<xsl:value-of select="id(@author-id)/@title"/>
				<xsl:value-of select="id(@author-id)/text()"/>
			</p>
		</xsl:if>
		
		<img src="{image}" height="320"/>
		
		<h3>Ingredients</h3>
		<table>
			<thead>
				<tr>
					<th>amount</th>
					<th>unit</th>
					<th>ingredient</th>
				</tr>
			</thead>
			<tbody>
				<xsl:apply-templates select="ingredient"/>
			</tbody>
		</table>
		
		<h3>Preparation</h3>
		<ol>
			<xsl:for-each select="preparation/step">
				<li><xsl:value-of select="."/></li>
			</xsl:for-each>
		</ol>
		
	</xsl:template>
	
	
	<xsl:template match="ingredient">
		<tr>
			<td><xsl:value-of select="@amount"/></td>
			<td><xsl:value-of select="@unit"/></td>
			<td><xsl:value-of select="@name"/></td>
		</tr>
	</xsl:template>
	
</xsl:stylesheet>