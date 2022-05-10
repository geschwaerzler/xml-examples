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
                    
                    <fo:region-before extent="10mm"/>
                    <fo:region-after extent="10mm"/>
                    
                </fo:simple-page-master>
            </fo:layout-master-set>
            
            
            <!-- Here comes the content.
                 Printed content consists of one or more page-sequences. Each page-sequence starts on a new page. -->
            
            <!-- front page -->
            <fo:page-sequence master-reference="recipe-page">
                <fo:flow flow-name="xsl-region-body" font-family="sans-serif" font-size="9pt"  background-color="#F0F0F0">
                    <fo:block font-size="28pt">
                        <xsl:value-of select="description"/>
                    </fo:block>
                    
                    <xsl:call-template name="header2">
                        <xsl:with-param name="text">Table of Contents</xsl:with-param>
                    </xsl:call-template>
                    <fo:block font-size="18" font-weight="700" margin-top="24pt" margin-bottom="12pt">
                        
                    </fo:block>
                    
                    <fo:list-block>
                        <xsl:for-each select="recipe">
                            <fo:list-item>
                                <fo:list-item-label><fo:block>*</fo:block></fo:list-item-label>
                                <fo:list-item-body margin-left="8mm">
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
            
            
            <!-- recipe detail pages -->
            <xsl:apply-templates select="recipe"/>
            
        </fo:root>
    </xsl:template>
    
    
    <xsl:template name="header2">
        <xsl:param name="text"/>
        <fo:block margin-top="24pt" margin-bottom="12pt" font-size="18pt" font-weight="700" id="{generate-id()}">
            <xsl:value-of select="$text"/>
        </fo:block>
    </xsl:template>
    
    
    <xsl:template match="recipe">
        <fo:page-sequence master-reference="recipe-page">
            <fo:static-content flow-name="xsl-region-before" font-size="7pt">
                <fo:block text-align-last="justify">
                    <xsl:value-of select="/collection/description"/>
                    <fo:leader/>
                    <fo:inline font-weight="700"><xsl:value-of select="title"/></fo:inline>
                </fo:block>
            </fo:static-content>
            
            <fo:static-content flow-name="xsl-region-after" font-size="7pt">
                <fo:block text-align-last="right">
                    Page <fo:page-number/>
                </fo:block>
            </fo:static-content>
            
            <fo:flow flow-name="xsl-region-body">
                <xsl:call-template name="header2">
                    <xsl:with-param name="text" select="title"/>
                </xsl:call-template>
                
                <fo:block font-weight="700">Ingredients</fo:block>
                <fo:table>
                    <fo:table-body>
                        <xsl:for-each select="ingredient" xml:space="preserve">
                            <fo:table-row border="0.25pt solid black">
                                <fo:table-cell>
                                    <fo:block><xsl:value-of select="@name"/></fo:block>
                                </fo:table-cell>
                                <fo:table-cell>
                                    <fo:block>
                                        <xsl:value-of select="@amount"/>
                                        <xsl:value-of select="@unit"/>
                                    </fo:block>
                                </fo:table-cell>
                            </fo:table-row>                            
                        </xsl:for-each>
                    </fo:table-body>
                </fo:table>
            </fo:flow>
        </fo:page-sequence>
    </xsl:template>
    
    
    
</xsl:stylesheet>
