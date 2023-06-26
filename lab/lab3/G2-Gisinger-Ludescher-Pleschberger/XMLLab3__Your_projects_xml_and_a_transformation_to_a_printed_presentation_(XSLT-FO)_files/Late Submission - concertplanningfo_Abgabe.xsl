<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    xmlns:fo="http://www.w3.org/1999/XSL/Format">
    <xsl:output method="xml" indent="yes"/>
    
    <xsl:template match="/concert-planning">
        <fo:root>
            <fo:layout-master-set>
                <fo:simple-page-master 
                        master-name="Concert-Planner"
                        page-height="297.0mm" page-width="209.9mm"
                        margin-bottom="8mm" margin-left="25mm" margin-right="10mm" margin-top="10mm">
         
                     <fo:region-body margin-bottom="28mm" margin-left="0mm" margin-right="44mm" margin-top="20mm"/>                             
                     <fo:region-before extent="24pt" region-name="Concert-Planner-header"/>                                          
                     <fo:region-after extent="24pt" region-name="Concert-Planner-footer"/>
                </fo:simple-page-master>
            </fo:layout-master-set>  
            <!-- front-page -->
            <fo:page-sequence master-reference="Concert-Planner">
                <fo:flow flow-name="xsl-region-body" font-family="sans-serif" font-size="30pt">
                    <fo:block margin-top="40mm">
                        Concert Planning
                    </fo:block>
                </fo:flow>
            </fo:page-sequence>
            
            <!-- First page -->
            <fo:page-sequence master-reference="Concert-Planner">
                <fo:flow flow-name="xsl-region-body">
                    <fo:block>
                        <fo:block font-size="16pt" font-weight="bold" text-align="center">Table of
                            Content</fo:block>
                        <fo:block font-size="12pt" text-align-last="justify">
                            <fo:basic-link internal-destination="cl">Concert-List
                                <fo:leader leader-pattern="dots"></fo:leader>
                            <fo:page-number-citation ref-id="cl"/></fo:basic-link>
                        </fo:block>
                        <fo:block font-size="12pt" text-align-last="justify">
                            <fo:basic-link internal-destination="clbt">Customer-List and bought
                                tickets
                                <fo:leader leader-pattern="dots"></fo:leader>
                                <fo:page-number-citation ref-id="clbt"/></fo:basic-link>
                        </fo:block>
                        <fo:block font-size="12pt" text-align-last="justify">
                            <fo:basic-link internal-destination="al">Artist-List
                                <fo:leader leader-pattern="dots"></fo:leader>
                                <fo:page-number-citation ref-id="al"/></fo:basic-link>
                        </fo:block>
                        <fo:block font-size="12pt" text-align-last="justify">
                            <fo:basic-link internal-destination="vl">Venue-List
                                <fo:leader leader-pattern="dots"></fo:leader>
                                <fo:page-number-citation ref-id="vl"/></fo:basic-link>
                        </fo:block>
                    </fo:block>
                </fo:flow>
            </fo:page-sequence>
            
            
            <fo:page-sequence master-reference="Concert-Planner">
                <fo:static-content flow-name="Concert-Planner-footer" text-align="left">
                    <fo:block>
                        Page: <fo:page-number id="cl"/>
                    </fo:block>
                </fo:static-content>
                <fo:static-content flow-name="Concert-Planner-header" text-align="justify" >
                    <xsl:for-each select="concert">
                        <fo:block font-size="6pt">
                        <xsl:value-of select="@title"/>
                    </fo:block>
                    </xsl:for-each>
                </fo:static-content>
                    <fo:flow flow-name="xsl-region-body">
                        <fo:block>
                            <fo:block font-size="16pt" font-weight="bold">Concert-List
                          </fo:block>
                            <xsl:apply-templates select="concert" mode="details"/>
                        </fo:block>
                    </fo:flow>
            </fo:page-sequence>   
            <fo:page-sequence master-reference="Concert-Planner">
                <fo:static-content flow-name="Concert-Planner-footer" text-align="left">
                    <fo:block>
                        Page: <fo:page-number id="clbt"/>
                    </fo:block>
                </fo:static-content>
                <fo:static-content flow-name="Concert-Planner-header" text-align="justify" >
                    <xsl:for-each select="concert">
                        <fo:block font-size="6pt">
                            <xsl:value-of select="concat(@title, ': ' , @description)"/>
                        </fo:block>
                    </xsl:for-each>
                </fo:static-content>
                <fo:flow flow-name="xsl-region-body">
                        <fo:block>
                            <fo:block font-size="16pt" font-weight="bold">Customer-List and bought
                                tickets</fo:block>
                            <xsl:apply-templates select="customer" mode="default"/>
                        </fo:block>
                </fo:flow>
            </fo:page-sequence>
            
            <fo:page-sequence master-reference="Concert-Planner">
                <fo:static-content flow-name="Concert-Planner-footer" text-align="left">
                    <fo:block>
                        Page: <fo:page-number id="al"/>
                    </fo:block>
                </fo:static-content>
                <fo:static-content flow-name="Concert-Planner-header" text-align="justify" >
                    <xsl:for-each select="artist">
                        <fo:block font-size="6pt" >
                            
                            <xsl:value-of select="concat(@name, ': ' , @description)"/>
                        </fo:block>
                    </xsl:for-each>
                </fo:static-content>
                <fo:flow flow-name="xsl-region-body">
  
                        <fo:block>
                            <fo:block font-size="16pt" font-weight="bold">Artist-List</fo:block>
                            <xsl:apply-templates select="artist" mode="default"/>
                        </fo:block>
                </fo:flow>
            </fo:page-sequence>
            <fo:page-sequence master-reference="Concert-Planner">
                <fo:static-content flow-name="Concert-Planner-footer" text-align="left">
                    <fo:block>
                        Page: <fo:page-number id="vl"/>
                    </fo:block>
                </fo:static-content>
                <fo:flow flow-name="xsl-region-body">
                        
                        <fo:block>
                            <fo:block font-size="16pt" font-weight="bold">Venue-List</fo:block>
                            <xsl:apply-templates select="venue" mode="default"/>
                        </fo:block>
                    </fo:flow>
            </fo:page-sequence>
        </fo:root>   
    </xsl:template>
    
    <xsl:template match="venue" mode="default">
        <fo:block>
            <fo:table>
                <fo:table-column column-width="auto"/>
                <fo:table-column column-width="auto"/>
                <fo:table-column column-width="auto"/>
                <fo:table-header>
                    <fo:table-row>
                        <fo:table-cell>
                            <fo:block>Venuename</fo:block>
                        </fo:table-cell>
                        <fo:table-cell>
                            <fo:block>Address</fo:block>
                        </fo:table-cell>
                        <fo:table-cell>
                            <fo:block>Capacity</fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                </fo:table-header>
                <fo:table-body>
                    <fo:table-row>
                        <fo:table-cell>
                            <fo:block>
                                <xsl:value-of select="@name"/>
                            </fo:block>
                        </fo:table-cell>
                        <fo:table-cell>
                            <fo:block>
                                <xsl:value-of select="@address"/>
                            </fo:block>
                        </fo:table-cell>
                        <fo:table-cell>
                            <fo:block>
                                <xsl:value-of select="@capacity"/>
                            </fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                </fo:table-body>
            </fo:table>
        </fo:block>
    </xsl:template>
    
    <xsl:template match="artist" mode="default">
        <fo:block>
            <fo:table>
                <fo:table-column column-width="auto"/>
                <fo:table-column column-width="auto"/>
                <fo:table-column column-width="auto"/>
                <fo:table-header>
                    <fo:table-row>
                        <fo:table-cell>
                            <fo:block>Name</fo:block>
                        </fo:table-cell>
                        <fo:table-cell>
                            <fo:block>Genre</fo:block>
                        </fo:table-cell>
                        <fo:table-cell>
                            <fo:block>Artist-ID</fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                </fo:table-header>
                <fo:table-body>
                    <fo:table-row>
                        <fo:table-cell>
                            <fo:block>
                                <xsl:value-of select="@name"/>
                            </fo:block>
                        </fo:table-cell>
                        <fo:table-cell>
                            <fo:block>
                                <xsl:value-of select="@genre"/>
                            </fo:block>
                        </fo:table-cell>
                        <fo:table-cell>
                            <fo:block>
                                <xsl:value-of select="@artist_id"/>
                            </fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                </fo:table-body>
            </fo:table>
        </fo:block>
    </xsl:template>
    
    <xsl:template match="concert" mode="details">
        <xsl:variable name="concert" select="@concert_id"/>
        <fo:block>
            <fo:table>
                <fo:table-column column-width="auto"/>
                <fo:table-column column-width="auto"/>
                <fo:table-header>
                    <fo:table-row>
                        
                        <fo:table-cell>
                            <fo:block>Ticket ID</fo:block>
                        </fo:table-cell>
                        <fo:table-cell>
                            <fo:block>Customer</fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                </fo:table-header>
                <fo:table-body>
                    <fo:table-row>
                        <fo:table-cell>
                            <xsl:for-each select="../ticket_ref">
                               
           
                            <fo:block>
                               
                                <xsl:value-of select=".[@concert_id = $concert]/@ticket_id"/>
                            </fo:block>
                            </xsl:for-each>
                        </fo:table-cell>
                        <fo:table-cell>
                            <xsl:for-each select="../ticket_ref">
                               
                            <fo:block>
                                
                                <xsl:value-of
                                    select="id(.[@concert_id = $concert]/@customer_id)/@name"
                                />
                            </fo:block>
                            </xsl:for-each>
                        </fo:table-cell>
                    </fo:table-row>
                </fo:table-body>
            </fo:table>
        </fo:block>
    </xsl:template>
    
    <xsl:template match="customer" mode="default">
        <xsl:variable name="customer" select="@customer_id"/>
            <fo:block>
                <fo:table>
                    <fo:table-column column-width="auto"/>
                    <fo:table-column column-width="auto"/>
                    <fo:table-column column-width="auto"/>
                    <fo:table-column column-width="auto"/>
                    <fo:table-header>
                        <fo:table-row>
                            <fo:table-cell>
                                <fo:block>
                                    <xsl:value-of select="@name"/>
                               
                                </fo:block>
                            </fo:table-cell>
                        </fo:table-row>
                        <fo:table-row>
                            <fo:table-cell>
                                <fo:block>Ticket ID</fo:block>
                            </fo:table-cell>
                            <fo:table-cell>
                                <fo:block>Ticket Type</fo:block>
                            </fo:table-cell>
                            <fo:table-cell>
                                <fo:block>Ticket Price</fo:block>
                            </fo:table-cell>
                            <fo:table-cell>
                                <fo:block>Concert Name</fo:block>
                            </fo:table-cell>
                        </fo:table-row>
                    </fo:table-header>
                    <fo:table-body>
                        <xsl:for-each select="../ticket_ref[@customer_id = $customer]">
                            <xsl:variable name="concert"
                                select="../concert[@concert_id = current()/@concert_id]"/>
                            <fo:table-row>
                                <fo:table-cell>
                                    <fo:block>
                                        <xsl:value-of select="@ticket_id"/>
                                    </fo:block>
                                </fo:table-cell>
                                <fo:table-cell>
                                    <fo:block>
                                        <xsl:value-of
                                            select="../ticket[@ticket_id = current()/@ticket_id]/@type"
                                        />
                                    </fo:block>
                                </fo:table-cell>
                                <fo:table-cell>
                                    <fo:block>
                                        <xsl:value-of
                                            select="../ticket[@ticket_id = current()/@ticket_id]/@price"
                                        />
                                    </fo:block>
                                </fo:table-cell>
                                <fo:table-cell>
                                    <fo:block>
                                        <fo:basic-link internal-destination="{generate-id($concert)}">
                                            <xsl:value-of select="$concert/@title"/>
                                        </fo:basic-link>
                                    </fo:block>
                                </fo:table-cell>
                            </fo:table-row>
                        </xsl:for-each>
                    </fo:table-body>
                </fo:table>
            </fo:block>
    </xsl:template>
</xsl:stylesheet>