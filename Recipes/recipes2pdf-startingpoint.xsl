<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format">
    
    <!-- ............................ ROOT TEMPLATE .......................... -->
    <xsl:template match="/collection">
        <fo:root>
            
            <!-- define the layout of the document -->
            <fo:layout-master-set>
                <!-- here we define the layout of pages. There might be differrent page masters with e.g. different margin settings -->
                <fo:simple-page-master master-name="recipe-page"
                    page-height="297.0mm" page-width="209.9mm"
                    margin-bottom="8mm" margin-left="25mm" margin-right="10mm" margin-top="10mm">
                    
                    <!-- the content will be placed into the region-body -->
                    <fo:region-body margin-bottom="28mm" margin-left="0mm" margin-right="44mm" margin-top="60mm"/>
                    
                    <!-- region-before is the page header -->
                    <fo:region-before extent="24pt" region-name="recipe-header"/>
                    
                    <!-- region-after is the page footer -->
                    <fo:region-after extent="24pt" region-name="recipe-footer"/>
                    
                </fo:simple-page-master>
            </fo:layout-master-set>
            
            
            <!-- Here comes the content.
                 Printed content consists of one or more page-sequences. Each page-sequence starts on a new page. -->
            
            <!-- front page -->
            <fo:page-sequence master-reference="recipe-page">
                <fo:flow flow-name="xsl-region-body" font-family="sans-serif" font-size="9pt">
                    <fo:block font-size="28pt">
                        <xsl:value-of select="description"/>
                    </fo:block>
                    
                    <!-- headline 2: Table of contents -->
                    <xsl:call-template name="h2">
                        <xsl:with-param name="headline">Table of Contents</xsl:with-param>
                    </xsl:call-template>
                    
                    <!-- one liste item per recipe -->
                    <fo:list-block>
                        <xsl:for-each select="recipe">
                            <fo:list-item>
                                <fo:list-item-label>
                                    <fo:block>
                                        <xsl:value-of select="position()"/>.                                        
                                    </fo:block>
                                </fo:list-item-label>
                                <fo:list-item-body start-indent="6mm">
                                    <fo:block text-align-last="justify">
                                        <xsl:value-of select="title"/>
                                        <fo:leader leader-pattern="rule"></fo:leader>
                                        <fo:page-number-citation ref-id="{generate-id()}"/>
                                    </fo:block>
                                </fo:list-item-body>
                            </fo:list-item>
                        </xsl:for-each>
                    </fo:list-block>
                        
                </fo:flow>
            </fo:page-sequence>
            
            <!-- one page per recipe -->
            <xsl:apply-templates select="recipe"/>
            
        </fo:root>
    </xsl:template>
    
    
    <!-- recipe detail -->
    <xsl:template match="recipe">
        <fo:page-sequence master-reference="recipe-page">
            <fo:static-content flow-name="recipe-header">
                <fo:block text-align="right">
                    Page: <fo:page-number/>
                </fo:block>
            </fo:static-content>
            <fo:flow flow-name="xsl-region-body" font-family="sans-serif" font-size="9pt">
                <!-- headline 1 -->
                <fo:block font-size="28pt" id="{generate-id()}">
                    <xsl:value-of select="title"/>
                </fo:block>
                
                <!-- headline 2: Preparation -->
                <xsl:call-template name="h2">
                    <xsl:with-param name="headline">Preparation</xsl:with-param>
                </xsl:call-template>

                <fo:list-block>
                    <xsl:for-each select="preparation/step">
                        <fo:list-item margin-top="9pt">
                            <fo:list-item-label>
                                <fo:block>
                                    <xsl:value-of select="position()"/>.                                    
                                </fo:block>
                            </fo:list-item-label>
                            <fo:list-item-body>
                                <fo:block text-indent="6mm">
                                    <xsl:value-of select="."/>
                                </fo:block>
                            </fo:list-item-body>
                        </fo:list-item>
                    </xsl:for-each>
                </fo:list-block>
                
            </fo:flow>
        </fo:page-sequence>
    </xsl:template>
    
    
    <!-- helper templates -->
    <!-- void h2(String headline) {} -->
    <xsl:template name="h2">
        <xsl:param name="headline"/>
        <!-- headline 2 -->
        <fo:block font-size="14pt" font-weight="800" margin-top="14pt">
            <xsl:value-of select="$headline"/>
        </fo:block>
    </xsl:template>
    
</xsl:stylesheet>
