<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format">
    <xsl:variable name="aid1" select="@athlete-id"/>

    <!-- ............................ ROOT TEMPLATE .......................... -->
    <xsl:template match="/tournament">

        <fo:root>

            <!-- define the layout of the document -->
            <fo:layout-master-set>
                <!-- here we define the layout of pages. There might be differrent page masters with e.g. different margin settings -->
                <fo:simple-page-master master-name="tournament-page" page-height="297.0mm"
                    page-width="209.9mm" margin-bottom="8mm" margin-left="25mm" margin-right="10mm"
                    margin-top="10mm">

                    <!-- the content will be placed into the region-body -->
                    <fo:region-body margin-bottom="20mm" margin-left="0mm" margin-right="15mm"
                        margin-top="60mm"/>

                    <!--region before is the page header-->
                    <fo:region-before extent="24pt" region-name="tournament-header"/>

                    <!-- region-after ist the page footer -->
                    <fo:region-after extent="24pt" region-name="tournament-footer"/>

                </fo:simple-page-master>
            </fo:layout-master-set>


            <!-- Here comes the content.
                 Printed content consists of one or more page-sequences. Each page-sequence starts on a new page. -->

            <!-- front page -->
            <fo:page-sequence master-reference="tournament-page">
                <fo:flow flow-name="xsl-region-body" font-family="sans-serif" font-size="28pt">
                    <fo:block margin-top="30mm">
                        <xsl:value-of select="description"/>
                    </fo:block>
                </fo:flow>
            </fo:page-sequence>

            <!-- Inhaltsverzeichnis -->
            <fo:page-sequence master-reference="tournament-page">
                <xsl:call-template name="header">
                    <xsl:with-param name="right" select="'Inhaltsverzeichnis'"/>
                </xsl:call-template>

                <!-- um den Inhaltsverzeichnis anzuzeigen -->
                <fo:flow flow-name="xsl-region-body" font-family="sans-serif" font-size="25pt">
                    <fo:block font-weight="bold" margin-top="20mm">Inhaltsverzeichnis</fo:block>
                    <fo:list-block space-before="24pt" font-size="15pt">
                        <xsl:apply-templates select="group" mode="iv"/>
                    </fo:list-block>
                </fo:flow>
            </fo:page-sequence>

            <!-- um die Gruppenaufteilung anzuzeigen -->
            <xsl:apply-templates select="group" mode="detail"/>

            <!-- um die Scorecards anzuzeigen -->
            <xsl:for-each select="group/athlete">
                <xsl:variable name="aid" select="@id"/>
                <fo:page-sequence master-reference="tournament-page">

                    <xsl:call-template name="header">
                        <xsl:with-param name="right" select="@lastname"/>
                    </xsl:call-template>

                    <xsl:call-template name="footer"/>

                    <fo:flow flow-name="xsl-region-body">

                        <!-- Überschrift -->
                        <fo:block id="{generate-id()}" font-size="20" font-weight="bold">
                            <xsl:value-of select="concat(@firstname, ' ', @lastname, ' - Gruppe ', ../@nr)" xml:space="preserve"/>
                        </fo:block>

                        <fo:table margin-top="7pt" border-spacing="1" line-height="2"
                            text-align="center" font-size="16">
                            <fo:table-column column-width="20mm"/>
                            <fo:table-column column-width="35mm"/>
                            <fo:table-column column-width="30mm"/>
                            <fo:table-column column-width="30mm"/>
                            <fo:table-column column-width="30mm"/>
                            <fo:table-column column-width="20mm"/>

                            <fo:table-header border-width="1pt" border-style="solid"
                                background-color="green" padding="1">
                                <fo:table-row>
                                    <fo:table-cell>
                                        <fo:block font-weight="bold">Runde</fo:block>
                                    </fo:table-cell>
                                    <fo:table-cell>
                                        <fo:block font-weight="bold">Zielscheibe</fo:block>
                                    </fo:table-cell>
                                    <fo:table-cell>
                                        <fo:block font-weight="bold">Versuch 1</fo:block>
                                    </fo:table-cell>
                                    <fo:table-cell>
                                        <fo:block font-weight="bold">Versuch 2</fo:block>
                                    </fo:table-cell>
                                    <fo:table-cell>
                                        <fo:block font-weight="bold">Versuch 3</fo:block>
                                    </fo:table-cell>
                                    <fo:table-cell>
                                        <fo:block font-weight="bold">Punkte</fo:block>
                                    </fo:table-cell>
                                </fo:table-row>
                            </fo:table-header>

                            <fo:table-body border-width="1pt">
                                <xsl:apply-templates
                                    select="//score-card[@athlete-id = $aid]/target"/>
                            </fo:table-body>
                        </fo:table>
                    </fo:flow>
                </fo:page-sequence>
            </xsl:for-each>
        </fo:root>
    </xsl:template>


    <!-- .................... TEMPLATE FÜR HEADER .................... -->
    <xsl:template name="header">
        <xsl:param name="right"/>
        <fo:static-content flow-name="tournament-header">
            <fo:block font-size="8pt" text-align-last="justify">
                <xsl:value-of select="/tournament/description"/>
                <fo:leader/>
                <xsl:value-of select="$right"/>
            </fo:block>
        </fo:static-content>
    </xsl:template>


    <!-- .................... TEMPLATE FÜR FOOTER .................... -->
    <xsl:template name="footer">
        <xsl:param name="right"/>
        <fo:static-content flow-name="tournament-footer">
            <fo:block font-size="8pt" text-align="end"> page <fo:page-number/>
            </fo:block>
        </fo:static-content>        
    </xsl:template>


    <!-- .................... TEMPLATE FÜR INHALTSVERZEICHNIS .................... -->
    <xsl:template match="group" mode="iv">
        <fo:list-item space-after="30pt">
            <fo:list-item-label>
                <fo:block> Gruppe <fo:basic-link internal-destination="{generate-id()}">
                        <xsl:value-of select="@nr"/>
                    </fo:basic-link>
                </fo:block>
            </fo:list-item-label>
            <fo:list-item-body start-indent="24mm">
                <fo:block text-align-last="justify">
                    <fo:leader leader-pattern="dots"/>
                    <fo:page-number-citation ref-id="{generate-id()}"/>
                </fo:block>
            </fo:list-item-body>
        </fo:list-item>
    </xsl:template>


    <!-- .................... TEMPLATE FÜR GRUPPENAUFTEILUNG ....................D -->
    <xsl:template match="group" mode="detail">

        <fo:page-sequence master-reference="tournament-page">

            <xsl:call-template name="header">
                <xsl:with-param name="right" select="concat('Gruppe ', @nr)"/>
            </xsl:call-template>

            <xsl:call-template name="footer"/>

            <fo:flow flow-name="xsl-region-body" font-family="sans-serif" font-size="12pt">
                <fo:block font-size="18pt" font-weight="bold" id="{generate-id()}"> Gruppe
                        <xsl:value-of select="@nr"/>
                </fo:block>
                <fo:list-block space-before="24pt" font-size="14pt">
                    <xsl:apply-templates select="athlete"/>
                </fo:list-block>
            </fo:flow>
        </fo:page-sequence>
    </xsl:template>


    <!-- .................... TEMPLATE FÜR ATHLETEN .................... -->
    <xsl:template match="athlete">
        <xsl:variable name="aid" select="@id"/>
        <fo:list-item space-before="20pt" space-after="10pt">
            <fo:list-item-label>
                <fo:block/>
            </fo:list-item-label>
            <fo:list-item-body>
                <fo:block font-size="14pt" margin-left="10mm">
                    <fo:basic-link internal-destination="{generate-id()}">
                        <xsl:value-of select="concat(@firstname, ' ', @lastname)"/>
                    </fo:basic-link>
                </fo:block>
            </fo:list-item-body>
        </fo:list-item>

        <fo:list-item>
            <fo:list-item-label>
                <fo:block/>
            </fo:list-item-label>
            <fo:list-item-body>
                <fo:block font-size="11pt" margin-left="-20mm">
                    <xsl:apply-templates select="../round/score-card[@athlete-id = $aid]"/>
                </fo:block>
            </fo:list-item-body>
        </fo:list-item>
    </xsl:template>


    <!-- ............... TEMPLATE FÜR GRUPPENAUFTEILUNG/RUNDEN ............... -->
    <xsl:template match="score-card">
        <fo:list-block margin-left="40mm">
            <fo:list-item>
                <fo:list-item-label>
                    <fo:block/>
                </fo:list-item-label>
                <fo:list-item-body>
                    <fo:block> Runde <xsl:value-of
                            select="concat(../@nr, ' am ', ../@date, ' . . . . . . . . . . ')"/>
                        <xsl:value-of select="sum(target/score/@points)"/>
                    </fo:block>
                </fo:list-item-body>
            </fo:list-item>
        </fo:list-block>
    </xsl:template>


    <!-- .................... TEMPLATE FÜR SCORECARDS DETAIL....................D -->
    <xsl:template match="target">
        <fo:table-row border-width="1pt" border-style="solid">
            <fo:table-cell border-width="1pt" border-style="solid">
                <fo:block>
                    <xsl:value-of select="../../@nr"/>
                </fo:block>
            </fo:table-cell>
            <fo:table-cell border-width="1pt" border-style="solid">
                <fo:block>
                    <xsl:value-of select="@nr"/>
                </fo:block>
            </fo:table-cell>
            <fo:table-cell border-width="1pt" border-style="solid">
                <fo:block>
                    <xsl:value-of select="score[1]/@points"/>
                </fo:block>
            </fo:table-cell>
            <fo:table-cell border-width="1pt" border-style="solid">
                <fo:block>
                    <xsl:value-of select="score[2]//@points"/>
                </fo:block>
            </fo:table-cell>
            <fo:table-cell border-width="1pt" border-style="solid">
                <fo:block>
                    <xsl:value-of select="score[3]/@points"/>
                </fo:block>
            </fo:table-cell>
            <fo:table-cell border-width="1pt" border-style="solid">
                <fo:block>
                    <xsl:value-of select="sum(score/@points)"/>
                </fo:block>
            </fo:table-cell>
        </fo:table-row>
    </xsl:template>


    <!-- .................... TEMPLATE FÜR SCORECARD/HEADLINE.................... -->
    <xsl:template match="athlete" mode="gruppe">
        <fo:block font-size="20pt" font-weight="bold">
            <xsl:for-each select="@id">
                <!-- diese Schleife ist hier eigentlich Fehl am Platz -->
                <xsl:value-of select="concat(@firstname, ' ', @lastname, ' - Gruppe ', ../@nr, ' ', ../round/@date)" xml:space="preserve"/>
            </xsl:for-each>
        </fo:block>
    </xsl:template>


</xsl:stylesheet>
