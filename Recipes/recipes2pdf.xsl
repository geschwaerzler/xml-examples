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
                <fo:flow flow-name="xsl-region-body" font-family="sans-serif" font-size="28pt">
                    <fo:block>
                        <xsl:value-of select="description"/>
                    </fo:block>
                    
                    <fo:block font-size="12pt" margin-top="24pt">
                        By the Famous 3rd Semester INF WS 2020/21
                    </fo:block>
                </fo:flow>
            </fo:page-sequence>
            
            <!-- Table of Contents -->
            <fo:page-sequence master-reference="recipe-page">
                
                <!-- page header: left: booklet title; left: table of contents -->
                <xsl:call-template name="generate-header">
                    <xsl:with-param name="title-right" select="'Table of Contents'"/>
                </xsl:call-template>
                
                <fo:flow flow-name="xsl-region-body" font-family="Times" font-size="9pt">
                    <fo:block font-size="12pt" font-weight="500">Table of Contents</fo:block>
                    
                    <fo:list-block margin-top="24pt">
                        <xsl:for-each select="recipe">
                            <fo:list-item>
                                <fo:list-item-label>
                                    <fo:block><xsl:value-of select="position()"/>.</fo:block>
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
            
            <!-- here come the recipe pages -->
            <xsl:apply-templates select="recipe"/>
            
        </fo:root>
    </xsl:template>
    
    
    <!-- Recipe detail pages -->
    <xsl:template match="recipe">
  
        <fo:page-sequence master-reference="recipe-page">
            
            <!-- page header: left: booklet title; left: recipe title -->
            <xsl:call-template name="generate-header">
                <xsl:with-param name="title-right" select="title"/>
            </xsl:call-template>
            
            <fo:static-content flow-name="recipe-footer">
                <fo:block font-size="7pt" text-align="end">
                    page <fo:page-number/>
                </fo:block>
            </fo:static-content>
            
            <fo:flow flow-name="xsl-region-body">
                <fo:block font-size="12pt" font-weight="500" id="{generate-id()}"><xsl:value-of select="title"/></fo:block>
                
                <xsl:if test="@author-id" xml:space="preserve">
                    <fo:block margin-top="12pt" font-size="9pt">
                        <xsl:value-of select="id(@author-id)/@title"/>
                        <xsl:value-of select="id(@author-id)"/>
                    </fo:block>                    
                </xsl:if>
            </fo:flow>
            
        </fo:page-sequence>
        
    </xsl:template>
    
    
    <xsl:template name="generate-header">
        <xsl:param name="title-right"/>
        <!-- page header: left: booklet title; left: recipe title -->
        <fo:static-content flow-name="recipe-header">
            <fo:block font-size="7pt" text-align-last="justify">
                <xsl:value-of select="/collection/description"/>
                <fo:leader/>
                <xsl:value-of select="$title-right"/>
            </fo:block>
        </fo:static-content>
    </xsl:template>
    
</xsl:stylesheet>
