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
				<style>
					table {
						border-collapse: collapse;
						margin-bottom: 16px;
					}
					td, th {
						border-bottom: 1px solid grey;
						width: 8em;
						text-align: center;
					}
					th {
						font-wheight: normal;
						font-size: 80%;
					}
					img {
						width: 320px;
					}
				</style>
			</head>
			<body>
				<h1><xsl:value-of select="description"/></h1>
				
				<h2>Table of Contents</h2>
				
				<ol>
					<xsl:for-each select="recipe">
						<li><a href="#{generate-id()}"><xsl:value-of select="title"/></a></li>
					</xsl:for-each>
				</ol>
				
				<xsl:apply-templates select="recipe"/>
				
				<h2>Index of Ingredients</h2>
				<ul>
					<xsl:apply-templates select="//recipe/ingredient">
						<xsl:sort select="@name"/>
					</xsl:apply-templates>
				</ul>
				
			</body>
		</html>
	</xsl:template>
	
	
	<xsl:template match="recipe">
		<hr/>
		
		<h2 id="{generate-id()}"><xsl:value-of select="title"/></h2>
		
		<xsl:apply-templates select="nutrition"/>
		
		<img src="{image}"/>
		
		<xsl:if test="comment">
			<h3>Comment</h3>
			<p style="font-style: italic">
				<xsl:value-of select="comment"/>
			</p>
		</xsl:if>
		
		<h3>Ingredients</h3>
		<xsl:choose>
			<xsl:when test="ingredient/ingredient">
				<xsl:apply-templates select="ingredient"/>
			</xsl:when>
			<xsl:otherwise>
				<ul>
					<xsl:for-each select="ingredient">
						<li xml:space="preserve">
							<xsl:value-of select="@amount"/>
							<xsl:value-of select="@unit"/>
							<xsl:value-of select="@name"/>
						</li>
					</xsl:for-each>
				</ul>
			</xsl:otherwise>
		</xsl:choose>
		
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
				<tr>
					<th>calories</th>
					<th>fat</th>
					<th>carbohydrates</th>
					<th>protein</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td><xsl:value-of select="@calories"/></td>
					<td><xsl:value-of select="@fat"/></td>
					<td><xsl:value-of select="@carbohydrates"/></td>
					<td><xsl:value-of select="@protein"/></td>
				</tr>
			</tbody>
		</table>
	
	</xsl:template>
	
	
	<xsl:template match="ingredient">
		<li><xsl:value-of select="@name"/></li>
	</xsl:template>
	
	
</xsl:stylesheet>