<?xml version="1.0" encoding="UTF-8"?> 

<xsl:stylesheet
    xmlns:fo="http://www.w3.org/1999/XSL/Format"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"> 
    
    <xsl:template match="/tournament">
        <fo:root>
            
            <fo:layout-master-set>
                <fo:simple-page-master  master-name="tournament" 
                    page-height="297.0mm" 
                    page-width="209.9mm" 
                    margin-bottom="8mm" 
                    margin-left="25mm" 
                    margin-right="10mm" 
                    margin-top="10mm">
                    <fo:region-body margin-bottom="28mm" margin-left="0mm" margin-right="44mm" margin-top="20mm"/>
                    <fo:region-before extent="24pt" region-name="tournament-header"/>
                    <fo:region-after extent="24pt" region-name="tournament-footer"/>
                </fo:simple-page-master>
            </fo:layout-master-set>
            
            <fo:page-sequence master-reference="tournament">
                <fo:flow flow-name="xsl-region-body">
                    <fo:block font-size="14pt" font-weight="800"  space-after="12pt">
                        Overview
                    </fo:block>
                    <fo:list-block>
                        <xsl:for-each select="classifications/shootingstyles/shootingstyle">
                            <fo:list-item>
                                <fo:list-item-label>
                                    <fo:block><xsl:value-of select="position()"/>.</fo:block>
                                </fo:list-item-label>
                                <fo:list-item-body start-indent="8mm">
                                    <fo:block text-align-last="justify"> 
                                        <fo:basic-link internal-destination="{@id}">
                                            <xsl:value-of select="@name"/>  
                                        </fo:basic-link>
                                        <fo:leader leader-pattern="dots"/>
                                        <fo:page-number-citation ref-id="{generate-id()}"/>
                                    </fo:block>
                                </fo:list-item-body>
                            </fo:list-item>
                        </xsl:for-each>
                    </fo:list-block>
                </fo:flow>
            </fo:page-sequence>
            
            <xsl:apply-templates select="classifications/shootingstyles/shootingstyle"/>
            
        </fo:root>
    </xsl:template>
    
    
    
    <xsl:template match="shootingstyle">
        <fo:page-sequence master-reference="tournament">
            <fo:static-content flow-name="tournament-header">
                <fo:block font-size="10pt" text-align="center">
                    JAVICH Archery Tournament
                </fo:block>
            </fo:static-content>
            <fo:static-content flow-name="tournament-footer">
                <fo:block font-size="10pt" text-align="center" id="{generate-id()}">
                    Page <fo:page-number/>
                </fo:block>
            </fo:static-content>
            <fo:flow flow-name="xsl-region-body">
                <fo:block font-size="14pt" font-weight="800"  space-after="12pt" id="{@id}">
                    <xsl:value-of select="@name"/>
                </fo:block>
                
                <xsl:if test="rule">
                    <fo:block font-weight="800" space-before="24pt" space-after="12pt">
                        Rules:
                    </fo:block>
                    <fo:list-block>
                        <xsl:for-each select="rule">
                            <fo:list-item>
                                <fo:list-item-label>
                                    <fo:block><xsl:value-of select="position()"/>.</fo:block>
                                </fo:list-item-label>
                                <fo:list-item-body start-indent="8mm">
                                    <fo:block>
                                        <xsl:value-of select="description"/>
                                    </fo:block>
                                </fo:list-item-body>
                            </fo:list-item>
                        </xsl:for-each>
                    </fo:list-block>                    
                </xsl:if>
                
                <fo:block font-weight="800" space-before="24pt" space-after="12pt">
                    Attendees
                </fo:block>
                <xsl:variable name="attendees" select="//person[substring-after(@classification, upper-case(@gender)) = current()/@id]"/>
                <xsl:choose>
                    <xsl:when test="$attendees">
                        <fo:list-block>
                            <xsl:for-each select="$attendees">
                                <xsl:sort select="lastname"/>
                                <fo:list-item>
                                    <fo:list-item-label>
                                        <fo:block/>
                                    </fo:list-item-label>
                                    <fo:list-item-body>
                                        <fo:block>
                                            <xsl:value-of select="concat(lastname, ' ',firstname )"/>
                                        </fo:block>
                                    </fo:list-item-body>
                                </fo:list-item>
                            </xsl:for-each>
                        </fo:list-block>                        
                    </xsl:when>
                    <xsl:otherwise>
                        <fo:block>There are no attendees for shooting style <xsl:value-of select="@name"/></fo:block>
                    </xsl:otherwise>
                </xsl:choose>
            </fo:flow>
        </fo:page-sequence>
    </xsl:template>    
</xsl:stylesheet>







