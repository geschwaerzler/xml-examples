<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
>

	<xsl:output method="html" encoding="UTF-8" indent="yes"/>
	
	<xsl:template match="/collection">
		<html>
			<head>
				<title><xsl:value-of select="description"/></title>
			</head>
			<body>
				<h1><xsl:value-of select="description"/></h1>
				
				<h2>Table of Contents</h2>
				
				<ol>
					<xsl:for-each select="recipe">
						<li><xsl:value-of select="title"/></li>
					</xsl:for-each>
				</ol>
				
				<xsl:apply-templates select="recipe"/>
				
			</body>
		</html>
	</xsl:template>
	
	
	<xsl:template match="recipe">
		<hr/>
		
		<h2><xsl:value-of select="title"/></h2>
		
		<xsl:apply-templates select="nutrition"/>
		
		<img src="{image}"/>
		
		<xsl:if test="comment">
			<h3>Comment</h3>
			<p style="font-style: italic">
				<xsl:value-of select="comment"/>
			</p>
		</xsl:if>
		
		<h3>Ingredients</h3>
		
		<h3>Preparation</h3>
		<ol>
			<xsl:for-each select="preparation/step">
				<li><xsl:value-of select="./text()"/></li>
			</xsl:for-each>
		</ol>
		
	</xsl:template>
	
	
	<xsl:template match="nutrition">
		<table>
			<thead>
				<tr style="border: 1px">
					<th>calories</th>
					<th>fat</th>
					<th>carbohydrates</th>
					<th>protein</th>
				</tr>
			</thead>
			<tbody>
				<tr style="border: 1px">
					<td><xsl:value-of select="@calories"/></td>
					<td><xsl:value-of select="@fat"/></td>
					<td><xsl:value-of select="@carbohydrates"/></td>
					<td><xsl:value-of select="@protein"/></td>
				</tr>
			</tbody>
		</table>
	
	</xsl:template>
	
	
</xsl:stylesheet>