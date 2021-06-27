<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">


	<xsl:output method="html" />

	<xsl:template match="tournament">
		<html>
			<head>
			<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous" />
				<title>
					<xsl:value-of select="tournament/description" />
				</title>
				<style>p.ingredient {
					margin-top: 2px;
					margin-bottom: 2px;
					}
					span.amount {
					font-style: italic;
					color: grey;
					}
					h1 {font-size: 200%; }
					h2 {font-size: 160%; }
					h3 {font-size: 140%; }
					h4 {font-size: 120%; }
					h5 {font-size: 100%; }
					li.small {font-size: 80%; color: black}
					.points {color: black}
					.underline {color: white}
					</style>
			</head>
			<body>
				<h1>
					<xsl:value-of select="description" />
				</h1>

				<h2>Inhaltsverzeichnis</h2>

				<ul>
					<xsl:apply-templates select="group" mode="hl" />
				</ul>
				
				<xsl:apply-templates select="group" mode="details"/>	
				
				<h2>Scorecards</h2>		
					
				
				<xsl:for-each select="group/athlete">
					<xsl:variable name="aid" select ="@id"/>
					<hr/>
					
					<h3 id= "{@id}"><xsl:value-of select = "concat(@firstname,' ',@lastname , ' - Gruppe ', ../@nr,' ' , ../round/@date)" xml:space = "preserve"/> </h3>	
					<table cellspacing = "1" cellpadding = "10" border = "thin"> 
						<tr>
						 	
						 	<th>Runde</th>		
							<th>Zielscheibe</th>
							<th>Versuch 1</th>
							<th>Versuch 2</th>		
							<th>Versuch 3</th>
							<th>Punkte</th>	
																		
						</tr>	
						<xsl:apply-templates select = "//score-card[@athlete-id = $aid]/target" mode = "detail"/>									
					</table>					
				</xsl:for-each>				
						
			</body>			
		</html>
	</xsl:template>
	
	

	<xsl:template match="group" mode="hl">
		<li><a href= "#{generate-id()}"> Gruppe-<xsl:value-of select="@nr" /></a></li>
	</xsl:template>
	

	<xsl:template match="group" mode="details"> 
		<hr/> <h3 id="{generate-id()}"> Gruppe <xsl:value-of select="@nr"/> </h3>		
		<xsl:apply-templates select="athlete"/>		
	</xsl:template>
		
	
	<xsl:template match="athlete">
		<xsl:variable name="aid" select ="@id"/>	
		<li class = "small"> <a href= "#{@id}"><xsl:value-of select="concat(@firstname, ' ' , @lastname)"/></a> 
		
		<ul>
			<br/><xsl:apply-templates select="../round/score-card[@athlete-id = $aid]"/>
		</ul>
		<br/>
		<br/>
		
		</li>	
	</xsl:template>


	<xsl:template match="score-card">
		<li class = "small">Runde <xsl:value-of select="concat(../@nr, ' am ' ,../@date, ' . . . . . . . . . . ')"/>
			<span class = "points"><xsl:value-of select = "sum(target/score/@points)"/></span>
		</li>		
	</xsl:template>
	
	
	<xsl:template match = "target" mode = "detail">
				
			
			<tr>
				<td> <xsl:value-of select = "../../@nr"/></td>
				<td> <xsl:value-of select = "@nr"/></td>
				<td> <xsl:value-of select = "score[1]/@points"/></td>
				<td> <xsl:value-of select = "score[2]//@points"/></td>
				<td> <xsl:value-of select = "score[3]/@points"/></td>
				<td> <xsl:value-of select = "sum(score/@points)"/></td>				
			</tr>											
	
	</xsl:template>	

</xsl:stylesheet>