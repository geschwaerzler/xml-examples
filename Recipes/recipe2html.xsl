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
				</ul>
				
				<xsl:apply-templates select="recipe" mode="detail"/>
				
				<h2 id="end">Ende Gelände</h2>
			</body>
		</html>
	</xsl:template>
	
	
	<xsl:template match="recipe" mode="toc">
		<li><a href="#end"><xsl:value-of select="title"/></a></li>
	</xsl:template>
	
	
	<xsl:template match="recipe" mode="detail">
		<h2><xsl:value-of select="title" /></h2>
		
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