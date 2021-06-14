<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:template match="/tournament">
		<head>
			<title><xsl:value-of select="description"/></title>
		</head>
		<body>
			<h1><xsl:value-of select="description"/></h1>
			
			<!-- Auflistung der teilnehmenden Teams -->
			<h2>Teams</h2>
			<ol>
				<xsl:for-each select="team">
					<li><a href="#{generate-id()}"><xsl:value-of select="title"/></a></li>
				</xsl:for-each>
			</ol>
			
			<hr/>
			
			<!-- Team Beschreibungen -->
			<h2>Team Description</h2>
			<xsl:apply-templates select="team" mode="description"/>
			
			<hr/>
			
			<!-- Team Mitglieder -->
			<h2>Team Competitors</h2>
			<xsl:apply-templates select="team" mode="members"/>
			
			<hr/>
			
			<!-- Punkteliste -->
			<h2>Score List</h2>
			<xsl:apply-templates select="team/competitor"/>
		</body>
	</xsl:template>
	
	<!-- Teambeschreibungen Template -->
	<xsl:template match="team" mode="description">
		<h3 id="{generate-id()}"><xsl:value-of select="title"/></h3>
		<ul>
			<li>Team-ID: <xsl:value-of select="@id"/></li>
			<li>Nationality: <xsl:value-of select="@nationality"/></li>
			<li>Group Size: <xsl:value-of select="@group-size"/></li>
			<li>Member List</li>
		</ul>
	</xsl:template>
	
	<!-- Teammitglieder Auflistung Template -->
	<xsl:template match="team" mode="members">
		<h3><xsl:value-of select="title"/></h3>
		<xsl:for-each select="competitor">
			<ul>
				<li><a href="#{generate-id()}"><xsl:value-of select="@id"/></a></li>
				<ul>
					<li>First Name: <xsl:value-of select="@firstname"/></li>
					<li>Last Name: <xsl:value-of select="@lastname"/></li>
					<li>Year of Birth: <xsl:value-of select="@year-of-birth"/></li>
					<li>Gender: <xsl:value-of select="@gender"/></li>
				</ul>
			</ul>
		</xsl:for-each>
	</xsl:template>
	
	<!-- Score List Template -->
	<xsl:template match="competitor">
		<h3 id="{generate-id()}"><xsl:value-of select="concat(@firstname, ' ', @lastname, ' (', ../title, ')')"/></h3>
		<xsl:apply-templates select="scores"/>
	</xsl:template>
	
	<!-- Target-Nr Template -->
	<xsl:template match="scores">
		<ul>
			<xsl:for-each select="target-score">
				<li>Target-Nr.: <xsl:value-of select="@target-nr"/></li>
				<xsl:apply-templates select="score"/>
			</xsl:for-each>
		</ul>
	</xsl:template>
	
	<!--  -->
	<xsl:template match="score">
		<ul>
			<li>Arrow-Nr.: <xsl:value-of select="@arrow-nr"/>, Score: <xsl:value-of select="@score"/></li>
		</ul>
	</xsl:template>
	
	
</xsl:stylesheet>