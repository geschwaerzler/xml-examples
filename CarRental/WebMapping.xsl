<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:output method="html"/>
	<xsl:decimal-format name="austria" decimal-separator="," grouping-separator="."/>
	
	<xsl:template match="/">
		<html>
			<head>
				<title>CarRental</title>
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
						background-color: yellow;
						font-size: 80%;
					}
					table, td, th {
						border: 1px solid #ddd;
						border-collapse: collapse;
					}
					th {
						font-size: 80%;
					}
				</style>
			</head>
			<body>
				<h1>CarRental</h1>
				
				<h2>Unser Angebot</h2>
				<ul>
					<xsl:apply-templates select="car-rental/auto" mode="toc"/>
				</ul>
				
				<xsl:apply-templates select="car-rental/auto" mode="content"/>
				
				<h2>Kennzeichenverzeichnis</h2>
				<table>
					<thead><tr><th>KZ</th><th>PKW</th></tr></thead>
					<tbody>
						<xsl:for-each select="/car-rental/auto">
							<xsl:sort select="@kennzeichen"/>
							<tr>
								<td><xsl:value-of select="@kennzeichen"/></td>
								<td><a href="#{@kennzeichen}"><xsl:value-of select="id(@autotyp-id)/@typ_bezeichnung"/></a></td>
							</tr>
						</xsl:for-each>
					</tbody>
				</table>
			</body>
		</html>
	</xsl:template>

	<xsl:template match="auto" mode="toc">
		<li xml:space="preserve">
			<a href="#{@kennzeichen}">
				<xsl:value-of select="id(@autotyp-id)/@typ_bezeichnung"/> -
				<xsl:value-of select="@farbe"/>
			</a>
			<span class="em">
				<xsl:call-template name="miet-preis">
					<xsl:with-param name="car" select="."/>
				</xsl:call-template>
			</span>			
		</li>
	</xsl:template>

	<xsl:template match="auto" mode="content">
		<h2 id="{@kennzeichen}"><xsl:value-of select="id(@autotyp-id)/@typ_bezeichnung"/> - <xsl:value-of select="@farbe"/></h2>
		<div>
			<img src="{@image}"/>
			<ul>
				<li xml:space="preserve">
					Mietpreis:
					<xsl:call-template name="miet-preis">
						<xsl:with-param name="car" select="."/>
					</xsl:call-template>
				</li>
				<li>Standort: <xsl:value-of select="id(@vermiet-station-id)/@stations_name"/></li>
				<li>Kennzeichen: <xsl:value-of select="@kennzeichen"/></li>
				<li>km-Stand: <xsl:value-of select="@km_stand"/></li>
				<xsl:for-each select="verfuegt_ueber">
					<li xml:space="preserve"><span class="em">Extra:</span> <xsl:value-of select="id(@extraausstattung-id)/@extras_bezeichnung"/></li>
				</xsl:for-each>
			</ul>
		</div>
	</xsl:template>
	
	<xsl:template name="miet-preis">
		<xsl:param name="car"/>
		
		<xsl:value-of select="format-number(id($car/@autotyp-id)/../@grundtarif, '€ #.##0,00', 'austria')"/> + 
		<xsl:value-of select="format-number(id($car/@autotyp-id)/../@km_preis, '€ #.##0,00/km', 'austria')"/>
	</xsl:template>
	
</xsl:stylesheet>