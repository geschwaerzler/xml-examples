<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format">
    
    <!-- ............................ ROOT TEMPLATE .......................... -->
    <xsl:template match="/archery_tournament">
        <fo:root>
            
            <!-- define the layout of the document -->
            <fo:layout-master-set>
                <!-- here we define the layout of pages. There might be differrent page masters with e.g. different margin settings -->
                <fo:simple-page-master master-name="archery-page"
                    page-height="297.0mm" page-width="209.9mm"
                    margin-bottom="8mm" margin-left="25mm" margin-right="10mm" margin-top="10mm">
                    
                    <!-- the content will be placed into the region-body -->
                    <fo:region-body margin-bottom="28mm" margin-left="0mm" margin-right="44mm" margin-top="20mm"/>
                    
                    <!-- region-before is the page header -->
                    <fo:region-before extent="24pt" region-name="archery-header"/>
                    
                    <!-- region-after is the page footer -->
                    <fo:region-after extent="24pt" region-name="archery-footer"/>
                    
                </fo:simple-page-master>
            </fo:layout-master-set>
            
            
            <!-- Here comes the content.
      Printed content consists of one or more page-sequences. Each page-sequence starts on a new page. -->
            
            <!-- front page -->
            <fo:page-sequence master-reference="archery-page">
                <fo:flow flow-name="xsl-region-body" font-family="sans-serif" font-size="28pt">
                    <fo:block margin-top="40mm">
                        <xsl:value-of select="description"/>
                    </fo:block>
                </fo:flow>
            </fo:page-sequence>
            
            <!-- table of contents -->
            <fo:page-sequence master-reference="archery-page">
                <!-- Header -->
                <xsl:call-template name="header">
                    <xsl:with-param name="right" select="'Table of Contents'"/>
                </xsl:call-template>
                
                <!-- Footer -->
                <fo:static-content flow-name="archery-footer">
                    <fo:block font-size="7pt" text-align="end">
                        page <fo:page-number/>
                    </fo:block>
                </fo:static-content>
                
                <!-- place the table of contents into region-body -->
                <fo:flow flow-name="xsl-region-body" font-family="Times" font-size="12pt">
                    <fo:block font-weight="bold" margin-top="20mm">Table of Contents</fo:block>
                    <fo:list-block space-before="10pt">
                        <xsl:call-template name="listitem">
                            <xsl:with-param name="label" select="'1.'"/>
                            <xsl:with-param name="body" select="'Disciplines'"/>
                            <xsl:with-param name="pagenrID" select="'disciplines'"/> <!-- singlequotes: XPath ausdruck -->
                        </xsl:call-template>
                        <xsl:call-template name="listitem">
                            <xsl:with-param name="label" select="'2.'"/>
                            <xsl:with-param name="body" select="'Divisions'"/>
                            <xsl:with-param name="pagenrID" select="'divisions'"/>
                        </xsl:call-template>
                        <xsl:call-template name="listitem">
                            <xsl:with-param name="label" select="'3.'"/>
                            <xsl:with-param name="body" select="'Participating Countries'"/>
                            <xsl:with-param name="pagenrID" select="'part.countr.'"/>
                        </xsl:call-template>
                        <xsl:call-template name="listitem">
                            <xsl:with-param name="label" select="'4.'"/>
                            <xsl:with-param name="body" select="'Groups'"/>
                            <xsl:with-param name="pagenrID" select="'groups'"/>
                        </xsl:call-template>
                        <xsl:call-template name="listitem">
                            <xsl:with-param name="label" select="'5.'"/>
                            <xsl:with-param name="body" select="'Scorecards'"/>
                            <xsl:with-param name="pagenrID" select="'scorecards'"/>
                        </xsl:call-template>     
                    </fo:list-block>     
                </fo:flow>
                
            </fo:page-sequence>
            
            <!-- Divisions -->
            <fo:page-sequence master-reference="archery-page">
                <!-- Header -->
                <xsl:call-template name="header">
                    <xsl:with-param name="right" select="'Divisions, Disciplines, Groups'"/>
                </xsl:call-template>
                
                <!-- Footer -->
                <fo:static-content flow-name="archery-footer">
                    <fo:block font-size="7pt" text-align="end">
                        page <fo:page-number/>
                    </fo:block>
                </fo:static-content>
                
                <!-- place the Disciplies into region-body -->
                <fo:flow flow-name="xsl-region-body" font-family="Times" font-size="12pt">
                    <fo:block font-weight="bold" margin-top="20mm" id="disciplines">Disciplines</fo:block>
                    <fo:list-block space-before="10pt">   
                        <xsl:for-each select="discipline">
                            <xsl:sort order="ascending"/>
                            <fo:list-item>
                                <fo:list-item-label>
                                    <fo:block>*</fo:block>
                                </fo:list-item-label>
                                <fo:list-item-body>
                                    <fo:block margin-left="15pt"><xsl:value-of select="."/></fo:block>
                                </fo:list-item-body>
                            </fo:list-item>
                        </xsl:for-each>
                    </fo:list-block>
                    
                    <!-- place the Divisions into region-body -->
                    <fo:block font-weight="bold" margin-top="20mm" id="divisions">Divisions</fo:block>
                    <fo:list-block space-before="10pt">   
                        <xsl:for-each select="division">
                            <xsl:sort order="ascending"/>
                            <fo:list-item>
                                <fo:list-item-label>
                                    <fo:block>*</fo:block>
                                </fo:list-item-label>
                                <fo:list-item-body>
                                    <fo:block margin-left="15pt"><xsl:value-of select="."/></fo:block>
                                </fo:list-item-body>
                            </fo:list-item>
                        </xsl:for-each>
                    </fo:list-block>
                    
                    <!-- place the Participating Countries into region-body -->
                    <fo:block font-weight="bold" margin-top="20mm" id="part.countr.">Participating Countries</fo:block>
                    <fo:list-block space-before="10pt">   
                        <xsl:for-each-group select="registration/participant/state" group-by=".">
                            <xsl:sort order="ascending"/>
                            <fo:list-item>
                                <fo:list-item-label>
                                    <fo:block>*</fo:block>
                                </fo:list-item-label>
                                <fo:list-item-body>
                                    <fo:block margin-left="15pt">
                                        <xsl:value-of select="."/>
                                    </fo:block>
                                </fo:list-item-body> 
                            </fo:list-item>
                        </xsl:for-each-group>
                    </fo:list-block>
                </fo:flow>
            </fo:page-sequence> 
            
            
            <!-- place the Groups into region-body -->
            <fo:page-sequence master-reference="archery-page">
                <!-- Header -->
                <xsl:call-template name="header">
                    <xsl:with-param name="right" select="'Groups'"/>
                </xsl:call-template>
                
                <!-- Footer -->
                <fo:static-content flow-name="archery-footer">
                    <fo:block font-size="7pt" text-align="end">
                        page <fo:page-number/>
                    </fo:block>
                </fo:static-content>
                
                <!-- place the Disciplies into region-body -->
                <fo:flow flow-name="xsl-region-body" font-family="Times" font-size="12pt">
                    <fo:block font-weight="bold" margin-top="2mm" id="groups">Groups</fo:block>    
                    <fo:list-block space-before="2pt">
                        <xsl:for-each select="group/subgroup">
                            <fo:list-item>
                                <fo:list-item-label><fo:block></fo:block></fo:list-item-label> <!-- label haben wir keines -->
                                <fo:list-item-body>
                                    <fo:block font-weight="bold" margin-right="10mm" margin-top="5mm" margin-bottom="0mm">
                                        Subgroup 
                                        <xsl:value-of select="position()"/>
                                    </fo:block>
                                    <xsl:for-each select="member"> 
                                        <xsl:sort select="id(@participant-id)/lastname" order="ascending"/>
                                        <fo:block margin-right="20mm">
                                            <xsl:value-of select="id(@participant-id)/lastname"/>
                                            <xsl:text> </xsl:text>
                                            <xsl:value-of select="id(@participant-id)/firstname"/>
                                        </fo:block>  
                                    </xsl:for-each>
                                </fo:list-item-body>
                            </fo:list-item>
                        </xsl:for-each>
                    </fo:list-block>      
                </fo:flow>
            </fo:page-sequence>
            
            
            <!-- Scorecards -->
            <fo:page-sequence master-reference="archery-page">
                <!-- Header -->
                <xsl:call-template name="header">
                    <xsl:with-param name="right" select="'Scorecards'"/>
                </xsl:call-template>
                
                <!-- Footer -->
                <fo:static-content flow-name="archery-footer">
                    <fo:block font-size="7pt" text-align="end">
                        page <fo:page-number/>
                    </fo:block>
                </fo:static-content>
                
                <fo:flow flow-name="xsl-region-body" font-family="Times" font-size="12pt">
                    <fo:block font-weight="bold" margin-top="20mm" id="scorecards">Scorecards</fo:block>
                    <fo:table border="0.5pt solid black" text-align="center" border-spacing="3pt" space-before="10pt" space-after="10pt">
                        <fo:table-body>
                            <fo:table-row>
                                <fo:table-cell padding="6pt" border="0.5pt solid black">
                                    <fo:block></fo:block>
                                </fo:table-cell>
                                <fo:table-cell padding="6pt" border="0.5pt solid black"> 
                                    <fo:block>Target 1</fo:block>
                                </fo:table-cell>
                                <fo:table-cell padding="6pt" border="0.5pt solid black"> 
                                    <fo:block>Target 2</fo:block>
                                </fo:table-cell>
                                <fo:table-cell padding="6pt" border="0.5pt solid black"> 
                                    <fo:block>Target 3</fo:block>
                                </fo:table-cell>
                                <fo:table-cell padding="6pt" border="0.5pt solid black"> 
                                    <fo:block>Target 4</fo:block>
                                </fo:table-cell>
                            </fo:table-row> 
                            <xsl:for-each select="match">
                                <fo:table-row>
                                    <fo:table-cell padding="6pt" border="0.5pt solid black">
                                        <fo:block>
                                            Match <xsl:value-of select="position()"/>
                                        </fo:block>
                                    </fo:table-cell>
                                    <xsl:for-each select="target">
                                        <table-cell padding="6pt" border="0.5pt solid black">
                                            <fo:block>
                                                <xsl:value-of select="id(@participant-id)"/>    <!--funktioniert nicht -->    
                                            </fo:block>
                                        </table-cell>
                                    </xsl:for-each>
                                </fo:table-row>
                            </xsl:for-each>
                        </fo:table-body>
                    </fo:table>	 
                </fo:flow>
            </fo:page-sequence>
        </fo:root>
    </xsl:template>
    
    <!-- ...................... Header Template ................... -->
    <xsl:template name="header">
        <xsl:param name="right"/>
        <!-- page header: left: booklet title; left: recipe title -->
        <fo:static-content flow-name="archery-header">
            <fo:block font-size="7pt" text-align-last="justify">
                <xsl:value-of select="/archery_tournament/description"/>
                <fo:leader/>
                <xsl:value-of select="$right"/>
            </fo:block>
        </fo:static-content>        
    </xsl:template>
    
    <!-- ...................... listitem for Table of Contents Template ............-->
    <xsl:template name="listitem">
        <xsl:param name="label"/>
        <xsl:param name="body"/>
        <xsl:param name="pagenrID"/>
        <fo:list-item>
            <fo:list-item-label>
                <fo:block><xsl:value-of select="$label"/></fo:block>
            </fo:list-item-label>
            <fo:list-item-body>
                <fo:block text-align-last="justify " margin-left="15pt">
                    <xsl:value-of select="$body"/>
                    <fo:leader leader-pattern="dots"/> <!-- blocksatz  -->
                    <fo:page-number-citation ref-id="{$pagenrID}"/> <!--geschwungene Klammer und $ weil Variable -->
                </fo:block>
            </fo:list-item-body>
        </fo:list-item> 
    </xsl:template> 
</xsl:stylesheet>