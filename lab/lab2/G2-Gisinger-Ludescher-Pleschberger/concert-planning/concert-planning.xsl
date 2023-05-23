<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html"/>
	<xsl:template match="/concert-planning">
		<html>
			<head>
				<title>Sold tickets for concert</title>
			</head>
			<body>
				<xsl:apply-templates select="concert" mode="details"/>
				
				<h2>Customerlist and bought tickets</h2>
				
				<xsl:apply-templates select="customer" mode="default"/>
			</body>
		</html>
	</xsl:template>
	
	<xsl:template match = "concert" mode = "details">
		<table>
			<thead>
				<tr>
					<th colspan="3"><xsl:value-of select="@title"/></th>
				</tr>
				<tr>
					<th>
					Ticket ID
					</th>
					<th>
					Customer ID
					</th>
				</tr>
			</thead>
			<tbody>
				<xsl:variable name="cid" select = "@concert_id"/>
					<xsl:for-each select="../ticket_ref[@concert_id = $cid]">
						<tr>
							<td>
								<xsl:value-of select="@ticket_id"/>							
							</td>
							<td>
								<xsl:value-of select="@customer_id"/>
							</td>
						</tr>
					</xsl:for-each>
			</tbody>
		</table>
	</xsl:template>
	<xsl:template match = "customer" mode = "default">
		<table>
			<thead>
				<tr>
					<th><xsl:value-of select="@name"/></th>
				</tr>
				<tr>
					<th>
					Ticket ID
					</th>
					<th>
					Concert Name
					</th>
				</tr>
			</thead>
			<tbody>
				<xsl:variable name="custid" select = "@customer_id"/>
					<xsl:for-each select="../ticket_ref[@customer_id = $custid]">
						<xsl:variable name="cid" select = "@concert_id"/>
							<tr>
								<td>
									<xsl:value-of select="@ticket_id"/>							
								</td>
								<td>
									<xsl:value-of select="../concert[@concert_id = $cid]/@title"/>
								</td>
							</tr>
					</xsl:for-each>
			</tbody>
		</table>
	</xsl:template>
</xsl:stylesheet>