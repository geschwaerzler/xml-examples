<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
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
                    <fo:block margin-top="40mm">
                        <xsl:value-of select="collection/description"/>
                    </fo:block>
                </fo:flow>
            </fo:page-sequence>
            
            <!-- table of contents -->
            <fo:page-sequence master-reference="recipe-page">
                <!-- place a page description into the page header -->
                <xsl:call-template name="header">
                    <xsl:with-param name="right" select="'Table of Contents'"/>
                </xsl:call-template>
                
                <!-- place the table of contents into region-body -->
                <fo:flow flow-name="xsl-region-body" font-family="Times" font-size="9pt">
                    <fo:block font-weight="bold" margin-top="40mm">Table of Contents</fo:block>
                    <fo:list-block space-before="24pt">
                        <xsl:apply-templates select="collection/recipe" mode="toc"/>
                    </fo:list-block>
                </fo:flow>
            </fo:page-sequence>
            
            <!-- recipes -->
            <xsl:apply-templates select="collection/recipe" mode="detail"/>
            
        </fo:root>
    </xsl:template>
    
    
    <!-- ...................... TABLE OF CONTENTS TEMPLATE ................... -->
    <xsl:template match="recipe" mode="toc">
        <fo:list-item>
            <fo:list-item-label>
                <fo:block><xsl:value-of select="position()"/>.</fo:block>
            </fo:list-item-label>
            <fo:list-item-body start-indent="4mm">
                <fo:block text-align-last="justify">
                    <xsl:value-of select="title"/>
                    <fo:leader leader-pattern="dots"></fo:leader>
                    <fo:page-number-citation ref-id="{generate-id()}"/>
                </fo:block>
            </fo:list-item-body>
        </fo:list-item>
    </xsl:template>
    
    
    <!-- .......................... RECIPE TEMPLATE .......................... -->
    <xsl:template match="recipe" mode="detail" xml:space="preserve">
        <fo:page-sequence master-reference="recipe-page">
            <xsl:call-template name="header">
                <xsl:with-param name="right" select="title"/>
            </xsl:call-template>
        
            <fo:static-content flow-name="recipe-footer">
                <fo:block font-size="7pt" text-align="end">
                    page <fo:page-number/>
                </fo:block>
            </fo:static-content>
        
            <fo:flow flow-name="xsl-region-body" font-family="Times" font-size="9pt">
                <!-- recipe title -->
                <fo:block font-size="14pt" font-weight="bold" id="{generate-id()}">
                    <xsl:value-of select="title"/>
                </fo:block>
                                
                <!-- ingredients -->
                <fo:block font-size="10pt" font-weight="bold" space-before="12pt">
                    Ingredients
                </fo:block>
                <xsl:for-each select="ingredient">
                    <xsl:call-template name="ingredient-detail">
                        <xsl:with-param name="ingredient" select="."/>
                        <xsl:with-param name="indent" select="0"/>
                    </xsl:call-template>
                </xsl:for-each>
                
                <!-- preparation -->
                <fo:block font-size="10pt" font-weight="bold" space-before="12pt">
                    Preparation
                </fo:block>
                <xsl:call-template name="preparation-list">
                    <xsl:with-param name="p" select="preparation"/>
                </xsl:call-template>
            
            </fo:flow>
        </fo:page-sequence>    
    </xsl:template>
    
    <xsl:template name="header">
        <xsl:param name="right"/>
        <!-- page header: left: booklet title; left: recipe title -->
        <fo:static-content flow-name="recipe-header">
            <fo:block font-size="7pt" text-align-last="justify">
                <xsl:value-of select="/collection/description"/>
                <fo:leader/>
                <xsl:value-of select="$right"/>
            </fo:block>
        </fo:static-content>        
    </xsl:template>
    
    
    <xsl:template name="preparation-list">
        <xsl:param name="p"/>
        <xsl:param name="indent" select="0"/> <!-- 0 is the default -->
        <fo:list-block margin-left="{$indent}mm">
            <xsl:for-each select="$p/step">
                <fo:list-item>
                    <fo:list-item-label>
                        <fo:block>
                            <xsl:value-of select="position()"/>.
                        </fo:block>
                    </fo:list-item-label>
                    <fo:list-item-body start-indent="{$indent+4}mm">
                        <fo:block>
                            <xsl:value-of select="."/>
                        </fo:block>
                    </fo:list-item-body>
                </fo:list-item>                
            </xsl:for-each>
        </fo:list-block>
    </xsl:template>
    
    
    <xsl:template name="ingredient-detail">
        <xsl:param name="ingredient"/>
        <xsl:param name="indent"/>
        
        <xsl:if test="not($ingredient/ingredient)" xml:space="preserve">
            <fo:block start-indent="{$indent}mm">       
                <xsl:value-of select="$ingredient/@name"/>
                <xsl:if test="$ingredient/@amount or $ingredient/@unit">
                    (<xsl:value-of select="$ingredient/@amount"/>
                    <xsl:value-of select="$ingredient/@unit"/>) 
                </xsl:if>
            </fo:block>
        </xsl:if>
        <xsl:if test="$ingredient/ingredient">
            <fo:block start-indent="{$indent}mm" font-weight="bold" space-before="6pt">
                <xsl:value-of select="$ingredient/@name"/>
            </fo:block>
            <xsl:for-each select="$ingredient/ingredient">
                <xsl:call-template name="ingredient-detail">
                    <xsl:with-param name="ingredient" select="."/>
                    <xsl:with-param name="indent" select="$indent+4"/>
                </xsl:call-template>                                
            </xsl:for-each>
            <xsl:if test="$ingredient/preparation">
                <fo:block font-style="italic" text-indent="{$indent}mm">
                    Preparation of <xsl:value-of select="$ingredient/@name"/>
                </fo:block>
                <xsl:call-template name="preparation-list">
                    <xsl:with-param name="p" select="$ingredient/preparation"/>
                    <xsl:with-param name="indent" select="$indent+4"/>
                </xsl:call-template>
            </xsl:if>
        </xsl:if>            
    </xsl:template>
    
</xsl:stylesheet>
