<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html"/>

	
	<xsl:template match="/archery_event">
		<html>
			<body>
				<h1><xsl:apply-templates select="tournament" mode="getTournamentName"/></h1>
				
				<ol>
				<xsl:apply-templates select="tournament" mode="getParticipantsPerDivision"/>
				</ol>
			</body>
		</html>	
	</xsl:template>


	<xsl:template match="tournament" mode="getTournamentName">
		<xsl:value-of select="./@tournament_name"/>
	</xsl:template>
	
	<xsl:template match="tournament" mode="getParticipantsPerDivision">
		<xsl:for-each select="./division">
			<li><xsl:value-of select="@division_name"/></li>
			<xsl:for-each select="./division/class">
				<li><xsl:value-of select="@fname"/> <xsl:value-of select="@lname"/></li>
				<h1>test</h1>
			</xsl:for-each>
		</xsl:for-each>
	</xsl:template>
	

	
</xsl:stylesheet>