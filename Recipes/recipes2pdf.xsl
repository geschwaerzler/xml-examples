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
                    
                    <fo:region-before extent="24pt" region-name="recipe-header"/>
                    
                    <fo:region-after extent="24pt" region-name="recipe-footer"/>
                    
                </fo:simple-page-master>
            </fo:layout-master-set>
            
            
            <!-- Here comes the content.
                 Printed content consists of one or more page-sequences. Each page-sequence starts on a new page. -->
            
            <!-- front page -->
            <fo:page-sequence master-reference="recipe-page">
                <fo:flow flow-name="xsl-region-body" font-family="serif" font-size="28pt">
                    <fo:block>
                        <xsl:value-of select="description"/>
                    </fo:block>
                </fo:flow>
            </fo:page-sequence>
            
            <!-- table of contents -->
            <fo:page-sequence master-reference="recipe-page">
                <fo:flow flow-name="xsl-region-body" font-family="sans-serif" font-size="9pt">
                    <xsl:call-template name="headline">
                        <xsl:with-param name="text" select="'Table of Contents'"/>
                    </xsl:call-template>

                    <fo:list-block space-before="24pt">
                        <xsl:apply-templates select="recipe" mode="table-of-contents"/>
                    </fo:list-block>
                    
                </fo:flow>
            </fo:page-sequence>
            
            <!-- recipe pages -->
            <xsl:apply-templates select="recipe" mode="detail"/>
            
        </fo:root>
    </xsl:template>
    
    
    <xsl:template match="recipe" mode="table-of-contents">
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
    </xsl:template>
    
    
    <xsl:template match="recipe" mode="detail">
        <fo:page-sequence master-reference="recipe-page">
            
            <fo:static-content flow-name="recipe-header">
                <fo:block font-size="7pt">
                    <xsl:value-of select="/collection/description"/>
                    -
                    <xsl:value-of select="title"/>
                </fo:block>
            </fo:static-content>
            
            <fo:static-content flow-name="recipe-footer">
                <fo:block font-size="7pt">
                    page <fo:page-number/>
                </fo:block>
            </fo:static-content>
            
            <fo:flow flow-name="xsl-region-body">
                
                <xsl:call-template name="headline">
                    <xsl:with-param name="text" select="title"/>
                    <xsl:with-param name="id" select="generate-id()"/>
                </xsl:call-template>
                
            </fo:flow>
        </fo:page-sequence>
        
    </xsl:template>
    
    
    <xsl:template name="headline">
        <xsl:param name="text"/>
        <xsl:param name="id"/>
        
        <fo:block font-family="serif" font-size="14pt" id="{$id}">
            <xsl:value-of select="$text"/>
        </fo:block>
        
    </xsl:template>
    
    
    
    
    
</xsl:stylesheet>
