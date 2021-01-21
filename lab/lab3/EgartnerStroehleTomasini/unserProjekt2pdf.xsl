<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format">

    <!-- ROOT TEMPLATE -->
    <xsl:template match="/archerDB">
        <fo:root>
            <fo:layout-master-set>
                <!-- Basiskonfigurationen für die Formatierung -->
                <fo:simple-page-master master-name="archer-page" page-height="297.0mm"
                    page-width="209.9mm" margin-bottom="8mm" margin-left="25mm" margin-right="10mm"
                    margin-top="10mm">

                    <!-- Regionsdefinition für den Inhalt des Dokuments -->
                    <fo:region-body margin-bottom="28mm" margin-left="0mm" margin-right="44mm"
                        margin-top="35mm"/>

                    <!-- Regionsdefinition für die Kopfzeile -->
                    <fo:region-before extent="24pt" region-name="archer-header"/>

                    <!-- Regionsdefinition für die Fußzeile -->
                    <fo:region-after extent="24pt" region-name="archer-footer"/>

                </fo:simple-page-master>
            </fo:layout-master-set>

            <!-- Titelseite -->
            <fo:page-sequence master-reference="archer-page" margin-top="60mm">
                <fo:flow flow-name="xsl-region-body" font-family="sans-serif" font-size="38pt">
                    <fo:block margin-right="-30mm" margin-top="-20mm" text-align-last="right">
                        <fo:external-graphic src="WFAC2021.jpg"/>
                    </fo:block>
                    <fo:block margin-top="40mm" font-size="bold">
                        <xsl:value-of select="tournament/@tournament_name"/>
                    </fo:block>
                    <fo:block font-size="16pt" margin-top="5mm">erstellt von Egartner Fabian,
                        Ströhle Justin and Tomasini Nico</fo:block>
                </fo:flow>
            </fo:page-sequence>

            <!-- Inhaltsverzeichnis -->
            <fo:page-sequence master-reference="archer-page">

                <!--Kopfzeile-->
                <xsl:call-template name="generate-header">
                    <xsl:with-param name="title-right" select="'Inhaltsverzeichnis'"/>
                </xsl:call-template>
                <fo:flow flow-name="xsl-region-body" font-family="times" font-size="10pt">> <!-- Gruppen -->
                    <fo:block font-size="12pt" font-weight="600">Gruppen</fo:block>
                    <fo:list-block margin-top="8pt">
                        <xsl:for-each select="tournament/round/group">
                            <fo:list-item>
                                <fo:list-item-label font-weight="800" font-size="16pt"
                                    margin-left="5pt">
                                    <fo:block>.</fo:block>
                                </fo:list-item-label>
                                <fo:list-item-body start-indent="5mm">
                                    <fo:block text-align-last="justify" margin-top="6pt">
                                        <fo:basic-link internal-destination="{generate-id()}">
                                            <xsl:value-of select="@group_name"/>
                                            <fo:leader leader-pattern="dots"/>
                                            <fo:page-number-citation ref-id="{generate-id()}"/>
                                        </fo:basic-link>
                                    </fo:block>
                                </fo:list-item-body>
                            </fo:list-item>
                        </xsl:for-each>
                    </fo:list-block>
                    <!-- Turniertage -->
                    <fo:block font-size="12pt" font-weight="600" margin-top="20pt"
                        >Turniertage</fo:block>
                    <fo:list-block margin-top="8pt">
                        <xsl:for-each select="tournament/round">
                            <fo:list-item>
                                <fo:list-item-label font-weight="800" font-size="16pt"
                                    margin-left="5pt">
                                    <fo:block>.</fo:block>
                                </fo:list-item-label>
                                <fo:list-item-body start-indent="5mm">
                                    <fo:block text-align-last="justify" margin-top="6pt">
                                        <fo:basic-link internal-destination="{generate-id()}">
                                            <xsl:value-of select="@round_name"/>
                                            <fo:leader leader-pattern="dots"/>
                                            <fo:page-number-citation ref-id="{generate-id()}"/>
                                        </fo:basic-link>
                                    </fo:block>
                                </fo:list-item-body>
                            </fo:list-item>
                        </xsl:for-each>
                    </fo:list-block>
                    <!-- Scorecards -->
                    <fo:block font-size="12pt" font-weight="600" margin-top="20pt"
                        >Scorecards</fo:block>
                    <fo:list-block margin-top="8pt">
                        <xsl:for-each select="tournament/archer" xml:space="preserve">
                            <fo:list-item>
                                <fo:list-item-label font-weight="800" font-size="16pt" margin-left="5pt">
                                    <fo:block>.</fo:block>
                                </fo:list-item-label>
                                <fo:list-item-body start-indent="5mm">                                
                                    <fo:block text-align-last="justify" margin-top="6pt">
                                        <fo:basic-link internal-destination="{generate-id()}">
                                          <xsl:value-of select="@fname"/>
                                          <xsl:value-of select="@lname"/>
                                          <fo:leader leader-pattern="dots"/>
                                          <fo:page-number-citation ref-id="{generate-id()}"/>
                                        </fo:basic-link>
                                    </fo:block>
                                </fo:list-item-body>
                            </fo:list-item>
                            
                        </xsl:for-each>
                    </fo:list-block>
                </fo:flow>
            </fo:page-sequence>

            <!-- used templates -->
            <xsl:apply-templates select="tournament/round/group"/>
            <xsl:apply-templates select="tournament/round"/>
            <xsl:apply-templates select="tournament/archer"/>
        </fo:root>
    </xsl:template>
    <xsl:template match="group">
        <fo:page-sequence master-reference="archer-page">

            <!-- Kopfzeile -->
            <xsl:call-template name="generate-header">
                <xsl:with-param name="title-right" select="@group_name"/>
            </xsl:call-template>

            <!-- Fußzeile -->
            <fo:static-content flow-name="archer-footer">
                <fo:block font-size="7pt" text-align="end"> page <fo:page-number/>
                </fo:block>
            </fo:static-content>

            <!-- Hauptteil -->
            <fo:flow flow-name="xsl-region-body">
                <fo:block font-size="14pt" font-weight="800" id="{generate-id()}"
                    margin-bottom="12pt">
                    <xsl:value-of select="@group_name"/>
                </fo:block>
                <xsl:variable name="current_group_id" select="@id"/>
                <xsl:for-each select="/archerDB/tournament/archer" xml:space="preserve"> 
                    <xsl:if test="member_of/@group_id = $current_group_id">
                        <fo:block margin-top="4pt" margin-left="5pt">
                             -
                             <fo:basic-link internal-destination="{generate-id()}">
                                 <xsl:value-of select="@fname"/>
                                 <xsl:value-of select="@lname"/>
                                 
                             </fo:basic-link>
                            <!-- TODO: Sum of points -->
                        </fo:block>
                    </xsl:if>
               </xsl:for-each>
            </fo:flow>
        </fo:page-sequence>
    </xsl:template>
    <xsl:template match="round">
        <fo:page-sequence master-reference="archer-page">

            <!-- Kopfzeile -->
            <xsl:call-template name="generate-header">
                <xsl:with-param name="title-right" select="@round_name"/>
            </xsl:call-template>

            <!-- Fußzeile -->
            <fo:static-content flow-name="archer-footer">
                <fo:block font-size="7pt" text-align="end"> page <fo:page-number/>
                </fo:block>
            </fo:static-content>

            <!-- Hauptteil -->
            <fo:flow flow-name="xsl-region-body">
                <fo:block font-size="14pt" font-weight="800" id="{generate-id()}"
                    margin-bottom="24pt">
                    <xsl:value-of select="@round_name"/>
                </fo:block>
                <fo:block font-size="11pt" font-weight="500" margin-bottom="6pt">Teilnehmende
                    Gruppen:</fo:block>
                <xsl:for-each select="group">
                    <fo:block margin-top="4pt" margin-left="5pt" font-size="10pt"> - <fo:basic-link
                            internal-destination="{generate-id()}">
                            <xsl:value-of select="@group_name"/>
                        </fo:basic-link>
                    </fo:block>
                </xsl:for-each>
                <fo:block font-size="11pt" font-weight="500" margin-top="15pt" margin-bottom="6pt"
                    >Parcours:</fo:block>
                <xsl:for-each select="parcour">
                    <fo:block margin-top="4pt" margin-left="5pt" font-size="10pt"> - <xsl:value-of
                            select="@parcour_name"/>
                    </fo:block>
                </xsl:for-each>
            </fo:flow>
        </fo:page-sequence>
    </xsl:template>

    <xsl:template match="archer">
        <fo:page-sequence master-reference="archer-page">

            <!-- Kopfzeile -->
            <xsl:call-template name="generate-header">
                <xsl:with-param name="title-right" select="@lname"/>
            </xsl:call-template>

            <!-- Fußzeile -->
            <fo:static-content flow-name="archer-footer">
                <fo:block font-size="7pt" text-align="end"> page <fo:page-number/>
                </fo:block>
            </fo:static-content>

            <!-- Hauptteil -->
            <fo:flow flow-name="xsl-region-body">
                <fo:block font-size="14pt" font-weight="800" id="{generate-id()}"
                    margin-bottom="24pt"> Scorecards von <xsl:value-of select="@fname"/>
                    <xsl:value-of select="' '"/>
                    <xsl:value-of select="@lname"/>
                </fo:block>
                <fo:table>
                    <fo:table-body>
                        <xsl:for-each select="scorecard">
                            <fo:table-row>
                                <fo:table-cell>Tag <fo:block font-weight="bold">Tag <xsl:value-of
                                            select="@sc_number"/>
                                    </fo:block>
                                </fo:table-cell>

                                <xsl:apply-templates select="point"/>
                            </fo:table-row>
                        </xsl:for-each>
                    </fo:table-body>
                </fo:table>

            </fo:flow>
        </fo:page-sequence>
    </xsl:template>

    <xsl:template match="point">
        <fo:table-cell>
            <fo:block>
                <xsl:value-of select="@targetpoints"/>
            </fo:block>
        </fo:table-cell>
    </xsl:template>

    <!-- Funktion zur Header-Generierung -->
    <xsl:template name="generate-header">
        <xsl:param name="title-right"/>
        <fo:static-content flow-name="archer-header">
            <fo:block font-size="7pt" text-align-last="justify">
                <xsl:value-of select="/archerDB/tournament/@tournament_name"/>
                <fo:leader/>
                <xsl:value-of select="$title-right"/>
            </fo:block>
        </fo:static-content>
    </xsl:template>
</xsl:stylesheet>
