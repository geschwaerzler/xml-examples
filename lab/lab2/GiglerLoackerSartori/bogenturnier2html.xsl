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
				
<!-- Verlinkung läuft bei uns hier nur korrekt, wenn wir die hmtl datei nachbearbeiten und den anchor bei gruppe 2 setzen-->
<!-- Wir wussten nicht wie man für jedes angeführte Element einen eindeutigen anchor setzt ohne die Gruppen einzeln auzuzählen-->
<!-- Aber die Links funktionieren -->

					<a href="#gruppe1"><xsl:value-of select="@id"/> </a>
					<xsl:value-of select="id(@klassen-id)"/>
				</li>
			</xsl:for-each>
		</ol>
		
		<xsl:variable name="test"></xsl:variable>
		
		
		
		
		<xsl:apply-templates select="gruppe"/>
		
		
		<h2>Scoreboard </h2>
		
		<ol>
		
		
		</ol>
		
		<xsl:apply-templates select="scoreboard"/>
	</body>
	</html>
	
	</xsl:template>
	
	<xsl:template match="gruppe"> 
		<h2>
			<a name="gruppe1"><xsl:value-of select="@id"/> </a>
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
	</xsl:template>
	
	<xsl:template match="scoreboard"> 	
	
		<h3> Scoreboard	</h3>
		
		<ol>
		<xsl:for-each select="mitglied">
		<xsl:variable name="Schütze" select="id(@schuetze-id)"></xsl:variable>
		<li xml:space="preserve">
		
			<xsl:value-of select="$Schütze/firstname"/>
			<xsl:value-of select="$Schütze/lastname"/>
			
		
		
		</li>
		
		
		</xsl:for-each>

		</ol>
		
	
	
	</xsl:template>
	
	
	
</xsl:stylesheet>