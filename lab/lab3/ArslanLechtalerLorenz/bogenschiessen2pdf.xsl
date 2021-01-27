<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format"
    version="2.0">
    
    
    <xsl:template match="/">
        
        <fo:root>
            
            <fo:layout-master-set>
                <fo:simple-page-master master-name="bogenschiessen"  page-height="297.0mm" page-width="209.9mm"
                    margin-bottom="12mm" margin-left="25mm" margin-right="10mm" margin-top="8mm">
                    <fo:region-body/>
                    <fo:region-after extent="0mm" region-name="fo:region-after"/>
                </fo:simple-page-master>
               
            </fo:layout-master-set>
            
            
            <fo:page-sequence master-reference="bogenschiessen">
                
                <fo:static-content flow-name="fo:region-after">
                    <fo:block text-align="center">
                        Page <fo:page-number/>
                    </fo:block>
                </fo:static-content>
                
                <fo:flow flow-name="xsl-region-body">
                    <fo:block>
                                               
                        <xsl:apply-templates select="bogenschiessen/turniere"></xsl:apply-templates>
                        <xsl:apply-templates select="bogenschiessen/punktestände"></xsl:apply-templates>    
                        
                    </fo:block>
                    
                </fo:flow>
                
                
            </fo:page-sequence>
            
            
        </fo:root>
        
        
    </xsl:template>
    
    <xsl:template match="turniere">
        
        <xsl:for-each select="turnier">
            
            <fo:block space-after="69mm"/> 
            
            
            
            <fo:block space-before="69pt" font-family="Verdana,Arial" space-after="22pt" keep-with-next="always" 
                line-height="32pt" font-size="28pt"><xsl:value-of select="@Name"/></fo:block>
            <fo:table id="turnier">
                <fo:table-header>
                    <fo:table-row> 
                        <fo:table-cell><fo:block>ID</fo:block></fo:table-cell>
                        <fo:table-cell><fo:block>Jahr</fo:block></fo:table-cell>
                        <fo:table-cell><fo:block>Land</fo:block></fo:table-cell>
                    </fo:table-row>
                </fo:table-header>
                <fo:table-body>
                    <fo:table-row>
                    <fo:table-cell><fo:block><xsl:value-of select="@lfd_nummer"/></fo:block></fo:table-cell>
                    <fo:table-cell><fo:block><xsl:value-of select="@jahr"/></fo:block></fo:table-cell>
                    <fo:table-cell><fo:block><xsl:value-of select="@land"/></fo:block></fo:table-cell>
                    </fo:table-row>
                </fo:table-body>
                
            </fo:table>
            
            
            <fo:block page-break-before="always"/>
            
            <fo:block space-after="49mm"/>
            <!-- Inhaltsverzeichniss -->
            <fo:block font-family="Verdana,Arial" space-after="18pt" keep-with-next="always" 
                line-height="28pt" font-size="24pt">Inhaltsverzeichniss</fo:block>
            
            <xsl:for-each select="/bogenschiessen/turniere/turnier">
                <xsl:for-each select="Runde">
                    
                    
                    <fo:table>
                        <fo:table-header>
                            <fo:table-row>
                                <fo:table-cell>
                                    <fo:block>
                                        Date
                                    </fo:block>
                                </fo:table-cell>
                                <fo:table-cell>
                                    <fo:block>
                                        Group id
                                    </fo:block>
                                </fo:table-cell>
                                <fo:table-cell>
                                    <fo:block>
                                        Page
                                    </fo:block>
                                </fo:table-cell>
                            </fo:table-row>
                            
                        </fo:table-header>
                        <fo:table-body>
                            <xsl:variable name="date"><xsl:value-of select="@date"/></xsl:variable>
                            <xsl:for-each select="Gruppe">
                                
                                <xsl:variable name="gid"><xsl:value-of select="@gruppen_id"/></xsl:variable>
                                
                                
                                <fo:table-row>
                                    <fo:table-cell>
                                        <fo:block>
                                            <xsl:value-of select="$date"/>
                                        </fo:block>
                                    </fo:table-cell>
                                    <fo:table-cell>
                                        <fo:block>
                                            <fo:basic-link internal-destination="{generate-id()}">
                                                <xsl:value-of select="$gid"/>
                                            </fo:basic-link>
                                            
                                            
                                        </fo:block>
                                        
                                    </fo:table-cell>
                                    <fo:table-cell>
                                        <fo:block>
                                            <fo:basic-link internal-destination="{generate-id()}">
                                                <fo:page-number-citation ref-id="{generate-id()}"/>
                                            </fo:basic-link>
                                        </fo:block>
                                        
                                    </fo:table-cell>
                                </fo:table-row>
                                
                                
                                
                                <!--<fo:block>Group: <fo:basic-link  internal-destination="turnier"><xsl:value-of select="@gruppen_id"/></fo:basic-link>, <xsl:value-of select="$date"/></fo:block>
          -->          </xsl:for-each>
                            
                            
                        </fo:table-body>
                    </fo:table>
                    
                   
                </xsl:for-each>
            </xsl:for-each>
            
            <fo:block>
                
                <fo:block page-break-before="always"/>       
                
            <!--<fo:leader leader-pattern="rule" leader-length="100%" rule-style="solid" rule-thickness="2pt"/>-->
         </fo:block>
            <!-- Gruppen Auflistung -->
            
            <fo:block font-family="Verdana,Arial" space-after="14pt" keep-with-next="always" 
                line-height="24pt" font-size="21pt">Groups</fo:block>
            
            <xsl:for-each select="Runde">
                
                <fo:block font-family="Verdana,Arial" space-after="12pt" keep-with-next="always" 
                    line-height="21pt" font-size="18pt"><xsl:value-of select="@runden_id"/></fo:block>
                <xsl:for-each select="Gruppe" >
                    
                    
                    
                    
                        
                        <xsl:variable name="gid"><xsl:value-of select="@gruppen_id"/></xsl:variable>
                        <fo:block font-family="Verdana,Arial" space-after="12pt" keep-with-next="always" 
                            line-height="19pt" font-size="16pt" id="{generate-id()}">
                            
                            <fo:block>Gruppen ID: <xsl:value-of select="@gruppen_id"/></fo:block>
                            
                        </fo:block>
                        
                    
                    <fo:table>
                      
                        <!-- Setup 
                        <fo:table-row>
                            <fo:table-cell><fo:block>Spieler ID</fo:block></fo:table-cell><fo:block><fo:table-cell><fo:block>Vorname</fo:block></fo:table-cell><fo:block><fo:table-cell><fo:block>Nachnahme</fo:block></fo:table-cell><fo:block><fo:table-cell><fo:block>Rolle</fo:block></fo:table-cell><fo:block>
                        </fo:table-row>
                        -->
                        <!-- Content -->
                        <fo:table-body>
                           
                            
                            
                            
                            <xsl:for-each select="schütze">
                                <xsl:variable name="person"><xsl:value-of select="@person_id"/></xsl:variable> 
                                <fo:table-row>
                                    <fo:table-cell><fo:block><xsl:value-of select="/bogenschiessen/turnier_teilnehmer/teilnehmer[@person_id=$person]/teilnehmer_Vn"></xsl:value-of></fo:block></fo:table-cell>
                                           
                                    <fo:table-cell><fo:block><xsl:value-of select="/bogenschiessen/turnier_teilnehmer/teilnehmer[@person_id=$person]/teilnehmer_Nn"></xsl:value-of></fo:block></fo:table-cell>
                                        
                                            
                                    
                                    <xsl:for-each select="/bogenschiessen/turnier_teilnehmer/teilnehmer[@person_id=$person]">
                                        
                                        <fo:table-cell><fo:block><fo:basic-link internal-destination="{generate-id()}"><xsl:value-of select="@person_id"/></fo:basic-link></fo:block></fo:table-cell>  
                                        <fo:table-cell>
                                            <fo:block>
                                                <fo:basic-link internal-destination="{generate-id()}">
                                                    <fo:page-number-citation ref-id="{generate-id()}"/>
                                                </fo:basic-link>
                                            </fo:block>
                                         </fo:table-cell>
                                    </xsl:for-each>
                                </fo:table-row>
                            </xsl:for-each>
                            
                            
                        </fo:table-body>
                        
                    </fo:table>
                    
                    <fo:block>
                        <fo:leader leader-pattern="rule" leader-length="100%" rule-style="solid" rule-thickness="2pt"/>                                               
                        
                    </fo:block>
                
            </xsl:for-each>
            
            
        </xsl:for-each>
        
        </xsl:for-each> 
        
    </xsl:template>
    
    
    <xsl:template match="punktestände">
        
        <fo:block page-break-after="always"/>
        
        <fo:block font-family="Verdana,Arial" space-after="18pt" keep-with-next="always" 
            line-height="28pt" font-size="24pt">Scorecards</fo:block>
        
        <xsl:for-each select="turnier_punkte">
            
            
            <xsl:variable name="turnier"><xsl:value-of select="@turnier_id"/></xsl:variable>
            
            <xsl:for-each select="/bogenschiessen/turnier_teilnehmer/teilnehmer">
                
                <xsl:variable name="person"><xsl:value-of select="@person_id"/></xsl:variable>
                
                <fo:block font-family="Verdana,Arial" space-after="14pt" keep-with-next="always" 
                    line-height="24pt" font-size="21px" white-space-treatment="preserve" id="{generate-id()}"> 
                    <xsl:value-of select="/bogenschiessen/turnier_teilnehmer/teilnehmer[@person_id=$person]/teilnehmer_Vn" ></xsl:value-of>
                    <xsl:text> </xsl:text>
                    <xsl:value-of select="/bogenschiessen/turnier_teilnehmer/teilnehmer[@person_id=$person]/teilnehmer_Nn"></xsl:value-of>
                    <xsl:text> </xsl:text>
                    <xsl:for-each select="/bogenschiessen/turnier_teilnehmer/teilnehmer[@person_id=$person]">
                        <fo:basic-link internal-destination="#{generate-id()}"><xsl:value-of select="@person_id"/></fo:basic-link>
                        
                    </xsl:for-each>
                </fo:block>
                
                
                <xsl:for-each select="/bogenschiessen/punktestände/turnier_punkte[@turnier_id=$turnier]/punktestand[@person_id=$person]">                  
                    
                    
                    <xsl:for-each select="Runde_punkte">
                        <fo:block font-family="Verdana,Arial" space-after="12pt" keep-with-next="always" 
                            line-height="21pt" font-size="18px" >Runden Name: <xsl:value-of select="@runden_id"/></fo:block>
                        
                        <fo:table >
                            <!-- Setup -->
                            <fo:table-header>
                                <fo:table-row>
                                    <fo:table-cell><fo:block>Scheibe</fo:block></fo:table-cell>
                                    <fo:table-cell><fo:block>Schuss 1</fo:block></fo:table-cell>
                                    <fo:table-cell><fo:block>Schuss 2</fo:block></fo:table-cell>
                                    <fo:table-cell><fo:block>Schuss 3</fo:block></fo:table-cell>
                                </fo:table-row>
                            </fo:table-header>
                            <!-- Content -->
                            <fo:table-body>
                                <xsl:variable name="parcur"/>
                                <xsl:variable name="runde"><xsl:value-of select="@runden_id"/></xsl:variable>
                                <xsl:for-each select="/bogenschiessen/turniere/turnier/Runde[@runden_id=$runde]">
                                    
                                    <xsl:variable name="parcur"><xsl:value-of select="@parkur_id"/></xsl:variable>
                                    
                                    <xsl:for-each select="/bogenschiessen/pacours/parkur[@parkur_id=$parcur]/scheiben">
                                        <fo:table-row>
                                            <fo:table-cell><fo:block><xsl:value-of select="@scheiben_id"/></fo:block></fo:table-cell>
                                            <xsl:variable name="scheibe"><xsl:value-of select="@scheiben_id"/></xsl:variable>
                                            <xsl:for-each select="/bogenschiessen/punktestände/turnier_punkte[@turnier_id=$turnier]/punktestand[@person_id=$person]/Runde_punkte[@runden_id=$runde]/scheiben_punkte[@scheiben_id=$scheibe]">
                                                
                                                <xsl:for-each select="schüsse">
                                                    <fo:table-cell><fo:block><xsl:value-of select="."/></fo:block></fo:table-cell>
                                                </xsl:for-each>
                                                
                                            </xsl:for-each>
                                            
                                        </fo:table-row>
                                    </xsl:for-each>      
                                </xsl:for-each>
                            </fo:table-body>
                            
                        </fo:table>
                        
                        
                        
                    </xsl:for-each>
                    
                    
                    
                </xsl:for-each>
                
                
                <fo:block>
                 <fo:leader leader-pattern="rule" leader-length="100%" rule-style="solid" rule-thickness="2pt"/>
                    <fo:block page-break-before="always"/>

                   </fo:block> 
                
            </xsl:for-each>
            
            
        </xsl:for-each>
        
        
    </xsl:template>
    
    
    
    
    
    
    
</xsl:stylesheet>

