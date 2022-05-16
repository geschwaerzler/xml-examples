<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml">
	<xsl:template match="/tournament">
		<html>
			<head>
				<title><xsl:value-of select= "@name"/></title>
				<style>
					p.ingredient {
						margin-top: 2px;
						margin-bottom: 2px;
					}
					span.amount {
						font-style: italic;
						color: grey;
					}
					h1 {font-size: 240%; }
					h2 {font-size: 200%; }
					h3 {font-size: 160%; }
					h4 {font-size: 140%; }
					h5 {font-size: 120%; }
					h6 {font-size: 100%; }
				</style>			
			</head>
			
			<body>
				<h1><xsl:value-of select="@name"/></h1>
				<h2>Table of contents</h2>
				<ol>
					<xsl:for-each select="group">
						<ul xml:space="preserve">
						<a href="#{generate-id()}">
							<xsl:value-of select="@name"/>
							<xsl:value-of select="id(@division-id)/text()"/>		
							<xsl:value-of select="id(@discipline-id)"/>
						</a>
						</ul>
					</xsl:for-each>
				</ol>
				<xsl:apply-templates select="group"></xsl:apply-templates>
				
				<h2><a name="scores">
				<xsl:for-each select="concat(group/archer/firstname,' ', group/archer/lastname, '-', group/@name, ' ', group/day/@date)">
						</xsl:for-each>
						</a>
				</h2>
					<table border = "1px">
					<tr><th>target</th><th>arrow 1</th><th>arrow 2</th><th>arrow 3</th><th>arrow 4</th></tr>
					</table>
				<xsl:apply-templates select = "group/day/scores"></xsl:apply-templates>
			
			</body>
		</html>
	</xsl:template>
	
	<xsl:template match="group">
		<h2 id="{generate-id()}">
		<a href = "#scores">
			<xsl:value-of select="@name"/>	
			<xsl:value-of select="id(@division-id)/text()"/>			
			<xsl:value-of select="id(@discipline-id)"/>
			</a>
		</h2>
		<ul>
			<xsl:for-each select="archer">
				<li xml:space="preserve">
					<xsl:value-of select="firstname"/>
					<xsl:value-of select="lastname"/>
					<xsl:value-of select="target-scores"/>
				</li>
			</xsl:for-each>
		</ul>	
	</xsl:template>
	
	<xsl:template match="scores">
				<tr>
					<td><xsl:value-of select="target-scores/@target"/></td>
					<td><xsl:value-of select="target-scores/arrow1-score"/></td>
					<td><xsl:value-of select="target-scores/arrow2-score"/></td>
					<td><xsl:value-of select="target-scores/arrow3-score"/></td>
					<td><xsl:value-of select="target-scores/arrow4-score"/></td>
				</tr>
	</xsl:template>
	
</xsl:stylesheet>