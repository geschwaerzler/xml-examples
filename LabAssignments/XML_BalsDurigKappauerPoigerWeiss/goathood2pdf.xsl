<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    
    <xsl:template match="/goat-hood">
        <fo:root>
            <!-- define the layout of the document -->
            <fo:layout-master-set>
                <!-- here we define the layout of pages. There might be differrent page masters with e.g. different margin settings -->
                <fo:simple-page-master master-name="goat-hood-page"
                    page-height="297.0mm" page-width="209.9mm"
                    margin-bottom="8mm" margin-left="25mm" margin-right="10mm" margin-top="10mm">
                    
                    <!-- the content will be placed into the region-body -->
                    <fo:region-body margin-bottom="28mm" margin-left="0mm" margin-right="24mm" margin-top="20mm"/>
                    
                    <!-- region-before is the page header -->
                    <fo:region-before extent="24pt" region-name="goat-hood-header"/>
                    
                    <!-- region-after is the page footer -->
                    <fo:region-after extent="24pt" region-name="goat-hood-footer"/>
                    
                </fo:simple-page-master>
            </fo:layout-master-set>
            <!-- Here comes the content.
      Printed content consists of one or more page-sequences. Each page-sequence starts on a new page. -->
            
            <!-- front page -->
            <fo:page-sequence master-reference="goat-hood-page">
                <fo:flow flow-name="xsl-region-body" font-family="sans-serif" font-size="28pt">
                    <fo:block>
                        <xsl:value-of select="beschreibung"/>
                    </fo:block>
                </fo:flow>
            </fo:page-sequence>
            
            <!-- Auflistung der Spieler -->
            <fo:page-sequence master-reference="goat-hood-page">
                <xsl:call-template name="footer" />
                <xsl:variable name="title" select="'Spieler'"/>
                <xsl:call-template name="header">
                    <xsl:with-param name="right" select="$title"/>
                </xsl:call-template>
                <fo:flow flow-name="xsl-region-body" font-family="serif" font-size="11pt">
                    <fo:block font-weight="bold" font-size="18pt"><xsl:value-of select="$title"/></fo:block>
                    <fo:list-block space-before="24pt">
                        <xsl:apply-templates select="spieler" mode="detail">
                            <xsl:sort select="rueckennummer"/>
                        </xsl:apply-templates>
                    </fo:list-block>
                </fo:flow>
            </fo:page-sequence>
            
            <!-- Auflistung der Ereignisse -->
            <fo:page-sequence master-reference="goat-hood-page">
                <xsl:call-template name="footer" />
                <xsl:variable name="title" select="'Ereignisse'"/>
                <xsl:call-template name="header">
                    <xsl:with-param name="right" select="$title"/>
                </xsl:call-template>
                <fo:flow flow-name="xsl-region-body" font-family="serif" font-size="11pt">
                    <fo:block font-weight="bold" font-size="18pt"><xsl:value-of select="$title"/></fo:block>
                    <fo:table border-collapse="collapse" 
                        border="0.5pt solid black"
                        text-align="center"
                        border-spacing="3pt"
                        space-before="24pt">
                        <fo:table-column column-width="25%"/>
                        <fo:table-column column-width="30%"/>
                        <fo:table-column column-width="45%"/>
                        <fo:table-header background-color="lightgrey" 
                            padding="10px" 
                            border="1px solid grey">
                            <fo:table-row border="1px solid grey" padding="5px">
                                <fo:table-cell border="1px solid grey" padding="10px">
                                    <fo:block>Datum - Uhrzeit</fo:block>
                                </fo:table-cell>
                                <fo:table-cell border="1px solid grey" padding="10px">
                                    <fo:block>Typ</fo:block>
                                </fo:table-cell>
                                <fo:table-cell border="1px solid grey" padding="10px">
                                    <fo:block>Spielort - Ergebnis</fo:block>
                                </fo:table-cell>
                            </fo:table-row>
                        </fo:table-header>
                        <fo:table-body>
                           <xsl:apply-templates select="ereignis">
                               <xsl:sort select="ereignis-datum/@datum"/>
                           </xsl:apply-templates>
                        </fo:table-body>
                    </fo:table>
                </fo:flow>
            </fo:page-sequence>
            
            <!-- Auflistung der Strafentypen -->
            <fo:page-sequence master-reference="goat-hood-page">
                <xsl:call-template name="footer" />
                <xsl:variable name="title" select="'Strafen'"/>
                <xsl:call-template name="header">
                    <xsl:with-param name="right" select="$title"/>
                </xsl:call-template>
                <fo:flow flow-name="xsl-region-body" font-family="serif" font-size="11pt">
                    <fo:block font-weight="bold" font-size="18pt"><xsl:value-of select="$title"/></fo:block>
                    <fo:table border-collapse="collapse" 
                        border="0.5pt solid black"
                        text-align="center"
                        border-spacing="3pt"
                        space-before="24pt">
                        <fo:table-column column-width="30%"/>
                        <fo:table-column column-width="10%"/>
                        <fo:table-column column-width="60%"/>
                        <fo:table-header background-color="lightgrey" padding="10px" border="1px solid grey">
                            <fo:table-row  border="1px solid grey" padding="5px">
                                <fo:table-cell border="1px solid grey" padding="10px">
                                    <fo:block>Strafentyp</fo:block>
                                </fo:table-cell>
                                <fo:table-cell border="1px solid grey" padding="10px">
                                    <fo:block>Preis</fo:block>
                                </fo:table-cell>
                                <fo:table-cell border="1px solid grey" padding="10px">
                                    <fo:block>Definition</fo:block>
                                </fo:table-cell>
                            </fo:table-row>
                        </fo:table-header>
                        <fo:table-body>
                            <xsl:apply-templates select="strafentyp"/>
                        </fo:table-body>
                    </fo:table>
                </fo:flow>
            </fo:page-sequence>
            
            <!-- Auflistung der Spieler und den bekommenen Strafen -->
            <fo:page-sequence master-reference="goat-hood-page">
                <xsl:call-template name="footer" />
                <xsl:variable name="title" select="'Strafen der Spieler'"/>
                <xsl:call-template name="header">
                    <xsl:with-param name="right" select="$title"/>
                </xsl:call-template>
                <fo:flow flow-name="xsl-region-body" font-family="serif" font-size="11pt">
                    <fo:block font-weight="bold" font-size="18pt"><xsl:value-of select="$title"/></fo:block>
                    <xsl:apply-templates select="spieler" mode="spieler-strafen">
                        <xsl:sort select="rueckennummer" />
                    </xsl:apply-templates>
                </fo:flow>
            </fo:page-sequence>
        </fo:root>
    </xsl:template>
    
    <!-- Template Seite Spieler Auslistung -->
    <xsl:template match="spieler" mode="detail" xml:space="preserve">
        <fo:list-item>
            <fo:list-item-label>
                <fo:block>
                    <xsl:value-of select="rueckennummer"/> -
                </fo:block>
            </fo:list-item-label>
            <fo:list-item-body start-indent="8mm">
                <fo:block >
                    <xsl:value-of select="vorname"/> 
                    <xsl:value-of select="nachname"/> - 
                    <xsl:value-of select="geburtsdatum"/>
                </fo:block>                
            </fo:list-item-body>
        </fo:list-item>
    </xsl:template>
    
    <!-- Template Seite Ereignis -->
    <xsl:template match="ereignis">
        <fo:table-row border="1px solid grey" padding="10px">
            <fo:table-cell border="1px solid grey" padding="10px">
                <fo:block>
                    <xsl:value-of select="ereignis-datum"/> -
                    <xsl:value-of select="ereignis-uhrzeit"/>
                </fo:block>
            </fo:table-cell>
            <fo:table-cell border="1px solid grey" padding="10px">
                <fo:block>
                    <xsl:if test="spiel-ort">
                        <xsl:if test="spiel-ort!=''">Spiel</xsl:if>
                    </xsl:if>
                    <xsl:if test="not(spiel-ort)">Training</xsl:if>
                    <xsl:if test="spiel-ort=''">Training</xsl:if>
                </fo:block>
            </fo:table-cell>
            <fo:table-cell border="1px solid grey" padding="10px">
                <fo:block text-align="left">
                    <xsl:if test="spiel-ort"><xsl:if test="spiel-ort!=''">
                        <xsl:value-of select="spiel-ort"/> -
                        <xsl:value-of select="spiel-ergebnis"/>
                    </xsl:if></xsl:if>
                </fo:block>
            </fo:table-cell>
        </fo:table-row>
    </xsl:template>
    
    <!-- Template Seite Strafentyp -->
    <xsl:template match="strafentyp">
        <fo:table-row border="1px solid grey" padding="10px">
            <fo:table-cell border="1px solid grey" padding="10px">
                <fo:block>
                    <xsl:value-of select="strafentyp-bezeichnung"/>
                </fo:block>
            </fo:table-cell>
            <fo:table-cell border="1px solid grey" padding="10px">
                <fo:block>
                    <xsl:value-of select="preis"/>
                </fo:block>
            </fo:table-cell>
            <fo:table-cell border="1px solid grey" padding="10px">
                <fo:block  text-align="left">
                    <xsl:value-of select="definition"/>
                </fo:block>
            </fo:table-cell>
        </fo:table-row>
    </xsl:template>
    
    <!-- Template Seite Spieler-Strafen -->
    <xsl:template match="spieler" mode="spieler-strafen">
        <xsl:variable name="spielerId" select="@id"/>
        <xsl:if test="//strafe[@spieler-id=$spielerId]" xml:space="preserve">
            <fo:block font-weight="bold" space-before="24pt">
                <xsl:value-of select="rueckennummer"/> - 
                <xsl:value-of select="vorname"/> 
                <xsl:value-of select="nachname"/>
            </fo:block>
            <fo:table border-collapse="collapse" 
                border="0.5pt solid black"
                text-align="center"
                border-spacing="3pt"
                space-before="12pt">
                <fo:table-column column-width="30%"/>
                <fo:table-column column-width="10%"/>
                <fo:table-column column-width="60%"/>
                <fo:table-body>
                    <xsl:for-each select="//strafe[@spieler-id=$spielerId]">
                        <xsl:variable name="ereignisId" select="@ereignis-id"/>
                        <xsl:variable name="strafentypId" select="@strafentyp"/>
                        <fo:table-row border="1px solid grey" padding="10px">
                            <fo:table-cell border="1px solid grey" padding="10px">
                                <fo:block>
                                    <xsl:value-of select="//ereignis[@id=$ereignisId]/ereignis-datum"/>
                                </fo:block>
                            </fo:table-cell>
                            <fo:table-cell border="1px solid grey" padding="10px">
                                <fo:block>
                                    <xsl:value-of select="//strafentyp[@id=$strafentypId]/preis"/>
                                </fo:block>
                            </fo:table-cell>
                            <fo:table-cell border="1px solid grey" padding="10px">
                                <fo:block text-align="left">
                                    <xsl:value-of select="//strafentyp[@id=$strafentypId]/strafentyp-bezeichnung"/>
                                </fo:block>
                            </fo:table-cell>
                        </fo:table-row>
                    </xsl:for-each>
                    <fo:table-row border-top="2px double black" padding="10px">
                        <fo:table-cell border="1px solid grey" padding="10px">
                            <fo:block>
                                Summe
                            </fo:block>
                        </fo:table-cell>
                        <fo:table-cell border="1px solid grey" padding="10px">
                            <fo:block>
                                <xsl:value-of select="sum(//strafentyp[@id=//strafe[@spieler-id=$spielerId]/@strafentyp]/preis)"/>
                            </fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                </fo:table-body>
            </fo:table>
        </xsl:if>
    </xsl:template>
    
    <xsl:template name="header">
        <xsl:param name="right"/>
        <fo:static-content flow-name="goat-hood-header">
            <fo:block font-size="7pt" text-align-last="justify">
                <xsl:value-of select="/goat-hood/beschreibung"/>
                <fo:leader/>
                <xsl:value-of select="$right"/>
            </fo:block>
        </fo:static-content>        
    </xsl:template>
    
    <xsl:template name="footer">
        <fo:static-content flow-name="goat-hood-footer">
            <fo:block font-size="7pt" text-align="end">
                Seite <fo:page-number/>
            </fo:block>
        </fo:static-content>
    </xsl:template>
</xsl:stylesheet>