<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format"
    version="2.0">
    
    <xsl:template match="/FAC">
        <fo:root>
            <fo:layout-master-set>
                <fo:simple-page-master master-name="title-page"
                    page-height="297.0mm" page-width="209.9mm"
                    margin-bottom="8mm" margin-left="25mm" margin-right="10mm" margin-top="10mm">
                    
                    <!-- the content will be placed into the region-body -->
                    <fo:region-body margin-bottom="28mm" margin-left="0mm" margin-right="44mm" margin-top="20mm"/>
                    
                    <!-- region-before is the page header -->
                    <fo:region-before extent="24pt" region-name="recipe-header"/>
                    
                    <!-- region-after is the page footer -->
                    <fo:region-after extent="24pt" region-name="recipe-footer"/>
                    
                </fo:simple-page-master>
            </fo:layout-master-set>
            
            <fo:page-sequence master-reference="title-page">
                <fo:flow flow-name="xsl-region-body" font-family="sans-serif" font-size="24pt">
                    <fo:block>
                        World Field Archery Championship
                    </fo:block>
                    <fo:block margin-top="24pt" font-size="12pt">
                        2021
                    </fo:block>
                    
                    <!-- Table of Contents -->
                    <fo:list-block space-before="24pt" font-size="9pt">
                        <xsl:apply-templates select="group" mode="toc"/>    
                    </fo:list-block>
                   
                </fo:flow>
            </fo:page-sequence>
            
            <fo:page-sequence master-reference="title-page">
                <fo:static-content flow-name="recipe-footer">
                    <fo:block font-size="7pt" text-align="end">
                        page <fo:page-number/>
                    </fo:block>
                </fo:static-content>
                
                <fo:flow flow-name="xsl-region-body">
                        <!-- Group details -->
                        <xsl:apply-templates select="group" mode="detail"/>
                </fo:flow>
            </fo:page-sequence>
        </fo:root>
    </xsl:template>
    
    <!-- Table of Content -->
    <xsl:template match="group" mode="toc">
        <fo:list-item>
            <fo:list-item-label>
                <fo:block><xsl:value-of select="position()"/>.</fo:block>
            </fo:list-item-label>
            <fo:list-item-body start-indent="4mm">
                <fo:block text-align-last="justify">
                    <xsl:value-of select="@group_id"/>
                    <fo:leader leader-pattern="dots"></fo:leader>
                    <fo:page-number-citation ref-id="{generate-id()}"/>
                </fo:block>
            </fo:list-item-body>
        </fo:list-item>
    </xsl:template>
    
    <!-- Group details -->
    <xsl:template match="group" mode="detail">
        <fo:block font-size="12pt" font-weight="bold" id="{generate-id()}">Details für die Gruppe <xsl:value-of select="@group_id"/></fo:block>
        <fo:list-block margin-bottom="42pt">
            <xsl:for-each select="@*">
            <fo:list-item>
                <fo:list-item-label>
                    <fo:block>*</fo:block>
                </fo:list-item-label>
                <fo:list-item-body start-indent="4mm">
                    <fo:block><xsl:apply-templates select="id(.)" mode="group_member"/></fo:block>
                </fo:list-item-body>
            </fo:list-item>
            </xsl:for-each>
        </fo:list-block>
    </xsl:template>
    
    <xsl:template match="competitor" mode="group_member" xml:space="preserve">
		<xsl:variable name="cID" select="@competitor_id"/>
		<xsl:value-of select="@fname"/> <xsl:value-of select="@lname"/> <xsl:value-of select="sum(/FAC/scorecard[@competitor_id=$cID]/score-group/score/@score)"/>
	</xsl:template>
</xsl:stylesheet>