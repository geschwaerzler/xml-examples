<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format"
    xmlns:rx="http://www.renderx.com/XSL/Extensions">
    
    <!-- ............................ ROOT TEMPLATE .......................... -->
    <xsl:template match="/">
        <fo:root>
            <!-- define the layout of the document -->
            <fo:layout-master-set>
                <!-- here we define the layout of pages. There might be differrent page masters with e.g. different margin settings -->
                <fo:simple-page-master master-name="bogenschiess-page"
                    page-height="297.0mm" page-width="209.9mm"
                    margin-bottom="8mm" margin-left="25mm" margin-right="10mm" margin-top="10mm">
                    
                    <!-- the content will be placed into the region-body -->
                    <fo:region-body  column-count="1" margin-bottom="28mm" margin-left="0mm" margin-right="15mm" margin-top="30mm"/>
                    
                    <fo:region-before extent="24pt" region-name="bogenschiess-header"/>
                    
                    <fo:region-after extent="24pt" region-name="bogenschiess-footer"/>
                    
                    
                </fo:simple-page-master>
            </fo:layout-master-set>
            
            
            <!-- Here comes the content.
                 Printed content consists of one or more page-sequences. Each page-sequence starts on a new page. -->
            
            <!-- front page -->
            <fo:page-sequence master-reference="bogenschiess-page">
                <fo:flow flow-name="xsl-region-body" font-family="sans-serif" font-size="28pt">
                    <fo:block margin-top="60mm">
                        Jahr <xsl:value-of select="bogenschiess-db/tournament/@event_year"/>
                    </fo:block>
                   
                    <fo:block font-size="20pt">
                        Tournament in
                        <xsl:value-of select="bogenschiess-db/tournament/@host_country"/> in City (<xsl:value-of select="bogenschiess-db/tournament/@host_city_code"/>)
                    </fo:block>
                   
                </fo:flow>
            </fo:page-sequence>
            
            <!-- inhaltsverzeichnis-->
            <fo:page-sequence master-reference="bogenschiess-page">
                
                <fo:static-content flow-name="bogenschiess-header">
                    <fo:block font-size="10pt" text-align="center">
                        Table of Contents
                    </fo:block>
                </fo:static-content>
                
                <fo:flow flow-name="xsl-region-body" font-family="sans-serif" font-size="28pt">
                    <fo:block  margin-top="60mm">
                        Inhaltsverzeichnis
                    </fo:block>
                    <fo:block font-size="12pt">
                        <fo:list-block margin-top="24pt">
                            <xsl:for-each select="//person[contains(@tournament_role, 'PARTICIPANT')]">
                                    <fo:list-item>
                                        <fo:list-item-label>
                                            <fo:block>
                                                <xsl:value-of select="position()"/>.
                                            </fo:block>
                                        </fo:list-item-label>
                                        <fo:list-item-body start-indent="4mm">
                                            <fo:block text-align-last="justify">
                                                <xsl:value-of select="@firstname"/>,
                                                <xsl:value-of select="@lastname"/>
                                                <fo:leader leader-pattern="dots"  />
                                                S.<fo:page-number-citation ref-id="{generate-id()}"/></fo:block>
                                            
                                        </fo:list-item-body>
                                    </fo:list-item>                            
                            </xsl:for-each>
                        </fo:list-block>
                    </fo:block>
                </fo:flow>
            </fo:page-sequence>
          
            
            <xsl:apply-templates select="//person[contains(@tournament_role, 'PARTICIPANT')]"></xsl:apply-templates>
            
            <!-- inhaltsverzeichnis-->
            <fo:page-sequence master-reference="bogenschiess-page">
                
                <fo:static-content flow-name="bogenschiess-header">
                    <fo:block font-size="7pt" text-align="center">
                        Table of Contents
                    </fo:block>
                </fo:static-content>
                
                <fo:flow flow-name="xsl-region-body" font-family="sans-serif" font-size="28pt">
                    <fo:block  margin-top="60mm">
                        Inhaltsverzeichnis Runden
                    </fo:block>
                    <fo:block font-size="12pt">
                        <fo:list-block margin-top="24pt">
                            <xsl:for-each select="//round">
                                    <fo:list-item>
                                    <fo:list-item-label>
                                        <fo:block>
                                            <xsl:value-of select="position()"/>.
                                        </fo:block>
                                    </fo:list-item-label>
                                    <fo:list-item-body start-indent="4mm">
                                        <fo:block text-align-last="justify">
                                            Round <xsl:value-of select="@round_number"/>,
                                            <xsl:value-of select="@place"/>
                                            <fo:leader leader-pattern="dots"  />
                                            S.<fo:page-number-citation ref-id="{generate-id()}"/></fo:block>
                                    </fo:list-item-body>
                                </fo:list-item>  
                            </xsl:for-each>
                        </fo:list-block>
                    </fo:block>
                </fo:flow>
            </fo:page-sequence>
            <xsl:apply-templates select="//round"></xsl:apply-templates>
            
        </fo:root>
    </xsl:template>
    
    <xsl:template match="person">
        <fo:page-sequence master-reference="bogenschiess-page">
            <fo:static-content flow-name="bogenschiess-footer">
                <fo:block font-size="10pt" text-align="center">
                    S. <fo:page-number></fo:page-number>
                </fo:block>
            </fo:static-content>
            <fo:flow flow-name="xsl-region-body" font-family="sans-serif" font-size="28pt">
                
                <!-- Here could be a Picture but it does not look good :P
                <fo:block>
                    <fo:external-graphic src="url('{@profile_pic}')" content-height="100pt" content-width="200mm"/>
                </fo:block>
                -->
               
                
                <fo:block id="{generate-id()}">
                    <xsl:value-of select="@firstname"/>, <xsl:value-of select="@lastname"/>
                </fo:block>
               
                
                
                <xsl:for-each select="participant">
                    <!-- this does not work :/-->
                    <!--<rx:flow-section column-count="2" column-gap="18pt">-->
                        <fo:block font-size="12pt">
                            <fo:block margin-top="20pt" font-size="16pt">Personendetails</fo:block>
                            <fo:block font-weight="bold">Gender:</fo:block>
                            <fo:block>
                                <xsl:value-of select="@gender"/>
                            </fo:block>
                            <fo:block font-weight="bold">Professionell:</fo:block>
                            <fo:block><xsl:value-of select="@is_professional"/></fo:block>
                        </fo:block>
                        <fo:block font-size="12pt">
                            <fo:block margin-top="20pt" font-size="16pt">Style and Division</fo:block>
                            <fo:block font-weight="bold">Style-Name:</fo:block>
                            <fo:block>
                                <xsl:value-of select="./style-and-division/shooting-style/@style_name"/>
                            </fo:block>
                            <fo:block font-weight="bold">Bogentyp:</fo:block>
                            <fo:block>
                                <xsl:value-of select="./style-and-division/shooting-style/@bow_type"/>
                            </fo:block>
                            <fo:block font-weight="bold">Altersgruppe:</fo:block>
                            <fo:block>
                                <xsl:value-of select="./style-and-division/age-group/@gr_name"/>
                            </fo:block>
                        </fo:block>
                    <!--</rx:flow-section>-->
                    
                    <fo:block font-size="12pt">
                        <fo:block font-weight="bold">sum of Points</fo:block>
                        <xsl:variable name="p-id" select="../@id"></xsl:variable>
                        <xsl:value-of select="sum(//result[@person-id=$p-id]/@points)"></xsl:value-of>
                        pts.
                    </fo:block>
                    <fo:block margin-top="20pt" font-size="16pt">Runden und Ergebnisse</fo:block>
                    <fo:table margin-top="20pt" font-size="12pt">
                        <fo:table-header margin-left="30pt" border-bottom-color="#000000" border-bottom-style="solid" border-bottom-width="1pt">
                        <fo:table-row font-weight="bold">
                            <fo:table-cell><fo:block>Ort</fo:block></fo:table-cell>
                            <fo:table-cell  margin-left="10pt"><fo:block>Runden Nummer</fo:block></fo:table-cell>
                            <fo:table-cell><fo:block>Start Zeit</fo:block></fo:table-cell>
                            <fo:table-cell><fo:block>Runden Typ</fo:block></fo:table-cell>
                            <fo:table-cell  margin-left="10pt"><fo:block>Gruppenrolle</fo:block></fo:table-cell>
                            <fo:table-cell margin-left="30pt"><fo:block>Punkte</fo:block></fo:table-cell>
                        </fo:table-row>
                    </fo:table-header>
                    <xsl:variable name="p-id2" select="../@id"></xsl:variable>
                    <fo:table-body>
                        <xsl:for-each select="//result[@person-id=$p-id2]/ancestor::round">
                            <fo:table-row>
                                <fo:table-cell>
                                    <fo:block><xsl:value-of select="@place"/></fo:block>
                                </fo:table-cell>
                                <fo:table-cell margin-left="10pt">
                                    <fo:block>
                                        <xsl:value-of select="@round_number"/>
                                    </fo:block>
                                </fo:table-cell>
                                <fo:table-cell>
                                    <fo:block>
                                        <xsl:value-of select="@start_time"/>
                                    </fo:block>
                                </fo:table-cell>
                                <fo:table-cell>
                                    <fo:block><xsl:value-of select="@round_type_name"/></fo:block>
                                </fo:table-cell>
                                <fo:table-cell  margin-left="10pt">
                                    <fo:block><xsl:value-of select="./group/group-role[@person-id=$p-id2]/@group-role"/></fo:block>
                                </fo:table-cell>
                                <fo:table-cell  margin-left="30pt" text-align="right">
                                    <fo:block><xsl:value-of select="./result[@person-id=$p-id2]/@points"/></fo:block>
                                </fo:table-cell>
                            </fo:table-row>
                        </xsl:for-each>
                        <fo:table-row font-weight="bold">
                            <fo:table-cell><fo:block></fo:block></fo:table-cell>
                            <fo:table-cell  margin-left="10pt"><fo:block></fo:block></fo:table-cell>
                            <fo:table-cell><fo:block></fo:block></fo:table-cell>
                            <fo:table-cell><fo:block></fo:block></fo:table-cell>
                            <fo:table-cell  margin-left="10pt"><fo:block></fo:block></fo:table-cell>
                            <fo:table-cell text-align="right" margin-left="30pt" border-bottom-color="#000000" border-bottom-style="double" border-bottom-width="2pt" space-before="10pt">
                                <fo:block>
                                    <xsl:value-of select="sum(//result[@person-id=$p-id2]/@points)"></xsl:value-of>
                                </fo:block>
                            </fo:table-cell>
                        </fo:table-row>
                    </fo:table-body>
                </fo:table>
                </xsl:for-each>
            </fo:flow>
        </fo:page-sequence>
    </xsl:template>
    
    <xsl:template match="round">
        <fo:page-sequence master-reference="bogenschiess-page">
                <fo:static-content flow-name="bogenschiess-footer">
                    <fo:block font-size="10pt" text-align="center">
                        S. <fo:page-number></fo:page-number>
                    </fo:block>
                </fo:static-content>
            
                <fo:flow flow-name="xsl-region-body" font-family="sans-serif">
                    <fo:block font-size="28pt" id="{generate-id()}">Runde
                        <xsl:value-of select="@round_number"/> -
                        <xsl:value-of select="@place"/>
                    </fo:block>
                    
                    <xsl:apply-templates select="group"></xsl:apply-templates>
                    
                    <fo:block font-size="16pt" margin-top="20pt" margin-bottom="10pt">Ergebniss in der Runde</fo:block>
                    
                    <xsl:apply-templates select="result"></xsl:apply-templates>
                </fo:flow>
            </fo:page-sequence>
    </xsl:template>
    
    <xsl:template match="group">
        <fo:block font-size="16pt" margin-top="20pt" margin-bottom="10pt">
            Gruppe  <xsl:value-of select="@id"/>
        </fo:block>
        <xsl:apply-templates select="group-role"></xsl:apply-templates>
    </xsl:template>
    
    <xsl:template match="group-role">
        <fo:block>
            <fo:inline>
            <xsl:value-of select="//person[@id=current()/@person-id]/@firstname"/>,
            <xsl:value-of select="//person[@id=current()/@person-id]/@lastname"/>
            </fo:inline>
             - 
            <fo:inline font-weight="bold"><xsl:value-of select="@group-role"/></fo:inline>
        </fo:block>     
    </xsl:template>
    
    <xsl:template match="result">
        <fo:block  text-align="justify">
            
            <fo:inline>
            <xsl:value-of select="//person[@id=current()/@person-id]/@firstname"/>, <xsl:value-of select="//person[@id=current()/@person-id]/@lastname"/>
            </fo:inline>
             - 
            <fo:inline margin-left="5pt" font-weight="bold"> <xsl:value-of select="@points"/> Points</fo:inline>
        </fo:block>        
    </xsl:template>
</xsl:stylesheet>