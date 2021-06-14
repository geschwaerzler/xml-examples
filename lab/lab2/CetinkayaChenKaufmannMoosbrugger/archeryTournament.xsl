<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html"/>
	<xsl:template match="/tournament">
		<html>
			<head>
				<title><xsl:value-of select="@name"/></title>
			</head>
			<body>
			<h1><xsl:value-of select="@name"/></h1>
			<!-- Inhaltsverzeichnis -->
			<h2>Inhaltsverzeichnis</h2>
			<ol>
				<li><a href="#C0001">Rangliste je Tag</a>
					<ol>
						<li><a href="#C0011">1. Tag</a></li>
						<li><a href="#C0012">2. Tag</a></li>
						<li><a href="#C0013">3. Tag</a></li>
					</ol>
				</li>
				<li><a href="#C0002">Gruppen - Athleten</a>
				<ol>
					<xsl:apply-templates select="group" mode="list-of-contents"/>
				</ol>
				</li>
				<li><a href="#C0003">Gruppen - Ergebnisse</a></li>
				<li><a href="#C0004">Teilnehmer</a></li>
				<li><a href="#C0005">Ranges</a></li>
			</ol>
			
			<!-- List of rounds with groups per day -->
			<h2 id="C0001">Ranglisten je Tag</h2>
			<!-- 1.Tag -->
			<h3 id="C0011">1. Tag, 19.06.2021</h3>
			<table>
			<xsl:for-each select="group/round[@date = '2021-06-19']/score-card">
				<xsl:sort select="sum(target/score/@points)" order="descending"/>
				<xsl:variable name="person" select="id(@athlete-id)"/>
			
				<tr>
				<td><xsl:value-of select="position()"/>.</td>
				<td><xsl:value-of select="$person/@firstname"/></td>
				<td><xsl:value-of select="$person/@lastname"/></td>
				<td>
				<a href="#{generate-id()}"><xsl:value-of select="sum(target/score/@points)"/></a>
				</td>
				</tr>
			</xsl:for-each>
			</table>
			 
			<!-- 2.Tag -->
			<h3 id="C0012">2. Tag, 20.06.2021</h3>
			<table>
			<xsl:for-each select="group/round[@date = '2021-06-20']/score-card">
				<xsl:sort select="sum(target/score/@points)" order="descending"/>
				<xsl:variable name="person" select="id(@athlete-id)"/>
			
				<tr>
				<td><xsl:value-of select="position()"/>.</td>
				<td><xsl:value-of select="$person/@firstname"/></td>
				<td><xsl:value-of select="$person/@lastname"/></td>
				<td>
				<a href="#{generate-id()}"><xsl:value-of select="sum(target/score/@points)"/></a>
				</td>
				</tr>
			</xsl:for-each>
			</table>
			<!-- 3.Tag -->
			<h3 id="C0013">3. Tag, 21.06.2021</h3>
			<table>
			<xsl:for-each select="group/round[@date = '2021-06-21']/score-card">
				<xsl:sort select="sum(target/score/@points)" order="descending"/>
				<xsl:variable name="person" select="id(@athlete-id)"/>
			
				<tr>
				<td><xsl:value-of select="position()"/>.</td>
				<td><xsl:value-of select="$person/@firstname"/></td>
				<td><xsl:value-of select="$person/@lastname"/></td>
				<td>
				<a href="#{generate-id()}"><xsl:value-of select="sum(target/score/@points)"/></a>
				</td>
				</tr>
			</xsl:for-each>
			</table>
			
			<!-- Gruppen combis -->
			<h2 id="C0002">Gruppen</h2>
			<xsl:apply-templates select="group" mode="athlete-list">
				<xsl:sort select="@nr"/>
			</xsl:apply-templates>	
			
			<!-- Ergebnisse gruppen-->
			<h2 id="C0003">Ergebnisse</h2>
			<xsl:apply-templates select="group" mode="result"/>
			
			
			<!-- Teilnehmerliste -->
			<h2 id="C0004">Teilnehmerlist:</h2>
			<table>
			<tr><th>Firstname</th><th>Lastname</th><th>Age</th><th>Club</th><th>Division</th> </tr>
			<xsl:for-each select="person">
				<xsl:sort select="@lastname"/>
				<xsl:sort select="@firstname"/>
				<tr>
					<td><xsl:value-of select="@firstname"/></td>
					<td><xsl:value-of select="@lastname"/></td>
					<td><xsl:value-of select="@age"/></td>
					<td><xsl:value-of select="@club"/></td>
					<td><xsl:value-of select="@shooting-style"/></td>
				</tr>
			</xsl:for-each>
			</table>
			
			<!-- Ranges list -->
			<h2 id="C0005">Ranges</h2>
			<table>
				<tr><th>Name</th><th>Beginnt bei</th></tr>
				<xsl:for-each select="range">
					<tr><td><xsl:value-of select="@name"/></td><td><xsl:value-of select="startLocation/text()"/></td></tr>
				</xsl:for-each>
			</table>
			</body>
		</html>
	</xsl:template>
	
	<xsl:template match="score-card" mode="full">
		<h4 id="{generate-id()}">Scorecard für: </h4>
		<xsl:value-of select="id(@athlete-id)/@firstname"/><xsl:text> </xsl:text>
		<xsl:value-of select="id(@athlete-id)/@lastname"/><xsl:text> Gruppe: </xsl:text>
		<xsl:value-of select="../../@nr"/> <xsl:text> Datum: </xsl:text>
		<xsl:value-of select="../@date"/>
		
		<table>
			<tr><th>target#</th><th>Arrow 1</th><th>Arrow 2</th><th>Arrow3</th><th>Arrow4</th></tr>
			<xsl:for-each select="target" >
				<tr>
					<td><xsl:value-of select="@id"/></td>
					<td><xsl:value-of select="score[@arrow-nr=1]/@points"/></td>
					<td><xsl:value-of select="score[@arrow-nr=2]/@points"/></td>
					<td><xsl:value-of select="score[@arrow-nr=3]/@points"/></td>
					<td><xsl:value-of select="score[@arrow-nr=4]/@points"/></td>
				</tr>
			</xsl:for-each>
		</table>
	</xsl:template>
	
	<xsl:template match="score-card" mode="sum">
		<xsl:param name="aid"/>
		<a href="#{generate-id()}"><xsl:value-of select="sum(id($aid)/target/score/@points)"/></a>
	</xsl:template>
	
	<xsl:template match="group" mode="list-of-contents">
		<li><a href="#{generate-id()}"><xsl:value-of select="@nr"/></a></li>
	</xsl:template>
	
	<xsl:template match="group" mode="result">
		<h3>Ergebnisse der Gruppe <xsl:value-of select="@nr"/></h3>
		<p><xsl:apply-templates select="round/score-card" mode="full"/></p>
	</xsl:template>
	
	<xsl:template match="group" mode="athlete-list" xml:space="preserve">
		<h3 id="{generate-id()}">Gruppe <xsl:value-of select="@nr"></xsl:value-of></h3>
		<xsl:text>Datum: </xsl:text>
		<xsl:value-of select="round/@date"/>
		<xsl:text> Round-Type: </xsl:text>
		<xsl:value-of select="round/@type"/>
		<xsl:text> on Range: </xsl:text>
		<xsl:value-of select="id(round/@range-id)/@name"/>
		<br/>
		<table>
		<tr><th>Firstname</th><th>Lastname</th><th>Role</th><th>Score</th></tr>
		<xsl:for-each select="athlete">
		<xsl:sort select="@role" order="descending"/>
		<tr>
			<td><xsl:value-of select="id(@person-id)/@firstname"/></td>
			<td><xsl:value-of select="id(@person-id)/@lastname"/></td>
			<td><xsl:value-of select="@role"/></td>
			<td>
			<xsl:variable name="athlete" select="@person-id"/>
			<a href="#{generate-id(../round/score-card)}"><xsl:value-of select="sum(../round/score-card[@athlete-id = $athlete]/target/score/@points)"/></a>
			</td>
		</tr>
		</xsl:for-each>
		</table>
	</xsl:template>
</xsl:stylesheet>