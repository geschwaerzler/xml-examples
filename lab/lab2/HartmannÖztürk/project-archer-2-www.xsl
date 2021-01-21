<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:template match="/">

		<html>
			<head>
				<title><xsl:value-of select="project-archer/description"/></title>
				<style type="text/css">
					*{
						margin: 0 auto;
						font-family: Calibri, Arial, Times New Roman;
					}
					
					body {
						background: #edf3f3;
					}
					
					header {
						width: 100%;
						height: 64px;
						
						background: #fcba03;
						border-bottom: 2px solid #ffe08a;
						
						font-size: 32px;
					}
					
					.archer-img {
						height: 64px;
						width: 64px;
						
						margin-left: 48px;
					}
					
					.header-title {
						vertical-align: middle;
					    height: 64px;
					    line-height: 16px;
					    
					    display: inline-block;
					    padding-left: 16px;
					}
					
					.header-authors {
						font-size: 16px;
						
						height: 16px;
						line-height: 64px;
						margin-right: 64px;
						
						float: right;
						display: inline-block;
					}
					
					main {
						margin: 32px 0 0 86px;
					}
					
					h1,h2 {
						padding: 16px 0 16px 0;
					}
					
					hr {
						width: 70%;
						float: left;
					}
					
					ul, ol {
						padding-bottom: 16px; 
					}
					
					div {
						padding-left: 24px;
					}
					
					table, th, td {
						border: 1px black solid;
						border-collapse: collapse;
					}
					
					td, th {
						padding: 6px;
						text-align: center;
					}
					
					table {
						margin-top: 32px;
						position: relative;
						left: -20%;
					}
					
				</style>
			</head>
		
			<body>
				
				<header>
					<img src="archer_icon.png" class="archer-img"/>
					<div class="header-title"><b><xsl:value-of select="project-archer/description"/></b></div>
					<div class="header-authors"><b><i>Mert Öztürk , Benjamin Hartmann</i></b></div>
				</header>
				
				<main>
		             <h1>Table of Contents</h1>
		             <hr/><br/>
		             <div>
			             <ol>
			                 <li> <a href = "#teams">Teams</a></li>
			                     <ul style="list-style-type:disc;">
			                         <xsl:apply-templates select = "project-archer/team" mode = "toc"></xsl:apply-templates>
			                     </ul>
			                 <li> <a href = "#stations">Stations</a></li>
			                     <ul style="list-style-type:disc;">
			                         <xsl:apply-templates select = "project-archer/station" mode = "toc"></xsl:apply-templates>
			                     </ul>        
			                 <li> <a href = "#rounds">Rounds</a></li>
			                     <ul style="list-style-type:disc;">
			                         <xsl:apply-templates select = "project-archer/round" mode = "toc"></xsl:apply-templates>
			                     </ul>
			            </ol>    
					</div>
					
					<h1 id="teams">Teams</h1>
					<hr/>
					<div>
						<xsl:apply-templates select="project-archer/team" mode="content"/>
					</div>
					
					<h1 id="stations">Stations</h1>
					<hr/>
					<div>
						<xsl:apply-templates select="project-archer/station" mode="content"/>
					</div>
					
					<h1 id="rounds">Rounds</h1>
					<hr/>
					<div>
						<xsl:apply-templates select="project-archer/round" mode="content"/>
					</div>
					
				</main>
				
			</body>
		
		</html>

	</xsl:template>
	
	<xsl:template match="team" mode="toc"> <!-- toc = table of content -->
        <li><a href="#team-{position()}">Team #<xsl:value-of select="substring-after(@id, '-')"/></a></li>
    </xsl:template>
    
    <xsl:template match="station" mode="toc"> <!-- toc = table of content -->
        <li><a href="#station-{generate-id()}">Station #<xsl:value-of select="substring-after(@id, '-')"/></a></li>
    </xsl:template>
    
    <xsl:template match="round" mode="toc"> <!-- toc = table of content -->
        <li><a href="#round-{position()}">Round #<xsl:value-of select="substring-after(@id, '-')"/></a></li>
    </xsl:template>
	
	<xsl:template match="team" mode="content" xml:space="preserve">
	
		<h2 id="team-{position()}">Team <xsl:value-of select="substring-after(@id, '-')"/></h2>
		<p>Team-Leader: <xsl:value-of select="concat(id(@leader_id)/@fname, ' ', id(@leader_id)/@lname)"/></p>
		<ul>
			<xsl:for-each select="team_member">
				<li>
					<xsl:value-of select="concat(id(@id)/@fname, ' ', id(@id)/@middle_name, ' ', id(@id)/@lname)"/>
				</li>
			</xsl:for-each>
		</ul>
		<p>Responsible for Station:</p>
		<xsl:variable name="t" select="@id"/>
		<ul>
			<xsl:for-each select="../station[responsible_for/@id=$t]">
				<li>
					<a href="#station-{generate-id()}">Station <xsl:value-of select="substring-after(@id, '-')"/></a>
				</li>
			</xsl:for-each>
		</ul>
		
	</xsl:template>
	
	<xsl:template match="station" mode="content" xml:space="preserve">
	
		<h2 id="station-{generate-id()}">Station <xsl:value-of select="substring-after(@id, '-')"/></h2>
		<p>Located at: <xsl:value-of select="@position_ns"/> , <xsl:value-of select="@position_we"/></p>
		<br/>
		Targets at Station:
		<ul>
			<xsl:for-each select="position_at">
				<li>
					Target #<xsl:value-of select="substring-after(@id, '-')"/>
				</li>
			</xsl:for-each>
		</ul>
	
	</xsl:template>
	
	<xsl:template match="round" mode="content" xml:space="preserve">
	
		<h2 id="round-{position()}">Round #<xsl:value-of select="substring-after(@id, '-')"/> - Date: <xsl:value-of select="@day"/></h2>
		
		<xsl:for-each select="standard_unit">
			<table>
				<tr>
					<th colspan="6" style="background: #fcba03;">Discipline: <xsl:value-of select="@id"/></th>
				</tr>
				<tr>
					<th rowspan="{3 + count(target_type/target)}" style="background: lightgray;">
						Standard-Unit <xsl:value-of select="position()"/>
					</th>
				</tr>
				<tr>
					<th>Target ID</th>
					<th>Target-Size</th>
					<th>Seniors / Veterans /<br/>Adults / Young Adults<br/><br/>(Marker: <xsl:value-of select="target_type/target/division[@division_name='adult']/@coloring"/>)</th>
					<th>Juniors<br/><br/>(Marker: <xsl:value-of select="target_type/target/division[@division_name='junior']/@coloring"/>)</th>
					<th>Cubs<br/><br/>(Marker: <xsl:value-of select="target_type/target/division[@division_name='cub']/@coloring"/>)</th>
				</tr>
		
				<xsl:for-each select="target_type/target">
					<tr>
						<td><xsl:value-of select="substring-after(@id, '-')"/></td>
						<td><xsl:value-of select="substring-after(../@id, '-')"/>cm</td>
						<td>
							<xsl:for-each select="division[@division_name='adult']/shooting_position">
								<xsl:value-of select="@distance"/>
								<xsl:choose>
									<xsl:when test="position() != last()">-</xsl:when>
								</xsl:choose>
							</xsl:for-each>
							Yards
						</td>
						<td>
							<xsl:for-each select="division[@division_name='junior']/shooting_position">
								<xsl:value-of select="@distance"/>
								<xsl:choose>
									<xsl:when test="position() != last()">-</xsl:when>
								</xsl:choose>
							</xsl:for-each>
							Yards
						</td>
						<td>
							<xsl:for-each select="division[@division_name='adult']/shooting_position">
								<xsl:value-of select="@distance"/>
								<xsl:choose>
									<xsl:when test="position() != last()">-</xsl:when>
								</xsl:choose>
							</xsl:for-each>
							Yards
						</td>
					</tr>
				</xsl:for-each>
			</table>
			<br/>
		</xsl:for-each>

	
	</xsl:template>
	
</xsl:stylesheet>