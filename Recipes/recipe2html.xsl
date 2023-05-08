<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:output method="html"/>
	
	<xsl:template match="/collection">
		<html>
			<head>
				<title><xsl:value-of select="description" /></title>
			</head>
			<body>
				<h1><xsl:value-of select="description" /></h1>
				
				<h2>Table of Contents</h2>
				<ul>
					<xsl:apply-templates select="recipe" mode="toc"/>
					<li><a href="#index">Index of Ingredients</a></li>
				</ul>
				
				<xsl:apply-templates select="recipe" mode="detail"/>
				
				<h2 id="index">Index of Ingredients</h2>
				<table>
					<thead>
						<tr>
							<th>Ingredient</th>
							<th>Recipe</th>
						</tr>
					</thead>
					<tbody>
						<xsl:for-each select="//ingredient">
							<xsl:sort select="@name"/>
							<xsl:variable name="r" select="ancestor::recipe"/>
							<tr>
								<td>
									<xsl:value-of select="@name"/>
								</td>
								<td>
									<a href="#{generate-id($r)}"><xsl:value-of select="$r/title"/></a>
								</td>
							</tr>
						</xsl:for-each>
					</tbody>
				</table>
				
			</body>
		</html>
	</xsl:template>
	
	
	<xsl:template match="recipe" mode="toc">
		<li><a href="#{generate-id()}"><xsl:value-of select="title"/></a></li>
	</xsl:template>
	
	
	<xsl:template match="recipe" mode="detail">
		<h2 id="{generate-id()}"><xsl:value-of select="title" /></h2>
		
		<xsl:choose>
			<xsl:when test=""></xsl:when>
			<xsl:when test=""></xsl:when>
			<xsl:otherwise></xsl:otherwise>
		</xsl:choose>
		
		<xsl:if test="@author-id">
			<h3>Author</h3>
			<xsl:variable name="a" select="id(@author-id)"/>
			<p xml:space="preserve">
				<xsl:value-of select="$a/@title"/>
				<xsl:value-of select="$a"/>
			</p>
		</xsl:if>
		
		<h3>Ingredients</h3>
		<p>TODO: ...</p>
	
		<h3>Preparation</h3>
		<ol>
			<xsl:for-each select="preparation/step">
				<li><xsl:value-of select="."/></li>
			</xsl:for-each>
		</ol>
		
	</xsl:template>
	
	
	
	
	
	
	
	
	
	
	

</xsl:stylesheet>