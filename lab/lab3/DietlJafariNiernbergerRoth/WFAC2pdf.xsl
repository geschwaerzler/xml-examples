<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format">



    <!-- root template -->

    <xsl:template match="/">
        <fo:root>

            <fo:layout-master-set>
                <!-- define layout of pages -->
                <fo:simple-page-master master-name="wfac-page" page-height="297.0mm"
                    page-width="209.9mm" margin-bottom="8mm" margin-left="25mm" margin-right="25mm"
                    margin-top="10mm">

                    <!-- content is placed in region body -->
                    <fo:region-body margin-bottom="28mm" margin-left="0mm" margin-right="44mm"
                        margin-top="20mm"/>

                    <fo:region-before extent="24pt" region-name="wfac-header"/>
                    <fo:region-after extent="24pt" region-name="wfac-footer"/>

                </fo:simple-page-master>

            </fo:layout-master-set>

            <!-- content -->
            <fo:page-sequence master-reference="wfac-page">
                <fo:flow flow-name="xsl-region-body" font-family="sans-serif" font-size="28pt">
                    <fo:block space-before="40mm"> WFAC 2021 Group Results </fo:block>
                </fo:flow>
            </fo:page-sequence>


            <!-- Table of Groups -->
            <fo:page-sequence master-reference="wfac-page">

                <fo:static-content flow-name="wfac-header">
                    <!-- justify = blocksatz -->
                    <fo:block text-align-last="justify">
                        <fo:leader/> Table of Groups </fo:block>
                </fo:static-content>

                <fo:flow flow-name="xsl-region-body">
                    <fo:block font-size="14pt" font-weight="bold"> Table of Groups </fo:block>

                    <fo:list-block>
                        <xsl:for-each select="wfac/group">
                            <fo:list-item>
                                <fo:list-item-label>
                                    <fo:block>
                                        <xsl:value-of select="position()"/>. </fo:block>
                                </fo:list-item-label>
                                <fo:list-item-body start-indent="4mm">
                                    <fo:block text-align-last="justify"> Group <xsl:value-of
                                            select="@gID"/>
                                        <fo:leader leader-pattern="dots"/>
                                    </fo:block>
                                </fo:list-item-body>
                            </fo:list-item>
                            <xsl:for-each select="groupmember">
                                <fo:list-item>
                                    <fo:list-item-label>
                                        <fo:block>
                                            
                                        </fo:block>
                                    </fo:list-item-label>
                                    <fo:list-item-body>
                                        <fo:block>
                  
                                            <xsl:call-template name="competitorList"/> 
                                            
                                        </fo:block></fo:list-item-body>
                                </fo:list-item>
                            </xsl:for-each>
                        </xsl:for-each>
                    </fo:list-block>
                </fo:flow>
            </fo:page-sequence>

            <!-- page for scoring -->

            <fo:page-sequence master-reference="wfac-page">

                <fo:static-content flow-name="wfac-footer">
                    <fo:block font-size="12pt" text-align="end"> page <fo:page-number/>
                    </fo:block>
                </fo:static-content>

                <fo:static-content flow-name="wfac-header">
                    <!-- justify = blocksatz -->
                    <fo:block text-align-last="justify">
                        <fo:leader/> Scoring </fo:block>
                </fo:static-content>

                <fo:flow flow-name="xsl-region-body">
                    <fo:block font-family="sans-serif" font-size="14pt" font-weight="bold"
                        space-after="10mm"> Scoring </fo:block>

                    <!--Names of competitors with score table-->
                    <xsl:for-each select="/wfac/competitor">
                        <xsl:text>&#xd;</xsl:text>
                        <xsl:variable name="compNr" select="@registration_id"/>
                        <fo:block space-before="10mm">
    
                            <fo:table>
                            <fo:table-header>
                                <fo:table-row>
                                    <fo:table-cell>
                                        <fo:block>
                                            <xsl:value-of select="@registration_id"/>
                                            <xsl:text>&#160;</xsl:text>
                                            <xsl:value-of select="@fname"/>
                                            <xsl:text>&#160;</xsl:text>
                                            <xsl:value-of select="@lname"/>
                                        </fo:block>
                                    </fo:table-cell>
                                    <fo:table-cell>
                                        <fo:block>
                                            target#
                                        </fo:block>
                                    </fo:table-cell>
                                    <fo:table-cell>
                                        <fo:block>
                                            score
                                        </fo:block>
                                    </fo:table-cell>
                                </fo:table-row>
                            </fo:table-header>
                            
                            
                            <fo:table-body>
                                <xsl:for-each
                                    select="/wfac/competitor[@registration_id = $compNr]/scorecard/scorecard_entry">
                                    <xsl:call-template name="scorecard"/>
                                </xsl:for-each>
                            </fo:table-body>
                        </fo:table>
                        </fo:block>
                    </xsl:for-each>
                </fo:flow>


            </fo:page-sequence>



        </fo:root>
    </xsl:template>


    <xsl:template name="scorecard" match="wfac/competitor/scorecard">
        <fo:table-row>
            <fo:table-cell>
                <fo:block/>
            </fo:table-cell>
            <fo:table-cell>
                <fo:block>
                    <xsl:value-of select="@entry_number"/>
                </fo:block>
               
            </fo:table-cell>
            <fo:table-cell>
                <fo:block>
                    <xsl:value-of select="@score"/>
                </fo:block></fo:table-cell>
        </fo:table-row>
    </xsl:template>
    
    <xsl:template name="competitorList" match="wfac/competitor">
       
       <!-- transformator greift nicht auf DTD zu -> keine IDREF -> 
           kommen nicht auf competitor über groupmember registration_id -->
       <xsl:value-of select="../competitor/@registration_id"/>
        
        
        <xsl:value-of select="@registration_id"/>
        <xsl:text>&#160;</xsl:text>
        <xsl:value-of select="@role"/>
    </xsl:template>


</xsl:stylesheet>
