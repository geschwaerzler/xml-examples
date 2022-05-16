<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<!-- author's note: We suggest to view the page in a standard web browser
	(not the internal browser of eclipse) to guarantee correct CSS behavior -->

	<xsl:output method="html" encoding="UTF-8"/>
	<xsl:template match="/tournament">
		<html>
			<head>
				<link rel="stylesheet" href="archery_style.css"/>
			</head>
			
			<body>
				<header>
					<h1>World Archery Championship 2022</h1>
				</header>
				
				<nav>
					<!-- navigation for parcours -->
					<div class="toc">
						<h2>Parcour overview:</h2>
						
						<ul>
							<xsl:for-each select="parcour">
								<li>
									<a href="#{@id}"><xsl:value-of select="@title"/></a>
								</li>
							</xsl:for-each>
						</ul>
					</div>
					
					<!-- navigation for groups -->
					<div class="toc">
						<h2>Contestant groups:</h2>
						
						<ul>
							<xsl:for-each select="group">
								<li>
									<a href="#{@id}">Group <xsl:value-of select="@id"/></a>
								</li>
							</xsl:for-each>
						</ul>
					</div>
				</nav>
				
				<hr/>
				
				<!-- main content of the page -->
				<section id="content">					
					
					<xsl:apply-templates select="parcour"/>
					
					<br/>
					<hr/>
					
					<xsl:apply-templates select="group"/>
					
					<hr/>
					
					<p>Hint: Hover over a cumulative score to see the points scored in the three individual shots</p>
					<xsl:apply-templates select="scoreboard"/>

				</section>
			</body>
		</html>


	</xsl:template>	<!-- end of main template -->
	
	

	<xsl:template match="parcour">
		<div class="parcours">
			<div class="column-left">
				<h3 id="{@id}">Parcour: <xsl:value-of select="@title"/></h3>
				<img src="assets/parcour_{@id}.jpg" onerror="this.onerror=null; this.src='assets/default_picture.jpg'"/>
			</div>
			<div class="column-right">
			<h4>Targets:</h4>
			<ol>
				<xsl:for-each select="target">
					<li>
						distance: <xsl:value-of select="@distance"/>m, 
						size: <xsl:value-of select="@size"/>cm
					</li>
				</xsl:for-each>
			</ol>
			</div>
		</div>
	</xsl:template>
	
	
	<xsl:template match="group">
		<h3 id="{@id}" xml:space="preserve">Group <xsl:value-of select="@id"/>: <xsl:value-of select="@class"/> <xsl:value-of select="@division"/></h3>
		
		<xsl:variable name="class" select="@class"/>
		<xsl:variable name="division" select="@division"/>
		<xsl:variable name="gid" select="@id"/>
			
			<ol> 
				<xsl:for-each select="//archer[@id = //group[@id = $gid]/member/@archerid]">
					<xsl:if test="archer_profile/class[text()=$class] and archer_profile/division[text()=$division]">
						<li xml:space="preserve">
							<xsl:value-of select="fname"/> <xsl:value-of select="lname"/>:
							<ul>
								<li>Country: <xsl:value-of select="nationality"/></li>
								<li>Birthdate: <xsl:value-of select="birthdate"/></li>
							</ul>
						</li>
						<br/>
					</xsl:if>
				</xsl:for-each>
			</ol>
	</xsl:template>
	
	
	<xsl:template match="scoreboard">
		<xsl:variable name="pid" select="@parcourid"/>
		<h3 xml:space="preserve">Scoreboard for group <xsl:value-of select="@groupid"/> on parcour <xsl:value-of select="//parcour[@id = $pid]/@title"/>:</h3>
			
			<table>
				<th>Target</th>
				<xsl:for-each select="shooting-target[position() = 1]/score">
					<xsl:variable name="aid" select="@archerid"/>
					<th> <!-- archer names as column headers -->
						<xsl:value-of select="//archer[@id = $aid]/fname/text()"/><br/>
						<xsl:value-of select="//archer[@id = $aid]/lname/text()"/>
					</th>
				</xsl:for-each>
				
				<xsl:for-each select="shooting-target">
					<tr>
						<td> <!-- first column (target number) -->
							<xsl:value-of select="substring(@targetid, string-length(@targetid)-1)"/>
						</td>
						<!-- other columns (player scores ) -->
						<xsl:for-each select="score">
							<td>
								<xsl:value-of select="sum(shot/@points)"/>
								<!-- display detailed scores on hover of table cell -->
								<span class="details">
								    <xsl:for-each select="shot">
								        <xsl:value-of select="@points"/> 
								        <xsl:if test="position()!=last()">+</xsl:if>
								    </xsl:for-each>
								</span>
							</td>				
						</xsl:for-each>
					</tr>				
				</xsl:for-each>
			</table>
	</xsl:template>
	
</xsl:stylesheet>