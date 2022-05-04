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
					<xsl:apply-templates select="recipe" mode="toc"/>
				</ol>
				
				<h2>Authors and their Recipes</h2>
				<xsl:for-each select="author">
					<h3 xml:space="preserve">
						<xsl:value-of select="@title"/>
						<xsl:value-of select="text()"/>
					</h3>
						
					<xsl:variable name="authorID" select="@id"/>
					<ul>
						<xsl:for-each select="//recipe[@author-id = $authorID]">
							<xsl:sort select="title" order="descending"/>
							<li><xsl:value-of select="title"/></li>
						</xsl:for-each>
					</ul>
					
				</xsl:for-each>
				
				<xsl:apply-templates select="recipe" mode="detail"/>
				
			</body>
		</html>
	</xsl:template>
	
	<xsl:template match="recipe" mode="toc">
		<li><a href="#{generate-id()}"><xsl:value-of select="title"/></a></li>
	</xsl:template>
	
	
	<xsl:template match="recipe" mode="detail">
	
		<hr/>
		
		<h2 id="{generate-id()}"><xsl:value-of select="title"/></h2>
		<p xml:space="preserve">
			Author: <xsl:value-of select="id(@author-id)/@title"/> <xsl:value-of select="id(@author-id)/text()"/>
		</p>
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