<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format">

    <xsl:template match="/collection">
        <fo:root>
            
            <fo:layout-master-set>
                <fo:simple-page-master master-name="a4page">
                    <fo:region-body margin="2.5cm"/>
                    <fo:region-after extent="24pt" margin="2.5cm"/>
                </fo:simple-page-master>
            </fo:layout-master-set>
            
            <fo:page-sequence master-reference="a4page" font-family="serif" font-size="9pt">
                <fo:flow flow-name="xsl-region-body">
                    <fo:block font-size="18pt" font-weight="bold" margin-top="72pt">
                        <xsl:value-of select="description"/>
                    </fo:block>
                    <fo:block font-size="14pt" font-weight="bold" margin-top="24pt" margin-bottom="12pt">
                        Table of Contents
                    </fo:block>
                    <xsl:for-each select="recipe">
                        <fo:block><xsl:value-of select="title"/></fo:block>
                    </xsl:for-each>
                </fo:flow>
            </fo:page-sequence>
            
            <xsl:apply-templates select="recipe"/>
            
        </fo:root>
    </xsl:template>
    
    <xsl:template match="recipe">
        <fo:page-sequence master-reference="a4page" font-family="serif" font-size="9pt">
            
            <fo:static-content flow-name="xsl-region-after" font-size="8pt"><fo:block>page <fo:page-number/></fo:block></fo:static-content>

            <fo:flow flow-name="xsl-region-body">
                <fo:block font-size="14pt" font-weight="bold">
                    <xsl:value-of select="title"/>
                </fo:block>
                
                <fo:block font-size="12pt" font-weight="bold" margin-top="12pt">Preparation</fo:block>
                <fo:list-block>
                    <xsl:for-each select="preparation/step">
                        <fo:list-item>
                            <fo:list-item-label>
                                <fo:block><xsl:value-of select="position()"/>.</fo:block>
                            </fo:list-item-label>
                            <fo:list-item-body margin-left="4mm">
                                <fo:block><xsl:value-of select="text()"/></fo:block>
                            </fo:list-item-body>
                        </fo:list-item>
                    </xsl:for-each>
                </fo:list-block>
            </fo:flow>
            
        </fo:page-sequence>
    </xsl:template>
    
</xsl:stylesheet>
