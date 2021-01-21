<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format">

    <!-- ............................ ROOT TEMPLATE .......................... -->
    <xsl:template match="/archery_db">
        <fo:root>
            
            <!-- define the layout of the document -->
            <fo:layout-master-set>
                
                <!-- here we define the layout of pages. There might be differrent page masters with e.g. different margin settings -->
                <fo:simple-page-master master-name="archery-page" page-height="297.0mm"
                    page-width="209.9mm" margin-bottom="8mm" margin-left="25mm" margin-right="10mm" margin-top="10mm">
                    
                    <!-- the content will be placed into the region-body -->
                    <fo:region-body margin-bottom="28mm" margin-left="0mm" margin-right="44mm" margin-top="60mm"/>
                    
                    <!-- region-before is the page header -->
                    <fo:region-before extent="24pt" region-name="archery-header"/>
                    
                    <!-- region-after is the page footer -->
                    <fo:region-after extent="24pt" region-name="archery-footer"/>
                    
                </fo:simple-page-master>
            </fo:layout-master-set>
            
            <!-- Here comes the content. Printed content consists of one or more page-sequences. Each page-sequence starts on a new page. -->
            
            <!-- front page -->
            <fo:page-sequence master-reference="archery-page">
                <fo:flow flow-name="xsl-region-body" font-family="monospace" font-size="30pt">
                    <fo:block>
                        <xsl:value-of select="description"/>
                    </fo:block>
                    <fo:block font-size="14pt" margin-top="24pt">Sebastian Robert, Mathias Fritsch, Ilona Wichser </fo:block>
                </fo:flow>
            </fo:page-sequence>
            
            <!-- Inhaltsverzeichnis -->
            <fo:page-sequence master-reference="archery-page">
                
                <!-- page header: left: booklet title; right: Inhaltsverzeichnis -->
                <xsl:call-template name="generate-header">
                    <xsl:with-param name="title-right" select="'Inhaltsverzeichnis'"></xsl:with-param>
                </xsl:call-template>
                
                <fo:flow flow-name="xsl-region-body" font-family="Times" font-size="14pt">
                    <fo:block font-size="24pt" font-weight="500">Inhaltsverzeichnis</fo:block>
                        <fo:list-block margin-top="24pt">
                         <xsl:for-each select="turnier/gruppe">
                            <fo:list-item>
                                <fo:list-item-label>
                                    <fo:block></fo:block>
                                </fo:list-item-label>
                                <fo:list-item-body start-indent="8mm">
                                    <fo:block text-align-last="justify">
                                        <fo:basic-link internal-destination="{generate-id()}" >                                      
                                         <xsl:value-of select="@gruppen_ID"/>
                                         <fo:leader leader-pattern="dots"/>
                                         <fo:page-number-citation ref-id="{generate-id()}"/>
                                        </fo:basic-link>
                                    </fo:block>
                                    
                                    <fo:list-block margin-top="10pt" margin-bottom="10pt">
                                        <xsl:for-each select="mitglied">
                                            <fo:list-item>
                                                <fo:list-item-label>
                                                    <fo:block></fo:block>
                                                </fo:list-item-label>
                                                <fo:list-item-body start-indent="20mm">
                                                    <fo:block text-align-last="justify">
                                                        <fo:basic-link internal-destination="{generate-id()}" >                                      
                                                            <xsl:value-of select="@teilnehmer-ID"/>
                                                            <fo:leader leader-pattern="dots"/>
                                                            <fo:page-number-citation ref-id="{generate-id()}"/>
                                                        </fo:basic-link>
                                                    </fo:block>
                                                </fo:list-item-body>
                                            </fo:list-item>
                                        </xsl:for-each>
                                    </fo:list-block>
                                </fo:list-item-body>
                            </fo:list-item>
                        </xsl:for-each>
                    </fo:list-block>
                </fo:flow>
            </fo:page-sequence>
            
            <!-- here come the group pages --> 
            <xsl:apply-templates select="turnier/gruppe"/>
            
            
            <!-- here come the scorecards -->
            <xsl:apply-templates select="turnier/gruppe/mitglied"/>

        </fo:root>
    </xsl:template>

    <!-- group-detail pages -->
    <xsl:template match="turnier/gruppe">
        <fo:page-sequence master-reference="archery-page">
            
            <!-- page header: left: booklet title; right: group -->
            <xsl:call-template name="generate-header">
                <xsl:with-param name="title-right" select="@gruppen_ID"/>
            </xsl:call-template>
            
            <!-- page footer: right: page -->
            <xsl:call-template name="generate-footer"></xsl:call-template>

            
            <fo:flow flow-name="xsl-region-body" font-family="Times" font-size="14pt">
                <fo:block font-size="24pt" font-weight="500" id="{generate-id()}">
                    <xsl:value-of select="@gruppen_ID"/>
                </fo:block>

                <fo:block font-size="18pt" margin-top="20pt"> Teilnehmer </fo:block>
                <fo:list-block margin-top="20pt">
                    <xsl:for-each select="mitglied" xml:space="preserve">
                        <fo:list-item>
                            <fo:list-item-label>
                                 <fo:block>
                                        <xsl:value-of select="id(@teilnehmer-ID)/@vorname"/>                                
                                        <xsl:value-of select="id(@teilnehmer-ID)/@nachname"/>
                                </fo:block>
                            </fo:list-item-label>
                            <fo:list-item-body start-indent="50mm">
                                <fo:block>
                                     <fo:basic-link internal-destination="{generate-id()}" >          
                                        <xsl:value-of select="@teilnehmer-ID"/>
                                     </fo:basic-link>
                                </fo:block>
                            </fo:list-item-body>        
                         </fo:list-item>
                    </xsl:for-each>
               </fo:list-block>
            </fo:flow>
        </fo:page-sequence>
    </xsl:template>
    
    <!-- scorecard pages -->
    <xsl:template match="turnier/gruppe/mitglied">
        <fo:page-sequence master-reference="archery-page">
            
                <!-- page header: left: booklet title; right: teilnehmer -->
                <xsl:call-template name="generate-header">
                    <xsl:with-param name="title-right" select="@teilnehmer-ID"/>
                </xsl:call-template>
                
                <!-- page footer: right: page -->
                <xsl:call-template name="generate-footer"></xsl:call-template>
                
                
                <fo:flow flow-name="xsl-region-body" font-family="Times" font-size="14pt">
                    
                    <fo:block font-size="24pt" font-weight="500" id="{generate-id()}">
                        <xsl:value-of  select="id(@teilnehmer-ID)/@vorname"/>
                        <xsl:text> </xsl:text>
                        <xsl:value-of select="id(@teilnehmer-ID)/@nachname"/>
                        <xsl:text> | </xsl:text>
                        <xsl:value-of select="@teilnehmer-ID"/>
                    </fo:block>
                    

                        <fo:table margin-top="20pt">
                            <fo:table-column column-width="50mm"/>
                            <fo:table-column column-width="50mm"/>
                            <fo:table-column column-width="50mm"/>
                            
                            <fo:table-header background-color="#F38222" border-width="1pt" border-style="solid">
                                <fo:table-row>
                                    <fo:table-cell>
                                        <fo:block font-weight="bold">Round</fo:block>
                                    </fo:table-cell>
                                    <fo:table-cell>
                                        <fo:block font-weight="bold">Target</fo:block>
                                    </fo:table-cell>
                                    <fo:table-cell>
                                        <fo:block font-weight="bold">Score</fo:block>
                                    </fo:table-cell>
                                </fo:table-row>
                            </fo:table-header>
                            
                            <fo:table-body border-width="1pt" border-style="solid">
                                <xsl:for-each select="punktestand">
                                    <fo:table-row  border-width="1pt" border-style="solid">
                                        <fo:table-cell  border-width="1pt" border-style="solid">
                                            <fo:block><xsl:value-of select="../../@runde-ID"/></fo:block>
                                        </fo:table-cell>
                                        <fo:table-cell  border-width="1pt" border-style="solid">
                                            <fo:block><xsl:value-of select="@scheibe-ID"/></fo:block>
                                        </fo:table-cell>
                                        <fo:table-cell  border-width="1pt" border-style="solid">
                                            <fo:block><xsl:value-of select="@punkte"/></fo:block>
                                        </fo:table-cell>
                                    </fo:table-row>
                                </xsl:for-each>
                                
                            </fo:table-body>
                            
                        </fo:table>

                </fo:flow>
            
        </fo:page-sequence>
    </xsl:template>

    <xsl:template name="generate-header">
        <xsl:param name="title-right"/>
        <!-- page header: left: booklet title; right: chapter title -->
        <fo:static-content flow-name="archery-header">
            <fo:block font-size="7pt" text-align-last="justify">
                <xsl:value-of select="/archery_db/description"/>
                <fo:leader/> 
                <xsl:value-of select="$title-right"/>
            </fo:block>
        </fo:static-content>
    </xsl:template>
    
    <xsl:template name="generate-footer">
        <xsl:param name="page-right"/>
        <!-- page footer: root: page -->
        <fo:static-content flow-name="archery-footer">
            <fo:block font-size="7pt" text-align="end">
               page <fo:page-number/>
            </fo:block>
        </fo:static-content>
    </xsl:template>

</xsl:stylesheet>
