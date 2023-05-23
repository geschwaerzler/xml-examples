<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html"/>
	
	<xsl:template match="/collection">
		<html>
			<head>
				<title>Bestellungen</title>
				
			</head>
			<body>
				<h1>Stammkunden</h1>
					<xsl:apply-templates select="Kunde/Person" mode="toc"/>
								
				<h1>Bestellungen</h1>
					
					<xsl:apply-templates select="Kunde/Person" mode="detail"/>
					
				<h1>Karte</h1>
					<h2>Speisekarte</h2>
					<xsl:apply-templates select="Speisekarte"/>
					<h3>Getränke</h3>
						<xsl:for-each select="//Getränk">
							<p>
								<b><xsl:value-of select="@name" /></b>
							</p>
							<p>	
								<xsl:value-of select="@behältnis"/>
							</p>
							<p>
								<xsl:value-of select="@preis"/> Euro
							</p>						
						
						</xsl:for-each>
					<h3>Extras</h3>		
						<xsl:for-each select="//Extra" >
							<p>
								<b><xsl:value-of select="@name" /></b>
							</p>
							<p>
								<xsl:value-of select="@preis"/> Euro
							</p>
						</xsl:for-each>
								
					
				<h1>Bestellte Speisen</h1>
					<table>
						<thead>
							<tr>
								<td width="200px"><b>Artikel</b></td>
								<td width="150px"><b>Name</b></td>
								<td><b>Datum</b></td>
							</tr>
						</thead>		
						<xsl:apply-templates select="//position">
							<xsl:sort select="id(@artikel)/@name"/>
						</xsl:apply-templates>
					</table>
			</body>
		</html>
	</xsl:template>
	
	<xsl:template match ="Person" mode="toc"> 
		<h2>
			<a xml:space = "preserve" href="#{generate-id()}">
				<xsl:value-of select="name/vorname"/>
				<xsl:value-of select="name/nachname"/>
			</a>
		</h2>
	</xsl:template>

	<xsl:template match ="Person" mode="detail"> 
		<h2 >
			<a id="{generate-id()}" xml:space = "preserve">
				<xsl:value-of select="name/vorname" />
				<xsl:value-of select="name/nachname"/>
			</a>
		</h2>
		<xsl:apply-templates select="bestellung"/>
	</xsl:template>
	
	<xsl:template match="bestellung">
		<h3  xml:space="preserve">
			<xsl:value-of select="@datum" />
			<xsl:value-of select="@uhrzeit"/>	
		</h3>
		<table>
			<thead>
				<tr>
					<th width="200px">Artikel</th>
					<th width="60px">Anzahl</th>
					<th>Preis</th>
				</tr>
			</thead>
			<xsl:for-each select="position">
				<tr>
					<td id="{generate-id(ancestor::bestellung)}"><xsl:value-of select="id(@artikel)/@name" /></td>
					<td><xsl:value-of select="@menge"/></td>
					<td><xsl:value-of select="@einzelpreis"/></td>
				</tr>
			</xsl:for-each>
		</table>	
	</xsl:template>
	
	<xsl:template match="Speise">
		<h3><xsl:value-of select="@name"/></h3>
			<xsl:for-each select="Zutat">
				<li><xsl:value-of select="."/></li>
			</xsl:for-each>	
		<p>Preis: <xsl:value-of select="@preis"/> Euro</p>
	</xsl:template>

	
	
	<xsl:template match="//position">
		<tr xml:sort="">
			<td>
				<a href="#{generate-id(ancestor::bestellung)}">
					<xsl:value-of select="id(@artikel)/@name"/>
				</a>
			</td>
			<td xml:space="preserve">
				<xsl:value-of select="ancestor::Person/name/vorname"/>
				<xsl:value-of select="ancestor::Person/name/nachname"/>
			</td>
			<td><xsl:value-of select="ancestor::bestellung/@datum"/></td>		
		</tr>
	</xsl:template>
</xsl:stylesheet>