<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format">
    <xsl:key name="stationkey" match="Station" use="@id"/>
    <!-- ............................ ROOT TEMPLATE .......................... -->
    <xsl:template match="/">
        <fo:root>
            
            <!-- define the layout of the document -->
            <fo:layout-master-set>
                <!-- here we define the layout of pages. There might be differrent page masters with e.g. different margin settings -->
                <fo:simple-page-master master-name="main-page"
                    page-height="297.0mm" page-width="209.9mm"
                    margin-bottom="8mm" margin-left="25mm" margin-right="25mm" margin-top="10mm">
                    
                    <!-- the content will be placed into the region-body -->
                    <fo:region-body margin-bottom="28mm" margin-left="0mm" margin-right="0mm" margin-top="60mm"/>
                    
                </fo:simple-page-master>
                <fo:simple-page-master master-name="pages"
                    page-height="297.0mm" page-width="209.9mm"
                    margin-bottom="10mm" margin-left="20mm" margin-right="20mm" margin-top="10mm">
                    
                    <!-- the content will be placed into the region-body -->
                    <fo:region-body margin-bottom="10mm" margin-left="0mm" margin-right="0mm" margin-top="15mm"/>
                    
                </fo:simple-page-master>
            </fo:layout-master-set>
            
            
            <!-- Here comes the content.
                 Printed content consists of one or more page-sequences. Each page-sequence starts on a new page. -->
            
            <!-- front page -->
            <fo:page-sequence master-reference="main-page">
                <fo:flow flow-name="xsl-region-body" font-family="sans-serif" font-size="28pt">
                    <fo:block font-size="40pt" text-align="justify" line-height="1.5">
                        Unser Projekt zum Aufbau des Archery-Parkours
                    </fo:block>
                    <fo:block font-size="20pt" text-align="justify">
                        von Justin Jeremias Kirchmann, Zikrihan Sahin und Michael Adrian Rumpelnig                        
                    </fo:block>
                </fo:flow>
            </fo:page-sequence>
            
            <fo:page-sequence master-reference="pages">
                <fo:flow flow-name="xsl-region-body" font-family="sans-serif">
                   
                    <fo:block font-size="30pt" margin-bottom="20pt">
                        Inhaltsverzeichnis:                        
                    </fo:block>
                    
                    <fo:block>                        
                       
                        <fo:list-block>
                            
                            <fo:list-item>
                                
                                <fo:list-item-label>
                                    
                                    <fo:block>
                                        <fo:basic-link internal-destination="1" font-weight="bold">
                                            Liste der Teams mit ihren Teammembern                                            
                                        </fo:basic-link>
                                    </fo:block>
                                
                                </fo:list-item-label>
                                
                                <fo:list-item-body font-weight="bold" start-indent="165mm">
                                    
                                    <fo:block>                                        
                                        <fo:basic-link internal-destination="1"><fo:page-number-citation ref-id="1"/></fo:basic-link>
                                    </fo:block>
                                    
                                </fo:list-item-body>
                                
                            </fo:list-item>
                            
                            <fo:list-item>
                                
                                <fo:list-item-label>
                                    <fo:block>                                        
                                        <fo:basic-link internal-destination="2" font-weight="bold">
                                            Liste der Teams und den ihnen zugeteilten Stationen
                                        </fo:basic-link>                                        
                                    </fo:block>
                                </fo:list-item-label>
                                
                                <fo:list-item-body font-weight="bold" start-indent="165mm">
                                    <fo:block>                                        
                                        <fo:basic-link internal-destination="2"><fo:page-number-citation ref-id="2"/></fo:basic-link>
                                    </fo:block>
                                    
                                </fo:list-item-body>
                                
                            </fo:list-item>
                            
                        </fo:list-block>
                        
                    </fo:block>
                    
                </fo:flow>
            </fo:page-sequence>
            
            <fo:page-sequence master-reference="pages">
                <fo:flow flow-name="xsl-region-body" font-family="sans-serif">
                    <fo:block font-size="30pt" margin-bottom="20pt" id="1">
                        Liste der Teams mit ihren Teammembern:
                    </fo:block>                    
                    
                    <xsl:for-each select="Aufbau/Team">
                        
                        <fo:block font-size="20pt" margin-bottom="5pt" color="blue">
                            <xsl:value-of select="@id"/>
                        </fo:block>
                        
                        <fo:table table-layout="fixed" margin-bottom="10pt">
                            <fo:table-body>
                               <fo:table-row>
                                   <fo:table-cell><fo:block font-weight="bold">Member-ID</fo:block></fo:table-cell>
                                   <fo:table-cell><fo:block font-weight="bold">Vorname</fo:block></fo:table-cell>
                                   <fo:table-cell><fo:block font-weight="bold">Nachname</fo:block></fo:table-cell>
                               </fo:table-row>
                                
                               <xsl:for-each select="Team_Member">
                                   
                                   <fo:table-row>
                                       <fo:table-cell><fo:block><xsl:value-of select="@id" /></fo:block></fo:table-cell>
                                       <fo:table-cell><fo:block><xsl:value-of select="@fname" /></fo:block></fo:table-cell>
                                       <fo:table-cell><fo:block><xsl:value-of select="@lname" /></fo:block></fo:table-cell>
                                   </fo:table-row>
                                   
                               </xsl:for-each>
                                
                            </fo:table-body>
                        </fo:table>
                                                
                    </xsl:for-each>
                                                            
                </fo:flow>
            </fo:page-sequence>
            
            <fo:page-sequence master-reference="pages">
                <fo:flow flow-name="xsl-region-body" font-family="sans-serif">
                    
                    <fo:block font-size="30pt" margin-bottom="20pt" id="2">Liste der Teams und den ihnen zugeteilten Stationen</fo:block>
                    
                    <xsl:for-each select="Aufbau/Team">
                        
                        <fo:block font-size="20pt" margin-bottom="5pt" color="red"><xsl:value-of select="@id"/></fo:block>
                        
                        <fo:table margin-bottom="10pt">
                            <fo:table-body>
                                
                                <fo:table-row>
                                    <fo:table-cell><fo:block font-weight="bold">Stations-ID</fo:block></fo:table-cell>
                                    <fo:table-cell><fo:block font-weight="bold">Position-NS</fo:block></fo:table-cell>
                                    <fo:table-cell><fo:block font-weight="bold">Position-WE</fo:block></fo:table-cell>
                                </fo:table-row>
                                
                                <xsl:for-each select="builds">
                                    
                                    <xsl:for-each select="key('stationkey',@station_id)">
                                        
                                        <fo:table-row>
                                            <fo:table-cell><fo:block><xsl:value-of select="@id"/></fo:block></fo:table-cell>
                                            <fo:table-cell><fo:block><xsl:value-of select="@position_ns"/></fo:block></fo:table-cell>
                                            <fo:table-cell><fo:block><xsl:value-of select="@position_we"/></fo:block></fo:table-cell>
                                        </fo:table-row>
                                        
                                    </xsl:for-each>
                                    
                                </xsl:for-each>
                                
                            </fo:table-body>
                        </fo:table>
                        
                    </xsl:for-each>
                    
                </fo:flow>
            </fo:page-sequence>
            
        </fo:root>
    </xsl:template>
    
</xsl:stylesheet>