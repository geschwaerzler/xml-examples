<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html" />

	<xsl:template match="/">
		<html>
			<head>
				<title>Lieferando</title>
			</head>
			<body>
				<h2>Lieferando</h2>
				<h3>Unsere Partner:</h3>
				<ul>
					<li>
						<a href="#sakura">Sakura</a>
					</li>
					<li>
						<a href="#la_scarpetta">La Scarpetta</a>
					</li>
					<li>
						<a href="#laendle_kebap">Ländle Kebap</a>
					</li>
					<li>
						<a href="#extra_balkan_grill">Extra Balkan Grill</a>
					</li>
					<li>
						<a href="#la_grotta">La Grotta</a>
					</li>
					<li>
						<a href="#steinbock_hohenems">Steinbock Hohenems</a>
					</li>
				</ul>

				<xsl:apply-templates select="//Restaurant" />

			</body>
		</html>
	</xsl:template>

	<xsl:template match="Restaurant" mode="menu">
		<h3><a name="{geschaeft/@name}"><xsl:value-of select="geschaeft/@name" /></a></h3>
	</xsl:template>



	<xsl:template match="Restaurant">
		<h3>
			<a name="{geschaeft/@name}">
				<xsl:value-of select="geschaeft/@name" />
			</a>
		</h3>
		<!-- <ul> <li> <a href="#{geschaeft/@name}"> <xsl:value-of select="geschaeft/@name" 
			/> </a> </li> </ul> -->
		<p>
			<strong>Adresse:</strong>
			<xsl:value-of select="geschaeft/@adresse" />
		</p>
		<p>
			<strong>Geöffnet von:</strong>
			<xsl:value-of select="geschaeft/@geoeffnet_von" />
			bis
			<xsl:value-of select="geschaeft/@geoeffnet_bis" />
		</p>


		<!-- Vorspeisen -->
		<xsl:if test="Speise[@speisegattung-id='vorspeise']">
			<h3>Vorspeisen</h3>
			<table>
				<tr>
					<th>Bezeichnung</th>
					<th>Preis</th>
				</tr>
				<xsl:for-each
					select="Speise[@speisegattung-id='vorspeise']">
					<tr>
						<td>
							<xsl:value-of select="@bezeichnung" />
						</td>
						<td>
							<xsl:value-of select="@preis" />

						</td>
					</tr>
				</xsl:for-each>
			</table>
		</xsl:if>

		<!-- Hauptspeisen -->
		<xsl:if test="Speise[@speisegattung-id='hauptspeise']">
			<h3>Hauptspeisen</h3>
			<table>
				<tr>
					<th>Bezeichnung</th>
					<th>Preis</th>
				</tr>
				<xsl:for-each
					select="Speise[@speisegattung-id='hauptspeise']">
					<tr>
						<td>
							<xsl:value-of select="@bezeichnung" />
						</td>
						<td>
							<xsl:value-of select="@preis" />

						</td>
					</tr>
				</xsl:for-each>
			</table>
		</xsl:if>

		<!-- Desserts -->
		<xsl:if test="Speise[@speisegattung-id='dessert']">
			<h3>Desserts</h3>
			<table>
				<tr>
					<th>Bezeichnung</th>
					<th>Preis</th>
				</tr>
				<xsl:for-each
					select="Speise[@speisegattung-id='dessert']">
					<tr>
						<td>
							<xsl:value-of select="@bezeichnung" />
						</td>
						<td>
							<xsl:value-of select="@preis" />

						</td>
					</tr>
				</xsl:for-each>
			</table>
		</xsl:if>

		<!-- Getränke -->
		<xsl:if
			test="Getränk[@getränkegattung-id='nichtalk_getränke'] 
		| Getränk[@getränkegattung-id='alk_getränke']
		| Getränk[@getränkegattung-id='warme_getränke'] ">
			<h3>Getränke</h3>
			<table>
				<tr>
					<th>Bezeichnung</th>
					<th>Preis</th>
				</tr>
				<xsl:for-each
					select="Getränk[@getränkegattung-id='nichtalk_getränke'] | 
				Getränk[@getränkegattung-id='alk_getränke'] | 
				Getränk[@getränkegattung-id='warme_getränke'] ">
					<tr>
						<td>
							<xsl:value-of select="@bezeichnung" />
						</td>
						<td>
							<xsl:value-of select="@preis" />

						</td>
					</tr>
				</xsl:for-each>
			</table>
		</xsl:if>



	</xsl:template>


</xsl:stylesheet>
 
  
  
