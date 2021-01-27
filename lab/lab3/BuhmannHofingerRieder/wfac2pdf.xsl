<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format">
    <!-- Buhmann Tobias, Hofinger Victoria, Rieder David -->
    
    <!-- ............................ ROOT TEMPLATE .......................... -->
    <xsl:template match="/">
        <fo:root>
            
            <!-- define the layout of the document -->
            <fo:layout-master-set>
                <!-- here we define the layout of pages. There might be differrent page masters with e.g. different margin settings -->
                <fo:simple-page-master master-name="wfac-page" page-height="297.0mm"
                    page-width="209.9mm" margin-bottom="8mm" margin-left="25mm" margin-right="10mm"
                    margin-top="10mm">
                    
                    <!-- the content will be placed into the region-body -->
                    <fo:region-body margin-bottom="28mm" margin-left="0mm" margin-right="44mm"
                        margin-top="20mm"/>
                    
                    <fo:region-before extent="24pt" region-name="wfac-header"/>
                    
                    <fo:region-after extent="24pt" region-name="wfac-footer"/>
                    
                </fo:simple-page-master>
            </fo:layout-master-set>
            
            <fo:page-sequence master-reference="wfac-page">
                <fo:flow flow-name="xsl-region-body" font-family="sans-serif" font-size="28pt">
                    <fo:block font-size="50pt" font-weight="bold" text-align="center" margin-top="100mm"> WFAC2020 </fo:block>
                </fo:flow>
            </fo:page-sequence>
            <fo:page-sequence master-reference="wfac-page">
                <fo:static-content flow-name="wfac-footer">
                    <fo:block font-size="10pt" text-align="center"> page <fo:page-number/>
                    </fo:block>
                </fo:static-content>
                <fo:flow flow-name="xsl-region-body" font-family="sans-serif" font-size="28pt">
                    <fo:list-block margin-top="24pt">
                        <xsl:apply-templates select="tournament/tournamentday/group" mode="toc"/>
                    </fo:list-block>
                    
                </fo:flow>
            </fo:page-sequence>
            <fo:page-sequence master-reference="wfac-page">
                <fo:static-content flow-name="wfac-footer">
                    <fo:block font-size="10pt" text-align="center"> page <fo:page-number/>
                    </fo:block>
                </fo:static-content>
                <fo:flow flow-name="xsl-region-body">
                    <fo:block font-size="10pt" text-align="left">
                        <xsl:apply-templates select="tournament/tournamentday" mode="toc"/>
                    </fo:block>
                </fo:flow>
            </fo:page-sequence>
            <fo:page-sequence master-reference="wfac-page">
                <fo:static-content flow-name="wfac-footer">
                    <fo:block font-size="10pt" text-align="center"> page <fo:page-number/>
                    </fo:block>
                </fo:static-content>
                <fo:flow flow-name="xsl-region-body">
                    <fo:block font-size="10pt" text-align="left">
                        <xsl:apply-templates select="tournament/tournamentday/group/competitor"
                            mode="scc"/>
                    </fo:block>
                </fo:flow>
            </fo:page-sequence>
            
            
            
            
        </fo:root>
    </xsl:template>
    <xsl:template match="group" mode="toc">
        <fo:list-item>
            <fo:list-item-label>
                <fo:block> </fo:block>
            </fo:list-item-label>
            <fo:list-item-body start-indent="10mm">
                <fo:block text-align-last="justify">
                    <xsl:variable name="gid" select="@id"/>
                    <fo:basic-link internal-destination="{$gid}">
                        <xsl:value-of select="tournament/tournamentday/group"/> Group <xsl:value-of
                            select="substring-after($gid, 'g')"/> - <xsl:value-of select="../@date"/>
                        <fo:leader leader-pattern="dots"/>
                        <fo:page-number-citation ref-id="{@id}"/>
                    </fo:basic-link>
                </fo:block>
            </fo:list-item-body>
        </fo:list-item>
    </xsl:template>
    
    <xsl:template match="tournamentday" mode="toc">
        <fo:block font-size="16pt" font-weight="bold" page-break-before="always">
            <xsl:value-of select="position()"/>. Day, <xsl:value-of select="@date"/>
        </fo:block>
        
        <xsl:apply-templates select="group" mode="detail"> </xsl:apply-templates>
        <fo:block font-size="16pt" font-weight="bold" margin="10pt">
            <xsl:value-of select="position()"/>. Day, scoring </fo:block>
        
        <xsl:for-each select="group/competitor">
            <xsl:sort select="scorecard/@totalscore" data-type="number" order="descending"/>
            <fo:block  font-size="16pt">
                <xsl:value-of select="position()"/>. <xsl:variable name="id" select="@person_id"/>
                <xsl:variable name="idg" select="../@id"/>
                <xsl:variable name="fname" select="id($id)/@fname"/>
                <xsl:variable name="lname" select="id($id)/@lname"/>
                <xsl:value-of select="concat($fname, ' ', $lname)"/> (<xsl:value-of
                    select="scorecard/@totalscore"/>) </fo:block>
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template match="group" mode="detail">
        <xsl:variable name="gid" select="@id"/>
        <fo:block id="{$gid}" font-size="16pt" font-weight="bold" margin="10pt">
            <xsl:value-of select="group"/>
            <!-- <h2 id="{generate-id()}"> --> Group <xsl:value-of
                select="substring-after($gid, 'g')"/>
        </fo:block>
        
        <xsl:for-each select="competitor">
            
            <xsl:variable name="idg" select="../@id"/>
            <xsl:variable name="id" select="@person_id"/>
            <xsl:variable name="fname" select="id($id)/@fname"/>
            <xsl:variable name="lname" select="id($id)/@lname"/>
            <fo:block font-size="16pt">
                <xsl:value-of select="concat($fname, ' ', $lname)"/>
                <fo:basic-link internal-destination="{concat($idg,$id)}" text-decoration="underline"
                    > (<xsl:value-of select="scorecard/@totalscore"/>) </fo:basic-link>
            </fo:block>
        </xsl:for-each>
        
    </xsl:template>
    
    <xsl:template match="competitor" mode="scc">
        <xsl:variable name="idg" select="../@id"/>
        <xsl:variable name="idp" select="@person_id"/>
        <fo:block-container>
            <fo:block id="{concat($idg,$idp)}" font-size="16pt" font-weight="bold" margin="10pt">
                <xsl:value-of select="id($idp)/@fname"/>
                <xsl:text>  </xsl:text><xsl:value-of select="id($idp)/@lname"/> Group <xsl:value-of
                    select="substring-after($idg, 'g')"/> - <xsl:value-of select="../../@date"/>
            </fo:block>
            
            <fo:block>
                <fo:table border="1pt solid black" text-align="center">
                    
                    <fo:table-header>
                        <fo:table-row>
                            <fo:table-cell border="1pt solid black">
                                <fo:block>target#</fo:block>
                            </fo:table-cell>
                            <fo:table-cell border="1pt solid black">
                                <fo:block>arrow1</fo:block>
                            </fo:table-cell>
                            <fo:table-cell border="1pt solid black">
                                <fo:block>arrow2</fo:block>
                            </fo:table-cell>
                            <fo:table-cell border="1pt solid black">
                                <fo:block>arrow3</fo:block>
                            </fo:table-cell>
                            <fo:table-cell border="1pt solid black">
                                <fo:block>arrow4</fo:block>
                            </fo:table-cell>
                        </fo:table-row>
                    </fo:table-header>
                    
                    <fo:table-body>
                        <xsl:for-each select="scorecard">
                            <xsl:for-each select="station">
                                <fo:table-row>
                                    <fo:table-cell border="1pt solid black">
                                        <fo:block>
                                            <xsl:value-of select="position()"/>
                                        </fo:block>
                                    </fo:table-cell>
                                    
                                    <xsl:for-each select="Scorentry">
                                        <fo:table-cell border="1pt solid black">
                                            <fo:block>
                                                <xsl:value-of select="@points"/>
                                            </fo:block>
                                        </fo:table-cell>
                                    </xsl:for-each>
                                </fo:table-row>
                            </xsl:for-each>
                        </xsl:for-each>
                        
                    </fo:table-body>
                </fo:table>
            </fo:block>
        </fo:block-container>
    </xsl:template>
</xsl:stylesheet>