<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:template match="/turnier">
		
	<html>
	<head> 
		<title> 
		<xsl:value-of select="headline"/>
		</title>
	</head>
	<body>
		<h1>
		<xsl:value-of select="headline"/>
		</h1>
		<h2> Gruppen </h2>
		
		<ol>
			<xsl:for-each select="gruppe">
				<li>
					<a href="#{@id}"><xsl:value-of select="@id"/> </a>
					<xsl:value-of select="id(@klassen-id)"/>
				</li>
			</xsl:for-each>
		</ol>
		<xsl:apply-templates select="gruppe"/>
		<xsl:apply-templates select="//gruppe/mitglied"/>
	</body>
	</html>
	
	</xsl:template>
	
	<xsl:template match="gruppe"> 
		<h2 id="{@id}">
			<xsl:value-of select="@id"/>
			<xsl:value-of select="id(@klassen-id)"/>
		</h2>
		<h3> Mitglieder </h3>
		<ol>
			<xsl:for-each select="mitglied">
				<xsl:variable name="Schütze" select="id(@schuetze-id)"/>
				<li xml:space="preserve">
				<xsl:value-of select="$Schütze/firstname"/>
				<xsl:value-of select="$Schütze/lastname"/>
					(<xsl:value-of select="sum(scoreboard/ziele/punkte/text())"/>)
				</li>
			</xsl:for-each>
		</ol>
		<br/>
		<br/>
		
	</xsl:template>
	
	<xsl:template match="//gruppe/mitglied"> 
	<xsl:variable name="Schütze" select="id(@schuetze-id)"/>	
		<h2 xml:space="preserve"> Scorecard 
			<xsl:value-of select="$Schütze/firstname"/>
			 <xsl:value-of select="$Schütze/lastname"/> 
		</h2>
		<table style="border: 1px solid black;">
			<tr>
				<td style="font-weight:600; min-width:100px">Target</td>
				<td style="font-weight:600; min-width:100px">Shot 1</td>
				<td style="font-weight:600; min-width:100px">Shot 2</td>
				<td style="font-weight:600; min-width:100px">Shot 3</td>
				<td style="font-weight:600; min-width:100px">Gesamt</td>
			</tr>
				<xsl:for-each select="scoreboard/ziele">
				<tr>
					<td>
						<xsl:variable name="zielid" select="@target-id"></xsl:variable>
						<xsl:value-of select="//target[@id = $zielid]/text()"/>
					</td>
					<td>
						<xsl:value-of select="punkte[position()=1]/text()"/>
					</td>
					<td>
						<xsl:value-of select="punkte[position()=2]/text()"/>
					</td>
					<td>
						<xsl:value-of select="punkte[position()=3]/text()"/>
					</td>
					<td>
						<xsl:value-of select="sum(punkte/text())"/>
					</td>
				</tr>
				</xsl:for-each>
			<tr>
				<td></td><td></td><td></td><td></td>
				<td><xsl:value-of select="sum(scoreboard/ziele/punkte/text())"/></td>
			</tr>	
				
				
			<tr>
			
			</tr>
		</table>
	
	</xsl:template>
	
</xsl:stylesheet>