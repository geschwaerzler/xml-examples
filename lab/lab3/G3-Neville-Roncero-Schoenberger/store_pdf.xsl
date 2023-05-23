<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format">
   
    <!-- ............................ ROOT TEMPLATE .......................... -->
    <xsl:template match="/store">
        <fo:root>
            
            <!-- define the layout of the document -->
            <fo:layout-master-set>
                <!-- here we define the layout of pages. There might be differrent page masters with e.g. different margin settings -->
                <fo:simple-page-master master-name="music_store-page"
                    page-height="297.0mm" page-width="209.9mm"
                    margin-bottom="8mm" margin-left="25mm" margin-right="10mm" margin-top="10mm">
                    
                    <!-- the content will be placed into the region-body -->
                    <fo:region-body margin-bottom="28mm" margin-left="0mm" margin-right="44mm" margin-top="25mm"/>
                    
                    <!-- region-before is the page header -->
                    <fo:region-before extent="24pt" region-name="music_store-header"/>
                    
                    <!-- region-after is the page footer -->
                    <fo:region-after extent="24pt" region-name="music_store-footer"/>
                    
                </fo:simple-page-master>
            </fo:layout-master-set>
            
            <!-- front page -->
            <fo:page-sequence master-reference="music_store-page">
                <fo:flow flow-name="xsl-region-body" font-family="sans-serif" font-size="28pt">
                    <fo:block margin-top="50mm">
                        <xsl:value-of select="@store_name"/>
                    </fo:block>
                </fo:flow>
            </fo:page-sequence>
            
            <!-- table of contents -->
            <fo:page-sequence master-reference="music_store-page">
                <!-- place a page description into the page header -->
                <xsl:call-template name="header">
                    <xsl:with-param name="right" select="'Table of Contents'"/>
                </xsl:call-template>
                
                <!-- place the table of contents into region-body -->
                <fo:flow flow-name="xsl-region-body" font-family="Times" font-size="9pt">
                    <fo:block font-size="16pt" font-weight="bold" margin-top="40mm">Table of Contents</fo:block>
                    <fo:list-block space-before="24pt">
                        <xsl:apply-templates select="/store/product" mode="toc"/>
                    </fo:list-block>
                </fo:flow>
            </fo:page-sequence>
            
            <!-- products -->
            <xsl:apply-templates select="/store/product" mode="detail"/>
            
            <!-- song list -->
            <fo:page-sequence master-reference="music_store-page">
                
                <!-- place a page description into the page header -->
                <xsl:call-template name="header">
                    <xsl:with-param name="right" select="'Song List'"/>
                </xsl:call-template>
            
                <!-- place the page number into the page footer -->
                <fo:static-content flow-name="music_store-footer">
                    <fo:block font-size="7pt" text-align="end">
                        page <fo:page-number/>
                    </fo:block>
                </fo:static-content>
                
                <!-- place the song list into region-body -->
                <fo:flow flow-name="xsl-region-body" font-family="Times" font-size="9pt">
                    <fo:block font-size="16pt" font-weight="bold">Song List</fo:block>
                    <fo:list-block space-before="24pt">
                        <xsl:apply-templates select="product/song" mode="all">
                            <xsl:sort select="@name"/>
                        </xsl:apply-templates>
                    </fo:list-block>
                </fo:flow>
            </fo:page-sequence>                
        </fo:root>
    </xsl:template>
    
    <!-- ...................... TABLE OF CONTENTS TEMPLATE ................... -->
    <xsl:template match="product" mode="toc">
        <fo:list-item>
            <fo:list-item-label>
                <fo:block>
                    <xsl:value-of select="position()"/>.
                </fo:block>
            </fo:list-item-label>
            <fo:list-item-body start-indent="4mm">
                <fo:block text-align-last="justify">
                    <xsl:value-of select="@title"/>
                    <fo:leader leader-pattern="dots"></fo:leader>
                    <fo:page-number-citation ref-id="{generate-id()}"/>
                </fo:block>
            </fo:list-item-body>
        </fo:list-item>
    </xsl:template>
    
    <!-- .......................... PRODUCT TEMPLATE .......................... -->
    <xsl:template match="product" mode="detail" xml:space="preserve">
        <fo:page-sequence master-reference="music_store-page">
            <xsl:call-template name="header">
                <xsl:with-param name="right" select="@title"/>
            </xsl:call-template>
        
            <fo:static-content flow-name="music_store-footer">
                <fo:block font-size="7pt" text-align="end">
                    page <fo:page-number/>
                </fo:block>
            </fo:static-content>
        
            <fo:flow flow-name="xsl-region-body" font-family="Times" font-size="9pt">
                
                <!-- product title -->
                <fo:block font-size="16pt" font-weight="bold" id="{generate-id()}" margin-bottom="15pt">
                    <xsl:value-of select="@title"/>
                </fo:block>
                
                <!-- general product information -->
                <fo:block font-size="12pt">
                    <fo:block margin-bottom="15pt">
                        <fo:external-graphic src="{@image}" content-height="250px" content-width="auto"/>
                    </fo:block>
                    
                    <fo:block margin-bottom="5pt">
                        <fo:inline font-weight = "bold">Artist:</fo:inline>
                        <xsl:value-of select="id(@artist_id)/@artist_name"/>
                    </fo:block>
                    
                    <fo:block margin-bottom="5pt">
                        <fo:inline font-weight = "bold"> Media:</fo:inline>
                        <xsl:value-of select="@media"/>
                    </fo:block>
                    
                    <fo:block margin-bottom="5pt">
                        <fo:inline font-weight = "bold">Genre:</fo:inline>
                        <xsl:value-of select="@genre"/> 
                    </fo:block>
                    
                    <fo:block margin-bottom="5pt">
                        <fo:inline font-weight = "bold">Label:</fo:inline>
                        <xsl:value-of select="@label"/>
                    </fo:block>
                    
                    <fo:block margin-bottom="5pt">
                        <fo:inline font-weight = "bold">Length:</fo:inline>
                        <xsl:value-of select="@length"/>
                    </fo:block>
                    
                    <xsl:if test="@number_of_cds">
                        <fo:block margin-bottom="5pt">
                            <fo:inline font-weight = "bold">Number of CDs:</fo:inline>
                            <xsl:value-of select="@number_of_cds"/>
                        </fo:block>
                    </xsl:if>
                    
                    <fo:block margin-bottom="5pt">
                        <fo:inline font-weight = "bold">Release Date:</fo:inline>
                        <xsl:value-of select="@release_date"/>
                    </fo:block>
                    
                    <fo:block margin-bottom="5pt">
                        <fo:inline font-weight = "bold">Condition:</fo:inline>
                        <xsl:value-of select="@condition"/>
                    </fo:block>
                    
                    <fo:block margin-bottom="20pt">
                        <fo:inline font-weight = "bold">Price:</fo:inline>
                        <xsl:value-of select="@retail_price"/>
                    </fo:block>
                </fo:block>
                
                <!-- song list in product (table) -->
                <fo:table table-layout="fixed" space-before="1em" space-after="1em">
                    
                    <!-- columns -->
                    <fo:table-column column-number="1" column-width="60mm"/>
                    <fo:table-column column-number="2" column-width="40mm"/>
                    <fo:table-column column-number="3" column-width="20mm"/>
                    <xsl:if test="@media = 'LP'">
                        <fo:table-column column-number="4" column-width="20mm"/>
                    </xsl:if>
                    <xsl:if test="@number_of_cds">
    					<fo:table-column column-number="5" column-width="20mm"/>
    				</xsl:if>
                    
                    <!-- table header -->
                    <fo:table-header text-align="center" font-size="12pt" font-weight = "bold">
                        <fo:table-row>
                            <fo:table-cell border-style="solid" border-width="0.5mm">
                                <fo:block>Song Name</fo:block>
                            </fo:table-cell>
                            <fo:table-cell border-style="solid" border-width="0.5mm">
                                <fo:block>Featured Artist(s)</fo:block>
                            </fo:table-cell>
                            <fo:table-cell border-style="solid" border-width="0.5mm">
                                <fo:block>Length</fo:block>
                            </fo:table-cell>
                            <xsl:if test="@media = 'LP'">
                                <fo:table-cell border-style="solid" border-width="0.5mm">
                                    <fo:block>LP - Side</fo:block>
                                </fo:table-cell>
                            </xsl:if>
                            <xsl:if test="@number_of_cds">
                                <fo:table-cell border-style="solid" border-width="0.5mm">
                                    <fo:block>Nr. of CD</fo:block>
                                </fo:table-cell>
                            </xsl:if>
                        </fo:table-row>
                    </fo:table-header>
                    
                    <!-- table body -->
                    <fo:table-body text-align="left" font-size="12pt">
                        <xsl:for-each select="song">
                            <fo:table-row>
                                <fo:table-cell border-style="solid" border-width="0.5mm">
                                    <fo:block>
                                        <xsl:value-of select="@name"/>
                                    </fo:block>
                                </fo:table-cell>
                                <fo:table-cell border-style="solid" border-width="0.5mm">
                                        <fo:block>
                                            <xsl:for-each select="id(featured_artist/@artist_id)">
                                                <fo:block>
                                                    <xsl:value-of select="@artist_name"/>
                                                </fo:block>   
                                            </xsl:for-each>
                                        </fo:block>
                                </fo:table-cell>
                                <fo:table-cell border-style="solid" border-width="0.5mm" text-align="center">
                                    <fo:block>
                                        <xsl:value-of select="@length"/>
                                    </fo:block>
                                </fo:table-cell>
                                <xsl:if test="ancestor::product/@media = 'LP'">
                                    <fo:table-cell border-style="solid" border-width="0.5mm" text-align="center">
                                        <fo:block>
                                            <xsl:value-of select="@lp_side"/>
                                        </fo:block>
                                    </fo:table-cell>
                                </xsl:if>
                                <xsl:if test="@number_of_cds">
                                    <fo:table-cell border-style="solid" border-width="0.5mm">
                                        <fo:block>
                                            <xsl:value-of select="@cd_number"/>
                                        </fo:block>
                                    </fo:table-cell>
                                </xsl:if>
                            </fo:table-row>
                        </xsl:for-each>
                    </fo:table-body>
                </fo:table>
            </fo:flow>
        </fo:page-sequence>    
    </xsl:template>
    
    <!-- .......................... SONG INDEX TEMPLATE .......................... -->
    <xsl:template match="product/song" mode="all" xml:space="preserve">
        <fo:list-item>
            <fo:list-item-label>
                <fo:block>-</fo:block>
            </fo:list-item-label>
            <fo:list-item-body start-indent="4mm">
                <fo:block text-align-last="justify">
                    <xsl:value-of select="./@name"/>
                    <fo:leader leader-pattern="dots"></fo:leader>
                    <xsl:value-of select="ancestor::product/@title"/>
                </fo:block>
            </fo:list-item-body>
        </fo:list-item>
    </xsl:template>
    
    <!-- .......................... HELPER TEMPLATE .......................... -->
    <xsl:template name="header">
        <xsl:param name="right"/>
        <!-- page header: left: music store name; right: product title -->
        <fo:static-content flow-name="music_store-header">
            <fo:block font-size="7pt" text-align-last="justify">
                <xsl:value-of select="/store/@store_name"/>
                <fo:leader/>
                <xsl:value-of select="$right"/>
            </fo:block>
        </fo:static-content>        
    </xsl:template>
</xsl:stylesheet>