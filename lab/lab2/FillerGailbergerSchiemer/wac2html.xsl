<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html"/>
	<xsl:template match="/collection">
 		<html>
 			<head>
 				<title><xsl:value-of select="collection_name"/></title>
 			</head>
 			<body>
 				<h1><xsl:value-of select="collection_name"/></h1>
 				<h2>Competitions:</h2>
 				<ol>
 					<xsl:for-each select="competition">
 						<li><a href="#{generate-id()}"><xsl:value-of select="competition_name"/> - <xsl:value-of select="competition_date"/></a></li>
 					</xsl:for-each>
 				</ol>
 				
 				<xsl:apply-templates select="competition"/>
 				
 				<hr/>
 				<h2>Articles: </h2>
 				<xsl:apply-templates select="competition/article"/>
 			</body>
 		</html>
 	</xsl:template>
 	
 	
 	
	<xsl:template match="competition">
		<br/>
		<hr/>
		<h2><xsl:value-of select="collection_name"/></h2>

		<a name="{generate-id()}"><h2><xsl:value-of select="competition_name"/></h2></a>
 		<xsl:for-each select="." >
 			<p><xsl:value-of select="competition_date"/>: 
 				<xsl:value-of select="competition_city"/>, 
 				<xsl:value-of select="competition_country"/> 
 			</p>
 		</xsl:for-each>
 		
 		<h3>Athletes: </h3>
 		<xsl:for-each select="athlete_registration" >
 			<b>User: <xsl:value-of select="id(user_ref/@user_id)/username"/></b><br/>
 			<a>Division: <xsl:value-of select="id(division_ref/@division_id)/division_name"/></a><br/>
 			<a>Shooting Style: <xsl:value-of select="id(shooting_style_ref/@shooting_style_id)/shooting_style_name"/></a><br/>
 		</xsl:for-each>
 		
		<h3>Courses: </h3>
		<xsl:for-each select="course" >
			<b>Course: <xsl:value-of select="course_name"/></b><br/>
			<a>Division: <xsl:value-of select="id(division_ref/@division_id)/division_name"/></a><br/>
			<a>Shooting Style: <xsl:value-of select="id(shooting_style_ref/@shooting_style_id)/shooting_style_name"/></a><br/>
		</xsl:for-each>
 		
 		<h3>Penalties: </h3>
 		<xsl:for-each select="penalty" >
 			<b>User: <xsl:value-of select="id(user_ref/@user_id)/username"/></b><br/>
 			<a>Reason: <xsl:value-of select="penalty_reason"/></a><br/>
 			<a>Date: <xsl:value-of select="date"/></a><br/>
 		</xsl:for-each>
	</xsl:template>
	
	
	
	<xsl:template match="article">
	 	<h3><xsl:value-of select="article_title"/></h3>
	 	<b>Competition: </b><xsl:value-of select="../competition_name"/><br/>
	 	<b>Article Description: </b><xsl:value-of select="article_description"/><br/>
	 	<b>Article Body: </b><xsl:value-of select="article_body"/><br/>
 	</xsl:template>
 	
 	
</xsl:stylesheet>
