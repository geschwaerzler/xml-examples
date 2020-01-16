<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format">
    
    <!-- ............................ ROOT TEMPLATE .......................... -->
    <xsl:template match="/">
        <fo:root>
            
            <!-- define the layout of the document -->
            <fo:layout-master-set>
                <!-- here we define the layout of pages. There might be differrent page masters with e.g. different margin settings -->
                <fo:simple-page-master master-name="recipe-page"
                    page-height="297.0mm" page-width="209.9mm"
                    margin-bottom="8mm" margin-left="25mm" margin-right="10mm" margin-top="10mm">
                    
                    <!-- the content will be placed into the region-body -->
                    <fo:region-body margin-bottom="28mm" margin-left="0mm" margin-right="44mm" margin-top="20mm"/>
                    
                    <fo:region-before extent="24pt" region-name="recipe-header"/>
                    
                    <fo:region-after extent="24pt" region-name="recipe-footer"/>

                </fo:simple-page-master>
            </fo:layout-master-set>
            
            
            <!-- Here comes the content.
                 Printed content consists of one or more page-sequences. Each page-sequence starts on a new page. -->
            
            <!-- front page -->
            <fo:page-sequence master-reference="recipe-page">
                <fo:flow flow-name="xsl-region-body" font-family="Helvetica" font-size="28pt">
                    <fo:block space-before="40mm">
                        <xsl:value-of select="collection/description"/>
                    </fo:block>
                </fo:flow>
            </fo:page-sequence>
            
            <!-- Table of COntents -->
            <fo:page-sequence master-reference="recipe-page">
                <fo:flow flow-name="xsl-region-body">
                    <fo:block font-family="sans-serif" font-size="14pt" font-weight="bold">
                        Table of Contents
                    </fo:block>
                    
                    <fo:list-block>
                        <xsl:for-each select="collection/recipe">
                            <fo:list-item>
                                <fo:list-item-label>
                                    <fo:block>
                                        <xsl:value-of select="position()"/>.                                        
                                    </fo:block>
                                </fo:list-item-label>
                                <fo:list-item-body start-indent="4mm">
                                    <fo:block text-align-last="justify">
                                        <xsl:value-of select="title"/>
                                        <fo:leader leader-pattern="dots"/>
                                        <fo:page-number-citation ref-id="{generate-id()}"/>
                                    </fo:block>
                                </fo:list-item-body>
                            </fo:list-item>
                        </xsl:for-each>
                    </fo:list-block>
                        
                    
                </fo:flow>
            </fo:page-sequence>
            
            <!-- recipe pages -->
            <xsl:apply-templates select="collection/recipe" mode="detail"/>
            
        </fo:root>
    </xsl:template>
    
    <xsl:template match="recipe" mode="detail">
        <fo:page-sequence master-reference="recipe-page" font-family="sans-serif" font-size="9pt">
            
            <fo:static-content flow-name="recipe-header">
                <fo:block text-align-last="justify">
                    <xsl:value-of select="/collection/description"/>
                    <fo:leader/>
                    <xsl:value-of select="title"/>
                </fo:block>    
            </fo:static-content>
            
            <fo:static-content flow-name="recipe-footer">
                <fo:block font-size="7pt" text-align="end">
                    page <fo:page-number/>
                </fo:block>
            </fo:static-content>
            
            <fo:flow flow-name="xsl-region-body">
                <fo:block font-family="sans-serif" font-size="14pt" font-weight="bold" id="{generate-id()}">
                    <xsl:value-of select="title"/>
                </fo:block>
                
                <fo:block space-before="12pt" font-size="10pt" font-weight="bold">
                    Preparation
                </fo:block>
                
                <fo:list-block space-before="12pt">
                    <xsl:for-each select="preparation/step">
                        <fo:list-item>
                            <fo:list-item-label>
                                <fo:block><xsl:value-of select="position()"/>.</fo:block>
                            </fo:list-item-label>
                            <fo:list-item-body>
                                <fo:block start-indent="4mm"><xsl:value-of select="."/></fo:block>
                            </fo:list-item-body>
                        </fo:list-item>                        
                    </xsl:for-each>
                </fo:list-block>
                
            </fo:flow>
            
            
        </fo:page-sequence>
    </xsl:template>
    
</xsl:stylesheet>
