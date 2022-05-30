<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format">
    
    
    <!-- ............................ ROOT TEMPLATE .......................... -->
    <xsl:template match="/archery-tournament">
        <fo:root>
            
            <!-- define the layout of the document -->
            <fo:layout-master-set>
                <!-- here we define the layout of pages. There might be differrent page masters with e.g. different margin settings -->
                <fo:simple-page-master master-name="tournament-page"
                    page-height="297.0mm" page-width="209.9mm"
                    margin-bottom="8mm" margin-left="25mm" margin-right="10mm" margin-top="10mm">
                    
                    <!-- the content will be placed into the region-body -->
                    <fo:region-body margin-bottom="28mm" margin-left="0mm" margin-right="44mm" margin-top="60mm"/>
                    
                </fo:simple-page-master>
                
            </fo:layout-master-set>
            
            <!-- Here comes the content.
                 Printed content consists of one or more page-sequences. Each page-sequence starts on a new page. -->
            
            <!-- front page -->
            <fo:page-sequence master-reference="tournament-page">
                <fo:flow flow-name="xsl-region-body" font-family="serif" font-size="28pt">
                    <fo:block>
                        <xsl:value-of select="description/text()"/>
                    </fo:block>
                </fo:flow>
            </fo:page-sequence>
            
            <!-- table of contents (list of athletes) page -->
            <fo:page-sequence master-reference="tournament-page">
                <!-- place a page description into the page header -->
                
                <!-- place the table of contents into region-body -->                    
                <fo:flow flow-name="xsl-region-body" font-family="Times" font-size="10pt">
                    <fo:block font-weight="bold" margin-top="40mm" font-size="20pt">Table of Contents</fo:block>
                    <fo:table>
                        <fo:table-column column-width="5mm"/>
                        <fo:table-column column-width="7mm"/>
                        <fo:table-column column-width="150mm"/>
                        <fo:table-column column-width="8mm"/>
                        
                        <fo:table-body>
                            <xsl:apply-templates select="athlete" mode="toc"/>
                        </fo:table-body>
                    </fo:table>
                </fo:flow>
            </fo:page-sequence>
            
            <!-- groups page -->
            <fo:page-sequence master-reference="tournament-page">
                <fo:flow flow-name="xsl-region-body" font-family="Times" font-size="10pt">
                    <fo:block font-weight="bold" margin-top="20mm" font-size="20pt">List of Groups</fo:block>
                    <xsl:apply-templates select="group"/>
                </fo:flow>
            </fo:page-sequence>
            
            <!-- scorecards page -->
            <fo:page-sequence master-reference="tournament-page">
                <fo:flow flow-name="xsl-region-body" font-family="Times" font-size="10pt">
                    <fo:block font-weight="bold" margin-top="20mm" font-size="20pt">Scorecards</fo:block>
                    <xsl:apply-templates select="scorecard"/>
                </fo:flow>
            </fo:page-sequence>
        </fo:root>
    </xsl:template>
    
    <!-- Athlete template -->
    <xsl:template match="athlete" mode="toc">
        <fo:table-row>
            <!-- dot -->
            <fo:table-cell>
                <fo:block text-align="right">
                    <xsl:value-of select="position()"/>&#160;
                </fo:block>
            </fo:table-cell>
            
            <!-- Nationality -->
            <fo:table-cell>
                <fo:block font-family="monospace">
                    <fo:basic-link internal-destination="{generate-id(firstname)}">
                        <xsl:value-of select="nationality"/>
                    </fo:basic-link>
                </fo:block>
            </fo:table-cell>
            
            <!-- Lastname + Firstname -->
            <fo:table-cell>
                <fo:block text-align-last="justify">
                    <fo:basic-link internal-destination="{generate-id(firstname)}">
                        <xsl:value-of select="lastname"/>&#160;<xsl:value-of select="firstname"/>&#160;
                        <fo:leader leader-pattern="dots" width="100%"/>
                    </fo:basic-link>
                </fo:block>
            </fo:table-cell>
            
            <!-- page number -->
            <fo:table-cell>
                <fo:block text-align-last="justify">
                    <fo:basic-link internal-destination="{generate-id(firstname)}">
                        <fo:page-number-citation ref-id="{generate-id(firstname)}"/>
                    </fo:basic-link>
                </fo:block>
            </fo:table-cell>
        </fo:table-row>
    </xsl:template>
  
    <!-- Group template -->
    <xsl:template match="group">
        <fo:list-block keep-together="always" provisional-distance-between-starts="18pt" margin-bottom="10pt">
            <fo:list-item>
                <!-- Point -->
                <fo:list-item-label end-indent="10pt">
                    <fo:block>&#x2022;</fo:block>
                </fo:list-item-label>
                <fo:list-item-body start-indent="10pt">
                    <!-- Name -->
                    <fo:block font-weight="bold"><xsl:value-of select="@name"/></fo:block>
                    
                    <fo:list-block keep-together="always" provisional-distance-between-starts="18pt">
                        <xsl:apply-templates select="member"/>
                        
                    </fo:list-block>
                </fo:list-item-body>
            </fo:list-item>
        </fo:list-block>
    </xsl:template>
    
    <!-- athlete template for the list of groups -->  
    <xsl:template match="member">
        <fo:list-item>
            <!-- Point -->
            <fo:list-item-label end-indent="10pt">
                <fo:block>-</fo:block>
            </fo:list-item-label>
            <fo:list-item-body start-indent="15pt">
                <fo:block>
                    <xsl:value-of select="id(@athlete-id)/lastname"/>&#160;
                    <xsl:value-of select="id(@athlete-id)/firstname"/>
                </fo:block>
            </fo:list-item-body>
        </fo:list-item>
    </xsl:template>
    
    <!-- Scorecard template -->  
    <xsl:template match="scorecard">
        <fo:list-block keep-together="always" provisional-distance-between-starts="18pt" margin-bottom="10pt" id="{generate-id(.)})">
            <fo:list-item>
                <!-- Point -->
                <fo:list-item-label end-indent="10pt">
                    <fo:block>&#x2022;</fo:block>
                </fo:list-item-label>
                <!-- Body -->
                <fo:list-item-body start-indent="10pt">
                    <!-- Name -->
                    <fo:block id="{generate-id(id(@athlete-id)/firstname)}">
                        <xsl:value-of select="id(@athlete-id)/lastname"/>&#160;
                        <xsl:value-of select="id(@athlete-id)/firstname"/>
                    </fo:block>
                    <!-- Table -->
                    <fo:table>
                        <fo:table-column column-width="42pt"/>
                        <fo:table-column column-width="42pt" number-columns-repeated="3"/>
                        <fo:table-body start-indent="-3pt">
                            <xsl:for-each select="target">
                                <fo:table-row>
                                    <!-- Target -->
                                    <fo:table-cell border="1pt solid black" text-align="center" background-color="#D9D9D9">
                                        <fo:block>
                                            <xsl:value-of select="@name"/>
                                        </fo:block>
                                    </fo:table-cell>
                                    <xsl:for-each select="score">
                                        <fo:table-cell border="1pt solid black" text-align="center">
                                            <fo:block>
                                                <xsl:value-of select="./text()"/>
                                            </fo:block>
                                        </fo:table-cell>
                                    </xsl:for-each>
                                </fo:table-row>
                            </xsl:for-each>
                            <xsl:apply-templates select="scorecard"/>
                        </fo:table-body>
                    </fo:table>
                </fo:list-item-body>
            </fo:list-item>
        </fo:list-block>
    </xsl:template>
</xsl:stylesheet>
