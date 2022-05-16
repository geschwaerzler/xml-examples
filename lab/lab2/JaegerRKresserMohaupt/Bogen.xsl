<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:template match="/">

		<html>
			<body>

				<h2>Bogenturnier</h2>
				<br></br>

				<h2> Inhaltsverzeichnis </h2>

				<a href="#Gruppe1">Gruppe 1 19.09.1944</a>
				<br></br>

				<a href="#Gruppe2">Gruppe 2 20.09.1944</a>
				<br></br>

				<a href="#sc1">Olaf Scholz Scorecard</a>
				<br></br>

				<a href="#sc2">Christian Lindner Scorecard</a>
				<br></br>

				<h2> Tag 1 19.09.1944 </h2>

				<h2 id="Gruppe1"> Gruppe 1 Recurve Profi</h2>

				<table border="1">

					<tr bgcolor="#9acd32">
						<th>Schuetzen Nr</th>
						<th>Schuetze Vorname</th>
						<th>Schuetze Nachname</th>
						<th>Nationalitaet</th>
						<th>Punktezahl</th>
					</tr>

					<xsl:for-each select="Bogenturnier/Schuetzenprofil/Schuetze[Gruppe/@id='g1']">
						<tr>
							<td>
								<xsl:value-of select="schuetze_id"/>
							</td>
							<td>
								<xsl:value-of select="Schuetze_Vorname"/>
							</td>
							<td>
								<xsl:value-of select="Schuetze_Nachname"/>
							</td>
							<td>
								<xsl:value-of select="Nationalitaet"/>
							</td>
							<td>
								<xsl:value-of select="Gesamtpunkte"/>
							</td>
						</tr>
					</xsl:for-each>

				</table>

				<br></br>

				<h2> Tag 2 20.09.1944 </h2>

				<h2 id="Gruppe2"> Gruppe 2 Cumpound Amateur</h2>

				<table border="1">
					<tr bgcolor="#9acd32">
						<th>Schuetzen Nr</th>
						<th>Schuetze Vorname</th>
						<th>Schuetze Nachname</th>
						<th>Punktezahl</th>

					</tr>
					<xsl:for-each select="Bogenturnier/Schuetzenprofil/Schuetze[Gruppe/@id='g2']">
						<tr>
							<td>
								<xsl:value-of select="schuetze_id"/>
							</td>
							<td>
								<xsl:value-of select="Schuetze_Vorname"/>
							</td>
							<td>
								<xsl:value-of select="Schuetze_Nachname"/>
							</td>
							<td>
								<xsl:value-of select="Nationalitaet"/>
							</td>
							<td>
								<xsl:value-of select="Gesamtpunkte"/>
							</td>
						</tr>
					</xsl:for-each>

				</table>

				<h2 id="sc1"> Scorecard Olaf Scholz </h2>
				<table border="1">
					<tr bgcolor="#7b5c00">
						<th>Ziel Nr</th>
						<th>Ziel Name</th>
						<th>Punkte</th>
					</tr>


					<xsl:for-each select="Bogenturnier/ParkourOS/target">
						<tr>

							<td>
								<xsl:value-of select="target_id"/>
							</td>
							<td>
								<xsl:value-of select="target_name"/>
							</td>
							<td>
								<xsl:value-of select="punkte"/>
							</td>

						</tr>
					</xsl:for-each>

				</table>

				<h2 id="sc2"> Scorecard Christian Lindner </h2>
				<table border="1">
					<tr bgcolor="#7b5c00">
						<th>Ziel Nr</th>
						<th>Ziel Name</th>
						<th>Punkte</th>
					</tr>


					<xsl:for-each select="Bogenturnier/ParkourCL/target">
						<tr>
							<td>
								<xsl:value-of select="target_id"/>
							</td>
							<td>
								<xsl:value-of select="target_name"/>
							</td>
							<td>
								<xsl:value-of select="punkte"/>
							</td>
						</tr>
					</xsl:for-each>

				</table>

			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>