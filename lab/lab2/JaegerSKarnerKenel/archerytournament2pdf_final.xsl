<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format">
    
    <!-- ............................ ROOT TEMPLATE .......................... -->
    <xsl:template match="archerytournament">
        <fo:root>
            
            <!-- define the layout of the document -->
            <fo:layout-master-set>
                <!-- here we define the layout of pages. There might be differrent page masters with e.g. different margin settings -->
                <fo:simple-page-master master-name="tournament-page"
                    page-height="297.0mm" page-width="209.9mm"
                    margin-bottom="8mm" margin-left="25mm" margin-right="10mm" margin-top="10mm">
                    
                    <!-- the content will be placed into the region-body -->
                    <fo:region-body margin-bottom="28mm" margin-left="0mm" margin-right="44mm" margin-top="20mm"/>
                  
                    <!-- region-before is the page header -->
                    <fo:region-before extent="24pt" region-name="tournament-header"/>
                    
                    <!-- region-after is the page footer -->
                    <fo:region-after extent="24pt" region-name="tournament-footer"/>
                    
                </fo:simple-page-master>
            </fo:layout-master-set>
            
            
            <!-- front page -->
            <fo:page-sequence master-reference="tournament-page">
                <fo:flow flow-name="xsl-region-body" font-family="sans-serif" font-size="28pt">
                    <fo:block margin-top="40mm">
                        <xsl:value-of select="@name"/>
                    </fo:block>
                </fo:flow>
            </fo:page-sequence>
            
            <!-- table of contents -->
            <fo:page-sequence master-reference="tournament-page">
                <!-- place a page description into the page header -->
                <xsl:call-template name="header">
                    <xsl:with-param name="right" select="'Table of Contents'"/>
                </xsl:call-template>
                
                <!-- place the table of contents into region-body -->
                <fo:flow flow-name="xsl-region-body" font-family="Times" font-size="9pt">
                    <fo:block font-weight="bold" margin-top="40mm">Table of Contents</fo:block>
                    <fo:list-block space-before="24pt">
                        <xsl:apply-templates select="group" mode="toc"/>
                        <xsl:apply-templates select="parkour" mode="toc"/>
                    </fo:list-block>
                </fo:flow>
            </fo:page-sequence>
            
            <!-- groups -->
            <xsl:call-template name="groups"/>
            
            <!-- parkours -->
            <xsl:call-template name="parkours"/>
            
            <!-- scorecards -->
            <xsl:apply-templates select="athlete" mode="scorecards"/>
            
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
                    <xsl:value-of select="@name"/>
                    <fo:leader leader-pattern="dots"></fo:leader>
                    <fo:page-number-citation ref-id="{generate-id()}"/>
                </fo:block>
            </fo:list-item-body>
        </fo:list-item>
    </xsl:template>
    
    <xsl:template match="parkour" mode="toc">
        <fo:list-item>
            <fo:list-item-label>
                <fo:block><xsl:value-of select="position()+count(/archerytournament/group)"/>.</fo:block>
            </fo:list-item-label>
            <fo:list-item-body start-indent="4mm">
                <fo:block text-align-last="justify">
                    Parkour <xsl:value-of select="@name"/>
                    <fo:leader leader-pattern="dots"></fo:leader>
                    <fo:page-number-citation ref-id="{generate-id()}"/>
                </fo:block>
            </fo:list-item-body>
        </fo:list-item>
    </xsl:template>
    
    
    <!-- .......................... HEADER TEMPLATE .......................... -->
    <xsl:template name="header">
        <xsl:param name="right"/>
        <fo:static-content flow-name="tournament-header">
            <fo:block font-size="7pt" text-align-last="justify">
                <xsl:value-of select="/archerytournament/@name"/>
                <fo:leader/>
                <xsl:value-of select="$right"/>
            </fo:block>
        </fo:static-content>
    </xsl:template>
    
    
    <!-- .......................... GROUPS TEMPLATE .......................... -->
    <xsl:template name="groups">
        <fo:page-sequence master-reference="tournament-page">
            <xsl:call-template name="header">
                <xsl:with-param name="right" select="'Groups'"/>
            </xsl:call-template>
            
            <fo:static-content flow-name="tournament-footer">
                <fo:block font-size="7pt" text-align="end">
                    page <fo:page-number/>
                </fo:block>
            </fo:static-content>
            
            <fo:flow flow-name="xsl-region-body" font-family="Times" font-size="9pt">
                <fo:block font-weight="bold">Groups</fo:block>
                <xsl:for-each select="/archerytournament/group">
                    <fo:block margin-top="4mm"><xsl:value-of select="@name"/></fo:block>
                    <xsl:for-each select="member">
                        <fo:list-block space-before="4pt">
                            <fo:list-item>
                                <fo:list-item-label>
                                    <fo:block>-</fo:block>
                                </fo:list-item-label>
                                <fo:list-item-body start-indent="4mm">
                                    <fo:block>
                                        <xsl:value-of select="id(@athlete-id)/firstname"/> <xsl:value-of select="id(@athlete-id)/lastname"/>
                                    </fo:block>
                                </fo:list-item-body>
                            </fo:list-item>
                        </fo:list-block>
                    </xsl:for-each>
                </xsl:for-each>
            </fo:flow>
        </fo:page-sequence>
    </xsl:template>
    
    
    <!-- .......................... PARKOURS TEMPLATE .......................... -->
    <xsl:template name="parkours">
        <fo:page-sequence master-reference="tournament-page">
            <xsl:call-template name="header">
                <xsl:with-param name="right" select="'Parkours'"/>
            </xsl:call-template>
            
            <fo:static-content flow-name="tournament-footer">
                <fo:block font-size="7pt" text-align="end">
                    page <fo:page-number/>
                </fo:block>
            </fo:static-content>
            
            <fo:flow flow-name="xsl-region-body" font-family="Times" font-size="9pt">
                <fo:block font-weight="bold">Parkours</fo:block>
                <xsl:for-each select="/archerytournament/parkour">
                    <fo:block font-weight="bold" margin-top="4mm" id="{generate-id()}"><xsl:value-of select="@name"/></fo:block>
                    <xsl:for-each select="target">
                        <fo:list-block space-before="4pt">
                            <fo:list-item>
                                <fo:list-item-label>
                                    <fo:block>-</fo:block>
                                </fo:list-item-label>
                                <fo:list-item-body start-indent="4mm">
                                    <fo:block>
                                        Target <xsl:value-of select="@id"/>
                                    </fo:block>
                                </fo:list-item-body>
                            </fo:list-item>
                        </fo:list-block>
                    </xsl:for-each>
                </xsl:for-each>
            </fo:flow>
        </fo:page-sequence>
    </xsl:template>
    
    
    <!-- .......................... SCORECARDS TEMPLATE .......................... -->
    <xsl:template match="athlete" mode="scorecards" xml:space="preserve">
        <fo:page-sequence master-reference="tournament-page">
            <xsl:call-template name="header">
                <xsl:with-param name="right" select="concat(firstname,' ',lastname)"/>
            </xsl:call-template>
            
            <fo:static-content flow-name="tournament-footer">
                <fo:block font-size="7pt" text-align="end">
                    page <fo:page-number/>
                </fo:block>
            </fo:static-content>
            
            <fo:flow flow-name="xsl-region-body" font-family="Times" font-size="9pt">
                <fo:block font-weight="bold">
                    <xsl:value-of select="firstname"/> <xsl:value-of select="lastname"/>
                </fo:block>
                <xsl:apply-templates select="scorecard"/>
            </fo:flow>
        </fo:page-sequence>
    </xsl:template>
    
    <xsl:template match="scorecard">
        <fo:table border="0.5pt solid black" text-align="center" margin-top="4mm">
            <fo:table-body>
                <fo:table-row>
                    <fo:table-cell padding="6pt" border="0.5pt solid black">
                        <fo:block> Target </fo:block>
                    </fo:table-cell>
                    <fo:table-cell padding="6pt" border="0.5pt solid black">
                        <fo:block> Score </fo:block>
                    </fo:table-cell>
                    <fo:table-cell padding="6pt" border="0.5pt solid black">
                        <fo:block> Score </fo:block>      
                    </fo:table-cell>
                    <fo:table-cell padding="6pt" border="0.5pt solid black">
                        <fo:block> Score </fo:block>      
                    </fo:table-cell>
                </fo:table-row>
                <fo:table-row>
                    <fo:table-cell padding="6pt" border="0.5pt solid black">
                        <fo:block> <xsl:value-of select="score[1]/@target-id"/> </fo:block>
                    </fo:table-cell>
                    <fo:table-cell padding="6pt" border="0.5pt solid black">
                        <fo:block> <xsl:value-of select="score[1]"/> </fo:block>
                    </fo:table-cell>
                    <fo:table-cell padding="6pt" border="0.5pt solid black">
                        <fo:block> <xsl:value-of select="score[2]"/> </fo:block>
                    </fo:table-cell>
                    <fo:table-cell padding="6pt" border="0.5pt solid black">
                        <fo:block> <xsl:value-of select="score[3]"/> </fo:block>
                    </fo:table-cell>
                </fo:table-row>
                <fo:table-row>
                    <fo:table-cell padding="6pt" border="0.5pt solid black">
                        <fo:block> <xsl:value-of select="score[4]/@target-id"/> </fo:block>
                    </fo:table-cell>
                    <fo:table-cell padding="6pt" border="0.5pt solid black">
                        <fo:block> <xsl:value-of select="score[4]"/> </fo:block>
                    </fo:table-cell>
                    <fo:table-cell padding="6pt" border="0.5pt solid black">
                        <fo:block> <xsl:value-of select="score[5]"/> </fo:block>
                    </fo:table-cell>
                    <fo:table-cell padding="6pt" border="0.5pt solid black">
                        <fo:block> <xsl:value-of select="score[6]"/> </fo:block>
                    </fo:table-cell>
                </fo:table-row>
                <fo:table-row>
                    <fo:table-cell padding="6pt" border="0.5pt solid black">
                        <fo:block> <xsl:value-of select="score[7]/@target-id"/> </fo:block>
                    </fo:table-cell>
                    <fo:table-cell padding="6pt" border="0.5pt solid black">
                        <fo:block> <xsl:value-of select="score[7]"/> </fo:block>
                    </fo:table-cell>
                    <fo:table-cell padding="6pt" border="0.5pt solid black">
                        <fo:block> <xsl:value-of select="score[8]"/> </fo:block>
                    </fo:table-cell>
                    <fo:table-cell padding="6pt" border="0.5pt solid black">
                        <fo:block> <xsl:value-of select="score[9]"/> </fo:block>
                    </fo:table-cell>
                </fo:table-row>
            </fo:table-body>
        </fo:table>
    </xsl:template>
    
</xsl:stylesheet>
