<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
    xmlns:fo="http://www.w3.org/1999/XSL/Format"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    
    <xsl:template match="/">
        <fo:root>
            <!-- HEADER -->
            <fo:layout-master-set>
                <!-- layout for A4 -->
                <fo:simple-page-master master-name="wfac-page"
                    page-height="297.0mm" page-width="209.9mm"
                    margin-bottom="8mm" margin-left="25mm" margin-right="10mm" margin-top="10mm">
                    
                    <fo:region-body margin-bottom="28mm" margin-left="0mm" margin-right="44mm" margin-top="20mm"/>
                    
                    <!-- define header and footer -->
                    <fo:region-before extent="24pt" region-name="wfac-header" />
                    <fo:region-after extent="24pt" region-name="wfac-footer" />
                </fo:simple-page-master>
            </fo:layout-master-set>
            
            <!-- CONTENT -->
            <!-- Title -->
            <fo:page-sequence master-reference="wfac-page" font-family="Times" font-size="9pt">
                <fo:flow flow-name="xsl-region-body">
                    <fo:block margin-top="90mm" font-size="36pt">
                        <fo:inline font-weight="bold">WFAC Scorecards</fo:inline>
                    </fo:block>
                    <fo:block font-size="18pt">
                        <fo:inline>World Field Archery Championship 2021</fo:inline>
                    </fo:block>
                </fo:flow>
            </fo:page-sequence>
            
            <!-- Inhaltsverzeichnis -->
            <fo:page-sequence master-reference="wfac-page" font-family="Times" font-size="9pt">
                <fo:flow flow-name="xsl-region-body">
                    <fo:block font-size="14pt" font-weight="bold" space-after="12pt">
                        Table of Contents
                    </fo:block>
                    <xsl:for-each select="wfac/group">
                        <fo:list-block>
                            <fo:list-item>
                                <fo:list-item-label>
                                    <fo:block>
                                        <xsl:value-of select="position()">
                                        </xsl:value-of>.
                                    </fo:block>
                                </fo:list-item-label>
                                <fo:list-item-body>
                                    <fo:block start-indent="4mm" text-align-last="justify">
                                        <fo:basic-link internal-destination="{@group-id}">
                                            Group <xsl:value-of select="@group-id" /> -
                                            <xsl:value-of select="@date"/>
                                        </fo:basic-link>
                                        <fo:leader leader-pattern="dots" />
                                        <fo:page-number-citation ref-id="{@group-id}" />
                                    </fo:block>                                    
                                </fo:list-item-body>
                            </fo:list-item>
                        </fo:list-block>
                    </xsl:for-each>
                </fo:flow>
            </fo:page-sequence>
            
            <!-- Groups -->
            <fo:page-sequence master-reference="wfac-page" font-family="Times" font-size="9pt">
                <fo:flow flow-name="xsl-region-body">
                    <fo:block font-size="24pt">
                        <fo:inline font-weight="bold">Groups</fo:inline>
                    </fo:block>
                    <xsl:for-each select="wfac/group" xml:space="preserve">
                        <fo:block font-size="10pt" space-before="12pt" id="{@group-id}">
                            <fo:inline font-weight="bold"><xsl:value-of select="@group-id"/> am <xsl:value-of select="@date"/></fo:inline>
                        </fo:block>
                        
                        <fo:table>
                            <fo:table-header font-weight="bold" background-color="#d1d1d1">
                                <fo:table-row>
                                    <fo:table-cell border="0.5pt solid black" padding="1pt" text-align="center">
                                        <fo:block>
                                            Function
                                        </fo:block>
                                    </fo:table-cell>
                                    <fo:table-cell border="0.5pt solid black" padding="1pt" text-align="center">
                                        <fo:block>
                                            Name
                                        </fo:block>
                                    </fo:table-cell>
                                    <fo:table-cell border="0.5pt solid black" padding="1pt" text-align="center">
                                        <fo:block>
                                            Scorecard
                                        </fo:block>
                                    </fo:table-cell>
                                </fo:table-row>
                            </fo:table-header>
                            <fo:table-body>
                                <xsl:for-each select="participant" xml:space="preserve">
                                    <xsl:variable name="p" select="id(@registration-id)"/>
                                    <fo:table-row>
                                        <fo:table-cell border="0.5pt solid black" padding="1pt" text-align="center"><fo:block><xsl:value-of select="@role"/></fo:block></fo:table-cell>
                                        <fo:table-cell border="0.5pt solid black" padding="1pt" text-align="center"><fo:block><xsl:value-of select="$p/@fname"/> <xsl:value-of select="$p/@lname"/></fo:block></fo:table-cell>
                                        <fo:table-cell border="0.5pt solid black" padding="1pt" text-align="center"><fo:block><fo:basic-link internal-destination="{scorecard/@scorecard-id}"><xsl:value-of select="scorecard/@scorecard-id"/></fo:basic-link></fo:block></fo:table-cell>
                                    </fo:table-row>
                                </xsl:for-each>
                            </fo:table-body>
                        </fo:table>
                    </xsl:for-each>
                    
                </fo:flow>
            </fo:page-sequence>
            
            <fo:page-sequence master-reference="wfac-page" font-family="Times" font-size="9pt">
                <fo:flow flow-name="xsl-region-body">
                    <fo:block font-size="24pt">
                        <fo:inline font-weight="bold">Scorecards</fo:inline>
                    </fo:block>
                    <xsl:for-each select="wfac/group/participant" xml:space="preserve">
                        <xsl:variable name="p" select="id(@registration-id)"/>
                        <fo:block font-size="10pt" space-before="12pt" id="{scorecard/@scorecard-id}">
                            <fo:inline font-weight="bold">Card-ID: <xsl:value-of select="scorecard/@scorecard-id"/> - <xsl:value-of select="$p/@fname"/> <xsl:value-of select="$p/@lname"/></fo:inline>
                        </fo:block>
                        
                        <fo:table>
                            <fo:table-header font-weight="bold" background-color="#d1d1d1">
                                <fo:table-row>
                                    <fo:table-cell border="0.5pt solid black" padding="1pt" text-align="center">
                                        <fo:block>
                                            Target
                                        </fo:block>
                                    </fo:table-cell>
                                    <fo:table-cell border="0.5pt solid black" padding="1pt" text-align="center">
                                        <fo:block>
                                            Arrow 1
                                        </fo:block>
                                    </fo:table-cell>
                                    <fo:table-cell border="0.5pt solid black" padding="1pt" text-align="center">
                                        <fo:block>
                                            Arrow 2
                                        </fo:block>
                                    </fo:table-cell>
                                    <fo:table-cell border="0.5pt solid black" padding="1pt" text-align="center">
                                        <fo:block>
                                            Arrow 3
                                        </fo:block>
                                    </fo:table-cell>
                                    <fo:table-cell border="0.5pt solid black" padding="1pt" text-align="center">
                                        <fo:block>
                                            Arrow 4
                                        </fo:block>
                                    </fo:table-cell>
                                </fo:table-row>
                            </fo:table-header>
                            <fo:table-body>
                                <fo:table-row>
                                    <fo:table-cell border="0.5pt solid black" padding="1pt" text-align="center"><fo:block>Target 1</fo:block></fo:table-cell>
                                    <xsl:for-each select="scorecard/scorecard-entry[@target-id = 'target-1']" xml:space="preserve">
                                        <fo:table-cell border="0.5pt solid black" padding="1pt" text-align="center"><fo:block><xsl:value-of select="@score"/></fo:block></fo:table-cell>
                                    </xsl:for-each>
                                </fo:table-row>
                                
                                
                                <fo:table-row>
                                    <fo:table-cell border="0.5pt solid black" padding="1pt" text-align="center"><fo:block>Target 1</fo:block></fo:table-cell>
                                    <xsl:for-each select="scorecard/scorecard-entry[@target-id = 'target-1']" xml:space="preserve">
                                        <fo:table-cell border="0.5pt solid black" padding="1pt" text-align="center"><fo:block><xsl:value-of select="@score"/></fo:block></fo:table-cell>
                                    </xsl:for-each>
                                </fo:table-row>
                                
                                <xsl:if test="scorecard/scorecard-entry[@target-id = 'target-3']">
                                    <fo:table-row>
                                        <fo:table-cell border="0.5pt solid black" padding="1pt" text-align="center"><fo:block>Target 1</fo:block></fo:table-cell>
                                        <xsl:for-each select="scorecard/scorecard-entry[@target-id = 'target-1']" xml:space="preserve">
                                            <fo:table-cell border="0.5pt solid black" padding="1pt" text-align="center"><fo:block><xsl:value-of select="@score"/></fo:block></fo:table-cell>
                                        </xsl:for-each>
                                    </fo:table-row>
                                </xsl:if>
                                
                                
                            </fo:table-body>
                        </fo:table>
                    </xsl:for-each>
                </fo:flow>
            </fo:page-sequence>
        </fo:root>
    </xsl:template>
</xsl:stylesheet>