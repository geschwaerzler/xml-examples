<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	
	<xsl:output method="html"/>
	
	<xsl:template match="/tournament">
	
	<!-- https://ilias.fhv.at/goto_ilias_fhv_at_file_528590_download.html -->
	
		<html>
			<head>
				<style>
					table, th, td {
					  border: 1px solid black;
					  border-collapse: collapse;
					}
					table.center {
					  margin-left: auto;
					  margin-right: auto;
					}
				</style>
				<title>WOFAC Torunanemnt</title>
				<h1>World Outdoor Flint Archery Mail Match</h1>
			</head>
			
			<body>
				<h2>Inhaltsverzeichnis</h2>
				<h3>Events</h3>
				
				<ol>
					<xsl:apply-templates select="event" mode="table-of-contents"/>
				</ol>
				
				<xsl:apply-templates select="event" mode="detail"/>
				
				<hr/>
				
				<xsl:apply-templates select="participant" mode="scoring"/>
				
				<hr/>
				
			</body>
		</html>
		
	</xsl:template>

	<xsl:template match="event" mode="table-of-contents">
		<a href = "#{generate-id()}">
			<li>
				<xsl:value-of select="@id"/> &#160; <xsl:value-of select="@date"/>
			</li>
		</a>
	</xsl:template>
	
	<xsl:template match="event" mode="detail">
		<hr/>
		<h2 id="{generate-id()}"><xsl:value-of select="@id"/> &#160; <xsl:value-of select="@date"/></h2>
		<xsl:apply-templates select="../division" mode="default">
			<xsl:with-param name="event-id" select="@id"></xsl:with-param>
		</xsl:apply-templates>
		<h2><xsl:value-of select="@id"/> &#160; Scoring</h2>
		<table>
			<xsl:apply-templates select="../participant" mode="scoring-daily">
				<xsl:with-param name="event-id" select="@id"/>
				<xsl:sort select="sum(match[@event-id = @id]/scoring/table/arrow/@points)" data-type="number" order="descending"/>
			</xsl:apply-templates>
		</table>
	</xsl:template>
	
	<xsl:template match="participant" mode="scoring-daily">
		<xsl:param name="event-id"/>
		<tr>
			<td>
				<xsl:value-of select="@fname"/>
			</td>
			<td>
				<xsl:value-of select="@lname"/>
			</td>
			<td>
				<a href="#{generate-id()}">
					<xsl:value-of select="sum(./match[@event-id = $event-id]/scoring/table/arrow/@points)"/>
				</a>
			</td>
		</tr>
	</xsl:template>
	
	<xsl:template match="division" mode="default">
		<xsl:param name="event-id"/>
		<h2><xsl:value-of select="@id"/></h2>
		<table>
			<xsl:apply-templates select="../participant" mode="division">
				<xsl:with-param name="division-id" select="@id"/>
				<xsl:with-param name="event-id" select="$event-id"/>
			</xsl:apply-templates>
		</table>
	</xsl:template>
	
	<xsl:template match="participant" mode="division">
		<xsl:param name="division-id"/>
		<xsl:param name="event-id"/>
			<xsl:if test="(@div-id = $division-id) and (match/@event-id = $event-id)">
				<tr>
					<td>
						<xsl:value-of select="@fname"/>
					</td>
					<td>
						<xsl:value-of select="@lname"/>
					</td>
					<td>
						<a href="#{generate-id()}">
							<xsl:value-of select="sum(./match[@event-id = $event-id]/scoring/table/arrow/@points)"/>
						</a>
					</td>
				</tr>
			</xsl:if>
	</xsl:template>
	
	<xsl:template match="participant" mode="scoring">
		<h2 id="{generate-id()}"> <xsl:value-of select="@fname"/> &#160; <xsl:value-of select="@lname"/></h2>
		<xsl:apply-templates select="match"/>
	</xsl:template>
	
	<xsl:template match="match">
		<h3><xsl:value-of select="@event-id"/></h3>
		<xsl:apply-templates select="scoring"/>
	</xsl:template>
	
	<xsl:template match="scoring">
		<table>
			<tr>
				<th>
					target#
				</th>
				<xsl:for-each select="table[1]/arrow">
					<th>
						arrow: &#160;
						<xsl:value-of select="@arrow-nr"/>
					</th>
				</xsl:for-each>
			</tr>
			<xsl:for-each select="table">
				<tr>
					<td>
						<xsl:value-of select="@target-id"/>
					</td>
					<xsl:for-each select="arrow">
						<td>
							<xsl:value-of select="@points"/>
						</td>
					</xsl:for-each>
				</tr>
			</xsl:for-each>
		</table>
	</xsl:template>

</xsl:stylesheet>