<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format">
    
    <!-- ............................ ROOT TEMPLATE .......................... -->
    <xsl:template match="/archery">
        <fo:root>
            
            <!-- define the layout of the document -->
            <fo:layout-master-set>
                <!-- here we define the layout of pages. There might be differrent page masters with e.g. different margin settings -->
                <fo:simple-page-master master-name="archery-page"
                    page-height="297.0mm" page-width="209.9mm"
                    margin-bottom="8mm" margin-left="25mm" margin-right="10mm" margin-top="10mm">
                    
                    <!-- the content will be placed into the region-body -->
                    <fo:region-body margin-bottom="28mm" margin-left="0mm" margin-right="44mm" margin-top="60mm"/>
                    
                    <fo:region-before extent="24pt" region-name="archery-header"/>
                    
                    <fo:region-after extent="24pt" region-name="archery-footer"/>
                    
                </fo:simple-page-master>
            </fo:layout-master-set>
            
            
            <!-- Here comes the content.
                Printed content consists of one or more page-sequences. Each page-sequence starts on a new page. -->
            
            <!-- front page -->
            <fo:page-sequence master-reference="archery-page">
                <fo:flow flow-name="xsl-region-body" font-family="sans-serif" font-size="28pt">
                    <fo:block>
                        <xsl:value-of select="description"/>
                    </fo:block>
                    
                    <fo:block font-size="12pt" margin-top="24pt">
                        WS Informatik, 2020/21 FH Dornbirn
                    </fo:block>
                    <fo:block font-size="12pt">
                    Juen, Celes, Neuhauser
                    </fo:block>
                </fo:flow>
            </fo:page-sequence>
            
            
            <!-- Mitarbeiterliste -->
            <fo:page-sequence master-reference="archery-page">
                
                <!-- Kopfzeile -->
                <xsl:call-template name="generate-header">
                    <xsl:with-param name="title-right" select="'Mitarbeiterliste - Inhaltsverzeichnis'"/>
                </xsl:call-template>
                
                
                <fo:flow flow-name="xsl-region-body" font-family="Times" font-size="9pt"> 
                    <fo:block font-size="12pt" font-weight="500">Mitarbeiterliste - Inhaltsverzeichnis</fo:block>
                    
                    <fo:list-block margin-top ="24">
                        <xsl:for-each select="mitarbeiter" xml:space="preserve">
                            <fo:list-item>
                                <fo:list-item-label> 
                                    <fo:block><xsl:value-of select="position()"/>.</fo:block>
                                </fo:list-item-label>
                                <fo:list-item-body start-indent="4mm">
                                    <fo:block text-align-last="justify">
                                        <xsl:value-of select="@fname"/> 
                                        <xsl:value-of select="@lname"/>
                                        <fo:leader leader-pattern="dots"></fo:leader>
                                        <fo:page-number-citation ref-id="{generate-id()}"/>
                                    </fo:block>
                                    
                                </fo:list-item-body>
                            </fo:list-item> 
                        </xsl:for-each>
                    </fo:list-block>
                </fo:flow>
            </fo:page-sequence>
            
            <!-- Mitarbeiterinfos kommen hierher-->
            <xsl:apply-templates select="mitarbeiter"/>
            
        </fo:root>
    </xsl:template>
    
    
    <!-- Mitarbeiter im Detail ausgearbeitet-->
    <xsl:template match ="mitarbeiter">
        
        <fo:page-sequence master-reference="archery-page">
            
            <!-- Kopfzeile Nachname von Mitarbeiter -->
            <xsl:call-template name="generate-header">
                <xsl:with-param name="title-right" select="@mitarbeiter_id"/>
            </xsl:call-template>
            
            <!-- Fußzeile Seitenzahl -->
            <fo:static-content flow-name="archery-footer">
                <fo:block font-size="7pt" text-align="end">
                    page <fo:page-number/>
                </fo:block>
            </fo:static-content>
            
            <fo:flow flow-name="xsl-region-body">
                <fo:block font-size="16pt" font-weight="500"  id="{generate-id()}">
                    <xsl:value-of select="@fname" xml:space="preserve"/>
                    <xsl:text> </xsl:text>
                    <xsl:value-of select="@lname"/>
                </fo:block>
                
                <fo:block margin-top="10pt" font-size="8pt">
                    <xsl:for-each select="hatRolle">
                        <xsl:value-of select="id(@rolle_id)/@titel"/>
                    </xsl:for-each>
                    <fo:block margin-top="10pt" font-size="8pt">
                        TelNr.: <xsl:value-of select="@tel_nr"/>
                    </fo:block>
                    
                </fo:block>
                
                <fo:block margin-top="24pt" font-size="14pt">
                    Hat zu erledigen:
                </fo:block>
                <fo:list-block margin-top="10pt" font-size="14">
                    <xsl:for-each select="hatAufgabe" xml:space="preserve">
                        <fo:list-item>
                            <fo:list-item-label> 
                                <fo:block>-</fo:block>
                            </fo:list-item-label>
                            <fo:list-item-body start-indent="5mm">
                                <fo:block font-size="14" >
                                    <xsl:value-of select="id(@aufgabe_id)/@aufgabe_bezeichnung"/> 
                                </fo:block>
                                <fo:block margin-top="5pt">
                                    bei:
                                </fo:block>  
                                <fo:block margin-top="5pt">
                                    <xsl:for-each select="id(@aufgabe_id)/an" xml:space="preserve">
                                        <xsl:value-of select="id(@ort_id)/@ort_name"/> GPS: <xsl:value-of select="id(@ort_id)/@gps_daten"/>
                                    </xsl:for-each>
                                </fo:block>
                                <fo:block margin-top="5pt" >
                                    benötigt: 
                                </fo:block>
                                <fo:block margin-top="5pt">
                                    <xsl:for-each select="id(@aufgabe_id)/verwende" xml:space="preserve">
                                        <xsl:value-of select="id(@material_id)/@material_bezeichnung"/> mit der ID: <xsl:value-of select="@material_id"/>
                                    </xsl:for-each>
                                </fo:block>
                                <fo:block margin-top="5pt">
                                    Arbeitszeit:
                                </fo:block>
                                <fo:block margin-top="5pt">
                                    <xsl:for-each select="id(@aufgabe_id)/termin" xml:space="preserve">
                                        <xsl:value-of select="@datum"/>, <xsl:value-of select="@beginn_uhrzeit"/>-<xsl:value-of select="@ende_uhrzeit"/>
                                    </xsl:for-each>
                                </fo:block>
                                <fo:block margin-top="2pt">
                                    ---------------------------------------
                                </fo:block>
                            </fo:list-item-body>
                        </fo:list-item>
                    </xsl:for-each>
                </fo:list-block>
                
            </fo:flow>
        </fo:page-sequence>
        
    </xsl:template>
    
    <!-- Methode für Kopfzeile -->
    <xsl:template name="generate-header">
        <xsl:param name="title-right"/>
        <fo:static-content flow-name="archery-header">
            <fo:block font-size="7pt" text-align-last="justify">
                
                <xsl:value-of select="description"/>
                <fo:leader/>
                <xsl:value-of select="$title-right"/>
            </fo:block>
        </fo:static-content>
    </xsl:template>
</xsl:stylesheet>
