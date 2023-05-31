<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:fo="http://www.w3.org/1999/XSL/Format"
    exclude-result-prefixes="xs" version="2.0">


    <!-- Titelseite -->
    <xsl:template match="/Lieferservice">
        <fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format">
            <fo:layout-master-set>
                <fo:simple-page-master master-name="title-page" page-height="300mm"
                    page-width="220mm" margin-bottom="8mm" margin-left="25mm" margin-right="10mm"
                    margin-top="10mm">

                    <fo:region-body margin-bottom="25mm" margin-left="0mm" margin-right="44mm"
                        margin-top="10mm" region-name="region-body"/>
                    <fo:region-before extent="24pt" region-name="region-header"/>
                    <fo:region-after extent="24pt" region-name="region-footer"/>
                </fo:simple-page-master>
            </fo:layout-master-set>

            <fo:page-sequence master-reference="title-page">
                <fo:flow flow-name="region-body">
                    <fo:block margin-top="55mm" font-family="sans-serif" font-weight="bold"
                        font-size="40pt">Lieferando</fo:block>
                </fo:flow>
            </fo:page-sequence>

            <!-- Restaurantverzeichnis -->
            <fo:page-sequence master-reference="title-page">
                <xsl:call-template name="header">
                    <xsl:with-param name="right" select="'Restaurantverzeichnis'"/>
                </xsl:call-template>

                <fo:flow flow-name="region-body">
                    <fo:block font-size="18pt" font-weight="bold" margin-top="50mm"
                        margin-bottom="10pt">Unsere Partner</fo:block>
                    <fo:list-block space-before="24pt">
                        <xsl:apply-templates select="Restaurant/geschaeft" mode="get_name"/>
                    </fo:list-block>
                </fo:flow>
            </fo:page-sequence>

            <xsl:apply-templates select="Restaurant" mode="detail"/>
        </fo:root>
    </xsl:template>

    <!-- Restaurantverzeichnis Template -->
    <xsl:template match="geschaeft" mode="get_name">
        <fo:list-item>
            <fo:list-item-label>
                <fo:block><xsl:value-of select="position()"/>.</fo:block>
            </fo:list-item-label>
            <fo:list-item-body start-indent="4mm">
                <fo:block text-align-last="justify">
                    <xsl:value-of select="@name"/>
                    <fo:leader leader-pattern="dots"/>
                    <fo:page-number-citation ref-id="{generate-id()}"/>
                </fo:block>
            </fo:list-item-body>
        </fo:list-item>
    </xsl:template>

    <!-- Restaurant Template -->
    <xsl:template match="Restaurant" mode="detail" xml:space="preserve">
        <fo:page-sequence master-reference="title-page">
            <xsl:call-template name="header">
                <xsl:with-param name="right" select="geschaeft/@name"/>
            </xsl:call-template>
        
            <fo:static-content flow-name="region-footer">
                <fo:block font-size="7pt" text-align="end">
                    page <fo:page-number/>
                </fo:block>
            </fo:static-content>
            
             <fo:flow flow-name="region-body" font-size="9pt">
                <!-- restaurant titel -->
                <fo:block font-size="25pt" font-weight="bold" margin-top="20mm" id="{generate-id()}">
                    <xsl:value-of select="geschaeft/@name"/>
                </fo:block>

                <!-- Speisen Überschrift -->
                <fo:block font-size="17pt" font-weight="bold" space-before="30pt">
                    Speisen
                </fo:block>
                 
                 <!-- Vorspeisen --> 
                 <fo:block font-size="13pt" font-weight="bold" space-before="20pt">
                    Vorspeisen
                </fo:block>
                <xsl:call-template name="Vorspeise"/>
                 
                  <!-- Hauptspeisen --> 
                 <fo:block font-size="13pt" font-weight="bold" space-before="17pt">
                    Hauptspeisen
                </fo:block>
                <xsl:call-template name="Hauptspeise"/>
                 
                  <!-- Dessert --> 
                 <fo:block font-size="13pt" font-weight="bold" space-before="17pt">
                    Dessert
                </fo:block>
                <xsl:call-template name="Dessert"/>
                 
                 <!-- Getränke --> 
                 <fo:block font-size="13pt" font-weight="bold" space-before="17pt">
                    Getränke
                </fo:block>
                <xsl:call-template name="Getränke"/>
             </fo:flow>
        </fo:page-sequence>
    </xsl:template>



    <xsl:template name="Vorspeise">
        <xsl:if test="Speise[@speisegattung-id = 'vorspeise']">
            <xsl:for-each select="Speise[@speisegattung-id = 'vorspeise']">
                <fo:block text-align-last="justify" font-size="10pt">
                    <xsl:value-of select="@bezeichnung"/>
                    <fo:leader leader-pattern="dots"/>
                    <xsl:value-of select="@preis"/>
                    <xsl:text> € </xsl:text>
                </fo:block>
            </xsl:for-each>
        </xsl:if>
    </xsl:template>

    <xsl:template name="Hauptspeise">
        <xsl:if test="Speise[@speisegattung-id = 'hauptspeise']">
            <xsl:for-each select="Speise[@speisegattung-id = 'hauptspeise']">
                <fo:block text-align-last="justify" font-size="10pt">
                    <xsl:value-of select="@bezeichnung"/>
                    <fo:leader leader-pattern="dots"/>
                    <xsl:value-of select="@preis"/>
                    <xsl:text> € </xsl:text>
                </fo:block>
            </xsl:for-each>
        </xsl:if>
    </xsl:template>

    <xsl:template name="Dessert">
        <xsl:if test="Speise[@speisegattung-id = 'dessert']">
            <xsl:for-each select="Speise[@speisegattung-id = 'dessert']">
                <fo:block text-align-last="justify" font-size="10pt">
                    <xsl:value-of select="@bezeichnung"/>
                    <fo:leader leader-pattern="dots"/>
                    <xsl:value-of select="@preis"/>
                    <xsl:text> € </xsl:text>
                </fo:block>
            </xsl:for-each>
        </xsl:if>
    </xsl:template>

    <xsl:template name="Getränke">
        <xsl:if test="
                Getränk[@getränkegattung-id = 'nichtalk_getränke']
                | Getränk[@getränkegattung-id = 'alk_getränke']
                | Getränk[@getränkegattung-id = 'warme_getränke']">
            <xsl:for-each select="
                    Getränk[@getränkegattung-id = 'nichtalk_getränke']
                    | Getränk[@getränkegattung-id = 'alk_getränke']
                    | Getränk[@getränkegattung-id = 'warme_getränke']">
                <fo:block text-align-last="justify" font-size="10pt">
                    <xsl:value-of select="@bezeichnung"/>
                    <fo:leader leader-pattern="dots"/>
                    <xsl:value-of select="@preis"/>
                    <xsl:text> € </xsl:text>
                </fo:block>
            </xsl:for-each>
        </xsl:if>
    </xsl:template>


    <!-- Header Template -->
    <xsl:template name="header">
        <xsl:param name="right"/>
        <fo:static-content flow-name="region-header">
            <fo:block text-align-last="justify" margin-right="5mm" margin-top="5mm">
                <xsl:value-of select="'Lieferando'"/>
                <fo:leader/>
                <xsl:value-of select="$right"/>
            </fo:block>
        </fo:static-content>
    </xsl:template>

</xsl:stylesheet>
