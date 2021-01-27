<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format">
    
    <!-- ............................ ROOT TEMPLATE .......................... -->
    <xsl:template match="/tournaments">
        <fo:root>
            
            <!-- define the layout of the document -->
            <fo:layout-master-set>
                <!-- here we define the layout of pages. There might be differrent page masters with e.g. different margin settings -->
                <fo:simple-page-master master-name="tournament-page"
                    page-height="297.0mm" page-width="209.9mm"
                    margin-bottom="8mm" margin-left="10mm" margin-right="10mm" margin-top="10mm">
                    
                    <!-- the content will be placed into the region-body -->
                    <fo:region-body margin-bottom="30mm" margin-left="15mm" margin-right="25mm" margin-top="30mm"/>
                    
                    <!-- region-before is the page header -->
                    <fo:region-before extent="24pt" region-name="tournament-header"/>
                    
                    <!-- region-after is the page footer -->
                    <fo:region-after font-family="Arial" extent="24pt" region-name="tournament-footer"/>
                    
                </fo:simple-page-master>
            </fo:layout-master-set>
            
            <!-- Front Page -->
            <fo:page-sequence master-reference="tournament-page">
                <fo:flow flow-name="xsl-region-body" font-family="monospace" font-size="50pt" font-weight="1000">
                    <fo:block>
                        Tournaments
                    </fo:block>
                </fo:flow>
            </fo:page-sequence>
            
            <!-- Table of Content -->
            <fo:page-sequence master-reference="tournament-page">
                
                <fo:flow flow-name="xsl-region-body" font-family="Arial" font-size="16pt">                    
                    <fo:block font-size="36pt" font-weight="600">Table of Content</fo:block>
                    <xsl:apply-templates select="tournament" mode="toc"></xsl:apply-templates>
                </fo:flow>
                
            </fo:page-sequence>
            
            <!-- Content -->
            <xsl:apply-templates select="tournament"></xsl:apply-templates>
            
        </fo:root>     
    </xsl:template>
    
    <!-- Table of Content Template -->
    <xsl:template match="tournament" mode="toc"> 
        <fo:list-block margin-left="5mm">           
            <fo:list-item>
                <fo:list-item-label>
                    <fo:block ><xsl:value-of select="position()"/>.</fo:block>
                </fo:list-item-label>
                <fo:list-item-body start-indent="10mm">
                    <fo:block text-align-last="justify">
                        <fo:basic-link internal-destination="{@tournament_id}">
                            <xsl:value-of select="@name"/>
                            <fo:leader leader-pattern="dots"></fo:leader>
                            <fo:page-number-citation ref-id="{@tournament_id}"/>
                        </fo:basic-link>
                    </fo:block>
                    <xsl:for-each select="round">
                        <xsl:call-template name="table-of-content">
                            <xsl:with-param name="path" select="concat(@round_name,' ', substring(@round_id, 7))"></xsl:with-param>
                            <xsl:with-param name="indent" select="0"></xsl:with-param>
                            <xsl:with-param name="id" select="@round_id"></xsl:with-param>
                        </xsl:call-template>
                        <xsl:for-each select="group">
                            <xsl:call-template name="table-of-content">
                                <xsl:with-param name="path" select="concat('Gruppe ', substring(@group_id, 7))"></xsl:with-param>
                                <xsl:with-param name="indent" select="5"></xsl:with-param>
                                <xsl:with-param name="id" select="@group_id"></xsl:with-param>
                            </xsl:call-template>
                            <xsl:for-each select="has_member">
                                <xsl:call-template name="table-of-content">
                                    <xsl:with-param name="path" select="concat(id(id(@archer_id)/@person_id)/@fname,' ',id(id(@archer_id)/@person_id)/@lname)"></xsl:with-param>
                                    <xsl:with-param name="indent" select="10"></xsl:with-param>
                                    <xsl:with-param name="id" select="@archer_id"></xsl:with-param>
                                </xsl:call-template>
                            </xsl:for-each>
                        </xsl:for-each>
                    </xsl:for-each>
                </fo:list-item-body>
            </fo:list-item>
        </fo:list-block>
    </xsl:template>
    
    <xsl:template name="table-of-content">
        <xsl:param name="path"></xsl:param>
        <xsl:param name="indent" select="5"></xsl:param>
        <xsl:param name="id"></xsl:param>
        <fo:list-block margin-left="{$indent}mm">           
            <fo:list-item>
                <fo:list-item-label>
                    <fo:block ><xsl:value-of select="position()"/>.</fo:block>
                </fo:list-item-label>
                <fo:list-item-body start-indent="{$indent+15}mm">
                        <fo:block text-align-last="justify">
                            <fo:basic-link internal-destination="{$id}">
                                <xsl:value-of select="$path"/>
                                <fo:leader leader-pattern="dots"></fo:leader>
                                <fo:page-number-citation ref-id="{$id}"/>
                            </fo:basic-link>
                        </fo:block>
                </fo:list-item-body>
            </fo:list-item>
        </fo:list-block>
    </xsl:template>
    
    <!-- Tournamentpage Template -->
    <xsl:template match="tournament">
        <fo:page-sequence master-reference="tournament-page">
            
            <fo:static-content flow-name="tournament-footer">
                <fo:block font-size="12pt" text-align="end">
                    Seite <fo:page-number/>
                </fo:block>
            </fo:static-content>
            
            <fo:flow flow-name="xsl-region-body" font-family="Arial" font-size="18pt">
                <fo:block font-size="40pt"  id="{@tournament_id}"><xsl:value-of select="@name"/></fo:block>
                <fo:block margin-top="15">Wird veranstaltet in:</fo:block>
                <fo:block margin-top="10" font-size="14pt"><xsl:value-of select="concat(location/@street, ' ', location/@street_no, '; ',location/@zip_code, ' ', location/@iso_code)"/></fo:block>
                <fo:block margin-top="30">Folgende Runden wurden gespielt: </fo:block>
                <fo:block>
                    <xsl:for-each select="round">
                        <fo:block font-size="14pt">
                            <fo:basic-link internal-destination="{@round_id}">
                                <xsl:value-of select="concat(@round_name,' ', substring(@round_id, 7))"/>
                            </fo:basic-link>                            
                        </fo:block>
                    </xsl:for-each>
                </fo:block>
            </fo:flow>
        </fo:page-sequence>
        
        <xsl:apply-templates select="round"/>
        
    </xsl:template>
    
    <!-- Roundpage Template -->
    <xsl:template match="round">
        <fo:page-sequence master-reference="tournament-page">
            
            <fo:static-content flow-name="tournament-footer">
                <fo:block font-size="12pt" text-align="end">
                    Seite <fo:page-number/>
                </fo:block>
            </fo:static-content>
            
            <fo:flow flow-name="xsl-region-body" font-family="Arial" font-size="18pt">
                <fo:block font-size="40pt" id="{@round_id}"><xsl:value-of select="concat(@round_name,' ', substring(@round_id, 7))"/></fo:block>              
                <fo:block margin-top="30pt">Folgende Gruppen haben in dieser Runde gespielt: </fo:block>
                <fo:block>
                    <xsl:for-each select="group">
                        <fo:block font-size="14pt">
                            <fo:basic-link internal-destination="{@group_id}">
                                <xsl:value-of select="concat('Gruppe ', substring(@group_id, 7))"/>
                            </fo:basic-link>                          
                        </fo:block>
                    </xsl:for-each>
                </fo:block>
                <xsl:apply-templates select="." mode="rank"></xsl:apply-templates>
                <fo:block margin-top="15pt">Gruppenrangliste</fo:block>
                <xsl:apply-templates select="group" mode="rank"></xsl:apply-templates>
            </fo:flow>
            
        </fo:page-sequence>
        
        <xsl:apply-templates select="group"></xsl:apply-templates>
        
    </xsl:template>
    
    <!-- Rundenrangliste Template -->
    <xsl:template match="round" mode="rank">
        <fo:block margin-top="30pt">Rundenrangliste</fo:block>
        <fo:list-block margin-top="5pt" font-size="14pt">            
                <xsl:apply-templates select="group/has_member" mode="rank">
                    <xsl:sort select="sum(id(@archer_id)/scorecard/point/@target_points)" data-type="number" order="descending"/>
                </xsl:apply-templates>            
        </fo:list-block>
    </xsl:template>
    
    <!-- Gruppenrangliste Template -->
    <xsl:template match="group" mode="rank">                
            <fo:block font-size="16pt" margin-top="3pt">
                <fo:basic-link internal-destination="{@group_id}">
                    <xsl:value-of select="concat('Gruppe ', substring(@group_id, 7))"/> 
                </fo:basic-link>                
                <fo:list-block margin-top="5pt" font-size="14pt">
                    <xsl:apply-templates select="has_member" mode="rank">
                        <xsl:sort select="sum(id(@archer_id)/scorecard/point/@target_points)" data-type="number" order="descending"/>
                    </xsl:apply-templates>
                </fo:list-block>
            </fo:block>        
    </xsl:template>
    
    <!-- Rangliste Template -->
    <xsl:template match="has_member" mode="rank">
        <fo:list-item>
            <fo:list-item-label>
                <fo:block ><xsl:value-of select="position()"/>.</fo:block>
            </fo:list-item-label>
            <fo:list-item-body margin-left="5mm">                
                <fo:block>                    
                    <xsl:value-of select="concat(id(id(@archer_id)/@person_id)/@fname,
                        ' '
                        ,id(id(@archer_id)/@person_id)/@lname)"></xsl:value-of> = 
                    <fo:basic-link internal-destination="{@archer_id}" color="blue">
                    (<xsl:value-of select="sum(id(@archer_id)/scorecard/point/@target_points)"/>)
                    </fo:basic-link>
                </fo:block>
                
            </fo:list-item-body>
        </fo:list-item>
    </xsl:template>
    
    <!-- Grouppage Template -->
    <xsl:template match="group">
        <fo:page-sequence master-reference="tournament-page">
            
            <fo:static-content flow-name="tournament-footer">
                <fo:block font-size="12pt" text-align="end">
                    Seite <fo:page-number/>
                </fo:block>
            </fo:static-content>
            
            <fo:flow flow-name="xsl-region-body" font-family="Arial" font-size="12">
                <fo:block font-size="40pt" margin-top="3pt" id="{@group_id}"><xsl:value-of select="concat('Gruppe ', substring(@group_id, 7))"/></fo:block>
                <fo:block margin-top="15pt" margin-bottom="5pt" font-size="14pt">Gruppenmitglieder: </fo:block>
                <xsl:apply-templates select="has_member" mode="list"></xsl:apply-templates>
                <xsl:apply-templates select="has_member"></xsl:apply-templates>
            </fo:flow>
            
        </fo:page-sequence>
    </xsl:template>
    
    <!-- Grouplist Template -->
    <xsl:template match="has_member" mode="list">
        <fo:list-block font-size="12pt">
            <fo:list-item>
                <fo:list-item-label>
                    <fo:block><xsl:value-of select="position()"/>.</fo:block>
                </fo:list-item-label>
                <fo:list-item-body>
                    <fo:block margin-left="5mm">
                        <fo:basic-link internal-destination="{@archer_id}">
                        <xsl:value-of select="concat(id(id(@archer_id)/@person_id)/@fname,' ',id(id(@archer_id)/@person_id)/@lname)"/>
                        </fo:basic-link>
                    </fo:block>
                </fo:list-item-body>
            </fo:list-item>
        </fo:list-block>
    </xsl:template>
    
    <!-- Scorecard Template -->
    <xsl:template match="has_member">       
        <fo:block font-size="14pt" font-weight="bold" margin-top="15pt"  margin-bottom="40pt" page-break-inside="avoid" id="{@archer_id}">
                    <xsl:value-of select="concat('Scorecard von ', id(id(@archer_id)/@person_id)/@fname,' ',id(id(@archer_id)/@person_id)/@lname, ':')"></xsl:value-of>
                    <fo:block margin-top="10pt">  
                        <fo:table>
                            <fo:table-body>
                                <fo:table-row>
                                    <fo:table-cell border="1pt solid black">
                                        <fo:block margin-left="30mm">
                                            Ziel
                                        </fo:block>                                        
                                    </fo:table-cell>
                                    <fo:table-cell  border="1pt solid black">
                                        <fo:block margin-left="30mm">
                                            Punkte
                                        </fo:block> 
                                    </fo:table-cell>
                                </fo:table-row>
                                <xsl:apply-templates select="id(@archer_id)/scorecard/point"/>
                            </fo:table-body>
                        </fo:table>                
                    </fo:block>           
                </fo:block>                 
    </xsl:template>
    
    <!-- ScorecardTableRows Template -->
    <xsl:template match="scorecard/point">        
            <fo:table-row font-size="12pt" font-weight="normal">
                <fo:table-cell border="1pt solid black">
                    <fo:block>
                        <xsl:value-of select="concat('Target ', substring(@target_no, 8))"></xsl:value-of>
                    </fo:block>
                </fo:table-cell>
                <fo:table-cell border="1pt solid black">
                    <fo:block>
                        <xsl:value-of select="@target_points"></xsl:value-of>
                    </fo:block>
                </fo:table-cell>
            </fo:table-row>        
    </xsl:template>
    
</xsl:stylesheet>

