<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	
	<xsl:output method="html"/>
	
	<xsl:template match="/media-library">
		<html>
			<head>
				<title>Media-Library</title>
			</head>
			
			
			<body>
				<h1>Media-Library</h1>
				<h2>Kunden</h2>
				
				<ul>
					<xsl:apply-templates select="person" mode="toc"/>	
				</ul>
				
				<xsl:apply-templates select="/media-library" mode="detail"/>
				<xsl:apply-templates select="/media-library" mode= "index"/>
								
				</body>
		</html>
	</xsl:template>
	
	
	<xsl:template match="person" mode="toc">
		<li><a href="#{generate-id()}"><xsl:value-of select="@firstname"/></a></li>	
	</xsl:template>


	<xsl:template match="/media-library" mode="detail">
		<h2>Favourite Lists</h2>
		<xsl:for-each select="person">
		
			<h3 xml:space="preserve" id="{generate-id()}">
				<xsl:value-of select="@firstname"/>
			</h3>
			
			<xsl:variable name="a-personal-number" select="@personal-number"/>
			
			<ul>
				<xsl:apply-templates select="//media-list[@person-personal-number = $a-personal-number]" mode="detail"/>
			</ul>
		</xsl:for-each>
	</xsl:template>
	
	
	<xsl:template match="media-list" mode="detail">
        <lh>
            <xsl:variable name="a-person-personal-number" select="@person-personal-number"/>
            <xsl:value-of select="@name"/>
            <ol>
                <xsl:for-each select="media-list-item">
                <xsl:variable name="a-media-id" select="@media-id"/>
                    <li id="{generate-id($a-media-id)}">
                        <xsl:value-of select="//media[@id = $a-media-id]/@title"/>
                         <xsl:if test="count(//rating[@media-id = $a-media-id and @person-personal-number = $a-person-personal-number]/@score)>0">
                         Rating: 
                         <xsl:value-of select="sum(//rating[@media-id = $a-media-id and @person-personal-number = $a-person-personal-number]/@score) div count(//rating[@media-id = $a-media-id and @person-personal-number = $a-person-personal-number]/@score)"/> 
                        </xsl:if>
                    </li>
                </xsl:for-each>
            </ol>
        </lh>
    </xsl:template>
	
	
	<xsl:template match="/media-library" mode="index">
		<h2>Media Index</h2>
		
		<xsl:for-each select="person">
			<xsl:sort select="@firstname"/>

			<xsl:variable name="a-firstname" select="@firstname"/>
			<xsl:variable name="a-personal-number" select="@personal-number"/>
			
			<xsl:apply-templates select="//media-list[@person-personal-number = $a-personal-number]" mode="index"/>
			
		</xsl:for-each>
	</xsl:template>
	
	
	<xsl:template match="media-list" mode="index">
		<xsl:for-each select="media-list-item">
		
			<xsl:variable name="a-media-id" select="@media-id"/>
			<xsl:variable name="a-person-personal-number" select="../@person-personal-number"/>
			
			<li>
				<a href="#{generate-id($a-media-id)}" xml:space="preserve">
					<xsl:value-of select="//media[@id = $a-media-id]/@title"/> <xsl:value-of select="../@name"/> <xsl:value-of select="//person[@personal-number = $a-person-personal-number]/@firstname"/>
				</a>
			</li>
		</xsl:for-each>
	</xsl:template>
	
</xsl:stylesheet>