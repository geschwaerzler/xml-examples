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
                <fo:simple-page-master master-name="archery-page"
                    page-height="297.0mm" page-width="209.9mm"
                    margin-bottom="8mm" margin-left="25mm" margin-right="10mm" margin-top="10mm">
                    
                    <!-- the content will be placed into the region-body -->
                    <fo:region-body margin-bottom="28mm" margin-left="0mm" margin-right="44mm" margin-top="60mm"/>
                    
                    <!-- region-before is the page header -->
                    <fo:region-before extent="24pt" region-name="archery-header"/>
                    
                    <!-- region-after is the page footer -->
                    <fo:region-after extent="24pt" region-name="archery-footer"/>
                    
                </fo:simple-page-master>
            </fo:layout-master-set>
            
            
            <!-- Here comes the content.
                 Printed content consists of one or more page-sequences. Each page-sequence starts on a new page. -->
            
            <!-- front page -->
            <fo:page-sequence master-reference="archery-page">
                <fo:flow flow-name="xsl-region-body" font-family="sans-serif" font-size="28pt">
                    <fo:block margin-top="40mm" font-size="28pt">
                        <xsl:value-of select="archery_event/tournament/@tournament_name"/>
                    </fo:block>
                    <fo:block font-size="20pt" margin-top="5mm">
                        <xsl:value-of select="archery_event/tournament/@place"/>,
                        <xsl:value-of select="archery_event/tournament/@year"/>
                    </fo:block>
                </fo:flow>
            </fo:page-sequence>
            
            <!-- table of contents -->
            <fo:page-sequence master-reference="archery-page">
                <!-- place a page description into the page header -->
                <xsl:call-template name="header">
                    <xsl:with-param name="right" select="'Table of Contents'"/>
                </xsl:call-template>
                
                <!-- place the table of contents into region-body -->
                <fo:flow flow-name="xsl-region-body" font-family="Times" font-size="9pt">
                    <fo:block font-weight="bold" margin-top="40mm">Table of Contents</fo:block>
                    <fo:list-block space-before="24pt">
                        <xsl:apply-templates select="archery_event/tournament/group" mode="toc"/>
                    </fo:list-block>
                </fo:flow>
            </fo:page-sequence>
            
            <!-- groups -->
            <xsl:apply-templates select="archery_event/tournament/group" mode="detail"/>
            
        </fo:root>
    </xsl:template>
    
    <!-- ...................... TABLE OF CONTENTS TEMPLATE ................... -->
    <xsl:template match="group" mode="toc">
        <fo:list-item>
            <fo:list-item-label>
                <fo:block><xsl:value-of select="position()"/>.</fo:block>
            </fo:list-item-label>
            <fo:list-item-body start-indent="4mm">
                <fo:block text-align-last="justify">
                    <fo:inline text-transform="capitalize"><xsl:value-of select="@group_id"/></fo:inline>
                    <fo:leader leader-pattern="dots"></fo:leader>
                    <fo:page-number-citation ref-id="{generate-id()}"/>
                </fo:block>
            </fo:list-item-body>
        </fo:list-item>
    </xsl:template>
    
    
    <!-- ....................................... GROUP TEMPLATE .......................................-->
    <xsl:template match="group" mode="detail" xml:space="preserve">
        <fo:page-sequence master-reference="archery-page">
            <xsl:call-template name="header">
                <xsl:with-param name="right" select="@group_id"/>
            </xsl:call-template>
        
            <fo:static-content flow-name="archery-footer">
                <fo:block font-size="7pt" text-align="end">
                    page <fo:page-number/>
                </fo:block>
            </fo:static-content>
        
            <fo:flow flow-name="xsl-region-body" font-family="Times" font-size="9pt">
                <!-- group id -->
                <fo:block font-size="14pt" font-weight="bold" id="{generate-id()}"> 
                    <fo:inline text-transform="capitalize"><xsl:value-of select="@group_id"/></fo:inline>
                </fo:block>
                                
                <!-- targets -->
                <fo:block font-size="12pt" font-weight="bold" space-before="12pt" space-after="12pt">
                    Targets
                </fo:block>
                <fo:block>
                    <xsl:for-each select="target">
                        <xsl:apply-templates select="." mode="target-detail"/>
                    </xsl:for-each>
                </fo:block>
            </fo:flow>
        </fo:page-sequence>    
    </xsl:template>
    
    
    <xsl:template match="target" mode="target-detail">
        
        <fo:block font-size="10pt" font-weight="bold" space-after="3pt">
            <fo:inline text-transform="capitalize">
                <xsl:value-of select="@target_id"/><xsl:text> ( Size: </xsl:text>
                <xsl:value-of select="@size"/><xsl:text>)</xsl:text>
            </fo:inline>
        </fo:block>
         
        <fo:block>
            <fo:table space-after="12pt">
                <fo:table-header border-bottom="1pt solid black">
                    <fo:table-row>
                        <fo:table-cell><fo:block font-weight="bold"><xsl:text>Participant</xsl:text></fo:block></fo:table-cell>
                        <fo:table-cell><fo:block font-weight="bold"><xsl:text>Score</xsl:text></fo:block></fo:table-cell>
                        <fo:table-cell><fo:block font-weight="bold"><xsl:text>Shot Number</xsl:text></fo:block></fo:table-cell>
                    </fo:table-row>
                </fo:table-header>
                <fo:table-body>
                    <xsl:for-each select="score">
                        <fo:table-row space-after="1.5pt">
                            <fo:table-cell>
                                <fo:block><fo:inline text-transform="capitalize"><xsl:value-of select="@participant_id"/></fo:inline></fo:block>
                            </fo:table-cell>
                            <fo:table-cell>
                                <fo:block><xsl:value-of select="@target_score"/></fo:block>
                            </fo:table-cell>
                            <fo:table-cell>
                                <fo:block><xsl:value-of select="@shot_no"/></fo:block>
                            </fo:table-cell>
                        </fo:table-row>
                    </xsl:for-each>
                </fo:table-body>
            </fo:table>
                    
        </fo:block>
        
    </xsl:template>
    
    
    <xsl:template name="header">
        <xsl:param name="right"/>
        <fo:static-content flow-name="archery-header">
            <fo:block font-size="7pt" text-align-last="justify">
                <xsl:value-of select="/collection/description"/>
                <fo:leader/>
                <xsl:value-of select="$right"/>
            </fo:block>
        </fo:static-content>        
    </xsl:template>
    
</xsl:stylesheet>
