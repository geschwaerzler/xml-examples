<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html" />

	<xsl:template match="/Lieferservice">
		<html>
			<head>
				<title>Lieferando</title>
			</head>
			<body>
				<h2>Lieferando</h2>
				<h3>Unsere Partner:</h3>
				<ul>
					<xsl:for-each select="Restaurant">
						<li>
							<a href="#{generate-id()}">
								<xsl:value-of select="geschaeft/@name" />
							</a>
						</li>
					</xsl:for-each>
				</ul>

				<xsl:apply-templates select="//Restaurant" />
				<h3>Gesamtübersicht - Speisen und Getränke</h3>
				<table>
					<thead>
						<tr>
							<th>Speise/Getränk</th>
							<th>Preis</th>
							<th>Restaurant</th>
						</tr>
					</thead>
					<tbody>
						<xsl:for-each
							select="Restaurant/Speise | Restaurant/Getränk">
							<xsl:sort select="@bezeichnung" />
							<tr>
								<td>
									<xsl:value-of select="@bezeichnung"></xsl:value-of>
								</td>
								<td>
									<xsl:value-of select="@preis"></xsl:value-of>
								</td>
								<td>
									<a href="#{generate-id(../geschaeft)}">
										<xsl:value-of select="../geschaeft/@name" />
									</a>
								</td>
							</tr>
						</xsl:for-each>
					</tbody>
				</table>
			</body>
		</html>
	</xsl:template>

	<xsl:template match="Restaurant" mode="menu">
		<h3>
			<a name="{geschaeft/@name}">
				<xsl:value-of select="geschaeft/@name" />
			</a>
		</h3>
	</xsl:template>



	<xsl:template match="Restaurant">
		<h3>
			<a name="{generate-id()}">
				<xsl:value-of select="geschaeft/@name" />
			</a>
		</h3>
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
 
  
  
