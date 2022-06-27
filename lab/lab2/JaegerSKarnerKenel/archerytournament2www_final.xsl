<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:template match="archerytournament">
		<html>
			<head>
			
				<title> 
					<xsl:value-of select="@name"/>
				</title>
					
			</head>

			<body>
				<h1><xsl:value-of select="@name"/></h1>
				
				<h2> Table of Contents </h2>
				
				<ol>
					<xsl:apply-templates select="group" mode="toc"/>
					<xsl:apply-templates select="parkour" mode="toc"/>
				</ol>
				
				<xsl:apply-templates select="group" mode="detail"/>
				<hr/>
				
				<xsl:apply-templates select="parkour"/>
				<hr/>
				
				<h3>Scorecards</h3>
				<xsl:apply-templates select="athlete" mode="scorecards"/>
				
			</body>
		</html>

	</xsl:template>
	
	<xsl:template match="group" mode="toc">
		<li><a href="#{generate-id()}"><xsl:value-of select="@name"/></a></li>
	</xsl:template>
	
	<xsl:template match="parkour" mode="toc">
		<li><a href="#{generate-id()}" xml:space="preserve">Parkour <xsl:value-of select="@name"/></a></li>
	</xsl:template>

	<xsl:template match="group" mode="detail">
			<hr/>
			<h3 id="{generate-id()}"><xsl:value-of select="@name"/></h3>
			<ul>
				<xsl:for-each select="member">
					<li><a href="#{generate-id(id(@athlete-id))}" xml:space="preserve"><xsl:value-of select="id(@athlete-id)/firstname"/> <xsl:value-of select="id(@athlete-id)/lastname"/></a></li>
				</xsl:for-each>
			</ul>
	</xsl:template>
	
	<xsl:template match="parkour">
		<h3 id="{generate-id()}" xml:space="preserve">Parkour <xsl:value-of select="@name"/></h3>
		<ul>
			<xsl:for-each select="target">
				<li xml:space="preserve">Target <xsl:value-of select="@id"/></li>
			</xsl:for-each>
		</ul>
	</xsl:template>
	
	<xsl:template match="athlete" mode="scorecards">
		<h4 id="{generate-id()}" xml:space="preserve"><xsl:value-of select="firstname"/> <xsl:value-of select="lastname"/></h4>
		<xsl:apply-templates select="scorecard"/>
		<hr/>
	</xsl:template>
	
	<xsl:template match="scorecard">
		<h5><xsl:value-of select="id(@parkour-id)/@name"/></h5>
		<table border="1px" cellpadding="5px" cellspacing="0px">
			<tr>
				<th>Target</th>
				<th>Score</th>
				<th>Score</th>
				<th>Score</th>
			</tr>
			<tr>
				<th><xsl:value-of select="score[1]/@target-id"/></th>
				<td><xsl:value-of select="score[1]"/></td>
				<td><xsl:value-of select="score[2]"/></td>
				<td><xsl:value-of select="score[3]"/></td>
			</tr>
			<tr>
				<th><xsl:value-of select="score[4]/@target-id"/></th>
				<td><xsl:value-of select="score[4]"/></td>
				<td><xsl:value-of select="score[5]"/></td>
				<td><xsl:value-of select="score[6]"/></td>
			</tr>
			<tr>
				<th><xsl:value-of select="score[7]/@target-id"/></th>
				<td><xsl:value-of select="score[7]"/></td>
				<td><xsl:value-of select="score[8]"/></td>
				<td><xsl:value-of select="score[9]"/></td>
			</tr>
		</table>
	</xsl:template>
	
</xsl:stylesheet>