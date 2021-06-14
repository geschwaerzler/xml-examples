<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:template match="/">
		<html>
			<head>
				<title>Archery tournaments</title>
				<style>
					table {
					    margin-top: 20px;
					}
					
					table,
					th,
					td {
					    border: 1px solid black;
					    border-collapse: collapse;
					}
					
					th,
					td {
					    padding: 2px 4px 2px 4px;
					    text-align: center;
					}</style>
			</head>

			<body>
				<h1>Archery Tournament Results</h1>

				<h2>Table of Contents</h2>
				<ol>
					<xsl:apply-templates select="archery-tournament/tournament" mode="toc"/>
				</ol>

				<xsl:apply-templates select="archery-tournament/tournament" mode="detail"/>
			</body>
		</html>
	</xsl:template>

	<xsl:template match="tournament" mode="toc">
		<li>
			<a href="#{generate-id()}">
				<xsl:value-of select="@name"/>
			</a>
			<xsl:if test="event">
				<ul>
					<xsl:apply-templates select="event" mode="toc"/>
				</ul>
			</xsl:if>
		</li>
	</xsl:template>

	<xsl:template match="event" mode="toc">
		<xsl:if test="participation/score">
			<li>
				<a href="#{generate-id()}">
					<xsl:value-of select="@title"/>
				</a>
			</li>
		</xsl:if>
	</xsl:template>

	<xsl:template match="tournament" mode="detail">
		<hr/>
		<h2 id="{generate-id()}">
			<xsl:value-of select="@name"/>
		</h2>

		<xsl:apply-templates select="." mode="podium"/>

		<xsl:apply-templates select="event"/>
	</xsl:template>

	<xsl:template match="tournament" mode="podium">
		<ol>
			<xsl:for-each select=".//application/@athlete-id">
				<xsl:sort
					select="sum(ancestor::tournament/event/participation[@athlete-id = current()]/sum(score/sum(arrow)))"
					order="descending" data-type="number"/>

				<li> Place (<xsl:value-of
						select="sum(ancestor::tournament/event/participation[@athlete-id = current()]/sum(score/sum(arrow)))"
					/> Points): <xsl:call-template name="athlete-name-by-id">
						<xsl:with-param name="athlete-id" select="current()"/>
					</xsl:call-template>
				</li>
			</xsl:for-each>
		</ol>
	</xsl:template>

	<xsl:template match="event">
		<xsl:if test="participation/score">
			<h3 id="{generate-id()}">
				<xsl:value-of select="@title"/>
			</h3>
		</xsl:if>

		<xsl:apply-templates select="participation"/>
	</xsl:template>

	<xsl:template match="participation">
		<xsl:variable name="athleteName">
			<xsl:call-template name="athlete-name-by-id">
				<xsl:with-param name="athlete-id" select="@athlete-id"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="arrowCount" select="max(score/count(arrow))"/>
		<xsl:variable name="cols" select="$arrowCount + 2"/>

		<xsl:if test="score">
			<table>
				<thead>
					<tr>
						<th colspan="{$cols}">
							<xsl:value-of select="$athleteName"/>
						</th>
					</tr>
					<tr>
						<th>Target</th>
						<xsl:for-each select="1 to $arrowCount">
							<th>Arrow <xsl:value-of select="position()"/></th>
						</xsl:for-each>
						<th>TOTAL</th>
					</tr>
				</thead>
				<tbody>
					<xsl:for-each select="score">
						<tr>
							<td>
								<xsl:value-of select="position()"/>
							</td>
							<xsl:for-each select="arrow">
								<td>
									<xsl:value-of select="text()"/>
								</td>
							</xsl:for-each>
							<td>
								<xsl:value-of select="sum(arrow)"/>
							</td>
						</tr>
					</xsl:for-each>
					<tr>
						<td colspan="{$cols - 1}"/>
						<td>
							<b>
								<xsl:value-of select="sum(score/sum(arrow))"/>
							</b>
						</td>
					</tr>
				</tbody>
			</table>
		</xsl:if>
	</xsl:template>

	<xsl:template name="athlete-name-by-id">
		<xsl:param name="athlete-id"/>

		<xsl:for-each select="//athlete">
			<xsl:if test="./@id = $athlete-id">
				<xsl:value-of select="concat(@firstname, ' ', @lastname)"/>
			</xsl:if>
		</xsl:for-each>
	</xsl:template>
</xsl:stylesheet>
