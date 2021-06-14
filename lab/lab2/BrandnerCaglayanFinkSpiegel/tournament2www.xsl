<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:template match="/tournament">
	<html>
		<head>
			<style>
				table {
				  font-family: arial, sans-serif;
				  border-collapse: collapse;
				  width: 50%;
				}
				
				td, th {
				  border: 1px solid #dddddd;
				  text-align: left;
				  padding: 8px;
				}
				
				tr:nth-child(even) {
				  background-color: #dddddd;
				}
			</style>
			<title>WFAC 2021</title>
		</head>
		<body>
			<h1><xsl:value-of select="@name"></xsl:value-of></h1>
			
			<!-- Inhaltsverzeichnis -->
			<h2>Inhaltsverzeichnis</h2>
				<ol>
					<xsl:apply-templates select="group" mode="table-of-contents"/>
					<xsl:apply-templates select="match" mode="table-of-contents"/>
				</ol>
			
			<!-- Groups -->
			<xsl:apply-templates select="group" mode="detail"/>
				
			<!--Punktliste -->
			<xsl:apply-templates select="match" mode="detail"/>
		</body>
	</html>
	</xsl:template>
	
	
	<xsl:template match="group" mode="table-of-contents">
		<li> <a href="#{generate-id()}"> <xsl:value-of select="@group-name" /> </a></li>
	</xsl:template>
	
	
	<xsl:template match="match" mode="table-of-contents">
		<li> <a href="#{generate-id()}"> <xsl:value-of select="id(@round-id)/@round-name"/> (<xsl:value-of select="@start-time"/> - <xsl:value-of select="@end-time"/>) </a></li>
	</xsl:template>
	
	
	<xsl:template match="group" mode="detail">
		<hr/>
		<h3 id="{generate-id()}"><xsl:value-of select="@group-name" /></h3>
		<ul style="list-style-type:none;">
			<xsl:for-each select="competitor">
				<li> <a href="#{generate-id()}"> <xsl:value-of select="text()" /> (<xsl:value-of select="id(@country-id)/@country-name"/>) </a></li>
			</xsl:for-each>
		</ul>
	</xsl:template>
	
	
	<xsl:template match="match" mode="detail">
		<hr/>
		<h3 id="{generate-id()}"><xsl:value-of select="id(@round-id)/@round-name"/></h3>
		<h4><xsl:value-of select="@start-time"/> - <xsl:value-of select="@end-time"/></h4>
	
		<xsl:for-each select="archer-score">
			<xsl:variable name="competitor" select="id(@competitor-id)" />
			<p id="{generate-id($competitor)}"><xsl:value-of select="$competitor/text()"/> </p>
			
			<table>
			<tr>
				<th>Target</th>
    			<th>Arrow 1</th>
    			<th>Arrow 2</th>
    			<th>Arrow 3</th>
    			<th>Arrow 4</th>
			</tr>
			<xsl:for-each select="target">
				<tr>
					<td><xsl:value-of select="@nr" /></td>
				<xsl:for-each select="score">
						<td><xsl:value-of select="@points" /></td>
				</xsl:for-each>
				</tr>
			</xsl:for-each>
		</table>
		</xsl:for-each>
	</xsl:template>
	
</xsl:stylesheet>