<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format">
   
    <xsl:template match="/tournament">
        <fo:root>
            <!-- define the layout of the document -->
            <fo:layout-master-set>
                <!-- here we define the layout of pages. There might be differrent page masters with e.g. different margin settings -->
                <fo:simple-page-master master-name="tournament"
                    page-height="297.0mm" page-width="209.9mm"
                    margin-bottom="8mm" margin-left="25mm" margin-right="10mm" margin-top="10mm">
                    
                    <!-- the content will be placed into the region-body -->
                    <fo:region-body margin-bottom="28mm" margin-left="0mm" margin-right="20mm" margin-top="0mm"/>
                    <fo:region-before extent="10mm"/>
                    <fo:region-after extent="10mm" region-name="tournament-footer"/>
                </fo:simple-page-master>
            </fo:layout-master-set>
                 
            <fo:page-sequence master-reference="tournament">
                <fo:flow flow-name="xsl-region-body" font-family="Times" font-size="9pt"  background-color="#F0F0F0">
                    <fo:block margin-top="60mm" font-size="28pt">
                        World Archery Championship 2022
                    </fo:block>
                </fo:flow>
            </fo:page-sequence>
            
            <fo:page-sequence master-reference="tournament">
                <!-- place the table of contents into region-body -->
                <fo:flow flow-name="xsl-region-body" font-family="Times" font-size="9pt">
                    <fo:block font-size="30pt" font-weight="bold" margin-top="40mm">Table of Contents</fo:block>
                    <fo:list-block space-before="36pt">
                        <fo:list-item>
                            <fo:list-item-label>
                                <fo:block font-size="16pt" font-weight="bold">1</fo:block>
                            </fo:list-item-label>
                            <fo:list-item-body start-indent="4mm">
                                <fo:block font-size="16pt" margin-left="2mm" text-align-last="justify">
                                    <fo:inline font-weight="bold">Parcours </fo:inline>
                                    <fo:page-number-citation ref-id="{generate-id()}"/>    
                                </fo:block>
                            </fo:list-item-body>
                        </fo:list-item>
                        <xsl:apply-templates select="parcour" mode="toc"/>
                        
                        <fo:list-item space-before="24pt">
                            <fo:list-item-label>
                                <fo:block font-size="16pt" font-weight="bold">2</fo:block>
                            </fo:list-item-label>
                            <fo:list-item-body start-indent="4mm">
                                <fo:block font-size="16pt" margin-left="2mm" text-align-last="justify">
                                    <fo:inline font-weight="bold">Groups </fo:inline>
                                    <fo:page-number-citation ref-id="{generate-id()}"/>
                                </fo:block>
                            </fo:list-item-body>
                        </fo:list-item>
                        <xsl:apply-templates select="group" mode="toc"/>
                        
                        <fo:list-item space-before="24pt">
                            <fo:list-item-label>
                                <fo:block font-size="16pt" font-weight="bold">3</fo:block>
                            </fo:list-item-label>
                            <fo:list-item-body start-indent="4mm">
                                <fo:block font-size="16pt" text-align-last="justify">
                                    <fo:inline margin-left="5mm" font-weight="bold">Scoreboards </fo:inline>
                                    <fo:page-number-citation ref-id="{generate-id()}"/>
                                </fo:block>
                            </fo:list-item-body>
                        </fo:list-item>
                        <xsl:apply-templates select="scoreboard" mode="toc"/>
                    </fo:list-block>
                </fo:flow>
            </fo:page-sequence>
            
            <fo:page-sequence master-reference="tournament">
                <fo:static-content flow-name="tournament-footer">
                    <fo:block font-size="10pt" text-align="end" margin-right="10mm">
                        page <fo:page-number/>
                    </fo:block>
                </fo:static-content>
                <fo:flow flow-name="xsl-region-body" font-family="Times">
                    <fo:block margin-top="20mm" font-size="28pt" font-weight="800">
                        Parcours
                    </fo:block>
                    <fo:block>
                        <xsl:apply-templates select="parcour" mode="details"/>
                    </fo:block>
                </fo:flow>
            </fo:page-sequence>
            
            <fo:page-sequence master-reference="tournament">
                <fo:static-content flow-name="tournament-footer">
                    <fo:block font-size="10pt" text-align="end" margin-right="10mm">
                        page <fo:page-number/>
                    </fo:block>
                </fo:static-content>
                <fo:flow flow-name="xsl-region-body" font-family="Times">
                    <fo:block margin-top="20mm" font-size="28pt" font-weight="800">
                        Groups
                    </fo:block>
                    <fo:block>
                        <xsl:apply-templates select="group" mode="details"/>
                    </fo:block>
                </fo:flow>
            </fo:page-sequence>
            
            <fo:page-sequence master-reference="tournament">
                <fo:static-content flow-name="tournament-footer">
                    <fo:block font-size="10pt" text-align="end" margin-right="10mm">
                        page <fo:page-number/>
                    </fo:block>
                </fo:static-content>
                <fo:flow flow-name="xsl-region-body" font-family="Times">
                    <fo:block margin-top="20mm" font-size="28pt" font-weight="800">
                        Groups
                    </fo:block>
                    <fo:block>
                        <xsl:apply-templates select="scoreboard" mode="table"/>
                    </fo:block>
                </fo:flow>
            </fo:page-sequence>
            
        </fo:root>
    </xsl:template>
    
    
    <xsl:template match="parcour" mode="toc">
        
        <fo:list-item>
            <fo:list-item-label>
                <fo:block font-size="20">1.<xsl:value-of select="position()"/></fo:block>
            </fo:list-item-label>
            <fo:list-item-body start-indent="8mm">
                <fo:block font-size="20" margin-left="10" text-align-last="justify">
                    <xsl:value-of select="@title"/>
                    <fo:leader leader-pattern="dots"/>
                    S. <fo:page-number-citation ref-id="{generate-id()}"/>
                </fo:block>
            </fo:list-item-body>
        </fo:list-item>
    </xsl:template>
    
    <xsl:template match="group" mode="toc">
        <fo:list-item>
            <fo:list-item-label>
                <fo:block font-size="20">2.<xsl:value-of select="position()"/>.</fo:block>
            </fo:list-item-label>
            <fo:list-item-body start-indent="8mm">
                <fo:block font-size="20" margin-left="10" text-align-last="justify"> Group <xsl:value-of select="@id"/>
                    (<xsl:value-of select="@class"/>, <xsl:value-of select="@division"/>)
                    <fo:leader leader-pattern="dots"/>
                    S. <fo:page-number-citation ref-id="{generate-id()}"/>
                </fo:block>
            </fo:list-item-body>
        </fo:list-item>
    </xsl:template>
    
    <xsl:template match="scoreboard" mode="toc">
        <fo:list-item>
            <fo:list-item-label>
                <fo:block font-size="20">3.<xsl:value-of select="position()"/></fo:block>
            </fo:list-item-label>
            <fo:list-item-body start-indent="8mm">
                <fo:block font-size="20" margin-left="10" text-align-last="justify">
                    <xsl:variable name="pid" select="@parcourid"/>
                    Group <xsl:value-of select="@groupid"/> on parcour <xsl:value-of select="//parcour[@id = $pid]/@title"/>
                    <fo:leader leader-pattern="dots"/>
                    S. <fo:page-number-citation ref-id="{generate-id()}"/>
                </fo:block>
            </fo:list-item-body>
        </fo:list-item>
    </xsl:template>
    
    
    <xsl:template match="parcour" mode="details">        
        <fo:block padding-top="25pt" padding-bottom="10pt" font-size="20pt" font-weight="bold" id="{generate-id()}">
            <xsl:value-of select="@title"/>
        </fo:block>
        
        <fo:block start-indent="20mm" padding-left="10pt" border-left="solid 2pt black">
            <fo:inline font-size="14pt" font-weight="bold">Targets:</fo:inline>
            <xsl:for-each select="target">
                <fo:block font-size="12pt">
                    Distance: <xsl:value-of select="@distance"/> m
                    <fo:leader leader-pattern="rule" leader-length="20mm"/>
                    Size: <xsl:value-of select="@size"/> cm
                </fo:block>
            </xsl:for-each>
        </fo:block>
    </xsl:template>
    
    
    <xsl:template match="group" mode="details">        
        <fo:block padding-top="20pt" padding-bottom="5pt" font-size="20pt" font-weight="bold" id="{generate-id()}">
            Group <xsl:value-of select="@id"/>: <xsl:value-of select="@class"/>, <xsl:value-of select="@division"/>
        </fo:block>
        <fo:block start-indent="20mm" padding-left="10pt" border-left="solid 2pt black">
            <fo:inline font-size="14pt" font-weight="bold">Members:</fo:inline>
            <xsl:for-each select="member" xml:space="preserve">
                <fo:block start-indent="25mm" font-size="11pt">
                    <xsl:variable name="aid" select="@archerid"/>
                    <xsl:value-of select="//archer[@id=$aid]/fname/text()"/>
                    <xsl:value-of select="//archer[@id=$aid]/lname/text()"/>
                    <fo:list-block>
                        <fo:list-item>
                            <fo:list-item-label>
                                <fo:block>--</fo:block>
                            </fo:list-item-label>
                            <fo:list-item-body start-indent="30mm">
                                <fo:block>Country: <xsl:value-of select="//archer[@id=$aid]/nationality"/></fo:block>
                            </fo:list-item-body>
                        </fo:list-item>
                        <fo:list-item>
                            <fo:list-item-label>
                                <fo:block>--</fo:block>
                            </fo:list-item-label>
                            <fo:list-item-body start-indent="30mm">
                                <fo:block>Birthdate: <xsl:value-of select="//archer[@id=$aid]/birthdate"/></fo:block>
                            </fo:list-item-body>
                        </fo:list-item>
                    </fo:list-block>
                </fo:block>
            </xsl:for-each>
        </fo:block>
    </xsl:template>


    <xsl:template match="scoreboard" mode="table">
        <xsl:variable name="pid" select="@parcourid"/>        
        <fo:block font-size="18pt" font-weight="bold" margin-top="30pt" margin-bottom="15pt" id="{generate-id()}">
            Scoreboard for group <xsl:value-of select="@groupid"/> on parcour <xsl:value-of select="//parcour[@id = $pid]/@title"/>:
        </fo:block>
        <fo:block>
            <fo:table table-layout="auto" border="black solid 2px" text-align="center" display-align="center">
                <fo:table-header font-weight="600">
                    <fo:table-row min-height="35pt" border-bottom="black double 4px" >
                        <fo:table-cell border="black solid 1px" border-right="black double 4px" width="60pt">
                            <fo:block>Target</fo:block>
                        </fo:table-cell>
                        
                        <xsl:for-each select="shooting-target[position() = 1]/score">
                            <xsl:variable name="aid" select="@archerid"/>
                            <fo:table-cell border="black solid 1px" min-width="90pt">
                                <fo:block>
                                    <xsl:value-of select="//archer[@id = $aid]/fname/text()"/>&#x2028;
                                    <xsl:value-of select="//archer[@id = $aid]/lname/text()"/>
                                </fo:block>
                            </fo:table-cell>
                        </xsl:for-each>
                    </fo:table-row>
                </fo:table-header>
                
                <fo:table-body>
                    <xsl:for-each select="shooting-target">
                        <fo:table-row min-height="35pt">
                            <!-- first column (target number) -->
                            <fo:table-cell border="black solid 1px" border-right="black double 4px">
                                <fo:block><xsl:value-of select="substring(@targetid, string-length(@targetid)-1)"/></fo:block>
                            </fo:table-cell>
                            <!-- other columns (player scores ) -->
                            <xsl:for-each select="score">
                                <fo:table-cell border="black solid 1px">
                                    <fo:block>
                                        <!-- display detailed scores on hover of table cell -->
                                        <fo:block color="grey">
                                             <xsl:for-each select="shot">
                                                <xsl:value-of select="@points"/> 
                                                <xsl:if test="position()!=last()"> + </xsl:if>
                                             </xsl:for-each>
                                        </fo:block>
                                        <!-- the sum of the points -->
                                        <fo:inline><xsl:value-of select="sum(shot/@points)"/></fo:inline>
                                    </fo:block>
                                </fo:table-cell>				
                            </xsl:for-each>
                        </fo:table-row>				
                    </xsl:for-each>
                </fo:table-body>
            </fo:table>
            
        </fo:block>
    </xsl:template>

</xsl:stylesheet>