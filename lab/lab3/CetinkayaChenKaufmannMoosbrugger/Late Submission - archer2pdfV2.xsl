<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format">
    
    <xsl:template match="/tournament">
        <fo:root>
            
            <!-- define the layout of the document -->
            <fo:layout-master-set>
                <!-- here we define the layout of pages. There might be differrent page masters with e.g. different margin settings -->
                <fo:simple-page-master master-name="a4page"
                    page-height="297.0mm" page-width="209.9mm"
                    margin-bottom="8mm" margin-left="25mm" margin-right="10mm" margin-top="10mm">
                    

                    <fo:region-body margin-bottom="28mm" margin-left="0mm" margin-right="44mm" margin-top="20mm"/>
                    <fo:region-before extent="24pt" region-name="archery-header"/>
                    <fo:region-after extent="24pt" region-name="archery-footer"/>
                </fo:simple-page-master>
            </fo:layout-master-set>

            <!-- front page -->
            <fo:page-sequence master-reference="a4page">
                
                <fo:flow flow-name="xsl-region-body" font-family="sans-serif" font-size="28pt">
                    <fo:block margin-top="40mm">
                       <xsl:value-of select="@name"/>
                    </fo:block>
                </fo:flow>
                
            </fo:page-sequence>
            
            <!-- Table of contents-->
            <fo:page-sequence master-reference="a4page">
                
                <fo:static-content flow-name="archery-header">
                    <fo:block font-size="7pt">
                        <xsl:value-of select="@name"/>
                        - Table of Contents
                    </fo:block>
                </fo:static-content>
                
                
                <fo:flow flow-name="xsl-region-body" font-family="sans-serif" font-size="28pt">
                    <fo:block margin-bottom="30px">Table of contents</fo:block>
                    
                    <fo:list-block>
                        <fo:list-item margin-bottom="10px">
                            <fo:list-item-label>
                                <fo:block></fo:block>
                            </fo:list-item-label>
                            <fo:list-item-body>
                                <fo:block text-align-last="justify" margin-bottom="10px" font-size="14pt">
                                    <fo:basic-link internal-destination="C001">
                                    Teilnehmerliste
                                    <fo:inline>
                                    <fo:leader leader-pattern="dots"/>
                                    </fo:inline>
                                    <fo:page-number-citation ref-id="C001"/>
                                    </fo:basic-link>
                                </fo:block>
                            </fo:list-item-body>
                        </fo:list-item>
                        
                        <fo:list-item margin-bottom="10px">
                            <fo:list-item-label>
                                <fo:block></fo:block>
                            </fo:list-item-label>
                            <fo:list-item-body>
                                <fo:block text-align-last="justify" margin-bottom="10px" font-size="14pt">
                                    <fo:basic-link internal-destination="C002">
                                        Gruppen
                                        <fo:inline>
                                            <fo:leader leader-pattern="dots"/>
                                        </fo:inline>
                                        <fo:page-number-citation ref-id="C002"/>
                                    </fo:basic-link>
                                </fo:block>
                            </fo:list-item-body>
                        </fo:list-item>
                        
                        <fo:list-item margin-bottom="10px">
                            <fo:list-item-label>
                                <fo:block></fo:block>
                            </fo:list-item-label>
                            <fo:list-item-body>
                                <fo:block text-align-last="justify" margin-bottom="10px" font-size="14pt">
                                    <fo:basic-link internal-destination="C003">
                                        Ergebnisse je Gruppe
                                        <fo:inline>
                                            <fo:leader leader-pattern="dots"/>
                                        </fo:inline>
                                        <fo:page-number-citation ref-id="C003"/>
                                    </fo:basic-link>
                                </fo:block>
                            </fo:list-item-body>
                        </fo:list-item>
                        
                        <fo:list-item margin-bottom="10px">
                            <fo:list-item-label>
                                <fo:block></fo:block>
                            </fo:list-item-label>
                            <fo:list-item-body>
                                <fo:block text-align-last="justify" margin-bottom="10px" font-size="14pt">
                                    <fo:basic-link internal-destination="C004">
                                        Ranglisten
                                        <fo:inline>
                                            <fo:leader leader-pattern="dots"/>
                                        </fo:inline>
                                        <fo:page-number-citation ref-id="C004"/>
                                    </fo:basic-link>
                                </fo:block>
                            </fo:list-item-body>
                        </fo:list-item>
                        
                        <fo:list-item margin-bottom="10px">
                            <fo:list-item-label>
                                <fo:block></fo:block>
                            </fo:list-item-label>
                            <fo:list-item-body>
                                <fo:block text-align-last="justify" margin-bottom="10px" font-size="14pt">
                                    <fo:basic-link internal-destination="C005">
                                        Ranges
                                        <fo:inline>
                                            <fo:leader leader-pattern="dots"/>
                                        </fo:inline>
                                        <fo:page-number-citation ref-id="C005"/>
                                    </fo:basic-link>
                                </fo:block>
                            </fo:list-item-body>
                        </fo:list-item>

                        
                    </fo:list-block>
                    
                </fo:flow>
            </fo:page-sequence>
                
           
            
            <!-- Teilnehmerlist-->
            <fo:page-sequence master-reference="a4page">
                
                <fo:static-content flow-name="archery-header">
                    <fo:block font-size="7pt">
                        <xsl:value-of select="@name"/>
                        - Participants
                    </fo:block>
                </fo:static-content>
                
                <fo:static-content flow-name="archery-footer">
                    <fo:block font-size="10pt">
                        Page <fo:page-number/>
                    </fo:block>
                </fo:static-content>
                
                
                <fo:flow flow-name="xsl-region-body" font-family="sans-serif" font-size="10pt">
                    <fo:block id="C001" font-size="24pt" >Teilnehmerliste</fo:block>
                    <fo:table>
                        <fo:table-column column-width="5%"/>
                        <fo:table-column column-width="25%"/>
                        <fo:table-column column-width="25%"/>
                        <fo:table-column column-width="10%"/>
                        <fo:table-column column-width="20%"/>
                        <fo:table-column column-width="10%"/>
                        <fo:table-column column-width="20%"/>
                        <fo:table-header font-size="10pt" margin-bottom="20px" border-bottom="1px solid black">
                            <fo:table-row>
                                <fo:table-cell><fo:block></fo:block></fo:table-cell>
                                <fo:table-cell><fo:block>Firstname</fo:block></fo:table-cell>
                                <fo:table-cell><fo:block>Lastname</fo:block></fo:table-cell>
                                <fo:table-cell><fo:block>Age</fo:block></fo:table-cell>
                                <fo:table-cell><fo:block>Club</fo:block></fo:table-cell>
                                <fo:table-cell><fo:block>Gender</fo:block></fo:table-cell>
                                <fo:table-cell><fo:block>Shooting Style</fo:block></fo:table-cell>
                            </fo:table-row>
                        </fo:table-header>
                        <fo:table-body>
                            <xsl:apply-templates select="person" mode="list"/>
                        </fo:table-body>
                    </fo:table>
                </fo:flow>
            </fo:page-sequence>
            
      
            <!--Gruppenzusammenstellungen-->
            <fo:page-sequence master-reference="a4page">
                
                <fo:static-content flow-name="archery-header">
                    <fo:block font-size="7pt">
                        <xsl:value-of select="@name"/>
                        - Groups
                    </fo:block>
                </fo:static-content>
                
                <fo:static-content flow-name="archery-footer">
                    <fo:block font-size="10pt">
                        Page <fo:page-number/>
                    </fo:block>
                </fo:static-content>
                
                <fo:flow flow-name="xsl-region-body">
                    <fo:block id="C002" font-size="24pt">Gruppen</fo:block>
                    <xsl:apply-templates select="group"/>
                       
                    
                </fo:flow>
            </fo:page-sequence>
            <!--Scorecards je gruppe-->
            <fo:page-sequence master-reference="a4page">
                
                <fo:static-content flow-name="archery-header">
                    <fo:block font-size="7pt">
                        <xsl:value-of select="@name"/>
                        - Groupresults
                    </fo:block>
                </fo:static-content>
                
                <fo:static-content flow-name="archery-footer">
                    <fo:block font-size="10pt">
                        Page <fo:page-number/>
                    </fo:block>
                </fo:static-content>
                
                <fo:flow flow-name="xsl-region-body">
                    <fo:block id="C003" font-size="24pt">Ergebnisse je Gruppen</fo:block>
                    
                    <xsl:for-each select="group">
                        <fo:block font-size="14pt"><xsl:text>Gruppe: </xsl:text><xsl:value-of select="@nr"/> <xsl:text>, Rundentyp: </xsl:text><xsl:value-of select="round/@type"/>
                        <xsl:text>, am </xsl:text><xsl:value-of select="round/@date"/>
                        </fo:block>
                        <xsl:apply-templates select="round/score-card"/>
                    </xsl:for-each>
                    
                </fo:flow>
            </fo:page-sequence>
            
            <!--Rangliste je Tag -->
            <fo:page-sequence master-reference="a4page">
                
                <fo:static-content flow-name="archery-header">
                    <fo:block font-size="7pt">
                        <xsl:value-of select="@name"/>
                        - Ranking
                    </fo:block>
                </fo:static-content>
                
                <fo:static-content flow-name="archery-footer">
                    <fo:block font-size="10pt">
                        Page <fo:page-number/>
                    </fo:block>
                </fo:static-content>
                
                
            <fo:flow flow-name="xsl-region-body">
                <fo:block id="C004" font-size="24pt">Ranglisten je Tag</fo:block>
                
                
                <fo:block margin-bottom="10px" font-size="15pt">Ergebnisse des Tages 2021-06-19</fo:block>
                <fo:table>
                    <fo:table-column column-width="5mm"/>
                    <fo:table-column column-width="30mm"/>
                    <fo:table-column column-width="40mm"/>
                    <fo:table-column column-width="20mm"/>
                    <fo:table-header border-bottom="1px solid black" margin-bottom="10px">
                        <fo:table-row>
                            <fo:table-cell><fo:block></fo:block></fo:table-cell>
                            <fo:table-cell><fo:block>Vorname</fo:block></fo:table-cell>
                            <fo:table-cell><fo:block>Nachname</fo:block></fo:table-cell>
                            <fo:table-cell><fo:block>Punkte</fo:block></fo:table-cell>
                        </fo:table-row>
                    </fo:table-header>
                    <fo:table-body>
                <xsl:for-each select="group/athlete[../round/@date = '2021-06-19']">
                    <xsl:sort select="sum(../round/score-card[@athlete-id = ./@athlete-id]/target/score/@points)" order="descending"/>
                    
                    <xsl:variable name="aid" select="@person-id"/>
                        <fo:table-row>
                            <fo:table-cell><fo:block><xsl:value-of select="position()"/></fo:block></fo:table-cell>
                            <fo:table-cell><fo:block><xsl:value-of select="id(@person-id)/@firstname"/></fo:block></fo:table-cell>
                            <fo:table-cell><fo:block><xsl:value-of select="id(@person-id)/@lastname"/></fo:block></fo:table-cell>
                            <fo:table-cell><fo:block><xsl:value-of select="sum(../round/score-card[@athlete-id = $aid]/target/score/@points)"/></fo:block></fo:table-cell>
                        </fo:table-row>
                                       
                    
                </xsl:for-each>
                    </fo:table-body>
                </fo:table> 
            </fo:flow>
            </fo:page-sequence>
            
            
            <!-- Ranges -->
            <fo:page-sequence master-reference="a4page">
                <fo:static-content flow-name="archery-header">
                    <fo:block font-size="7pt">
                        <xsl:value-of select="@name"/>
                        - Ranges
                    </fo:block>
                </fo:static-content>
                
                <fo:static-content flow-name="archery-footer">
                    <fo:block font-size="10pt">
                        Page <fo:page-number/>
                    </fo:block>
                </fo:static-content>
                
                <fo:flow flow-name="xsl-region-body">
                    <fo:block id="C005" font-size="24pt">Ranges</fo:block>
                    <xsl:apply-templates select="range"/>
                </fo:flow>
            </fo:page-sequence>
       
        </fo:root>
    
   </xsl:template>
   
   <xsl:template name="rangliste">
       <xsl:param name="date"/>
       <xsl:for-each select="group/athlete[../round/@date = $date]">
           <fo:block>TEST</fo:block>
       </xsl:for-each>
   </xsl:template>
   
   <xsl:template match="score-card">
       <fo:block><xsl:text>Score-Card für: </xsl:text>
                <xsl:value-of select="id(@athlete-id)/@firstname"/>
                <xsl:text> </xsl:text>
           <xsl:value-of select="id(@athlete-id)/@lastname"/>
       </fo:block>
       <fo:table margin-bottom="20px">
               <fo:table-column column-width="3mm" border-right="1px solid black"/>
               <fo:table-column column-width="20mm"/>
               <fo:table-column column-width="20mm"/>
               <fo:table-column column-width="20mm"/>
               <fo:table-column column-width="20mm"/>
                <fo:table-header font-size="10pt" margin-bottom="20px" border-bottom="1px solid black">
                    <fo:table-row>
                        <fo:table-cell><fo:block></fo:block></fo:table-cell>
                        <fo:table-cell><fo:block>Arrow 1</fo:block></fo:table-cell>
                        <fo:table-cell><fo:block>Arrow 2</fo:block></fo:table-cell>
                        <fo:table-cell><fo:block>Arrow 3</fo:block></fo:table-cell>
                        <fo:table-cell><fo:block>Arrow 4</fo:block></fo:table-cell>
                    </fo:table-row>
                    
                </fo:table-header>
                   <fo:table-body>
                       <xsl:for-each select="target">
                           <fo:table-row>
                               <fo:table-cell><fo:block><xsl:value-of select="position()"/></fo:block></fo:table-cell>
                               <fo:table-cell><fo:block margin-left="8px"><xsl:value-of select="score[@arrow-nr = 1]/@points"/></fo:block></fo:table-cell>
                               <fo:table-cell><fo:block><xsl:value-of select="score[@arrow-nr = 2]/@points"/></fo:block></fo:table-cell>
                               <fo:table-cell><fo:block><xsl:value-of select="score[@arrow-nr = 3]/@points"/></fo:block></fo:table-cell>
                               <fo:table-cell><fo:block><xsl:value-of select="score[@arrow-nr = 4]/@points"/></fo:block></fo:table-cell>
                           </fo:table-row>
                           
                       </xsl:for-each>
                   </fo:table-body>
       </fo:table>
       
       
       
   </xsl:template>
   
   <xsl:template match="group">
       <fo:block padding-top="10pt" font-size="20pt"><xsl:text>Gruppe: </xsl:text><xsl:value-of select="@nr"/></fo:block>
       
       <fo:list-block>
           <xsl:for-each select="athlete">
               <xsl:sort select="@role" order="descending"/>
                <fo:list-item>
                    <fo:list-item-label>
                        <fo:block></fo:block>
                    </fo:list-item-label>
                    <fo:list-item-body>
                        <fo:block><xsl:value-of select="id(@person-id)/@firstname"/><xsl:text> </xsl:text><xsl:value-of select="id(@person-id)/@lastname"/>
                        <xsl:if test="@role">
                            <xsl:text> as </xsl:text><xsl:value-of select="@role"/>
                        </xsl:if>    
                        </fo:block>
                    </fo:list-item-body>
                </fo:list-item>
           </xsl:for-each>
          
       </fo:list-block>
    
           
       
       
   </xsl:template>
   
   <xsl:template match="range">
       <fo:block>
       <fo:inline min-width="200pt"><xsl:value-of select="@name"/></fo:inline>
       <fo:inline><xsl:value-of select="startLocation/text()"/></fo:inline>
        </fo:block>
   </xsl:template>
   <xsl:template match="person" mode="list">
       <fo:table-row>
           <fo:table-cell>
               <fo:block><xsl:value-of select="position()"/></fo:block>
           </fo:table-cell>
           <fo:table-cell>
               <fo:block><xsl:value-of select="@firstname"/></fo:block>
           </fo:table-cell>
           <fo:table-cell>
               <fo:block><xsl:value-of select="@lastname"/></fo:block>
           </fo:table-cell>
           <fo:table-cell>
               <fo:block><xsl:value-of select="@age"/></fo:block>
           </fo:table-cell>
           <fo:table-cell>
               <fo:block><xsl:value-of select="@club"/></fo:block>
           </fo:table-cell>
           <fo:table-cell>
               <fo:block><xsl:value-of select="@gender"/></fo:block>
           </fo:table-cell>
           <fo:table-cell>
               <fo:block><xsl:value-of select="@shooting-style"/></fo:block>
           </fo:table-cell>
           
       </fo:table-row>
   </xsl:template>
    
    
</xsl:stylesheet>