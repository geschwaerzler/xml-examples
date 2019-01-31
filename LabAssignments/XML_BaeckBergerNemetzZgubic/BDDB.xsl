<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0"
    xmlns:fo="http://www.w3.org/1999/XSL/Format">
    
    <xsl:template match="/breakdance-datenbank">
        <fo:root>
                    <fo:layout-master-set>
                        <!-- here we define the layout of pages. There might be differrent page masters with e.g. different margin settings -->
                        <fo:simple-page-master master-name="crew-page"
                            page-height="297.0mm" page-width="209.9mm"
                            margin-bottom="8mm" margin-left="25mm" margin-right="10mm" margin-top="10mm">
                            
                            <fo:region-body margin-bottom="28mm" margin-left="0mm" margin-right="44mm" margin-top="60mm"/>
                            <fo:region-before extent="24pt" region-name="crew-header"/>
                            <fo:region-after extent="24pt" region-name="crew-footer"/>                    
                        </fo:simple-page-master>
                    </fo:layout-master-set>
                    
                    <fo:page-sequence master-reference="crew-page">    
                        <fo:flow flow-name="xsl-region-body" font-family="serif" font-size="9pt">
                            <fo:block font-weight="bold" font-size="40pt">Crew Liste</fo:block>
                            <fo:list-block space-before="24pt">
                                <xsl:apply-templates select="//crew" mode="toc"/>
                            </fo:list-block>
                        </fo:flow>
                    </fo:page-sequence>
                    
                    <xsl:apply-templates select="//crew" mode="detail"/>
                    
                    
                    
                </fo:root>
            </xsl:template>
            
            <xsl:template match="crew" mode="toc">
                <fo:list-item>
                    <fo:list-item-label>
                        <fo:block><xsl:value-of select="position()"/>.</fo:block>
                    </fo:list-item-label>
                    <fo:list-item-body start-indent="4mm">
                        <fo:block text-align-last="justify">
                            <xsl:value-of select="@crew_name"/>
                            <fo:leader leader-pattern="dots"></fo:leader>
                            <fo:page-number-citation ref-id="{generate-id()}"/>
                        </fo:block>
                    </fo:list-item-body>
                </fo:list-item>
            </xsl:template> 
            
            
            <xsl:template match="crew" mode="detail">
                <xsl:param name="crewId"/>
                <fo:page-sequence master-reference="crew-page">   
                    <fo:static-content flow-name="crew-footer">
                        <fo:block>Seite: <fo:page-number/></fo:block>
                    </fo:static-content>
                    <fo:flow flow-name="xsl-region-body" font-family="serif" font-size="9pt" id = "{generate-id()}">
                        <fo:block font-weight="bold" font-size="25pt" color="olive"><xsl:value-of select="@crew_name"/></fo:block>
                        <fo:block text-align-last="justify">                          
                            <fo:leader leader-pattern="rule"></fo:leader>    
                        </fo:block>
                        <fo:block>Lehrer</fo:block>
                        <fo:block font-weight="bold"><xsl:value-of select="id(@lehrer_id)/@vname"/></fo:block>
                        <fo:block text-align-last="justify">                          
                            <fo:leader leader-pattern="dots"></fo:leader>    
                        </fo:block>
                        <fo:block>Mitglieder:</fo:block>
                        <fo:list-block space-before="24pt">
                            <xsl:apply-templates select="./crewmember" mode="member"/>
                        </fo:list-block>
                        <fo:block text-align-last="justify">                          
                            <fo:leader leader-pattern="dots"></fo:leader>    
                        </fo:block>
                        <fo:block>Unterrichtseinheit:</fo:block>
                        <fo:list-block space-before="24pt">
                            <xsl:apply-templates select="." mode="wochentag"/>
                            <xsl:apply-templates select="." mode="stundenplan"/>
                            
                        </fo:list-block>
       
                        
                        
                    </fo:flow>
                </fo:page-sequence> 
            </xsl:template> 
            
            <xsl:template match="crewmember" mode="member" xml:space="preserve">
        <xsl:param name="schuelerID" select="@schueler_id"/>
        <fo:list-item >
            <fo:list-item-label>
                <fo:block>-</fo:block>
            </fo:list-item-label>
            <fo:list-item-body start-indent="4mm">
                <fo:block text-align-last="start">
                    <xsl:value-of select="//person[@id=$schuelerID]/@vname"/>
                    <xsl:value-of select="//person[@id=$schuelerID]/@nname"/>
                    <fo:page-number-citation ref-id="{generate-id()}"/>
                </fo:block>
            </fo:list-item-body>
        </fo:list-item>
    </xsl:template> 
            
            <xsl:template match="crew" mode="stundenplan">
                <xsl:param name="crewId" select="./@id"/>
                <fo:list-item>
                    <fo:list-item-label>
                        <fo:block></fo:block>
                    </fo:list-item-label>
                    <fo:list-item-body start-indent="4mm">
                        
                        <fo:block text-align-last="justify">
                            <xsl:value-of select="//schulstandort/raum/unterrichtseinheit[@crew_id = $crewId]/@ue_startZeit"/>
                            <xsl:value-of select="./crew/@id"/>
                      
                        </fo:block>
                    </fo:list-item-body>
                </fo:list-item>
            </xsl:template>
    
    <xsl:template match="crew" mode="wochentag">
        <xsl:param name="crewId" select="./@id"/>
        <fo:list-item>
            <fo:list-item-label>
                <fo:block></fo:block>
            </fo:list-item-label>
            <fo:list-item-body start-indent="4mm">
                
                <fo:block text-align-last="justify">
                    <xsl:value-of select="//schulstandort/raum/unterrichtseinheit[@crew_id = $crewId]/@ue_wochentag"/>
                    <xsl:value-of select="./crew/@id"/>
               
                </fo:block>
            </fo:list-item-body>
        </fo:list-item>
    </xsl:template>
            
            
</xsl:stylesheet>