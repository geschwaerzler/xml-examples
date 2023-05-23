<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format">
    <xsl:output method="xml" indent="yes"/>
    
    <xsl:template match="/concert-planning">
        <fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format">
            <fo:layout-master-set>
                <fo:simple-page-master master-name="main">
                    <fo:region-body/>
                </fo:simple-page-master>
            </fo:layout-master-set>
            <fo:page-sequence master-reference="main">
                <fo:flow flow-name="xsl-region-body">
                    <fo:block>
                        <fo:block font-size="16pt" font-weight="bold" text-align="center">Table of Content</fo:block>
                        <fo:block font-size="12pt"><fo:basic-link internal-destination="cl">Concert-List</fo:basic-link></fo:block>
                        <fo:block font-size="12pt"><fo:basic-link internal-destination="clbt">Customer-List and bought tickets</fo:basic-link></fo:block>
                        <fo:block font-size="12pt"><fo:basic-link internal-destination="al">Artist-List</fo:basic-link></fo:block>
                        <fo:block font-size="12pt"><fo:basic-link internal-destination="vl">Venue-List</fo:basic-link></fo:block>
                    </fo:block>
                    
                    <fo:block id="cl">
                        <fo:block font-size="16pt" font-weight="bold">Concert-List</fo:block>
                        <xsl:apply-templates select="concert" mode="details"/>
                    </fo:block>
                    
                    <fo:block id="clbt">
                        <fo:block font-size="16pt" font-weight="bold">Customer-List and bought tickets</fo:block>
                        <xsl:apply-templates select="customer" mode="default"/>
                    </fo:block>
                    
                    <fo:block id="al">
                        <fo:block font-size="16pt" font-weight="bold">Artist-List</fo:block>
                        <xsl:apply-templates select="artist" mode="default"/>
                    </fo:block>
                    
                    <fo:block id="vl">
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
                            <fo:block>
                                <xsl:value-of select="@ticket_id"/>
                            </fo:block>
                        </fo:table-cell>
                        <fo:table-cell>
                            <fo:block>
                                <xsl:value-of select="../customer[@customer_id = current()/ticket_ref/@customer_id]/@name"/>
                            </fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                </fo:table-body>
            </fo:table>
        </fo:block>
    </xsl:template>
    
    <xsl:template match="customer" mode="default">
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
                    <xsl:for-each select="../ticket_ref[@customer_id = current()/@customer_id]">
                        <xsl:variable name="concert" select="../concert[@concert_id = current()/@concert_id]"/>
                        <fo:table-row>
                            <fo:table-cell>
                                <fo:block>
                                    <xsl:value-of select="@ticket_id"/>
                                </fo:block>
                            </fo:table-cell>
                            <fo:table-cell>
                                <fo:block>
                                    <xsl:value-of select="../ticket[@ticket_id = current()/@ticket_id]/@type"/>
                                </fo:block>
                            </fo:table-cell>
                            <fo:table-cell>
                                <fo:block>
                                    <xsl:value-of select="../ticket[@ticket_id = current()/@ticket_id]/@price"/>
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