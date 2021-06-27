<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format">
    
    <!-- ............................ ROOT TEMPLATE .......................... -->
    <xsl:template match="/tournament">
        
        <fo:root>
            
            <!-- define the layout of the document -->
            <fo:layout-master-set>
                <!-- here we define the layout of pages. There might be differrent page masters with e.g. different margin settings -->
                <fo:simple-page-master master-name="tournament-page"
                    page-height="297.0mm" page-width="209.9mm"
                    margin-bottom="8mm" margin-left="25mm" margin-right="10mm" margin-top="10mm">
                    
                    <!-- the content will be placed into the region-body -->
                    <fo:region-body margin-bottom="28mm" margin-left="0mm" margin-right="15mm" margin-top="60mm"/>
                    
                    <!--region before is the page header-->
                    <fo:region-before extent="24pt" region-name="tournament-header"/>
                    
                    <!-- region-after ist the page footer -->
                    <fo:region-after extent="24pt" region-name="tournament-footer"/>
                    
                </fo:simple-page-master>
            </fo:layout-master-set>
            
            
            <!-- Here comes the content.
                 Printed content consists of one or more page-sequences. Each page-sequence starts on a new page. -->
            
            <!-- front page -->
            <fo:page-sequence master-reference="tournament-page">
                <fo:flow flow-name="xsl-region-body" font-family="sans-serif" font-size="28pt">
                    <fo:block margin-top="40mm">
                        <xsl:value-of select="description"/>
                    </fo:block>
                </fo:flow>
            </fo:page-sequence>
            
            <!-- Inhaltsverzeichnis -->
            <fo:page-sequence master-reference="tournament-page">
                <xsl:call-template name="header">
                    <xsl:with-param name="right" select="'Inhaltsverzeichnis'"/>
                </xsl:call-template>
                
                <!-- um den Inhaltsverzeichnis anzuzeigen -->
                <fo:flow flow-name="xsl-region-body" font-family="sans-serif" font-size="25pt">
                    <fo:block font-weight="bold" margin-top="25mm">Inhaltsverzeichnis</fo:block>
                    <fo:list-block space-before="24pt" font-size="15pt">
                        <xsl:apply-templates select="group" mode="iv"/>
                    </fo:list-block>
                </fo:flow>
            </fo:page-sequence>
            
            <!-- um die Gruppenaufteilung anzuzeigen -->
            <xsl:apply-templates select="group" mode="detail"/>
            
            <!-- Scorecards -->
            <xsl:apply-templates select="target"/>             
            
            
        </fo:root>
    </xsl:template>
    
    
    
    <!-- .................... TEMPLATE FÜR HEADER .................... -->
    <xsl:template name="header">
        <xsl:param name="rigth"/>
        <fo:static-content flow-name="tournament-header">
            <fo:block font-size="8pt" text-align-last="justify">
                <xsl:value-of select="description"/>
                <fo:leader/>
                <xsl:value-of select="$rigth"/>
            </fo:block>
        </fo:static-content>
    </xsl:template>
    
    
    <!-- .................... TEMPLATE FÜR FOOTER .................... -->
    <xsl:template name="footer">
        <xsl:param name="right"/>        
        <fo:static-content flow-name="tournament-footer">
            <fo:block font-size="8pt" text-align="end">
                page <fo:page-number/>
            </fo:block>
        </fo:static-content>
    </xsl:template>
    
    
    <!-- .................... TEMPLATE FÜR INHALTSVERZEICHNIS .................... -->
    <xsl:template match="group" mode="iv">
        <fo:list-item space-after="30pt">
            <fo:list-item-label> 
                <fo:block> Gruppe <xsl:value-of select="position()"/></fo:block>
            </fo:list-item-label>
            <fo:list-item-body start-indent="24mm">
                <fo:block text-align-last="justify">
                    <fo:basic-link internal-destination="{generate-id()}">
                        <xsl:value-of select="nr"/>
                        <fo:leader leader-pattern="dots"/>
                        <fo:page-number-citation ref-id="{generate-id()}"/> 
                    </fo:basic-link>                    
                </fo:block>
                
                             
            </fo:list-item-body>  
        </fo:list-item>
    </xsl:template>
    
    
    <!-- .................... TEMPLATE FÜR GRUPPENAUFTEILUNG ....................D -->
    <xsl:template match="group" mode="detail">
        <fo:page-sequence master-reference="tournament-page">
            
            <xsl:call-template name="header">
                <xsl:with-param name="rigth" select="@nr"/>
            </xsl:call-template>
            
            <xsl:call-template name="footer"/>            
            
            
            <fo:flow flow-name="xsl-region-body" font-family="sans-serif" font-size="12pt">
                <fo:block font-size="18pt" font-weight="bold" id="{generate-id()}"> Gruppe
                    <xsl:value-of select="@nr"/>                    
                </fo:block>
                
                <fo:block space-before="24pt" font-size="14pt">
                    <xsl:apply-templates select="athlete"/>
                </fo:block>                
            </fo:flow>
        </fo:page-sequence>
        
    </xsl:template>
    
    
    <!-- .................... TEMPLATE FÜR ATHLETEN .................... -->
    <xsl:template match="athlete">
        <fo:block>
            <xsl:value-of select="concat(@firstname, ' ', @lastname)"/>
        </fo:block>
        <fo:block>
            <xsl:apply-templates select="score-card"/>
        </fo:block>
       
    </xsl:template>
    
    
    <!-- ............... TEMPLATE FÜR GRUPPENAUFTEILUNG/RUNDEN ............... -->
    <xsl:template match="score-card">
        <fo:list-block space-before="14pt">
            <xsl:for-each select="@athlete-id" xml:space="preserve">
                <fo:list-item>
                    <fo:list-item-label>
                        <fo:block>
                            Runde <xsl:value-of select="concat(../@nr, ' am ', ../@date, ' . . . . . . . . . . ')"/>  
                            <xsl:value-of select="sum(target/score/@points)"/>
                        </fo:block>
                    </fo:list-item-label>               
                <fo:list-item-body>
                    <fo:block>
                        <fo:basic-link internal-destination="{generate-id()}">
                            <xsl:value-of select="@athlete-id"/>
                        </fo:basic-link>
                    </fo:block>
                </fo:list-item-body>
                </fo:list-item>
            </xsl:for-each>
        </fo:list-block>               
    </xsl:template>
    
    
    <!-- .................... TEMPLATE FÜR SCORECARDS DETAIL....................D -->
    <xsl:template match="target">
        <fo:page-sequence master-reference="tournament-page">
            
            <xsl:call-template name="header">
                <xsl:with-param name="rigth" select="../@athlete-id"/>
            </xsl:call-template>
            
            <xsl:call-template name="footer"/>
            
            <fo:flow flow-name="xsl-region-body" font-family="sans-serif" font-size="12pt">
              <fo:block font-size="20pt" font-weight="bold">
                  <xsl:apply-templates select="athlete" mode="gruppe"/>                  
              </fo:block>                 
            
                <fo:table margin-top="10pt">
                    <fo:table-column column-width="20mm"/>
                    <fo:table-column column-width="35mm"/>
                    <fo:table-column column-width="30mm"/>
                    <fo:table-column column-width="30mm"/>
                    <fo:table-column column-width="30mm"/>
                    <fo:table-column column-width="20mm"/>
                    
                    <fo:table-header border-width="1pt">
                        <fo:table-row>
                            <fo:table-cell>
                                <fo:block font-weight="bold">Runde</fo:block>
                            </fo:table-cell>
                            <fo:table-cell>
                                <fo:block font-weight="bold">Zielscheibe</fo:block>
                            </fo:table-cell>
                            <fo:table-cell>
                                <fo:block font-weight="bold">Versuch 1</fo:block>
                            </fo:table-cell>
                            <fo:table-cell>
                                <fo:block font-weight="bold">Versuch 2</fo:block>
                            </fo:table-cell>
                            <fo:table-cell>
                                <fo:block font-weight="bold">Versuch 3</fo:block>
                            </fo:table-cell>
                            <fo:table-cell>
                                <fo:block font-weight="bold">Punkte</fo:block>
                            </fo:table-cell>
                        </fo:table-row>                        
                    </fo:table-header>
                    
                    <fo:table-body border-width="1pt">
                        <xsl:for-each select="../@athlete-id">
                            <fo:table-row  border-width="1pt" border-style="solid">
                                <fo:table-cell>
                                    <fo:block><xsl:value-of select="../../@nr"/></fo:block>
                                </fo:table-cell>
                                <fo:table-cell>
                                    <fo:block><xsl:value-of select="@nr"/></fo:block>
                                </fo:table-cell>
                                <fo:table-cell>
                                    <fo:block><xsl:value-of select="score[1]/@points"/></fo:block>
                                </fo:table-cell>
                                <fo:table-cell>
                                    <fo:block><xsl:value-of select="score[2]//@points"/></fo:block>
                                </fo:table-cell>
                                <fo:table-cell>
                                    <fo:block><xsl:value-of select="score[3]/@points"/></fo:block>
                                </fo:table-cell>
                                <fo:table-cell>
                                    <fo:block><xsl:value-of select="sum(score/@points)"/></fo:block>
                                </fo:table-cell>
                            </fo:table-row>
                        </xsl:for-each>                        
                    </fo:table-body>                    
                </fo:table>              
            </fo:flow>   
            
        </fo:page-sequence>       
        
    </xsl:template>
    
    
    <!-- .................... TEMPLATE FÜR SCORECARD/HEADLINE.................... -->
    <xsl:template match="athlete" mode="gruppe">
        <fo:block>           
            <xsl:value-of select="concat(@firstname,' ',@lastname , ' - Gruppe ', ../@nr,' ' , ../round/@date)" xml:space = "preserve"/>            
        </fo:block>       
    </xsl:template>
    	
    
    
</xsl:stylesheet>

