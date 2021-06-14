<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	
	<!-- Root Template -->
	<xsl:template match="/overview">
		<html>
			<head>
				<title>Wettbewerbe</title>
				<!--  <link rel="stylesheet" type="text/css" href="css/night.css"/> -->
			</head>
			
			
			<body>
			
				<h1>Inhaltsverzeichnis</h1>
				<ol>
					<li><a href="#{generate-id()}"> Wettkaempfer</a></li>
					<ol>
						<xsl:for-each select="competitor">
							<li><a href="#{generate-id()}"><xsl:value-of select="@first_name"/>&#160;<xsl:value-of select="@last_name"/></a></li>
						</xsl:for-each>
					</ol>
					<li><a href="#{generate-id()}"> Tuniere</a></li>
					<ol>
						<xsl:for-each select="tournament">
							<li><a href="#{generate-id()}"><xsl:value-of select="@id"/></a></li>
						</xsl:for-each>
					</ol>
				</ol>
			
				<h1 id="{generate-id()}">Wettkaempfer</h1>
				<table>
					<tr>
						<th>ID</th>
						<th>Vorname</th>
						<th>Nachname</th>
						<th>Geburtsdatum</th>
						<th>Bogenklasse</th>
					</tr>
					<xsl:apply-templates select="competitor" />
				</table>
				
				
				<h1 id="{generate-id()}">Wettkaempfe</h1>
				<xsl:apply-templates select="tournament" />
				
				
			</body>
		</html>
	</xsl:template>


	<!-- Competiton Template -->
	<xsl:template match="competitor">
		<tr>
			<td> <xsl:value-of select="@id"/>   </td>
			<td id="{generate-id()}"> <xsl:value-of select="@first_name"/>   </td>
			<td> <xsl:value-of select="@last_name"/>   </td>
			<td> <xsl:value-of select="@date_of_birth"/>   </td>
			<td> <xsl:value-of select="@bow_class"/>   </td>
		</tr>
	</xsl:template>
	
	
	<xsl:template match="tournament">
		<h2 id="{generate-id()}">Tournment: <xsl:value-of select="@id"/></h2>
		
		<ul>
			<li>Anmeldefrist: <xsl:value-of select="@register_end_date"/></li>
	    	<li>Dauer: <xsl:value-of select="@event_start_date"/> - <xsl:value-of select="@event_end_date"/></li>
		</ul>

		
		<xsl:for-each select="competition_day">
			<h3>Spieltag <xsl:value-of select="@date_time"/></h3>
			<xsl:for-each select="round">
			
			
				<h4>Runde <xsl:value-of select="@id"/></h4>
				<table>
					<tr>
						<th>Ziel</th>
						<xsl:for-each select="/overview/competitor">
							<th><xsl:value-of select="@first_name"/>&#160;<xsl:value-of select="@last_name"/> </th>
						</xsl:for-each>
					</tr>
					
					<xsl:for-each select="target">
					<tr>
						<td>
							<xsl:value-of select="@target_size"/>&#160;
							<xsl:value-of select="@range"/>&#160;
							<xsl:value-of select="@ground_markers"/>&#160;
						</td>
						
						<xsl:for-each select="score">
							<td>
								<xsl:for-each select="attempt">
									<xsl:value-of select="@points"/>&#160;
								</xsl:for-each>							
							</td>
						</xsl:for-each>
						
					</tr>
					</xsl:for-each>
					
					
					
				</table>
			
			
			</xsl:for-each>		
		</xsl:for-each>
		
	</xsl:template>
	


</xsl:stylesheet>