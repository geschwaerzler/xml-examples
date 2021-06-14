<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method = "html"/>
	<xsl:template match="/Championships">
		<html>
			<head>
				<title>WFAC Championships</title>
			</head>
			
			<body>
				<h1>WFAC Championships</h1>
				<h2>Table of Contents</h2>
				
				<ol>
					<xsl:for-each select="Tournament">
					<li><a href="#{generate-id()}"><xsl:value-of select="@year"/></a></li>
					</xsl:for-each>
					
				</ol>
					<xsl:apply-templates select = "Tournament"/>
					<h1>Personen-Index</h1>
					<xsl:apply-templates select = "Tournament/Venue/Match/Person" mode= "index"/>
			</body>	
		</html>
	</xsl:template>
	
	<xsl:template match="Tournament">
		
		<h1 id = "{generate-id()}">
			<xsl:value-of select="@year"/> - 
			Tournament
			<xsl:value-of select="@id"/>
		</h1>
		<xsl:apply-templates select = "Venue"/>
		<h2>
		Matches
		</h2>
		<ol>
			<xsl:for-each select="Venue/Match">
			<li><a href="#{generate-id()}"><xsl:value-of select="@m_id"/> - <xsl:value-of select="@description"/></a></li>
			</xsl:for-each>
					
		</ol>
		<xsl:apply-templates select = "Venue/Match"/>
	</xsl:template>
	
	<xsl:template match="Venue">
		<h2>
			<xsl:value-of select= "@description" />
		</h2>
	</xsl:template>	
	
	<xsl:template match="Match">
		<h2 id = "{generate-id()}">
			<xsl:value-of select= "@description"/> (Match ID: <xsl:value-of select= "@m_id"/>)
		</h2>
		<xsl:apply-templates select = "Person" mode ="match"/>
	</xsl:template>
	
	<xsl:template match="Person" mode = "match">
		<h3>
			<a href="#{generate-id()}">Player: <xsl:value-of select= "@p_id"/> - <xsl:value-of select= "@name"/></a>
		</h3>
		<xsl:apply-templates select = "Score"/>
	</xsl:template>	
	
	<xsl:template match="Score">
		<h4>
			Score Total: <xsl:value-of select= "@score_total"/>
		</h4>
		<xsl:apply-templates select = "Points"/>
	</xsl:template>	
	
	<xsl:template match="Points">
		<h5>
			Target: <xsl:value-of select= "@target"/> | Arrow:  <xsl:value-of select= "@arrow"/> | Points: <xsl:value-of select= "@points_arrow"/>
		</h5>
	</xsl:template>
	
	<xsl:template match="Person" mode = "index">
		<h2 id = "{generate-id()}">
			<xsl:value-of select= "@name"/> - <xsl:value-of select= "@p_id"/>
		</h2>
		<h4>
		<xsl:value-of select= "email"/>
		<xsl:if test="email and fon">
			-
		</xsl:if>
			<xsl:value-of select= "fon"/>
		</h4>
	</xsl:template>	
	
</xsl:stylesheet>