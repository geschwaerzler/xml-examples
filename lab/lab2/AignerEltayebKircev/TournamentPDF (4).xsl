<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format"
    version="2.0"
>
    <xsl:template match="/tournament">
        <fo:root>
            <!-- layout -->
            <fo:layout-master-set>
                <!-- layout of pages -->
                <fo:simple-page-master master-name="tournament" 
                    page-height="297.0mm" page-width="209.9mm" 
                    margin-bottom="8mm" margin-left="25mm" margin-right="10mm" margin-top="10mm">
                    
                    <!-- content in the body -->
                    <fo:region-body margin-bottom="28mm" margin-left="0mm" margin-right="44mm" margin-top="20mm"/>
                    <fo:region-before extent="10mm"/>
                    <fo:region-after extent="10mm"/>
                </fo:simple-page-master>
            </fo:layout-master-set>
            
            
            <!-- front page -->
            
            <!-- inhalt -->
            <fo:page-sequence master-reference="tournament">
                <fo:flow flow-name="xsl-region-body" font-family="sans-serif">
                    <fo:block font-size="30pt" font-weight="700">
                        <xsl:value-of select="@name"/>
                    </fo:block>
                    
                                        <!-- inhaltsverzeichnis -->
                    <fo:block font-size="30pt" font-weight="700" margin-top="24pt" margin-bottom="12pt">
                        Tabel of contents
                    </fo:block>
                    <fo:list-block font-size="20pt">
                        <xsl:for-each select="group">
                            <fo:list-item>
                                <fo:list-item-label><fo:block></fo:block></fo:list-item-label>
                                <fo:list-item-body margin-left="8mm">
                                    <fo:block text-align-last="justify">
                                        <xsl:value-of select="concat(@name,' ', id(@division-id),' ', id(@discipline-id))"/>
                                        <fo:leader leader-pattern="dots"></fo:leader>
                                        <fo:page-number-citation ref-id="{generate-id()}"/>
                                    </fo:block>
                                </fo:list-item-body>
                            </fo:list-item>
                        </xsl:for-each>
                    </fo:list-block>
                </fo:flow>
            </fo:page-sequence>
            
            <xsl:apply-templates select="group"></xsl:apply-templates>
            <xsl:apply-templates select="group/archer"></xsl:apply-templates>
        </fo:root>
    </xsl:template>
    
    <xsl:template name="header2">
        <xsl:param name="text"/>
        <fo:block font-size="30pt" font-weight="700">
            <xsl:value-of select="$text"/>
        </fo:block>
    </xsl:template>
    
    <xsl:template match="group">
        <fo:page-sequence master-reference="tournament">
            <!-- seite nummerieren -->
            <fo:static-content flow-name="xsl-region-after" font-size="7pt">
                <fo:block text-align-last="right">
                    Page<fo:page-number/>
                </fo:block>
            </fo:static-content>
            
            <fo:flow flow-name="xsl-region-body">
                <fo:block font-size ="30pt" font-weight="700" id="{generate-id()}">
                    <xsl:value-of select="concat(@name, ' ', id(@divison-id), ' ', id(@discipline-id))"/>
                </fo:block>
                <fo:list-block font-size="20pt">
                    <xsl:for-each select="archer">
                        <fo:list-item>
                            <fo:list-item-label><fo:block>*</fo:block></fo:list-item-label>
                            <fo:list-item-body margin-left="8mm" margin-top="10mm" margin-bottom="20mm">
                                <fo:block ref-id="{generate-id()}">
                                    <xsl:value-of select="concat(firstname, ' ', lastname)"/>
                                </fo:block>
                            </fo:list-item-body>
                        </fo:list-item>
                    </xsl:for-each>
                </fo:list-block>
            </fo:flow>
            
          <!-- <fo:block font-weight="700">Scores</fo:block>
            <fo:table>
                <fo:table-body>
                    <xsl:for-each select="day/scores/target-scores" xml:space="preserve">
                    <fo:table-row border-after-width="0.25pt">
                        <fo:table-cell>
                            <fo:block><xsl:value-of select="@target"/></fo:block>
                        </fo:table-cell>
                        <fo:table-cell>
                            <fo:block><xsl:value-of select="arrow1-score"/></fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                    </xsl:for-each>
                </fo:table-body>
            </fo:table>
          -->  
           <!-- <fo:flow flow-name="xsl-region-body">
                <fo:block font-size="30pt">
                    <xsl:value-of select="concat(@name, ' ', day/@date)"/>   
                </fo:block>
            </fo:flow>
        -->   
        </fo:page-sequence>
    </xsl:template>
    
    <xsl:template match="archer">
        <fo:page-sequence master-reference="tournament">
            <fo:flow flow-name="xsl-region-body">
                <fo:block font-size="20pt" id="{generate-id()}">
                    <xsl:value-of select="concat(firstname,' ', lastname, '-', ../@name, ' ', ../day/@date)"/>
                </fo:block>
                <fo:table border="0.5pt solid black" text-align="center" border-spacing="3pt">
                <fo:table-header>
                    <fo:table-row>
                        <fo:table-cell>
                            <fo:block>Target</fo:block>
                        </fo:table-cell>
                        <fo:table-cell>
                            <fo:block>Arrow 1</fo:block>
                        </fo:table-cell>
                        <fo:table-cell>
                            <fo:block>Arrow 2</fo:block>
                        </fo:table-cell>
                        <fo:table-cell>
                            <fo:block>Arrow 3</fo:block>
                        </fo:table-cell>
                        <fo:table-cell>
                            <fo:block>Arrow 4</fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                </fo:table-header>    
                    <fo:table-body>
                        <fo:table-row>
                            <fo:table-cell>
                                <fo:block>
                                   1
                                </fo:block>
                            </fo:table-cell>
                            <fo:table-cell>
                                <fo:block>
                                    2
                                </fo:block>
                            </fo:table-cell>
                            <fo:table-cell>
                                <fo:block>
                                    3
                                </fo:block>
                            </fo:table-cell>
                            <fo:table-cell>
                                <fo:block>
                                    4
                                </fo:block>
                            </fo:table-cell>
                            <fo:table-cell>
                                <fo:block>
                                    5
                                </fo:block>
                            </fo:table-cell>
                        </fo:table-row>
                    </fo:table-body>
                </fo:table>
            </fo:flow>
        </fo:page-sequence>
    </xsl:template>

    <!-- <fo:page-sequence>
    <fo:flow flow-name="xsl-region-body">
        <xsl:call-template name="header2">
            <xsl:with-param name="text" select="concat(firstname,' ', lastname, '-', ../@name, ' ', ../day/@date)"></xsl:with-param>
        </xsl:call-template>
    </fo:flow>
    </fo:page-sequence>
    -->
    <!-- <xsl:for-each select="archer">
                        <fo:list-item>
                            <fo:list-item-label><fo:block>:</fo:block></fo:list-item-label>
                            <fo:list-item-body>
                                <xsl:value-of select="concat(firstname,' ', lastname, '-', ../@name, ' ', ../day/@date)"/>
                            </fo:list-item-body>
                        </fo:list-item> -->
</xsl:stylesheet>