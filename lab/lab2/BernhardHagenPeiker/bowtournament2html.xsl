<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml">
	<xsl:output method="html"/>
	
	<xsl:template match="/bow-tournament">
		<html>
			<head>
				<title>World Outdoor Field Archery 2022</title>
			</head>
			<body>
				<h1>World Outdoor Field Archery 2022</h1>
				
				<hr/>
				<h2>Table of contents</h2>
				<ol>
					<xsl:for-each select="group">
						<li><a href="#{generate-id()}"><xsl:value-of select="@name"/></a></li>
					</xsl:for-each>
				</ol>
				
				<hr/>
				<xsl:apply-templates select="group" mode="player"/>
				
				<hr/>
				<h2>Overall playerlist</h2>
				<ol>
					<xsl:for-each select="player">
						<xsl:sort select="@player-id/lastname"/>
						<li xml:space="preserve">
							<xsl:value-of select="lastname/text()"/>
							<xsl:value-of select="firstname/text()"/>
						</li>
					</xsl:for-each>
				</ol>
				
				<hr/>
				<xsl:apply-templates select="group" mode="score"/>
				
				<hr/>
				<h2>Scorecards</h2>
				<xsl:apply-templates select="group" mode="scorecard"/>			
			</body>
		</html>
	</xsl:template>
	
	<xsl:template match="group" mode="player">
		<h2 id="{generate-id()}"><xsl:value-of select="@name"></xsl:value-of></h2>
			<xsl:for-each select="member">
				<xsl:sort select="id(@player-id)/lastname"/>
				<ul xml:space="preserve">
					<xsl:value-of select="id(@player-id)/lastname"/>
					<xsl:value-of select="id(@player-id)/firstname"/>
				</ul>
			</xsl:for-each>
	</xsl:template>
	
	<xsl:template match="group" mode="scorecard">
		<xsl:for-each select="member">
			<h3 id="{generate-id()}" xml:space="preserve">
				<xsl:value-of select="id(@player-id)/firstname"/>
				<xsl:value-of select="id(@player-id)/lastname"/>
				-
				<xsl:value-of select="../@name"/>
			</h3>
			<xsl:for-each select="scorecard">
				<table border="1px" cellpadding="5px" cellspacing="2px">
					<tr>
						<th>target</th>				
						<th>arrow 1</th>
						<th>arrow 2</th>
						<th>arrow 3</th>
						<th>arrow 4</th>
					</tr>
					<xsl:for-each select="score">
						<tr>
							<th><xsl:value-of select="id(@target-id)/text()"/></th>
							<xsl:for-each select="arrow">
								<th><xsl:value-of select="text()"/></th>
							</xsl:for-each>
						</tr>
					</xsl:for-each>
				</table>
			</xsl:for-each>
		</xsl:for-each>
	</xsl:template>
	
	<xsl:template match="group" mode="score">
		<h2 id="{generate-id()}">Results <xsl:value-of select="@name"/></h2>
			<ol>
				<xsl:for-each select="member">
					<xsl:sort select="sum(scorecard//arrow/text())" order="descending"/>
					<li xml:space="preserve">
						<xsl:value-of select="id(@player-id)/firstname"/>
						<xsl:value-of select="id(@player-id)/lastname"/>
						<a href="#{generate-id()}">
						<xsl:value-of select="sum(scorecard//arrow/text())"/>
						</a>
					</li>					
				</xsl:for-each>
			</ol>
	</xsl:template>
	
</xsl:stylesheet>