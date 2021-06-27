<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format">
    
    <xsl:template match="/">
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
            
            
            <!-- Here comes the content.
      Printed content consists of one or more page-sequences. Each page-sequence starts on a new page. -->
    
            <!-- front page -->
            <fo:page-sequence master-reference="tournament-page">
                <fo:flow flow-name="xsl-region-body" font-family="sans-serif" font-size="28pt">
                    <fo:block margin-top="40mm">
                        <xsl:value-of select="organizer/tournament/@description"/>
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
                    <fo:block font-weight="bold" margin-top="40mm">Tournament Days:</fo:block>
                    <fo:list-block space-before="24pt">
                        <xsl:apply-templates select="organizer/tournament/tdate" mode="toc"/>
                    </fo:list-block>
                </fo:flow>
            </fo:page-sequence>
            
            <!-- tournaments days -->
            <xsl:apply-templates select="organizer/tournament/tdate" mode="detail"/>
            
            <!-- Scorecards -->
            <xsl:apply-templates select="organizer/tournament/tdate/group/participant/score" mode="scorecard"/>
            
            
        </fo:root>
    </xsl:template>
    
    <!-- ...................... TABLE OF CONTENTS TEMPLATE ................... -->
    <xsl:template match="tdate" mode="toc">
        <fo:list-item>
            <fo:list-item-label>
                <fo:block/>
            </fo:list-item-label>
            <fo:list-item-body start-indent="4mm">
                <fo:block text-align-last="justify">
                    <xsl:value-of select="@day"/> day - <xsl:value-of select="@date"/>
                    <fo:leader leader-pattern="dots"></fo:leader>
                    <fo:page-number-citation ref-id="{generate-id()}"/>
                </fo:block>
            </fo:list-item-body>
        </fo:list-item>
    </xsl:template>
    
    
    <xsl:template name="header">
        <xsl:param name="right"/>
        <!-- page header: left: booklet title; left: recipe title -->
        <fo:static-content flow-name="tournament-header">
            <fo:block font-size="7pt" text-align-last="justify">
                <xsl:value-of select="organizer/tournament/@description"/>
                <fo:leader/>
                <xsl:value-of select="$right"/>
            </fo:block>
        </fo:static-content>        
    </xsl:template>
    
    
    <xsl:template match="tdate" mode="detail" xml:space="preserve">
        <fo:page-sequence master-reference="tournament-page">
            <xsl:call-template name="header">
                <xsl:with-param name="right" select="@date"/>
            </xsl:call-template>
            
            <fo:static-content flow-name="tournament-footer">
                <fo:block font-size="7pt" text-align="end">
                    page <fo:page-number/>
                </fo:block>
            </fo:static-content>
            
            
            <fo:flow flow-name="xsl-region-body" font-family="Times" font-size="9pt">
                <!-- Tdate -->
                <fo:block font-size="20pt" font-weight="bold" id="{generate-id()}">
                    <xsl:value-of select="@day"/> day - <xsl:value-of select="@date"/>
                </fo:block>
                
                <!-- Groups -->
                
                <xsl:for-each select="group">
                    <fo:block font-size="13pt" font-weight="bold" space-before="12pt">
                        <xsl:value-of select="@name"/>
                    </fo:block>
                    <xsl:call-template name="group-detail">
                        <xsl:with-param name="participant" select="./participant"/> 
                        <xsl:with-param name="indent" select="3"/>
                    </xsl:call-template>
                </xsl:for-each>
                
                
                <fo:block font-size="14pt" font-weight="bold" space-before="40pt" space-after="10pt">
                    Scorecards:
                </fo:block>
                
                <xsl:for-each select="group/participant">
                    <fo:block font-size="10pt" font-weight="bold" space-before="12pt">
                        <xsl:value-of select="@firstname"/> <xsl:value-of select="@lastname"/>
                    </fo:block>
                    <xsl:call-template name="score-detail">
                        <xsl:with-param name="score" select="./score"/> 
                        <xsl:with-param name="indent" select="3"/>
                    </xsl:call-template>
                </xsl:for-each>
 
            </fo:flow>
        </fo:page-sequence>
      </xsl:template> 
    
    
    <xsl:template name="score-detail">
        <xsl:param name="score"/>
        <xsl:param name="indent"/>
        
        <fo:table border="0.5pt solid black" text-align="center">
            <fo:table-body>
                <fo:table-row>
                    <fo:table-cell padding="3pt" border="0.5pt solid black">¶
                        <fo:block> Round </fo:block>
                    </fo:table-cell>
                    
                    <xsl:for-each select="$score/round">
                        <fo:table-cell padding="3pt" border="0.5pt solid black">¶
                            <fo:block><xsl:value-of select="@nr"/></fo:block>
                        </fo:table-cell>
                    </xsl:for-each>
                    
                    <fo:table-cell padding="3pt" border="0.5pt solid black">¶
                        <fo:block> Total Score </fo:block>
                    </fo:table-cell>
                </fo:table-row>
                
                <fo:table-row>
                    <fo:table-cell padding="4pt" border="0.5pt solid black">
                        <fo:block> Score </fo:block>
                    </fo:table-cell>
                    
                    <xsl:for-each select="$score/round">
                        <fo:table-cell padding="4pt" border="0.5pt solid black">
                            <fo:block><xsl:value-of select="@round_score"/> </fo:block>
                        </fo:table-cell> 
                    </xsl:for-each>
                    
                    <fo:table-cell padding="3pt" border="0.5pt solid black">¶
                        <fo:block> <xsl:value-of select="$score/@total_score"/> </fo:block>
                    </fo:table-cell>
                </fo:table-row>
            </fo:table-body>
        </fo:table>
    </xsl:template>
    
    
    <xsl:template name="group-detail">
        <xsl:param name="participant"/>
        <xsl:param name="indent"/>
        <xsl:for-each select="$participant" xml:space="preserve">
            <fo:block font-size="12pt" start-indent="{$indent}mm">       
                <xsl:value-of select="@firstname"/> <xsl:value-of select="@lastname"/>
            </fo:block> 
        </xsl:for-each>
    </xsl:template>
</xsl:stylesheet>