<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:fo="http://www.w3.org/1999/XSL/Format"
    exclude-result-prefixes="xs"
    version="2.0">
    
    <xsl:template match="/Arbeitsuebersicht">
        <fo:root>
            <!-- Seitenlayout -->
            <fo:layout-master-set>
                <!-- hier A4 hochstehend -->
                <fo:simple-page-master master-name="arbeitsuebersicht-page"
                    page-height="297.0mm" page-width="209.9mm"
                    margin-bottom="8mm" margin-left="25mm" margin-right="10mm" margin-top="10mm">
                    
                    <!-- the content will be placed into the region-body -->
                    <fo:region-body margin-bottom="28mm" margin-left="0mm" margin-right="44mm" margin-top="20mm"/>
                    
                    <!-- region-before is the page header -->
                    <fo:region-before extent="24pt" region-name="arbeitsuebersicht-header"/>
                    
                    <!-- region-after is the page footer -->
                    <fo:region-after extent="24pt" region-name="arbeitsuebersicht-footer"/>
                    <!-- Here comes the content.-->
                    
                </fo:simple-page-master>
            </fo:layout-master-set>
            
            
            <!-- front page -->
            <fo:page-sequence master-reference="arbeitsuebersicht-page">
                <fo:flow flow-name="xsl-region-body" font-family="sans-serif" font-size="28pt">
                    <fo:block margin-top="40mm">
                        Aufgaben- bzw. Arbeitsübersicht Mitarbeiter:innen
                    </fo:block>
                    
                    <!-- margin-top für Abstand zwischen vorherigem Block -->
                    <fo:block font-size="12pt" margin-top="24pt">
                        By Hartmann, Maierhofer, Petscharnig
                    </fo:block>
                </fo:flow>
            </fo:page-sequence>
            
            <!-- Jede page-sequence beginnt auf neuen Seite, kann aber über mehrere Seiten gehen, wichtig bei zb Seitenvorschub -->
            <!-- Inhaltsverzeichnis -->
            <fo:page-sequence master-reference="arbeitsuebersicht-page">      
                <!-- Parameteraufruf mit Übergabe -->
                <xsl:call-template name="generate-header">
                    <xsl:with-param name="title-right" select="'Inhaltsverzeichnis'"></xsl:with-param>
                </xsl:call-template>
                
                <fo:flow flow-name="xsl-region-body"  font-family="Times" font-size="9pt">
                    <fo:block font-size="24pt" font-weight="500">Inhaltsverzeichnis:</fo:block> 
                    <fo:list-block margin-top="24pt">
                        <fo:list-item>
                            <fo:list-item-label>
                                <fo:block>1. </fo:block>
                                <fo:block>2. </fo:block>
                                <fo:block>3. </fo:block>
                                <fo:block>4. </fo:block>
                                <fo:block>5. </fo:block>
                                <fo:block>6. </fo:block>
                                <fo:block>7. </fo:block>
                                
                            </fo:list-item-label>
                            <!-- start-indent für Einrückung bei Auflistung bei Text -->
                            <fo:list-item-body start-indent="4mm">
                                <fo:block text-align-last="justify">Kurzübersicht Tage
                                    <fo:leader leader-pattern="dots"></fo:leader>
                                    <fo:page-number-citation ref-id="KÜTID"/>
                                </fo:block>
                                
                                <fo:block text-align-last="justify">Kurzübersicht Aufgaben
                                    <fo:leader leader-pattern="dots"></fo:leader>
                                    <fo:page-number-citation ref-id="KÜAID"/>
                                </fo:block>
                                
                                <xsl:for-each select="Aufgabe">
                                    <fo:block text-align-last="justify">
                                        <xsl:value-of select="@aufgabe_bezeichnung"/>
                                        <fo:leader leader-pattern="dots"></fo:leader>
                                        <fo:page-number-citation ref-id="{generate-id()}"/>
                                    </fo:block>
                                </xsl:for-each>
                                
                                <fo:block text-align-last="justify">Vorhandene Materialien
                                    <fo:leader leader-pattern="dots"></fo:leader>
                                    <fo:page-number-citation ref-id="VMID"/>
                                </fo:block>
                                
                                <fo:block text-align-last="justify">Bewerbe
                                    <fo:leader leader-pattern="dots"></fo:leader>
                                    <fo:page-number-citation ref-id="BewID"/>
                                </fo:block>
                            </fo:list-item-body>
                        </fo:list-item>
                    </fo:list-block>
                </fo:flow>
            </fo:page-sequence> 
            
            
            <!-- Seite Kurzübersicht der Tage -->
            <fo:page-sequence master-reference="arbeitsuebersicht-page">
                <xsl:call-template name="generate-header">
                    <xsl:with-param name="title-right" select="'Kurzübersicht Tage'"></xsl:with-param>
                </xsl:call-template>
                <fo:static-content flow-name="arbeitsuebersicht-footer">
                    <fo:block font-size="12pt" text-align="end">
                        Seite <fo:page-number/>
                    </fo:block>
                </fo:static-content> 
                <fo:flow flow-name="xsl-region-body"  font-family="Times" font-size="9pt">
                    <fo:block font-size="24pt" font-weight="500" id="KÜTID">Kurzübersicht Tage:</fo:block>
                    
                    <fo:block>
                        <xsl:for-each select="Aufgabe/Termin">
                            <xsl:sort select="@datum" order="ascending"></xsl:sort>
                            <fo:block margin-top="12pt"> <xsl:value-of select="@datum"/>, Start: <xsl:value-of select="@beginn_uhrzeit"/> </fo:block>
                        </xsl:for-each>
                    </fo:block>
                </fo:flow>
            </fo:page-sequence>
            
            <!-- Seite Kurzübersicht der Aufgaben -->
            <fo:page-sequence master-reference="arbeitsuebersicht-page">
                <xsl:call-template name="generate-header">
                    <xsl:with-param name="title-right" select="'Kurzübersicht Aufgaben'"></xsl:with-param>
                </xsl:call-template>
                <fo:static-content flow-name="arbeitsuebersicht-footer">
                    <fo:block font-size="12pt" text-align="end">
                        Seite <fo:page-number/>
                    </fo:block>
                </fo:static-content> 
                <fo:flow flow-name="xsl-region-body"  font-family="Times" font-size="9pt">
                    <fo:block font-size="24pt" font-weight="500" id="KÜAID">Kurzübersicht Aufgaben:</fo:block> 
                    
                    <fo:block>
                        <xsl:for-each select="Aufgabe">
                            <fo:block margin-top="12pt">
                                <xsl:value-of select="@aufgabe_bezeichnung"/>
                            </fo:block>
                        </xsl:for-each>
                    </fo:block>
                </fo:flow>
            </fo:page-sequence>
            
            <!-- Bei Aufruf von Apply-Templates sind Parameter implizit genau die Knoten die im Match stehen-->
            <xsl:apply-templates select="Aufgabe"></xsl:apply-templates>
            
            
            
            <!-- Seite Vorhandene Materialien -->
            <fo:page-sequence master-reference="arbeitsuebersicht-page">
                <!-- Call-Templates Parameter sind explizit -->
                <xsl:call-template name="generate-header">
                    <xsl:with-param name="title-right" select="'Vorhandene Materialien'"></xsl:with-param>
                </xsl:call-template>
                <fo:static-content flow-name="arbeitsuebersicht-footer">
                    <fo:block font-size="12pt" text-align="end">
                        Seite <fo:page-number/>
                    </fo:block>
                </fo:static-content> 
                <fo:flow flow-name="xsl-region-body"  font-family="Times" font-size="9pt">
                    <fo:block font-size="24pt" font-weight="500" id="VMID">Vorhandene Materialien:</fo:block> 
                    <fo:block margin-top="12pt">
                        <fo:table width="110mm" border-style="ridge" border-width="5pt">
                            <fo:table-body background-color="green">
                                <fo:table-row>
                                    <fo:table-cell width="40mm" border-style="solid" border-width="1pt">
                                        <fo:block font-size="15pt">Material</fo:block>
                                    </fo:table-cell>
                                    <fo:table-cell border-style="solid" border-width="1pt">
                                        <fo:block font-size="15pt">Zustand</fo:block>
                                    </fo:table-cell>
                                </fo:table-row>
                                <xsl:for-each select="Material">
                                    <xsl:sort select="@materialbezeichnung" order="ascending"></xsl:sort>
                                    
                                    <fo:table-row>
                                        <fo:table-cell border-style="solid" border-width="1pt">
                                            <fo:block><xsl:value-of select="@materialbezeichnung"/></fo:block>
                                        </fo:table-cell>
                                        
                                        <fo:table-cell border-style="solid" border-width="1pt">
                                            <fo:block><xsl:value-of select="@zustand"/></fo:block>
                                        </fo:table-cell>
                                    </fo:table-row>
                                </xsl:for-each>
                            </fo:table-body>                
                        </fo:table>
                    </fo:block>
                </fo:flow>
                
            </fo:page-sequence>
            
            <!-- Seite Bewerbe -->
            <fo:page-sequence master-reference="arbeitsuebersicht-page">
                <xsl:call-template name="generate-header">
                    <xsl:with-param name="title-right" select="'Bewerbe'"></xsl:with-param>
                </xsl:call-template>
                <fo:static-content flow-name="arbeitsuebersicht-footer">
                    <fo:block font-size="12pt" text-align="end">
                        Seite <fo:page-number/>
                    </fo:block>
                </fo:static-content>
                <!-- Flow gleich Inhalt -->
                <fo:flow flow-name="xsl-region-body"  font-family="Times" font-size="9pt">
                    <fo:block font-size="24pt" font-weight="500" id="BewID">Bewerbe:</fo:block> 
                    <fo:block>
                        <xsl:for-each select="Bewerb">
                            <fo:block margin-top="12pt"><xsl:value-of select="@bewerb_name"/></fo:block>
                        </xsl:for-each>
                    </fo:block>
                </fo:flow>
                
            </fo:page-sequence>
            
        </fo:root>
    </xsl:template>
    
    
    
    
    
    
    <!-- Template für Kopfzeile -->
    <xsl:template name="generate-header">
        <!-- Parameter für Text rechte Seite -->
        <xsl:param name="title-right"></xsl:param>
        <!-- Kopfzeile -->
        <fo:static-content flow-name="arbeitsuebersicht-header">
            <fo:block font-size="7pt" text-align-last="justify">
                Aufgaben- bzw. Arbeitsübersicht Mitarbeiter:innen
                <fo:leader/>
                <!-- Parameterübergabe an dieser Stelle -->
                <xsl:value-of select="$title-right"/>
            </fo:block>
        </fo:static-content>
    </xsl:template>
    
    
    
    <xsl:template match="Aufgabe" >
        <fo:page-sequence master-reference="arbeitsuebersicht-page">
            <xsl:call-template name="generate-header">
                <xsl:with-param name="title-right" select="@aufgabe_bezeichnung"></xsl:with-param>
            </xsl:call-template>
            <fo:static-content flow-name="arbeitsuebersicht-footer">
                <fo:block font-size="12pt" text-align="end">
                    Seite <fo:page-number/>
                </fo:block>
            </fo:static-content>   
            
            <fo:flow flow-name="xsl-region-body">
                <fo:block font-size="24pt" font-weight="500" id="{generate-id()}"><xsl:value-of select="@aufgabe_bezeichnung"/>
                </fo:block>
                <fo:block margin-top="12pt">
                    <xsl:value-of select="Termin/@datum"/>, <xsl:value-of select="Termin/@beginn_uhrzeit"/> bis <xsl:value-of select="Termin/@ende_uhrzeit"/>
                </fo:block>
                
                <fo:block margin-top="12pt">
                    <xsl:for-each select="AufgabenMitarbeiter">
                        <fo:block margin-top="12pt"><xsl:value-of select="id(@mitarbeiter_ID)/@vorname"/>, <xsl:value-of select="id(@mitarbeiter_ID)/@nachname"/>, <xsl:value-of select="id(@mitarbeiter_ID)/@tel_nr"/>, <xsl:value-of select="id(@mitarbeiter_ID)/Rolle/@titel"/></fo:block>
                    </xsl:for-each>
                    
                </fo:block>
            </fo:flow>
        </fo:page-sequence>
    </xsl:template>
    
    
    
</xsl:stylesheet>         