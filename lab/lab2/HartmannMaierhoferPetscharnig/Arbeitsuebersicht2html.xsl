<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:template match="/">
		<html>
			<head>
				<title>Aufgaben- bzw. Arbeitsübersicht Mitarbeiter:innen</title>
				<link href="Arbeitsuebersicht.css" type="text/css" rel="stylesheet" />
			</head>

			<body>
			<h1>Inhaltsverzeichnis</h1>
			<table align="center">
				<tr>
					<td>
						<ul>
							<li>
								<a href="#KurzuebersichtTage">Kurzübersicht Tage</a>
							</li>
							<li>
								<a href="#KurzuebersichtAufgaben">Kurzübersicht Aufgaben</a> <br/>
							</li>
							<li>
								<a href="#Uebersicht">Übersicht</a> <br/>
							</li>
							<li>
								<a href="#VorhandeneMat">Vorhandene Materialien<br/></a>
							</li>
							<li>
								<a href="#Bewerbe">Bewerbe<br/></a>
							</li>
						</ul>
					</td>	
				</tr>
			</table>
		<p></p>
				<a name="KurzuebersichtTage"><h1>Kurzübersicht Tage</h1></a>
				<xsl:for-each select="Arbeitsuebersicht/Aufgabe/Termin">
					<xsl:sort select="@datum" order="ascending"/>

						<xsl:value-of select="@datum"/>, Start: <xsl:value-of select="@beginn_uhrzeit"/>
					<br />
							<p></p>
				</xsl:for-each>
				<a name="KurzuebersichtAufgaben"><h1>Kurzübersicht Aufgaben</h1></a>
				<br/>
				<xsl:for-each select="Arbeitsuebersicht/Aufgabe">
						<xsl:value-of select="@aufgabe_bezeichnung" />
					<br /><br/>
				</xsl:for-each>
						<p></p>
				
				<a name="Uebersicht"><h1>Übersicht:<br/></h1></a>
				
				<xsl:for-each select="Arbeitsuebersicht/Aufgabe">
						<h2><xsl:value-of select="@aufgabe_bezeichnung"/>:</h2><br/>
						<xsl:value-of select="Termin/@datum"/>, <xsl:value-of select="Termin/@beginn_uhrzeit"/> bis <xsl:value-of select="Termin/@ende_uhrzeit"/>:<br/>
						<xsl:sort select="Termin/@datum" order="ascending"/>
						
						<xsl:for-each select="AufgabenMitarbeiter">
							<xsl:value-of select="id(@mitarbeiter_ID)/@vorname"/> <xsl:text> </xsl:text> <xsl:value-of select="id(@mitarbeiter_ID)/@nachname"/>, <xsl:value-of select="id(@mitarbeiter_ID)/@tel_nr"/>, <xsl:value-of select="id(@mitarbeiter_ID)/Rolle/@titel"/>	<br/>					
						</xsl:for-each>
						<br/>
	
				</xsl:for-each>
						<p></p>

				
				
				
				<a name="VerhandeneMat"><h1>Vorhandene Materialien:</h1><br/></a>
				
				<table border="1" align="center">
					<tr>
						<td><h2>Material</h2>
						</td>
						<td><h2>Zustand</h2>
						</td>
					</tr>
					
					<xsl:for-each select="Arbeitsuebersicht/Material">
					<tr>
					<td><xsl:value-of select="@materialbezeichnung"/>
					</td>
					<td><xsl:value-of select="@zustand"></xsl:value-of>
					</td>
					</tr>
					</xsl:for-each>
				</table>
					<p></p>

				
				
				<a name="Bewerbe"><h1>Folgende Bewerbe werden stattfinden:</h1><br/></a>
				<xsl:for-each select="Arbeitsuebersicht/Bewerb">
				<xsl:value-of select="@bewerb_name">
				</xsl:value-of><br/>
				</xsl:for-each>
			</body>
		</html>


	</xsl:template>
</xsl:stylesheet>