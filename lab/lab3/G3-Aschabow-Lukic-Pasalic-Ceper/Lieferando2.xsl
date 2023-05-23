<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format">
    <xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>
 
    
    <!-- Titelseite -->
    <xsl:template match="/Lieferservice">
        <fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format">
            <fo:layout-master-set>
                <fo:simple-page-master master-name="title-page" page-height="28cm" page-width="22cm">
                    <fo:region-body margin="2,5cm"/>
                </fo:simple-page-master>
                <fo:simple-page-master master-name="restaurant-menu" page-height="28cm"
                    page-width="22cm">
                    <fo:region-body margin="2,5cm"/>
                    <fo:region-before extent="2cm"/>
                </fo:simple-page-master>
            </fo:layout-master-set>
            
            <fo:page-sequence master-reference="title-page">
                <fo:flow flow-name="xsl-region-body" font-family="sans-serif" font-size="28pt">
                    <fo:block margin-top="40mm">
                        <xsl:value-of select="'Lieferando'"/>
                    </fo:block>
                </fo:flow>
            </fo:page-sequence>
            
            
            <fo:page-sequence master-reference="restaurant-menu">
                <fo:static-content flow-name="xsl-region-before">
                    <fo:block font-size="18pt" font-weight="bold" margin-bottom="10pt">
                        <xsl:value-of select="'Unsere Partner'"/>
                    </fo:block>
                </fo:static-content>
                
                
                <fo:flow flow-name="xsl-region-body">
                    <fo:block font-size="18pt" font-weight="bold" margin-bottom="10pt">
                        <xsl:text>Restaurant: </xsl:text>
                        <xsl:value-of select="geschaeft/@name"/>
                    </fo:block>
                    <fo:block margin-bottom="10pt">
                        <fo:inline font-weight="bold">Adresse: </fo:inline>
                        <xsl:value-of select="geschaeft/@adresse"/>
                    </fo:block>
                    <fo:block margin-bottom="10pt">
                        <fo:inline font-weight="bold">Geöffnet von: </fo:inline>
                        <xsl:value-of select="geschaeft/@geoeffnet_von"/>
                        <xsl:text> bis </xsl:text>
                        <xsl:value-of select="geschaeft/@geoeffnet_bis"/>
                    </fo:block>
                    
                    
                    <!-- Vorspeisen -->
                    <xsl:if test="Speise[@speisegattung-id = 'vorspeise']">
                        <fo:block font-size="16pt" font-weight="bold" margin-bottom="10pt">
                            <xsl:value-of select="'Vorspeise'"/>
                        </fo:block>
                        <fo:table>
                            <fo:table-column column-width="proportional-column-width(1)"/>
                            <fo:table-column column-width="proportional-column-width(1)"/>
                            <fo:table-header>
                                <fo:table-row>
                                    <fo:table-cell>
                                        <fo:block font-weight="bold">Bezeichnung</fo:block>
                                    </fo:table-cell>
                                    <fo:table-cell>
                                        <fo:block font-weight="bold">Preis</fo:block>
                                    </fo:table-cell>
                                </fo:table-row>
                            </fo:table-header>
                            <fo:table-body>
                                <xsl:for-each select="Speise[@speisegattung-id = 'vorspeise']">
                                    <fo:table-row>
                                        <fo:table-cell>
                                            <fo:block>
                                                <xsl:value-of select="@bezeichnung"/>
                                            </fo:block>
                                        </fo:table-cell>
                                        <fo:table-cell>
                                            <fo:block>
                                                <xsl:value-of select="@preis"/>
                                            </fo:block>
                                        </fo:table-cell>
                                    </fo:table-row>
                                </xsl:for-each>
                            </fo:table-body>
                        </fo:table>
                    </xsl:if>
                    
                    
                    <!-- Hauptspeisen -->
                    <xsl:if test="Speise[@speisegattung-id = 'hauptspeise']">
                        <fo:block font-size="16pt" font-weight="bold" margin-bottom="10pt">
                            <xsl:value-of select="'Hauptspeise'"/>
                        </fo:block>
                        <fo:table>
                            <fo:table-column column-width="proportional-column-width(1)"/>
                            <fo:table-column column-width="proportional-column-width(1)"/>
                            <fo:table-header>
                                <fo:table-row>
                                    <fo:table-cell>
                                        <fo:block font-weight="bold">Bezeichnung</fo:block>
                                    </fo:table-cell>
                                    <fo:table-cell>
                                        <fo:block font-weight="bold">Preis</fo:block>
                                    </fo:table-cell>
                                </fo:table-row>
                            </fo:table-header>
                            <fo:table-body>
                                <xsl:for-each select="Speise[@speisegattung-id = 'hauptspeise']">
                                    <fo:table-row>
                                        <fo:table-cell>
                                            <fo:block>
                                                <xsl:value-of select="@bezeichnung"/>
                                            </fo:block>
                                        </fo:table-cell>
                                        <fo:table-cell>
                                            <fo:block>
                                                <xsl:value-of select="@preis"/>
                                            </fo:block>
                                        </fo:table-cell>
                                    </fo:table-row>
                                </xsl:for-each>
                            </fo:table-body>
                        </fo:table>
                    </xsl:if>
                    
                    
                    <!-- Desserts -->
                    <xsl:if test="Speise[@speisegattung-id = 'dessert']">
                        <fo:block font-size="16pt" font-weight="bold" margin-bottom="10pt">
                            <xsl:value-of select="'Desserts'"/>
                        </fo:block>
                        <fo:table>
                            <fo:table-column column-width="proportional-column-width(1)"/>
                            <fo:table-column column-width="proportional-column-width(1)"/>
                            <fo:table-header>
                                <fo:table-row>
                                    <fo:table-cell>
                                        <fo:block font-weight="bold">Bezeichnung</fo:block>
                                    </fo:table-cell>
                                    <fo:table-cell>
                                        <fo:block font-weight="bold">Preis</fo:block>
                                    </fo:table-cell>
                                </fo:table-row>
                            </fo:table-header>
                            <fo:table-body>
                                <xsl:for-each select="Speise[@speisegattung-id = 'dessert']">
                                    <fo:table-row>
                                        <fo:table-cell>
                                            <fo:block>
                                                <xsl:value-of select="@bezeichnung"/>
                                            </fo:block>
                                        </fo:table-cell>
                                        <fo:table-cell>
                                            <fo:block>
                                                <xsl:value-of select="@preis"/>
                                            </fo:block>
                                        </fo:table-cell>
                                    </fo:table-row>
                                </xsl:for-each>
                            </fo:table-body>
                        </fo:table>
                    </xsl:if>
                    
                    
                    <!-- Getränke -->
                    <xsl:if
                        test="Getränk[@getränkegattung-id = 'nichtalk_getränke'] | Getränk[@getränkegattung-id = 'alk_getränke'] | Getränk[@getränkegattung-id = 'warme_getränke']">
                        <fo:block font-size="16pt" font-weight="bold" margin-bottom="10pt">
                            <xsl:value-of select="'Getränke'"/>
                        </fo:block>
                        <fo:table>
                            <fo:table-column column-width="proportional-column-width(1)"/>
                            <fo:table-column column-width="proportional-column-width(1)"/>
                            <fo:table-header>
                                <fo:table-row>
                                    <fo:table-cell>
                                        <fo:block font-weight="bold">Bezeichnung</fo:block>
                                    </fo:table-cell>
                                    <fo:table-cell>
                                        <fo:block font-weight="bold">Preis</fo:block>
                                    </fo:table-cell>
                                </fo:table-row>
                            </fo:table-header>
                            <fo:table-body>
                                <xsl:for-each
                                    select="Getränk[@getränkegattung-id = 'nichtalk_getränke'] | Getränk[@getränkegattung-id = 'alk_getränke'] | Getränk[@getränkegattung-id = 'warme_getränke']">
                                    <fo:table-row>
                                        <fo:table-cell>
                                            <fo:block>
                                                <xsl:value-of select="@bezeichnung"/>
                                            </fo:block>
                                        </fo:table-cell>
                                        <fo:table-cell>
                                            <fo:block>
                                                <xsl:value-of select="@preis"/>
                                            </fo:block>
                                        </fo:table-cell>
                                    </fo:table-row>
                                </xsl:for-each>
                            </fo:table-body>
                        </fo:table>
                    </xsl:if>
                </fo:flow>
            </fo:page-sequence>
        </fo:root>
    </xsl:template>
</xsl:stylesheet>
