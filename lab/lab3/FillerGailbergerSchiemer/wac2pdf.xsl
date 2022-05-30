<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:fo="http://www.w3.org/1999/XSL/Format">
	
	<xsl:template match="/collection">
		<fo:root>
			<fo:layout-master-set>
				<fo:simple-page-master master-name="wac-page"
					page-height="297.0mm" page-width="209.9mm"
					margin-bottom="8mm" margin-left="25mm" margin-right="10mm" margin-top="10mm">
					
					<fo:region-body margin-bottom="28mm" margin-left="0mm" margin-right="44mm" margin-top="20mm"/>
					
					<fo:region-before extent="24pt" region-name="wac-header"/>
					<fo:region-after extent="24pt" region-name="wac-footer"/>
				</fo:simple-page-master>
			</fo:layout-master-set>
			
			<fo:page-sequence master-reference="wac-page">
				<fo:flow flow-name="xsl-region-body" font-family="sans-serif" font-size="28pt">
					<fo:block margin-top="40mm">
						<xsl:value-of select="collection_name"/>
					</fo:block>
				</fo:flow>
			</fo:page-sequence>
			
			<fo:page-sequence master-reference="wac-page">
				<!-- place a page description into the page header -->
				<xsl:call-template name="header">
					<xsl:with-param name="right" select="'Table of Contents'"/>
				</xsl:call-template>
				
				<xsl:call-template name="footer"/>
				
				<!-- place the table of contents into region-body -->
				<fo:flow flow-name="xsl-region-body" font-family="Times" font-size="9pt">
					<fo:block font-weight="bold" margin-top="40mm">Table of Contents</fo:block>
					<fo:list-block space-before="24pt">
						<xsl:apply-templates select="competition" mode="toc"/>
					</fo:list-block>
				</fo:flow>
			</fo:page-sequence>
			
			<xsl:apply-templates select="competition" mode="detail"/>
			<xsl:call-template name="articles"/>
		</fo:root>
	</xsl:template>

	<xsl:template match="competition" mode="toc">
		<fo:list-item space-before="3mm">
			<fo:list-item-label>
				<fo:block><xsl:value-of select="position()"/>.</fo:block>
			</fo:list-item-label>
			<fo:list-item-body start-indent="4mm">
				<fo:block text-align-last="justify" height="10mm">
					<fo:basic-link internal-destination="{generate-id()}">
						<xsl:value-of select="competition_name"/>
						<fo:leader leader-pattern="dots"></fo:leader>
						<fo:page-number-citation ref-id="{generate-id()}"/>
					</fo:basic-link>
				</fo:block>
			</fo:list-item-body>
		</fo:list-item>
	</xsl:template>
	
	<xsl:template match="competition" mode="detail" xml:space="preserve">
        <fo:page-sequence master-reference="wac-page">
            <xsl:call-template name="header">
                <xsl:with-param name="right" select="competition_name"/>
            </xsl:call-template>
        
			<xsl:call-template name="footer"/>
        
            <fo:flow flow-name="xsl-region-body" font-family="Times" font-size="9pt">
                <!-- recipe title -->
                <fo:block font-size="14pt" font-weight="bold" id="{generate-id()}">
                    <xsl:value-of select="competition_name"/>
                </fo:block>
            	
				<xsl:call-template name="athletes"/>
				<xsl:call-template name="courses"/>
				<xsl:call-template name="penalties"/>
            </fo:flow>
        </fo:page-sequence>
    </xsl:template>
	
	<xsl:template name="athletes">
		<fo:block font-size="10pt" font-weight="bold" space-before="5mm">Athletes</fo:block>
		<xsl:for-each select="athlete_registration">
			<fo:block font-weight="bold">
				User: <xsl:value-of select="id(user_ref/@user_id)/username"/>
			</fo:block>
			<fo:block>
				Division: <xsl:value-of select="id(division_ref/@division_id)/division_name"/>
			</fo:block>
			<fo:block space-after="2mm">
				Shooting Style: <xsl:value-of select="id(shooting_style_ref/@shooting_style_id)/shooting_style_name"/>
			</fo:block>
		</xsl:for-each>
	</xsl:template>
	
	<xsl:template name="courses">
		<fo:block font-size="10pt" font-weight="bold" space-before="5mm">Courses</fo:block>
		<xsl:for-each select="course">
			<fo:block font-weight="bold">
				Course: <xsl:value-of select="course_name"/>
			</fo:block>
			<fo:block>
				Division: <xsl:value-of select="id(division_ref/@division_id)/division_name"/>
			</fo:block>
			<fo:block space-after="2mm">
				Shooting Style: <xsl:value-of select="id(shooting_style_ref/@shooting_style_id)/shooting_style_name"/>
			</fo:block>
		</xsl:for-each>
	</xsl:template>
		
	<xsl:template name="penalties">
		<fo:block font-size="10pt" font-weight="bold" space-before="5mm">Penalties</fo:block>
		<xsl:for-each select="penalty">
			<fo:block font-weight="bold">
				User: <xsl:value-of select="id(user_ref/@user_id)/username"/>
			</fo:block>
			<fo:block>
				Reason: <xsl:value-of select="penalty_reason"/>
			</fo:block>
			<fo:block space-after="2mm">
				Date: <xsl:value-of select="date"/>
			</fo:block>
		</xsl:for-each>
	</xsl:template>
	
	<xsl:template name="articles">
		<fo:page-sequence master-reference="wac-page">
			<xsl:call-template name="header">
				<xsl:with-param name="right" select="title"/>
			</xsl:call-template>
			
			<xsl:call-template name="footer"/>
			
			<fo:flow flow-name="xsl-region-body" font-family="Times" font-size="9pt">
				<fo:block font-size="14pt" font-weight="bold">Articles</fo:block>
				<xsl:for-each select="//article">
					<fo:block font-size="10pt" font-weight="bold">
						<xsl:value-of select="article_title"/>
					</fo:block>
					<fo:block>
						<fo:inline font-weight="bold">Competition: </fo:inline>
						<fo:inline><xsl:value-of select="../competition_name"/></fo:inline>
					</fo:block>
					<fo:block>
						<fo:inline font-weight="bold">Article Description: </fo:inline>
						<fo:inline><xsl:value-of select="article_description"/></fo:inline>
					</fo:block>
					<fo:block space-after="2mm">
						<fo:inline font-weight="bold">Article Body: </fo:inline>
						<fo:inline><xsl:value-of select="article_body"/></fo:inline>
					</fo:block>
				</xsl:for-each>
			</fo:flow>
		</fo:page-sequence>
	</xsl:template>
	
	<xsl:template name="header">
		<xsl:param name="right"/>
		<!-- page header: left: booklet title; left: recipe title -->
		<fo:static-content flow-name="wac-header">
			<fo:block font-size="7pt" text-align-last="justify">
				<xsl:value-of select="//collection_name"/>
				<fo:leader/>
				<xsl:value-of select="$right"/>
			</fo:block>
		</fo:static-content>      
	</xsl:template>	
	
	<xsl:template name="footer">
		<fo:static-content flow-name="wac-footer">
			<fo:block font-size="7pt" text-align="end">
				page <fo:page-number/>
			</fo:block>
		</fo:static-content>
	</xsl:template>

</xsl:stylesheet>