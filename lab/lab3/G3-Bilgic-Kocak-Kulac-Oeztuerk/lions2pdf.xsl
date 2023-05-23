<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    xmlns:fo="http://www.w3.org/1999/XSL/Format%22%3E">
    
    <xsl:template match="/lions">
        <fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format">
            <fo:layout-master-set>
                <fo:simple-page-master master-name="simple"
                    page-height="29.7cm"
                    page-width="21cm"
                    margin-top="1cm"
                    margin-bottom="4cm"
                    margin-left="2.5cm"
                    margin-right="2.5cm">
                    <fo:region-body margin-top="2cm"/>
                    <fo:region-before extent="3cm"/>
                    <fo:region-after extent="1.5cm"/>
                </fo:simple-page-master>
            </fo:layout-master-set>
            
            <fo:page-sequence master-reference="simple">
                <fo:static-content flow-name="xsl-region-after">
                    <fo:block text-align="right" margin-top="2cm">
                        Seite <fo:page-number/>
                    </fo:block>
                </fo:static-content>
                <fo:flow flow-name="xsl-region-body">
                    <fo:block font-size="20pt" font-weight="bold">
                        <xsl:value-of select="@name"/>
                    </fo:block>
                    <fo:block margin-top="1cm">
                        <fo:external-graphic src="url('file:///C:/Users/Lenovo/Downloads/lions.png')"
                            width="20pt"
                            height="30pt"/>
                    </fo:block>

                    <fo:block font-size="16pt" font-weight="bold" margin-top="7cm">
                        Inhaltsverzeichnis
                    </fo:block>
                    
                    <fo:list-block space-before="10pt">
                        <xsl:for-each select="team">
                            <fo:list-item>
                                <fo:list-item-label end-indent="label-end()">
                                    <fo:block text-align="start">
                                        <fo:inline font-weight="bold" color="green">
                                            <fo:basic-link internal-destination="{@id}">
                                                <xsl:value-of select="@type" />
                                            </fo:basic-link>
                                        </fo:inline>
                                    </fo:block>
                                </fo:list-item-label>
                                <fo:list-item-body start-indent="body-start()">
                                    <fo:block>
                                        <xsl:value-of select="id(@type)" />
                                        <fo:leader leader-pattern="dots" leader-length="100%" />
                                        <fo:page-number-citation ref-id="{@id}" />
                                    </fo:block>
                                </fo:list-item-body>
                            </fo:list-item>
                        </xsl:for-each>
                    </fo:list-block>
                    
                    <fo:block break-before="page">
                   
                        <xsl:for-each select="team">
                            <xsl:variable name="tid" select="@id" />
                            
                            <fo:block id="{$tid}" color="green" font-weight="bold" font-size="16pt" margin-bottom="1cm">
                                <xsl:value-of select="concat(@association, ' - Geschlecht: ', @gender, ' - Kategorie: ', @type)" />
                            </fo:block>
                            
                            <fo:block>
                                <xsl:for-each select="match">
                                    <xsl:variable name="mid" select="@id" />
                                    
                                    <fo:block id="{$mid}" font-style="italic" margin-bottom="1cm">
                                        <xsl:value-of select="concat(@date, ' -> ', @hall, ' in ', @city)" />
                                    </fo:block>
                                    
                                    <fo:block font-weight="bold" margin-bottom="1cm">Winner Team</fo:block>
                                    <fo:table>
                                        <fo:table-column column-width="auto" />
                                        <fo:table-column column-width="auto" />
                                        <fo:table-column column-width="auto" />
                                        <fo:table-column column-width="auto" />
                                        
                                        <fo:table-header>
                                            <fo:table-row>
                                                <fo:table-cell padding="5pt" background-color="#E0E3BE">
                                                    <fo:block font-weight="bold">ID</fo:block>
                                                </fo:table-cell>
                                                <fo:table-cell padding="5pt" background-color="#E0E3BE">
                                                    <fo:block font-weight="bold">Spieler</fo:block>
                                                </fo:table-cell>
                                                <fo:table-cell padding="5pt" background-color="#E0E3BE">
                                                    <fo:block font-weight="bold">Wurfposition</fo:block>
                                                </fo:table-cell>
                                                <fo:table-cell padding="5pt" background-color="#E0E3BE">
                                                    <fo:block font-weight="bold">Punkte</fo:block>
                                                </fo:table-cell>
                                            </fo:table-row>
                                        </fo:table-header>
                                        
                                        <fo:table-body >
                                            <xsl:for-each select="winner-team/scoreboard">
                                                <fo:table-row>
                                                    <fo:table-cell padding="5pt">
                                                        <fo:block id="{@player-id}">
                                                            <xsl:value-of select="@player-id" />
                                                        </fo:block>
                                                    </fo:table-cell>
                                                    <fo:table-cell padding="5pt">
                                                        <fo:block>
                                                            <xsl:value-of select="concat(id(@player-id)/@firstname, ' ', id(@player-id)/@lastname)" />
                                                        </fo:block>
                                                    </fo:table-cell>
                                                    <fo:table-cell padding="5pt">
                                                        <fo:block>
                                                            <xsl:value-of select="shooting-style/@description" />
                                                        </fo:block>
                                                    </fo:table-cell>
                                                    <fo:table-cell padding="5pt">
                                                        <fo:block>
                                                            <xsl:value-of select="shooting-style/@point" />
                                                        </fo:block>
                                                    </fo:table-cell>
                                                </fo:table-row>
                                            </xsl:for-each>
                                        </fo:table-body>
                                    </fo:table>
                                    
                                    <fo:block font-weight="bold" margin-top="2cm" margin-bottom="1cm">Loser Team</fo:block>
                                    <fo:table>
                                        <fo:table-column column-width="auto" />
                                        <fo:table-column column-width="auto" />
                                        <fo:table-column column-width="auto" />
                                        <fo:table-column column-width="auto" />
                                        
                                        <fo:table-header>
                                            <fo:table-row>
                                                <fo:table-cell padding="5pt" background-color="#E0E3BE">
                                                    <fo:block font-weight="bold">ID</fo:block>
                                                </fo:table-cell>
                                                <fo:table-cell padding="5pt" background-color="#E0E3BE">
                                                    <fo:block font-weight="bold">Spieler</fo:block>
                                                </fo:table-cell>
                                                <fo:table-cell padding="5pt" background-color="#E0E3BE">
                                                    <fo:block font-weight="bold">Wurfposition</fo:block>
                                                </fo:table-cell>
                                                <fo:table-cell padding="5pt" background-color="#E0E3BE">
                                                    <fo:block font-weight="bold">Punkte</fo:block>
                                                </fo:table-cell>
                                            </fo:table-row>
                                        </fo:table-header>
                                        
                                        <fo:table-body>
                                            <xsl:for-each select="loser-team/scoreboard">
                                                <fo:table-row>
                                                    <fo:table-cell>
                                                        <fo:block id="{@player-id}">
                                                            <xsl:value-of select="@player-id" />
                                                        </fo:block>
                                                    </fo:table-cell>
                                                    <fo:table-cell>
                                                        <fo:block>
                                                            <fo:basic-link internal-destination="{@player-id}">
                                                                <xsl:value-of select="concat(id(@player-id)/@firstname, ' ', id(@player-id)/@lastname)"/>
                                                            </fo:basic-link>
                                                        </fo:block>
                                                    </fo:table-cell>
                                                    
                                                    <fo:table-cell padding="5pt">
                                                        <fo:block>
                                                            <xsl:value-of select="shooting-style/@description" />
                                                        </fo:block>
                                                    </fo:table-cell>
                                                    <fo:table-cell padding="5pt">
                                                        <fo:block>
                                                            <xsl:value-of select="shooting-style/@point" />
                                                        </fo:block>
                                                    </fo:table-cell>
                                                </fo:table-row>
                                            </xsl:for-each>
                                        </fo:table-body>
                                    </fo:table>
                                    
                                    <fo:block break-before="page" />
                                </xsl:for-each>
                            </fo:block>
                        </xsl:for-each>
                    </fo:block>
                   
                    <fo:block font-size="18pt" font-weight="bold" margin-top="2cm" >
                        Spieler
                    </fo:block>
                    
                        <xsl:for-each select="//scoreboard">
                            <xsl:sort select="concat(id(@player-id)/@firstname, ' ', id(@player-id)/@lastname)" />
                            <fo:block>
                                <fo:basic-link internal-destination="{@player-id}">
                                    <xsl:value-of select="concat(id(@player-id)/@firstname, ' ', id(@player-id)/@lastname)"/>
                                </fo:basic-link>
                            </fo:block>
                        </xsl:for-each>
                    
                    
                    
                  
                    
                    
                    
                </fo:flow>
            </fo:page-sequence>
        </fo:root>
    </xsl:template>
</xsl:stylesheet>