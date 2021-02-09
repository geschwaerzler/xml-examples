<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html"/>
	<xsl:template match="/FAC">
		<html>
			<head><title>Field Archery Championship</title></head>
			<body>
				<h1>Field Archery Championship</h1>
				<h2>Inhaltsverzeichnis</h2>
				<o1>
					<xsl:apply-templates select="group" mode="toc"/>
				</o1>
				<hr/>
				<xsl:apply-templates select="group" mode="detail"/>
			</body>
		</html>
	</xsl:template>
	
	<xsl:template match="group" mode="toc">
		<li><a href="#{generate-id()}"><xsl:value-of select="@group_id"/></a></li>
	</xsl:template>
	
	<xsl:template match="group" mode="detail">
		<h1><a name="#{generate-id()}">Details für die Gruppe <xsl:value-of select="@group_id"/></a></h1>
		<ul>
			<xsl:for-each select="@*">
				<xsl:apply-templates select="id(.)" mode="group_member"></xsl:apply-templates>
			</xsl:for-each>
		</ul>
	</xsl:template>

	<xsl:template match="competitor" mode="group_member" xml:space="preserve">
		<xsl:variable name="cID" select="@competitor_id"/>
		<li><xsl:value-of select="@fname"/> <xsl:value-of select="@lname"/> <xsl:value-of select="sum(/FAC/scorecard[@competitor_id=$cID]/score-group/score/@score)"/></li>
	</xsl:template>
	
</xsl:stylesheet>