<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:output method="html"/>
	
	<xsl:template match="archery-tournament">
	
	<html>
		<head>
		
		<title> 
	
		</title>
				
		</head>

	<body>
		<t1>Vorarlberger Archery Landesmeisterschaft 2022</t1>
		<h2> Table of Contents </h2>
		
		<o1>
			<li> <a href="#{generate-id()}"> Group1 </a> </li>
			<li> <a href="#{generate-id()}"> Group2 </a> </li>
		</o1>
		
		<h2>---------------------------------------------</h2>
		
		<h2>Group1</h2>
		<xsl:apply-templates select="athlete"/>
		
		<h2>---------------------------------------------</h2>
	
		<h2>Group2</h2>
		<xsl:apply-templates select="athlete"/>
		
		<h2>---------------------------------------------</h2>
		
		<h2>Tournament Info</h2>
		
		<h2>Parkour1</h2>
		<h3>Target1</h3>
		<h3>Target2</h3>
		<h3>Target3</h3>
		<h3>Target4</h3>
		<h3>Target5</h3>
		<h2>Parkour2</h2>
		<h3>Target6</h3>
		<h3>Target7</h3>
		<h3>Target8</h3>
		<h3>Target9</h3>
		<h3>Target10</h3>
		<h2>Parkour3</h2>
		<h3>Target11</h3>
		<h3>Target12</h3>
		<h3>Target13</h3>
		<h3>Target14</h3>
		<h3>Target15</h3>
		
		
		<!--  
		<xsl:apply-templates select="tournament"/>
		-->
		<h2>---------------------------------------------</h2>
		<h2>Scorecard</h2>
		<xsl:apply-templates select= "scorecard"/>
		<h3>Targets-----Score1-----Score2-----Score3-----Score4-----Score5</h3>
		
	</body>
</html>
		<!-- TODO: Auto-generated template -->
</xsl:template>

	<xsl:template match="athlete">
	
		<h4>
			 <xsl:value-of select="lastname"/>
		</h4>
	
	</xsl:template>
	
	<!--  
	<xsl:template match= "tournament">
	<xsl:for-each select="parkour/target">
	<h3>  
	<xsl:value-of select="@id"></xsl:value-of>
	</h3>
	></xsl:for-each>
	</xsl:template>
	 -->
	
		
	
	<xsl:template match="scorecard">
	<!-- placeholder für scorecard mit for each -->
	
	<xsl:variable name="target-id"></xsl:variable>
	
	<xsl:attribute name="score">
	<xsl:value-of select="@target-id"></xsl:value-of>
	</xsl:attribute>

	</xsl:template>
	
</xsl:stylesheet>