<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format">
    
    <!-- ............................ ROOT TEMPLATE .......................... -->
    <xsl:template match="/">
        <fo:root>
            
            <!-- define the layout of the document -->
            <fo:layout-master-set>
                <!-- here we define the layout of pages. There might be differrent page masters with e.g. different margin settings -->
				<fo:simple-page-master master-name="competition-page"
                    page-height="297.0mm" page-width="209.9mm"
                    margin-bottom="8mm" margin-left="25mm" margin-right="10mm" margin-top="10mm">
                    
                    <!-- the content will be placed into the region-body -->
                    <fo:region-body margin-bottom="28mm" margin-left="0mm" margin-right="44mm" margin-top="20mm"/>
                    
                    <!-- region-after is the page footer -->
                    <fo:region-after extent="24pt"/>
                    
                </fo:simple-page-master>
            </fo:layout-master-set>
            
            <!-- define the content of the document -->
            <fo:page-sequence master-reference="competition-page">
                <fo:static-content flow-name="xsl-region-after" font-family="sans-serif"  font-size="9pt">
                    <fo:block text-align="right">
                        <fo:page-number/>
                    </fo:block>
                </fo:static-content>
                <fo:flow flow-name="xsl-region-body" font-family="sans-serif"  font-size="9pt">
                    <!-- Inhaltsverzeichnis -->
                    <fo:block font-size="18pt" margin-bottom="10pt" margin-top="10pt">Inhaltsverzeichnis</fo:block>  
                    <fo:list-block>
                        <fo:list-item>
                            <fo:list-item-label end-indent="label-end()">
                                <fo:block>&#x2022;</fo:block>
                            </fo:list-item-label>
                            <fo:list-item-body start-indent="body-start()">
                                <fo:block><fo:basic-link internal-destination="Wettkaempfer" text-decoration="underline">Wettkaempfer</fo:basic-link></fo:block>
                            </fo:list-item-body>
                        </fo:list-item>
                        <fo:list-item>
                            <fo:list-item-label end-indent="label-end()">
                                <fo:block/>
                            </fo:list-item-label>
                            <fo:list-item-body start-indent="body-start()">
                                <xsl:apply-templates select="/overview/competitor" mode="Inhaltsverzeichnis"/>
                            </fo:list-item-body>
                        </fo:list-item>
                        <fo:list-item>
                            <fo:list-item-label end-indent="label-end()">
                                <fo:block>&#x2022;</fo:block>
                            </fo:list-item-label>
                            <fo:list-item-body start-indent="body-start()">
                                <fo:block><fo:basic-link internal-destination="Wettkaempfe" text-decoration="underline">Turniere</fo:basic-link></fo:block>
                            </fo:list-item-body>
                        </fo:list-item>
                        <fo:list-item>
                            <fo:list-item-label end-indent="label-end()">
                                <fo:block/>
                            </fo:list-item-label>
                            <fo:list-item-body start-indent="body-start()">
                                <xsl:apply-templates select="/overview/tournament" mode="Inhaltsverzeichnis"/>
                            </fo:list-item-body>
                        </fo:list-item>
                    </fo:list-block>
                    
                    <!-- Wettkaempfer -->
                    <fo:block id="Wettkaempfer" font-size="18pt" margin-bottom="10pt" margin-top="10pt">Wettkaempfer</fo:block>
                    
                    <fo:table border="0.5pt solid black" text-align="center">
                        <fo:table-column column-width="20mm"/>
                        <fo:table-column column-width="20mm"/>
                        <fo:table-column column-width="20mm"/>
                        <fo:table-column column-width="25mm"/>
                        <fo:table-column column-width="20mm"/>
                        <fo:table-header>
                            <fo:table-row>
                                <fo:table-cell border="0.5pt solid black"><fo:block>ID</fo:block></fo:table-cell>
                                <fo:table-cell border="0.5pt solid black"><fo:block>Vorname</fo:block></fo:table-cell>
                                <fo:table-cell border="0.5pt solid black"><fo:block>Nachname</fo:block></fo:table-cell>
                                <fo:table-cell border="0.5pt solid black"><fo:block>Geburtsdatum</fo:block></fo:table-cell>
                                <fo:table-cell border="0.5pt solid black"><fo:block>Bogenklasse</fo:block></fo:table-cell>
                            </fo:table-row>
                        </fo:table-header>
                        <fo:table-body>
                            <xsl:apply-templates select="/overview/competitor" mode="table"/>
                        </fo:table-body>
                    </fo:table>
                    
                    <!-- Turniere / Wettkaempfe -->
                    <fo:block id="Wettkaempfe" font-size="18pt" margin-bottom="10pt" margin-top="10pt">Wettkaempfe</fo:block>
                    
                    <xsl:apply-templates select="overview/tournament" mode="content"/>
                </fo:flow>
            </fo:page-sequence>
        </fo:root>
    </xsl:template>
    
    <!-- Competiton Template -->
    <xsl:template match="/overview/competitor" mode="table">
        <fo:table-row>
            <fo:table-cell><fo:block><xsl:value-of select="@id"/></fo:block></fo:table-cell>
            <fo:table-cell> <fo:block id="{generate-id()}"> <xsl:value-of select="@first_name"/></fo:block></fo:table-cell>
            <fo:table-cell> <fo:block> <xsl:value-of select="@last_name"/> </fo:block>  </fo:table-cell>
            <fo:table-cell> <fo:block> <xsl:value-of select="@date_of_birth"/>  </fo:block> </fo:table-cell>
            <fo:table-cell> <fo:block> <xsl:value-of select="@bow_class"/>  </fo:block> </fo:table-cell>
        </fo:table-row>
    </xsl:template>
    
    <xsl:template match="/overview/competitor" mode="Inhaltsverzeichnis">
        <fo:list-block provisional-distance-between-starts="18pt" provisional-label-separation="3pt">
            <fo:list-item>
                <fo:list-item-label end-indent="label-end()">
                    <fo:block>&#x2022;</fo:block>
                </fo:list-item-label>
                <fo:list-item-body start-indent="body-start()">
                    <fo:block>
                        <fo:basic-link internal-destination="{generate-id()}" text-decoration="underline">
                            <xsl:value-of select="@first_name"/>&#160;<xsl:value-of select="@last_name"/>
                        </fo:basic-link>
                    </fo:block>
                </fo:list-item-body>
            </fo:list-item>
        </fo:list-block>
    </xsl:template>
    
    <xsl:template match="/overview/tournament" mode="Inhaltsverzeichnis">
        <fo:list-block provisional-distance-between-starts="18pt" provisional-label-separation="3pt">
            <fo:list-item>
                <fo:list-item-label end-indent="label-end()">
                    <fo:block>&#x2022;</fo:block>
                </fo:list-item-label>
                <fo:list-item-body start-indent="body-start()">
                    <fo:block>
                        <fo:basic-link internal-destination="{generate-id()}" text-decoration="underline">
                            <xsl:value-of select="@id"/>
                        </fo:basic-link>
                    </fo:block>
                </fo:list-item-body>
            </fo:list-item>
        </fo:list-block>
    </xsl:template>
    
    <xsl:template match="/overview/tournament" mode="content">
        <fo:block id="{generate-id()}" font-size="14pt" margin-top="5pt" margin-bottom="5pt">Tournament: <xsl:value-of select="@id"/></fo:block>
        
        <fo:list-block>
            <fo:list-item>
                <fo:list-item-label end-indent="label-end()">
                    <fo:block>&#x2022;</fo:block>
                </fo:list-item-label>
                <fo:list-item-body start-indent="body-start()">
                    <fo:block>
                        Anmeldefrist: <xsl:value-of select="@register_end_date"/>
                    </fo:block>
                </fo:list-item-body>
            </fo:list-item>
            <fo:list-item>
                <fo:list-item-label end-indent="label-end()">
                    <fo:block>&#x2022;</fo:block>
                </fo:list-item-label>
                <fo:list-item-body start-indent="body-start()">
                    <fo:block>
                        Dauer: <xsl:value-of select="@event_start_date"/> - <xsl:value-of select="@event_end_date"/>
                    </fo:block>
                </fo:list-item-body>
            </fo:list-item>
        </fo:list-block>
        
        <xsl:for-each select="competition_day">
            <fo:block font-size="12pt" margin-top="5pt" margin-bottom="5pt">Spieltag <xsl:value-of select="@date_time"/></fo:block>
            <xsl:for-each select="round">
                <fo:block font-size="10pt">Runde <xsl:value-of select="@id"/></fo:block>
                <!-- table -->
                <fo:table border="0.5pt solid black" text-align="center">
                    <fo:table-column column-width="30mm"/>
                    <fo:table-column column-width="25mm"/>
                    <fo:table-column column-width="25mm"/>
                    <fo:table-column column-width="25mm"/>
                    <fo:table-column column-width="25mm"/>
                    <fo:table-header>
                        <fo:table-row>
                            <fo:table-cell border="0.5pt solid black"><fo:block>Ziel</fo:block></fo:table-cell>
                            <xsl:for-each select="/overview/competitor">
                                <fo:table-cell border="0.5pt solid black">
                                    <fo:block><xsl:value-of select="@first_name"/>&#160;<xsl:value-of select="@last_name"/></fo:block>
                                </fo:table-cell>
                            </xsl:for-each>
                        </fo:table-row>
                    </fo:table-header>
                    <fo:table-body>
                        <xsl:for-each select="target">
                            <fo:table-row>
                                <fo:table-cell>
                                    <fo:block>
                                        <xsl:value-of select="@target_size"/>&#160;<xsl:value-of select="@range"/>&#160;<xsl:value-of select="@ground_markers"/>
                                    </fo:block>
                                </fo:table-cell>
                                <xsl:for-each select="score">
                                    <fo:table-cell>
                                        <fo:block>
                                            <xsl:for-each select="attempt">
                                                <xsl:value-of select="@points"/>&#160;
                                            </xsl:for-each>
                                        </fo:block>
                                    </fo:table-cell>
                                </xsl:for-each>
                            </fo:table-row>
                        </xsl:for-each>
                    </fo:table-body>
                </fo:table>
            </xsl:for-each>
        </xsl:for-each>
    </xsl:template>
</xsl:stylesheet>
