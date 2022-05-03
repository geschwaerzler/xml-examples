<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:output method="html"/>
	
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
						<li><a href="#{generate-id()}"><xsl:value-of select="title"/></a></li>
					</xsl:for-each>
				</ol>
				
				<xsl:apply-templates select="recipe"/>
				
			</body>
		</html>
	</xsl:template>
	
	
	<xsl:template match="recipe">
	
		<hr/>
		
		<h2 id="{generate-id()}"><xsl:value-of select="title"/></h2>
		<img src="{image}" height = "320"/>
		
		<h3>Ingredients</h3>
		
		<h3>Preparation</h3>
		<xsl:apply-templates select="preparation" />
		
		<xsl:if test="comment">
			<h3>Comment</h3>
			<p><xsl:value-of select="comment/text()" /></p>
		</xsl:if>
		
		
	</xsl:template>
	
	
	<xsl:template match="preparation">
		<ol>
			<xsl:for-each select="step">
				<li><xsl:value-of select="./text()"></xsl:value-of></li>
			</xsl:for-each>
		</ol>
	</xsl:template>
	
</xsl:stylesheet>