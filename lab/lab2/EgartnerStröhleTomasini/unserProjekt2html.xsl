<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	
	<xsl:template match="/">
		<html>
			<head>
				<title><xsl:value-of select="archerDB/description"/></title>
			</head>
			
			<body>
				<h1><xsl:value-of select="archerDB/description"></xsl:value-of></h1>
				
				<!--Inhaltsverzeichnis -->
				<h2>Turniertage</h2>
				
				<ol>
					<xsl:apply-templates select="archerDB/tournament/round" mode="toc"/>
				</ol>
				
				<h2>Gruppen</h2>
				
				<ol>
					<xsl:apply-templates select="archerDB/tournament/round/group" mode="toc"/>
				</ol>
				
				<h2>Scorecards</h2>
				
				<ol>
					<xsl:apply-templates select="archerDB/tournament/archer" mode="toc"/>
				</ol>
				
				<!--Detaildarstellungen -->
				<xsl:apply-templates select="archerDB/tournament/round/group" mode="detail"/>
				<xsl:apply-templates select="archerDB/tournament/round" mode="detail"/>
				<xsl:apply-templates select="archerDB/tournament/archer" mode="detail"/>
			</body>
		</html>
	</xsl:template>
	
	<xsl:template match="round" mode="toc">
		<li>
			<a href="#round-{position()}"><xsl:value-of select="@round_name"/></a>
		</li>
	</xsl:template>
	
	<xsl:template match="group" mode="toc">
		<li>
			<a href="#group-{position()}"><xsl:value-of select="@group_name"/></a>
		</li>
	</xsl:template>
	
	<xsl:template match="archer" mode="toc">
		<li xml:space="preserve">
			<a href="#scorecard-{position()}"><xsl:value-of select="@fname"/> 
											  <xsl:value-of select="@lname"/>
			</a>
		</li>
	</xsl:template>
	
	<xsl:template match="group" mode="detail">
		<h2 id="group-{position()}"><xsl:value-of select="@group_name"/></h2>
		<xsl:variable name="current_group_id" select="@id"/>
		
		<xsl:for-each select="/archerDB/tournament/archer">
			<xsl:if test="member_of/@group_id=$current_group_id">
				<ul>
					<li xml:space="preserve">
						<xsl:value-of select="@fname"/>
						<xsl:value-of select="@lname"/>
					</li>
				</ul>
			</xsl:if>  
		</xsl:for-each>
	</xsl:template>
	
	<xsl:template match="round" mode="detail">
		<h2 id="round-{position()}"><xsl:value-of select="@round_name"/></h2>
		
		<h3>Teilnehmende Gruppen:</h3>
		
		<ol>
			<xsl:for-each select="group">
					<li><xsl:value-of select="@group_name"/></li>
			</xsl:for-each>
		</ol>
		
		<h3>Parcours:</h3>
		
		<ul>
			<xsl:for-each select="parcour">
					<li><xsl:value-of select="@parcour_name"/></li>
			</xsl:for-each>
		</ul>
	</xsl:template>
	
	<xsl:template match="archer" mode="detail">
		<h2 xml:space="preserve" id="scorecard-{position()}">Scorecards von <xsl:value-of select="@fname"/> 
										<xsl:value-of select="@lname"/>
		</h2>
		
		<table>
			<xsl:for-each select="scorecard">
				<tr>
					<td><h3>Tag <xsl:value-of select="@sc_number"/></h3></td>
				<xsl:apply-templates select="point"/>
				</tr>
			</xsl:for-each>
		</table>
	</xsl:template>
	
	<xsl:template match="point">
		<td>
			<xsl:value-of select="@targetpoints"/>
		</td>
	</xsl:template>
</xsl:stylesheet>