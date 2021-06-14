<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:template match="/">
		<html>
			<head>
				<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous" />
				<title>
					WFAC 2020
				</title>
				<style>
					hr.hruler {
						margin-top:10px;
    					margin-bottom:2px;
					  }

					  body {

						  padding:20px;
						}
				</style>
			</head>
			<body>
				<h2>
					<xsl:value-of select="organizer/tournament/@description" />
				</h2>
				<h4>Inhaltsverzeichnis:</h4>
				<ul>
					<xsl:apply-templates select="organizer/tournament/tdate/group" mode="toc" />
				</ul>

				<xsl:apply-templates select="organizer/tournament/tdate" mode="detail" />

				<h4>Scorecards</h4>
				<xsl:apply-templates select="organizer/tournament/tdate/group/participant" mode="scorecards"/>
			</body>
		</html>
	</xsl:template>


	<!-- Produziert die Links im Inhaltsverzeichnis-->
	<xsl:template match="group" mode="toc">
		<li>
			<a href="#{../@day}">
				<xsl:value-of select="title" /> - <xsl:value-of select="ancestor::tdate/@date" />
			</a>
		</li>
	</xsl:template>


	<!-- Link trifft auf die Überschrift -->
	<xsl:template match="tdate" mode="detail">
		<h4 id="{@day}"><xsl:value-of select="@day" /> Day, <xsl:value-of select="@date" /></h4>
			<hr class="hruler"/>
			<xsl:for-each select="group/title">
				<h5><xsl:value-of select="." /></h5>
				<!-- Table with Name and score -->
				<table style="width:25%">
					<xsl:for-each select="../participant">
						<xsl:sort select="@name" order="ascending"/>
						<tr>
							<td xml:space="preserve"><xsl:value-of select="@firstname"/> <xsl:value-of select="@lastname"/></td>
							<td>
								<a href="#{@id}">
									(<xsl:value-of select="score/@total_score"/>)
								</a>
							</td>
						</tr>
					</xsl:for-each>
				</table>
				<br/>
			</xsl:for-each>

			<h5><xsl:value-of select="@day"/> Day of scoring</h5>
			<table style="width:25%">
				<xsl:for-each select="group/participant">
					<xsl:sort select="score/@total_score" data-type="number" order="descending"/>
					<tr>
						<td xml:space="preserve"><xsl:value-of select="@firstname"/> <xsl:value-of select="@lastname"/></td>
						<td>(<xsl:value-of select="score/@total_score"/>)</td>
					</tr>
				</xsl:for-each>
			</table>
			<br/>
	</xsl:template>

	<xsl:template match="participant" mode="scorecards">
		<hr/>
		<h5 id="{@id}" xml:space="preserve">
			<xsl:value-of select="@firstname"/>
			<xsl:value-of select="@lastname"/> -
			<xsl:value-of select="../@name"/>,
			<xsl:value-of select="../../@date"/>
		</h5>

			<table class="table" style="width:50%">
				<tr>
					<td><b>Round</b></td>
					<xsl:for-each select="score/round" xml:space="preserve">
						<td><b><xsl:value-of select="@nr"/></b></td>
					</xsl:for-each>
					<td><b>Total</b></td>
				</tr>
				<tr>
					<td>Score</td>
					<xsl:for-each select="score/round" xml:space="preserve">
						<td><xsl:value-of select="@round_score"/></td>
					</xsl:for-each>
					<td><b><u><xsl:value-of select="score/@total_score"/></u></b></td>
				</tr>
			</table>
	</xsl:template>
</xsl:stylesheet>
