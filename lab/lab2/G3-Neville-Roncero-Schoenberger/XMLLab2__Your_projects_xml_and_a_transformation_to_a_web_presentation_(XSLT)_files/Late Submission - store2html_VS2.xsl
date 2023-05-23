<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	
	<xsl:output method="html"></xsl:output>
	
	<xsl:template match="/store">
		<html>
			<head>
				<title><xsl:value-of select="@store_name"/></title>
				<style>
					th, td {padding: 15px; width: 150px; }
					th {text-align: left; }
					table {border-collapse: collapse; }
					th, td {border: 1px solid black; }
				</style>
			</head>
			
			<body>
				<h1><xsl:value-of select="@store_name"/></h1>
				
				<!-- Inhaltsverzeichnis -->
				<h2> Table of Contents </h2>
				<ol>
					<xsl:apply-templates select="product" mode="toc"/>
				</ol>
				
				<!-- Produkte -->
				<h2> Products </h2>
				<xsl:apply-templates select="product" mode="detail"/>
				
				<!-- Liste aller Songs mit Index -->
				<h2>Song List</h2>
				<ul>
					<xsl:apply-templates select="product/song" mode="all">
						<xsl:sort select="@name"/>
					</xsl:apply-templates>
				</ul>
			</body>
		</html>
	</xsl:template>
	
	<!-- Template für Inhaltsverzeichnis -->
	<xsl:template match="product" mode="toc">
		<li><a href="#{generate-id()}"><xsl:value-of select="@title"/></a></li>
	</xsl:template>
	
	<!-- Template für Detailansicht eines Produktes -->
	<xsl:template match="product" mode="detail">
		<h3 id="{generate-id()}"><xsl:value-of select="@title"/></h3>
		
		<img src="{@image}" width="20%"/>
		
		<p><b>Artist: </b><xsl:value-of select="id(@artist_id)/@artist_name"/></p>
		<p><b>Media: </b><xsl:value-of select="@media"/></p>
		<p><b>Genre: </b><xsl:value-of select="@genre"/> </p>
		<p><b>Label: </b><xsl:value-of select="@label"/> </p>
		<p><b>Length: </b><xsl:value-of select="@length"/> </p>
		<xsl:if test="@number_of_cds">
			<p><b>Number of CDs: </b><xsl:value-of select="@number_of_cds"></xsl:value-of> </p>
		</xsl:if>
		<p><b>Release Date: </b><xsl:value-of select="@release_date"></xsl:value-of> </p>
		<p><b>Condition: </b><xsl:value-of select="@condition"></xsl:value-of> </p>
		<p><b>Price: </b><xsl:value-of select="@retail_price"></xsl:value-of>€ </p>
		
		<table>
			<thead>
				<tr>
					<th> Song Name </th>
					<th> Featured Artist(s) </th>
					<th> Length </th>
					<xsl:if test="@media = 'LP'">
						<th> LP - Side </th>
					</xsl:if>
					<xsl:if test="@number_of_cds">
						<th> Nr. of CD </th>
					</xsl:if>
				</tr>
			</thead>
			<xsl:apply-templates select="song" mode="detail"/>		
		</table>
		
		<hr/>
	</xsl:template>
	
	<!-- Template für Detailansicht eines Songs innerhalb eines Produktes -->
	<xsl:template match="song" mode="detail">
		<tbody>
			<tr>
				<td> <p><xsl:value-of select="./@name"/></p> </td>
				<td> 
					<xsl:for-each select="id(featured_artist/@artist_id)">
						<p> <xsl:value-of select="@artist_name"/> </p>
					</xsl:for-each>
				</td>
				<td> <xsl:value-of select="@length"/> </td>
				<xsl:if test="ancestor::product/@media = 'LP'">
					<td> <xsl:value-of select="@lp_side"/> </td>
				</xsl:if>
				<xsl:if test="ancestor::product/@number_of_cds">
					<td> <xsl:value-of select="@cd_number"/> </td>
				</xsl:if>
			</tr>
		</tbody>
	</xsl:template>
	
	<!-- Template für Songliste Index -->
	<xsl:template match="product/song" mode="all">
		<li>
			<xsl:value-of select="./@name"/>
			<i> in: </i><a href="#{generate-id(..)}"><xsl:value-of select="ancestor::product/@title"/><br/></a>
		</li>	
	</xsl:template>
	
	<!-- xml.SelectNodes("/Names/Name[@type='M']"); -->	
</xsl:stylesheet>