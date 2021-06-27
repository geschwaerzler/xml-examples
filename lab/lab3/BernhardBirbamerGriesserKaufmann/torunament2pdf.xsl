<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format">
    <xsl:template match="/tournament">
    
        <fo:root>
            <!-- define the layout of the document -->
            <fo:layout-master-set>
                <!-- here we define the layout of pages. There might be differrent page masters with e.g. different margin settings -->
                <fo:simple-page-master master-name="tournament-page"
                    page-height="297.0mm" page-width="209.9mm"
                    margin-bottom="8mm" margin-left="25mm" margin-right="10mm" margin-top="10mm">
                    
                    <!-- the content will be placed into the region-body -->
                    <fo:region-body margin-bottom="28mm" margin-left="0mm" margin-right="44mm" margin-top="10mm"/>
                    
                    <!-- region-before is the page header -->
                    <fo:region-before extent="24pt" region-name="tournament-header"/>
                    
                    <!-- region-after is the page footer -->
                    <fo:region-after extent="24pt" region-name="tournament-footer"/>
                    
                </fo:simple-page-master>
            </fo:layout-master-set>
            
            <!-- Printed content consists of one or more page-sequences. Each page-sequence starts on a new page. -->
            
            <!-- front page -->
            <fo:page-sequence master-reference="tournament-page">
                <fo:flow flow-name="xsl-region-body" font-family="Arial" font-size="28pt">
                    <fo:block margin-top="20mm">
                        WFAC Tournament 2021
                    </fo:block>
                </fo:flow>
            </fo:page-sequence>
            
            <!-- table of contents -->
            <fo:page-sequence master-reference="tournament-page">
                <!-- place a page description into the page header -->
                <xsl:call-template name="header">
                    <xsl:with-param name="param" select="'Table of Contents'"/>
                </xsl:call-template>
                
                <!-- place the table of contents into region-body -->
                <fo:flow flow-name="xsl-region-body" font-family="Arial" font-size="14pt">
                    <fo:block font-weight="bold" margin-top="20mm">Table of Contents</fo:block>
                    <fo:list-block space-before="10pt">
                        <xsl:apply-templates select="event" mode="table-of-contents"/>
                    </fo:list-block>
                </fo:flow>
            </fo:page-sequence>
            
            <!-- events -->
            <fo:page-sequence master-reference="tournament-page">
                <!-- place a page description into the page header -->
                <xsl:call-template name="header">
                    <xsl:with-param name="param" select="'Events'"/>
                </xsl:call-template>
                
                <fo:static-content flow-name="tournament-footer">
                    <fo:block font-size="7pt" text-align="end">
                        page <fo:page-number/>
                    </fo:block>
                </fo:static-content>
                
                <!-- place the events into region-body -->
                <fo:flow flow-name="xsl-region-body" font-family="Arial" font-size="14pt">
                    <fo:block margin-top="10mm">
                        <xsl:apply-templates select="event" mode="detail"/>
                    </fo:block>
                </fo:flow>
            </fo:page-sequence>
            
            <!-- participant scoring -->
            <fo:page-sequence master-reference="tournament-page">
                <!-- place a page description into the page header -->
                <xsl:call-template name="header">
                    <xsl:with-param name="param" select="'Scoring of participants'"/>
                </xsl:call-template>
                
                <fo:static-content flow-name="tournament-footer">
                    <fo:block font-size="7pt" text-align="end">
                        page <fo:page-number/>
                    </fo:block>
                </fo:static-content>
                
                <!-- place the scoring of participants into region-body -->
                <fo:flow flow-name="xsl-region-body" font-family="Arial" font-size="14pt">
                    <fo:block font-weight="bold" margin-top="10mm">Scoring of participants</fo:block>
                    <fo:block space-before="10pt">
                        <xsl:apply-templates select="participant" mode="scoring"/>
                    </fo:block>
                </fo:flow>
            </fo:page-sequence>
            
        </fo:root>
       
    </xsl:template>
    
    <!-- Templates -->
    
    <xsl:template name="header">
        <xsl:param name="param"/>
        <!-- page header: left: booklet title; left: recipe title -->
        <fo:static-content flow-name="tournament-header">
            <fo:block font-size="7pt" text-align-last="justify">
                <xsl:value-of select="/event"/>
                <fo:leader/>
                <xsl:value-of select="$param"/>
            </fo:block>
        </fo:static-content>        
    </xsl:template>
    
    <xsl:template match="event" mode="table-of-contents">        
        <fo:list-item font-size="9pt">
            <fo:list-item-label>
                <fo:block><xsl:value-of select="position()"/>.</fo:block>
            </fo:list-item-label>
            <fo:list-item-body start-indent="4mm">
                <fo:block text-align-last="justify">
                    <xsl:value-of select="@id"/> &#160; <xsl:value-of select="@date"/>
                    <fo:leader leader-pattern="dots"></fo:leader>
                    <fo:page-number-citation ref-id="{generate-id()}"/>
                </fo:block>
            </fo:list-item-body>
        </fo:list-item>
    </xsl:template>
    
    <xsl:template match="event" mode="detail" xml:space="preserve">
        <fo:block font-size="16pt" id="{generate-id()}">
            <fo:block font-weight="bold">
                <xsl:value-of select="@id"/>
                <xsl:value-of select="@date"/>
            </fo:block>
            <fo:block font-size="9pt">
              <xsl:apply-templates select="../division" mode="default">
              	<xsl:with-param name="event-id" select="@id"/>
              </xsl:apply-templates>
            </fo:block>
            <fo:table space-before="5pt">
                <fo:table-header font-size="12pt" font-weight="bold">
                    <fo:table-row>
                        <fo:table-cell>
                            <fo:block><xsl:value-of select="@id"/> Scoring</fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                </fo:table-header>
                <fo:table-body font-size="9pt">
                    <xsl:variable name="e-id" select="@id"/>
                    <xsl:apply-templates select="../participant" mode="scoring-daily">
                        <xsl:with-param name="event-id" select="@id"/>
                        <xsl:sort select="sum(match[@event-id = $e-id]/scoring/table/arrow/@points)" data-type="number" order="descending"/>
                    </xsl:apply-templates>
                </fo:table-body>
             </fo:table>
        </fo:block>
        <fo:block>
            <fo:leader leader-pattern="rule" leader-length="70%" rule-style="dotted" rule-thickness="2pt"/>
        </fo:block>
    </xsl:template>
    
    <xsl:template match="division" mode="default">
        <xsl:param name="event-id"/>
        <fo:block font-size="12pt" font-weight="bold" space-before="5pt">
            <xsl:value-of select="@id"/>
        </fo:block>
        <fo:table>
            <fo:table-header>
                <fo:table-row>
                    <fo:table-cell>
                        <fo:block>Vorname</fo:block>
                    </fo:table-cell>
                    <fo:table-cell>
                        <fo:block>Nachname</fo:block>
                    </fo:table-cell>
                    <fo:table-cell>
                        <fo:block>Points</fo:block>
                    </fo:table-cell>
                </fo:table-row>
            </fo:table-header>
            <fo:table-body>
                <xsl:apply-templates select="../participant" mode="division">
                    <xsl:with-param name="division-id" select="@id"/>
                    <xsl:with-param name="event-id" select="$event-id"/>
                </xsl:apply-templates>
            </fo:table-body>
        </fo:table>
    </xsl:template>
    
    <xsl:template match="participant" mode="scoring-daily">
        <xsl:param name="event-id"/>
        <fo:table-row>
            <fo:table-cell>
                <fo:block>
                    <xsl:value-of select="@fname"/>
                </fo:block>
            </fo:table-cell>
            <fo:table-cell>
                <fo:block>
                    <xsl:value-of select="@lname"/>
                </fo:block>
            </fo:table-cell>
            <fo:table-cell>
                <fo:block>
                    <xsl:value-of select="sum(./match[@event-id = $event-id]/scoring/table/arrow/@points)"/>
                </fo:block>
            </fo:table-cell>
        </fo:table-row>
    </xsl:template>
    
    <xsl:template match="participant" mode="division">
        <xsl:param name="division-id"/>
        <xsl:param name="event-id"/>
        <xsl:if test="(@div-id = $division-id) and (match/@event-id = $event-id)">
            <fo:table-row>
                <fo:table-cell>
                    <fo:block>
                        <xsl:value-of select="@fname"/>
                    </fo:block>
                </fo:table-cell>
                <fo:table-cell>
                    <fo:block>
                        <xsl:value-of select="@lname"/>
                    </fo:block>
                </fo:table-cell>
                <fo:table-cell>
                    <fo:block>
                        <xsl:value-of select="sum(./match[@event-id = $event-id]/scoring/table/arrow/@points)"/>
                    </fo:block>
                </fo:table-cell>
            </fo:table-row>
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="participant" mode="scoring">
        <fo:block space-before="5pt" font-weight="bold">
            <xsl:value-of select="@fname"/> &#160; <xsl:value-of select="@lname"/>
        </fo:block>
        <fo:block font-size="9pt">
            <xsl:apply-templates select="match"/>
        </fo:block>
    </xsl:template>
    
    <xsl:template match="match">
        <fo:block space-before="5pt" font-size="11pt" font-weight="bold">
            <xsl:value-of select="@event-id"/>
        </fo:block>
        &#xa;
        <xsl:apply-templates select="scoring"/>
    </xsl:template>
    
    <xsl:template match="scoring">
        <fo:table space-after="5pt">
            <fo:table-header>
                <fo:table-cell>
                    <fo:block>
                        target#
                    </fo:block>
                </fo:table-cell>
                <xsl:for-each select="table[1]/arrow">
                    <fo:table-cell>
                        <fo:block>
                            arrow: &#160;
                            <xsl:value-of select="@arrow-nr"/>
                        </fo:block>
                    </fo:table-cell>
                </xsl:for-each>
            </fo:table-header>
            <fo:table-body>
                <xsl:for-each select="table">
                      <fo:table-row>
                          <fo:table-cell>
                              <fo:block>
                                  <xsl:value-of select="@target-id"/>
                              </fo:block>
                          </fo:table-cell>
                      <xsl:for-each select="arrow">
                          <fo:table-cell>
                              <fo:block>
                                  <xsl:value-of select="@points"/>
                              </fo:block>
                          </fo:table-cell>
                      </xsl:for-each>
                    </fo:table-row>
                </xsl:for-each>
            </fo:table-body>
        </fo:table>
    </xsl:template>
    
</xsl:stylesheet>