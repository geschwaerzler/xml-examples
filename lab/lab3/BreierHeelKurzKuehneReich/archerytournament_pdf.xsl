<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format">

    <!-- ............................ ROOT TEMPLATE .......................... -->
    <xsl:template match="/">
        <fo:root>

            <!-- define the layout of the document -->
            <fo:layout-master-set>
                <!-- here we define the layout of pages. There might be differrent page masters with e.g. different margin settings -->
                <fo:simple-page-master master-name="tournament-page" page-height="297.0mm"
                    page-width="209.9mm" margin-bottom="8mm" margin-left="25mm" margin-right="10mm"
                    margin-top="10mm">

                    <!-- the content will be placed into the region-body -->
                    <fo:region-body margin-bottom="28mm" margin-left="0mm" margin-right="44mm"
                        margin-top="20mm"/>

                    <!-- region-before is the page header -->
                    <fo:region-before extent="24pt" region-name="tournament-header"/>

                    <!-- region-after is the page footer -->
                    <fo:region-after extent="24pt" region-name="tournament-footer"/>

                </fo:simple-page-master>
            </fo:layout-master-set>


            <!-- Here comes the content.
                 Printed content consists of one or more page-sequences. Each page-sequence starts on a new page. -->
            
            <!-- front page -->
            <fo:page-sequence master-reference="tournament-page">
                <fo:flow flow-name="xsl-region-body" font-family="sans-serif" font-size="28pt">
                    <fo:block margin-top="40mm">
                        Archery Tournament Results
                    </fo:block>
                </fo:flow>
            </fo:page-sequence>
            
            <!-- table of contents -->
            <fo:page-sequence master-reference="tournament-page">
                <!-- place a page description into the page header -->
                <xsl:call-template name="header">
                    <xsl:with-param name="right" select="'Table of Contents'"/>
                </xsl:call-template>

                <!-- place the table of contents into region-body -->
                <fo:flow flow-name="xsl-region-body" font-family="Times" font-size="9pt">
                    <fo:block font-weight="bold" margin-top="40mm" font-size="14pt">Table of Contents</fo:block>
                    <fo:list-block space-before="24pt">
                        <xsl:apply-templates select="archery-tournament/tournament" mode="toc"/>
                    </fo:list-block>
                </fo:flow>
            </fo:page-sequence>

            <xsl:apply-templates select="archery-tournament/tournament" mode="detail"/>

        </fo:root>
    </xsl:template>

    <xsl:template name="header">
        <xsl:param name="right"/>
        <fo:static-content flow-name="tournament-header">
            <fo:block font-size="7pt" text-align-last="justify"> Archery Tournaments <fo:leader/>
                <xsl:value-of select="$right"/>
            </fo:block>
        </fo:static-content>
    </xsl:template>

    <xsl:template match="tournament" mode="toc">
        <fo:list-item>
            <fo:list-item-label>
                <fo:block><xsl:value-of select="position()"/>.</fo:block>
            </fo:list-item-label>
            <fo:list-item-body start-indent="4mm">
                <fo:block text-align-last="justify">
                    <xsl:value-of select="@name"/>
                    <fo:leader leader-pattern="dots"/>
                    <fo:page-number-citation ref-id="{generate-id()}"/>

                    <xsl:if test="event/participation/score">
                        <fo:list-block>
                            <xsl:apply-templates select="event" mode="toc"/>
                        </fo:list-block>
                    </xsl:if>
                </fo:block>
            </fo:list-item-body>
        </fo:list-item>
    </xsl:template>

    <xsl:template match="event" mode="toc">
        <xsl:if test="participation/score">
            <fo:list-item>
                <fo:list-item-label start-indent="4mm">
                    <fo:block>&#x2022;</fo:block>
                </fo:list-item-label>
                <fo:list-item-body start-indent="8mm">
                    <fo:block text-align-last="justify">
                        <xsl:value-of select="@title"/>
                        <fo:leader leader-pattern="dots"/>
                        <fo:page-number-citation ref-id="{generate-id()}"/>
                    </fo:block>
                </fo:list-item-body>
            </fo:list-item>
        </xsl:if>
    </xsl:template>

    <xsl:template match="tournament" mode="detail">
        <fo:page-sequence master-reference="tournament-page">
            <xsl:call-template name="header">
                <xsl:with-param name="right" select="@name"/>
            </xsl:call-template>

            <fo:static-content flow-name="tournament-footer">
                <fo:block font-size="7pt" text-align="end">
                    Page <fo:page-number/>
                </fo:block>
            </fo:static-content>

            <fo:flow flow-name="xsl-region-body" font-family="Times" font-size="9pt">
                <fo:block font-size="14pt" font-weight="bold" space-after="8pt" id="{generate-id()}">
                    <xsl:value-of select="@name"/>
                </fo:block>

                <xsl:apply-templates select="." mode="podium"/>
                <xsl:apply-templates select="event"/>
            </fo:flow>

        </fo:page-sequence>
    </xsl:template>

    <xsl:template match="tournament" mode="podium">
        <fo:list-block>
            <xsl:for-each select=".//application/@athlete-id">
                <xsl:sort
                    select="sum(ancestor::tournament/event/participation[@athlete-id = current()]/sum(score/sum(arrow)))"
                    order="descending" data-type="number"/>

                <fo:list-item>
                    <fo:list-item-label>
                        <fo:block>
                            <xsl:value-of select="position()"/>.
                        </fo:block>
                    </fo:list-item-label>
                    <fo:list-item-body start-indent="4mm">
                        <fo:block> Place (<xsl:value-of
                                select="sum(ancestor::tournament/event/participation[@athlete-id = current()]/sum(score/sum(arrow)))"
                            /> Points): <xsl:call-template name="athlete-name-by-id">
                                <xsl:with-param name="athlete-id" select="current()"/>
                            </xsl:call-template>
                        </fo:block>
                    </fo:list-item-body>
                </fo:list-item>
            </xsl:for-each>
        </fo:list-block>
    </xsl:template>

    <xsl:template match="event">
        <xsl:if test="participation/score">
            <fo:block font-size="12pt" font-weight="bold" space-before="8pt" id="{generate-id()}">
                <xsl:value-of select="@title"/>
            </fo:block>
        </xsl:if>
        <xsl:apply-templates select="participation"/>
    </xsl:template>

    <xsl:template match="participation">
        <xsl:variable name="athleteName">
            <xsl:call-template name="athlete-name-by-id">
                <xsl:with-param name="athlete-id" select="@athlete-id"/>
            </xsl:call-template>
        </xsl:variable>
        <xsl:variable name="arrowCount" select="max(score/count(arrow))"/>
        <xsl:variable name="cols" select="$arrowCount + 2"/>

        <xsl:if test="score">
            <fo:table border="0.5pt solid black" text-align="center" space-after="4pt">
                <fo:table-header>
                    <fo:table-row>
                        <fo:table-cell number-columns-spanned="5">
                            <fo:block font-weight="bold">
                                <xsl:value-of select="$athleteName"/>
                            </fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                    <fo:table-row>
                        <fo:table-cell border="0.5pt solid black">
                            <fo:block font-weight="bold">Target</fo:block>
                        </fo:table-cell>
                        <xsl:for-each select="1 to $arrowCount">
                            <fo:table-cell border="0.5pt solid black">
                                <fo:block font-weight="bold"> Arrow <xsl:value-of
                                        select="position()"/>
                                </fo:block>
                            </fo:table-cell>
                        </xsl:for-each>
                        <fo:table-cell border="0.5pt solid black">
                            <fo:block font-weight="bold">Total</fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                </fo:table-header>
                <fo:table-body>
                    <xsl:for-each select="score">
                        <fo:table-row>
                            <fo:table-cell border="0.5pt solid black">
                                <fo:block>
                                    <xsl:value-of select="position()"/>
                                </fo:block>
                            </fo:table-cell>
                            <xsl:for-each select="arrow">
                                <fo:table-cell border="0.5pt solid black">
                                    <fo:block>
                                        <xsl:value-of select="text()"/>
                                    </fo:block>
                                </fo:table-cell>
                            </xsl:for-each>
                            <fo:table-cell border="0.5pt solid black">
                                <fo:block>
                                    <xsl:value-of select="sum(arrow)"/>
                                </fo:block>
                            </fo:table-cell>
                        </fo:table-row>
                    </xsl:for-each>
                    <fo:table-row>
                        <fo:table-cell border="0.5pt solid black" number-columns-spanned="{$cols - 1}">
                            <fo:block/>
                        </fo:table-cell>
                        <fo:table-cell border="0.5pt solid black">
                            <fo:block font-weight="bold">
                                <xsl:value-of select="sum(score/sum(arrow))"/>
                            </fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                </fo:table-body>
            </fo:table>
            <br/>
        </xsl:if>
    </xsl:template>

    <xsl:template name="athlete-name-by-id">
        <xsl:param name="athlete-id"/>

        <xsl:for-each select="/archery-tournament/athlete">
            <xsl:if test="./@id = $athlete-id">
                <xsl:value-of select="@firstname"/>&#160;<xsl:value-of select="@lastname"/>
            </xsl:if>
        </xsl:for-each>
    </xsl:template>
</xsl:stylesheet>
