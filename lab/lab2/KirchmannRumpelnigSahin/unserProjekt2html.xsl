<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html" />
	<xsl:key name="stationkey" match="Station" use="@id"/>
	<xsl:template match="/">
		<!-- TODO: Auto-generated template -->

		<html>
			<head>
				<title>unser Projekt Aufbau</title>
				<style type="text/css">
					body {
					font-family: Arial;
					}
					img {
					width: 240px;
					float: left;
					}
					div>ul {
					float: left;
					font-size: 80%;
					}
					div {
					clear: both;
					display: table;
					}
					.em {
					font-size: 120%;

					}
					.ez{
					font-weight:bold;
					}

					table,
					td, th {
					border: 1px solid #ddd;
					border-collapse: collapse;
					}
					th {
					font-size: 80%;
					}
					h1 {
					font-family: Arial
					font-size: 30px;
					color: blue;
					}
					h2 {
					font-family: Arial
					font-size: 20px;
					color: lightblue;
					}
					
				</style>
			</head>

			<body>
						
				<header>
					<img src="header_picture.jpg" style="width:1920px;height:250px;object-fit:cover;"/>
				</header>				

				<h1>Teamaufstellung</h1>

				<p>
				Hier werden die einzelnen Teams dargestellt. Für jedes Team werden die Teammitglieder in einer kleinen Tabelle aufgeslistet und ausgegeben.
				</p>


				<xsl:for-each select="Aufbau/Team">

					<h2>
						<a href="#{generate-id()}">
							<xsl:value-of select="@id"></xsl:value-of>
						</a>
					</h2>

					<table>

						<tr>
							<th>ID</th>
							<th>Vorname</th>
							<th>Nachname</th>
						</tr>

						<xsl:for-each select="Team_Member">
							<tr>
								<td>
									<xsl:value-of select="@id" />
								</td>
								<td>
									<xsl:value-of select="@fname" />
								</td>
								<td>
									<xsl:value-of select="@lname" />
								</td>
							</tr>
						</xsl:for-each>

					</table>

				</xsl:for-each>

				<h1>Team Stationszuordnung</h1>

				<p>Hier werden die Stationen, welche den einzelnen Teams zugeordnet sind ausgegeben. Mann kann in der Tabelle die Stations-ID, sowie die Nord-Süd und West-Ost Position der Station sehen.</p>
				
				<xsl:for-each select="Aufbau/Team">
					<a name="{generate-id()}">
						<h2>

							<xsl:value-of select="@id" />

						</h2>
					</a>
					
					<table>

						<tr>
							<th>Stations-ID</th>
							<th>Position Nord-Süd</th>
							<th>Position West-Ost</th>
						</tr>

						<xsl:for-each select="builds">
						
							<xsl:for-each select="key('stationkey',@station_id)">
							
								<tr>
									<td>
										<xsl:value-of select="@id" />
									</td>
									<td>
										<xsl:value-of select="@position_ns" />
									</td>
									<td>
										<xsl:value-of select="@position_we" />
									</td>
								</tr>							
							
							</xsl:for-each>
						
						</xsl:for-each>

					</table>
					
					<p>
						Hier steht ein langer Leertext, zum Vorzeigen der Anchors:<br/>
						Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.   
						<br/>
						Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis at vero eros et accumsan et iusto odio dignissim qui blandit praesent luptatum zzril delenit augue duis dolore te feugait nulla facilisi. Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat.   
						<br/>
						Ut wisi enim ad minim veniam, quis nostrud exerci tation ullamcorper suscipit lobortis nisl ut aliquip ex ea commodo consequat. Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis at vero eros et accumsan et iusto odio dignissim qui blandit praesent luptatum zzril delenit augue duis dolore te feugait nulla facilisi.   
						<br/>
						Nam liber tempor cum soluta nobis eleifend option congue nihil imperdiet doming id quod mazim placerat facer possim assum. Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. Ut wisi enim ad minim veniam, quis nostrud exerci tation ullamcorper suscipit lobortis nisl ut aliquip ex ea commodo consequat.   
						<br/>
						Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis.   
						<br/>
						At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, At accusam aliquyam diam diam dolore dolores duo eirmod eos erat, et nonumy sed tempor et et invidunt justo labore Stet clita ea et gubergren, kasd magna no rebum. sanctus sea sed takimata ut vero voluptua. est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur
					</p>
					
				</xsl:for-each>
					
			</body>

		</html>

	</xsl:template>
</xsl:stylesheet>	