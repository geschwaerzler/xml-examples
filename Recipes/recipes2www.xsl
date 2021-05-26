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
				
			</body>
		</html>
	</xsl:template>
	
	
	<xsl:template match="recipe" mode="table-of-contents">
		<li><xsl:value-of select="title"/></li>					
	</xsl:template>
	
	
	<xsl:template match="recipe" mode="detail">
		<hr/>
		
		<h2 id="{generate-id()}"><xsl:value-of select="title"/></h2>
		
		<h3>Preparation</h3>
		<ol>
			<xsl:apply-templates select="preparation/step"/>
		</ol>
		
	</xsl:template>
	
	
	<xsl:template match="step">
		<li><xsl:value-of select="."/></li>
	</xsl:template>
	
</xsl:stylesheet>