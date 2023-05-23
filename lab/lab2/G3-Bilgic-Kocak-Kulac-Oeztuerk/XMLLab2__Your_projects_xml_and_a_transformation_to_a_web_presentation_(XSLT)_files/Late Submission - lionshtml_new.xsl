<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" 
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	
	<xsl:output method="html" />
	<xsl:template match="/lions">
		<html>
			<head>
			<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous" />
				<title>
					<xsl:value-of select="@name" />
				</title>
				<style>style {
					margin-top: 2px;
					margin-bottom: 2px;
					}
					
					span.amount {
					font-style: italic;
					color: grey;
					}
					
					h1 {font-size: 260%; }
					h2 {font-size: 160%; font-style: bold}
					h3 {font-size: 140%; color: #04B404}
					h4 {font-size: 120%; font-style: italic }
					h5 {font-size: 100%; }
					li.small {font-size: 80%; color: black}
					.points {color: green}
					.underline {color: green}
					</style>
			</head>
			<body>
			
				<h1>
					<xsl:value-of select="@name" mode = "h1"/><br></br>
				</h1>
				
				<img src="C:\Users\Lenovo\Downloads\lions.png" alt="Logo Bild" width = "200" height ="100"/>

				<br></br><br></br>
				<h2>Inhaltsverzeichnis</h2>
				<ol>
					<xsl:for-each select="team">
						<li>
							<a href="#{@id}"><xsl:value-of select="@type"/> </a>
							<xsl:value-of select="id(@type)"/>
						</li>
					</xsl:for-each>
				</ol>
					
				<xsl:for-each select="team">
					<xsl:variable name="tid" select ="@id"/>
				
					<h3 id= "{@id}">
						<xsl:value-of select="concat(@association, ' - Geschlecht: ',@gender , ' - Kategorie: ',@type)" xml:space="preserve"/><br></br>
					</h3>
					
					<br></br>
					
					<xsl:for-each select="match">
						<xsl:variable name="mid" select ="@id"/>
						
						<h4 id= "{@id}">
							<xsl:value-of select ="concat(@date,' -> ', @hall, ' in ', @city)" xml:space="preserve"/><br></br>
						</h4>
					
						<h4>Winner Team</h4>
						<table cellspacing = "10" cellpadding = "20" border = "thin"> 
							<tr>
								<th>ID</th>
								<th>Spieler</th>        
								<th>Wurfposition</th>        
								<th>Punkte</th>                                    
							</tr>
						
							<xsl:for-each select ="winner-team/scoreboard">
								<tr>
									<td><a id ="{@player-id}"><xsl:value-of select="@player-id"/></a></td>
									<td><xsl:value-of select="concat(id(@player-id)/@firstname,  ' ', id(@player-id)/@lastname)"/></td>
									<td><xsl:value-of select="shooting-style/@description"/></td>
									<td><xsl:value-of select="shooting-style/@point"/></td>    
								</tr> 
							</xsl:for-each>
						</table>
						<br><br></br></br>
					
						<h4>Loser Team</h4>
						<table cellspacing="10" cellpadding="20" border ="thin"> 
							<tr>
								<th>ID</th>
								<th>Spieler</th>        
								<th>Wurfposition</th>        
								<th>Punkte</th>                                    
							</tr>					
							<xsl:for-each select ="loser-team/scoreboard">
								<tr>
									<td><a id ="{@player-id}"><xsl:value-of select="@player-id"/></a></td>
									<td><xsl:value-of select="concat(id(@player-id)/@firstname, ' ', id(@player-id)/@lastname)"/></td>
									<td><xsl:value-of select="shooting-style/@description"/></td>
									<td><xsl:value-of select="shooting-style/@point"/></td>    
								</tr> 
							</xsl:for-each>
						</table>
						<br><br></br></br>
					</xsl:for-each>	<!-- match -->
				</xsl:for-each> <!-- Team -->
			
				<h2>Spieler</h2>

				<ol>
					<xsl:for-each select="//scoreboard">
  						<xsl:sort select="concat(id(@player-id)/@firstname, ' ', id(@player-id)/@lastname)" />
  						<li>
    						<a href="#{@player-id}"><xsl:value-of select="concat(id(@player-id)/@firstname, ' ', id(@player-id)/@lastname)"/></a>
      						<xsl:value-of select="id(@player-id)"/> 
  						</li>
					</xsl:for-each>
				</ol>
			</body>			
		</html>	
	</xsl:template>	
</xsl:stylesheet>