<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format">
    
    <!-- ............................ ROOT TEMPLATE .......................... -->
    <xsl:template match="/collection">
        <fo:root>
            <!-- define the layout of the document -->
            <fo:layout-master-set>
                <!-- here we define the layout of pages. There might be differrent page masters with e.g. different margin settings -->
                <fo:simple-page-master master-name="app-page"
                    page-height="297.0mm" page-width="209.9mm"
                    margin-bottom="8mm" margin-left="25mm" margin-right="10mm" margin-top="10mm">
                    
                    <!-- the content will be placed into the region-body -->
                    <fo:region-body margin-bottom="28mm" margin-left="0mm" margin-right="44mm" margin-top="20mm"/>
                    
                    <!-- region-before is the page header -->
                    <fo:region-before extent="24pt" region-name="app-header"/>
                    
                    <!-- region-after is the page footer -->
                    <fo:region-after extent="24pt" region-name="app-footer"/>
                    
                </fo:simple-page-master>
            </fo:layout-master-set>
            
            <!-- front page -->
            <fo:page-sequence master-reference="app-page">
                <fo:flow flow-name="xsl-region-body" font-family="sans-serif" font-size="28pt">
                    <fo:block margin-top="40mm">
                        <xsl:value-of select="description"/>
                    </fo:block>
                </fo:flow>
            </fo:page-sequence>
            
            <!-- table of contents -->
            <fo:page-sequence master-reference="app-page">
                <!-- place a page description into the page header -->
                <xsl:call-template name="header">
                    <xsl:with-param name="right" select="'Table of Contents'"/>
                </xsl:call-template>
                
                <!-- place the table of contents into region-body -->
                <fo:flow flow-name="xsl-region-body" font-family="Times" font-size="14pt">
                    <fo:block font-size="16pt" font-weight="bold" margin-top="40mm">Table of Contents</fo:block>
                    <fo:block font-weight="bold">Stammkunden</fo:block>
                    <fo:list-block>
                        <xsl:apply-templates select="Kunde/Person" mode="toc"/>
                    </fo:list-block>
                    <fo:list-block>
                        <fo:list-item>
                            <fo:list-item-label>
                                <fo:block>&#x2022;</fo:block>
                            </fo:list-item-label>
                            <fo:list-item-body start-indent="4mm">
                                <fo:block text-align-last="justify">
                                    Speisekarte
                                    <fo:leader leader-pattern="dots"></fo:leader>
                                    <fo:page-number-citation ref-id="{generate-id()}"/>
                                </fo:block>
                            </fo:list-item-body>
                        </fo:list-item>
                    </fo:list-block>
                    
                    
                    
                </fo:flow>
            </fo:page-sequence>
            <!-- Bestellungen Detail -->
            
            <xsl:apply-templates select="Kunde/Person" mode="detail"/>
            <!-- Speisekarte -->
            <fo:page-sequence master-reference="app-page">
                <xsl:call-template name="header">
                    <xsl:with-param name="right">Speisekarte</xsl:with-param>
                </xsl:call-template>
                
                <fo:static-content flow-name="app-footer">
                    <fo:block font-size="10pt" text-align="end">
                        page <fo:page-number/>
                    </fo:block>
                </fo:static-content>
                
                <fo:flow flow-name="xsl-region-body">
                    <fo:block padding="10pt" font-size="18pt" font-weight="bold">Speisekarte</fo:block>
                    <fo:block id="{generate-id()}">
                        <xsl:apply-templates select="Speisekarte"/>
                    </fo:block>
                    <!-- TODO Getränke -->
                    <!-- TODO Extras -->
                    
                </fo:flow>
            </fo:page-sequence>
            
        </fo:root>
    </xsl:template>
    <!-- Stammkundenliste -->
    <xsl:template match ="Person" mode="toc"> 
        <fo:list-item>
            <fo:list-item-label>
                <fo:block><xsl:value-of select="position()"/>.</fo:block>
            </fo:list-item-label>
            <fo:list-item-body start-indent="4mm">
                <fo:block text-align-last="justify">
                    <xsl:value-of select="name/vorname"/>
                    <xsl:text> </xsl:text>
                    <xsl:value-of select="name/nachname"/>
                    <fo:leader leader-pattern="dots"></fo:leader>
                    <fo:page-number-citation ref-id="{generate-id()}"/>
                </fo:block>
            </fo:list-item-body>
        </fo:list-item>
    </xsl:template>
    
    <!-- Person mit Bestellungen -->
    <xsl:template match ="Person" mode="detail"> 
        <fo:page-sequence master-reference="app-page">
            <xsl:call-template name="header">
                <xsl:with-param name="right" select="name/nachname"/>
            </xsl:call-template>
            
            <fo:static-content flow-name="app-footer">
                <fo:block font-size="10pt" text-align="end">
                    page <fo:page-number/>
                </fo:block>
            </fo:static-content>
            
            <fo:flow flow-name="xsl-region-body" font-family="Times" font-size="12pt">
                <fo:block font-weight="bold" id="{generate-id()}" padding="4pt" font-size="14pt">
                    <xsl:value-of select="name/vorname" />
                    <xsl:text> </xsl:text>
                    <xsl:value-of select="name/nachname"/>
                </fo:block>
                <xsl:apply-templates select="bestellung"/>
            </fo:flow>
        </fo:page-sequence>
    </xsl:template>    
    
    <xsl:template match="bestellung">
        <fo:block font-weight="bold" padding="10pt">
            <xsl:value-of select="@datum"/>
            <xsl:text> </xsl:text>
            <xsl:value-of select="@uhrzeit"/>	
        </fo:block>
        <fo:table border="0.5pt solid black" text-align="center">
            <fo:table-body>
                <fo:table-row>
                    <fo:table-cell padding="4pt" border="0.5pt solid black" width="200pt" font-weight="bold">
                        <fo:block> Artikel</fo:block>
                    </fo:table-cell>
                    <fo:table-cell padding="4pt" border="0.5pt solid black" width="80pt" font-weight="bold">
                        <fo:block> Anzahl</fo:block>
                    </fo:table-cell>
                    <fo:table-cell padding="4pt" border="0.5pt solid black" width="60pt" font-weight="bold">
                        <fo:block>Preis</fo:block>
                    </fo:table-cell>
                    <fo:table-cell padding="4pt" border="0.5pt solid black" width="60pt" font-weight="bold">
                        <fo:block>Betrag</fo:block>
                    </fo:table-cell>
                </fo:table-row>
                
                <xsl:for-each select="position">
                    <fo:table-row>
                        <fo:table-cell padding="6pt" border="0.5pt solid black">
                            <fo:block><xsl:value-of select="id(@artikel)/@name" /></fo:block>
                        </fo:table-cell>
                        <fo:table-cell padding="6pt" border="0.5pt solid black">
                            <fo:block><xsl:value-of select="@menge"/></fo:block>
                        </fo:table-cell>
                        <fo:table-cell padding="6pt" border="0.5pt solid black">
                            <fo:block><xsl:value-of select="@einzelpreis"/></fo:block>
                        </fo:table-cell>
                        <fo:table-cell padding="6pt" border="0.5pt solid black">
                            <fo:block><xsl:value-of select="format-number(@menge * @einzelpreis, '#.##')"/></fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                </xsl:for-each>
                <fo:table-row>
                    <fo:table-cell padding="6pt" border="0.5pt solid black">
                        <fo:block>Summe:</fo:block>
                    </fo:table-cell>
                    <fo:table-cell padding="6pt" border="0.5pt solid black">
                        <fo:block><xsl:value-of select="sum(position/@menge)"/></fo:block>
                    </fo:table-cell>
                    <fo:table-cell padding="6pt" border="0.5pt solid black">
                        <fo:block/>
                    </fo:table-cell>
                    <fo:table-cell padding="6pt" border="0.5pt solid black">
                        <fo:block/>
                    </fo:table-cell>
                </fo:table-row>
            </fo:table-body>
        </fo:table>
    </xsl:template>
    
    <!-- Speisekarte -->
    <xsl:template match="Speise">
        <fo:block padding="10pt" font-size="14pt" font-weight="bold">
            <xsl:value-of select="@name" />
        </fo:block>
        <fo:block>
            <xsl:for-each select="Zutat">
                <fo:list-block provisional-distance-between-starts="18pt" provisional-label-separation="3pt">
                    <fo:list-item>
                        <fo:list-item-label end-indent="label-end()">
                            <fo:block>&#x2022;</fo:block>
                        </fo:list-item-label>
                        <fo:list-item-body start-indent="body-start()">
                            <fo:block><xsl:value-of select="."/></fo:block>
                        </fo:list-item-body>
                    </fo:list-item>
                </fo:list-block>
            </xsl:for-each>
        </fo:block>
        <fo:block padding="6pt">Preis: <xsl:value-of select="@preis"/> Euro</fo:block>
    </xsl:template>
    
    <xsl:template name="header">
        <xsl:param name="right"/>
        <!-- page header: left: booklet title; left: recipe title -->
        <fo:static-content flow-name="app-header">
            <fo:block font-size="10pt" text-align-last="justify">
                <xsl:value-of select="//description"/>
                <fo:leader/>
                <xsl:value-of select="$right"/>
            </fo:block>
        </fo:static-content>        
    </xsl:template>
    
    
    
</xsl:stylesheet>