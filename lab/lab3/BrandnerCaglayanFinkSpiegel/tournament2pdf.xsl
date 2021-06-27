<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format">
    
	<xsl:template match="/">
		<fo:root>
			 <!-- define the layout of the document -->
            <fo:layout-master-set>
                <!-- here we define the layout of pages. There might be differrent page masters with e.g. different margin settings -->
                <fo:simple-page-master master-name="tournament-page"
                    page-height="297.0mm" page-width="209.9mm"
                    margin-bottom="8mm" margin-left="25mm" margin-right="10mm" margin-top="10mm">
                    
                    <!-- the content will be placed into the region-body -->
                    <fo:region-body margin-bottom="28mm" margin-left="0mm" margin-right="44mm" margin-top="20mm"/>
                    
                    <!-- region-before is the page header -->
                    <fo:region-before extent="24pt" region-name="tournament-header"/>
                    
                    <!-- region-after is the page footer -->
                    <fo:region-after extent="24pt" region-name="tournament-footer"/>
                    
                </fo:simple-page-master>
            </fo:layout-master-set>
            
            <!-- front page -->
		    <fo:page-sequence master-reference="tournament-page">
                <fo:flow flow-name="xsl-region-body" font-family="sans-serif" font-size="28pt">
                    <fo:block margin-top="40mm">
                        <xsl:value-of select="tournament/@name"/>
                    </fo:block>
                </fo:flow>
            </fo:page-sequence>
		    
		    <!-- table of contents -->
		    <fo:page-sequence master-reference="tournament-page">
		        <!-- place a page description into the page header -->
		        <xsl:call-template name="header">
		            <xsl:with-param name="right" select="'Table of Contents'"/>
		        </xsl:call-template>
		        
		        <!-- place the table of contents into region-body -->
		        <fo:flow flow-name="xsl-region-body" font-family="Times" font-size="9pt">
		            <fo:block font-weight="bold" margin-top="40mm">Table of Contents</fo:block>
		            <fo:list-block space-before="24pt">
		                <xsl:apply-templates select="tournament/group" mode="toc"/>
		                <xsl:apply-templates select="tournament/match" mode="toc">
		                    <xsl:with-param name="pagenumber-offset" select="count(tournament/group)" />
		                </xsl:apply-templates>
		            </fo:list-block>
		        </fo:flow>
		    </fo:page-sequence>
		    
		    <!-- groups -->
		    <xsl:apply-templates select="tournament/group" mode="detail"/>
		    
		    <!-- scores -->
		    <xsl:apply-templates select="tournament/match" mode="detail"/>
		</fo:root>
	</xsl:template>
    
    <!-- ...................... TABLE OF CONTENTS TEMPLATE ................... -->
    <xsl:template match="group" mode="toc">
        <fo:list-item>
            <fo:list-item-label>
                <fo:block><xsl:value-of select="position()"/>.</fo:block>
            </fo:list-item-label>
            <fo:list-item-body start-indent="4mm">
                <fo:block text-align-last="justify">
                    <xsl:value-of select="@group-name"/>
                    <fo:leader leader-pattern="dots"></fo:leader>
                    <fo:page-number-citation ref-id="{generate-id()}"/>
                </fo:block>
                <xsl:apply-templates select="match" mode="toc"/>
            </fo:list-item-body>
        </fo:list-item>
    </xsl:template>
 
    <xsl:template match="match" mode="toc">
        <xsl:param name="pagenumber-offset"/>
        <fo:list-item>
            <fo:list-item-label>
                <fo:block><xsl:value-of select="position() + $pagenumber-offset"/>.</fo:block>
            </fo:list-item-label>
            <fo:list-item-body start-indent="4mm">
                <fo:block text-align-last="justify">
                    <xsl:value-of select="id(@round-id)/@round-name"/>
                    (<xsl:value-of select="@start-time"/> - <xsl:value-of select="@end-time"/>)
                    <fo:leader leader-pattern="dots"></fo:leader>
                    <fo:page-number-citation ref-id="{generate-id()}"/>
                </fo:block>
            </fo:list-item-body>
        </fo:list-item>
    </xsl:template>
    
    <xsl:template name="header">
        <xsl:param name="right"/>
        <!-- page header: left: booklet title; left: recipe title -->
        <fo:static-content flow-name="tournament-header">
            <fo:block font-size="7pt" text-align-last="justify">
                <xsl:value-of select="/tournament/@name"/>
                <fo:leader/>
                <xsl:value-of select="$right"/>
            </fo:block>
        </fo:static-content>        
    </xsl:template>
    
    <xsl:template match="tournament/group" mode="detail">
        <fo:page-sequence master-reference="tournament-page">
            <xsl:call-template name="header">
                <xsl:with-param name="right" select="@group-name"/>
            </xsl:call-template>
        
            <fo:static-content flow-name="tournament-footer">
                <fo:block font-size="7pt" text-align="end">
                    page <fo:page-number/>
                </fo:block>
            </fo:static-content>
        
            <fo:flow flow-name="xsl-region-body" font-family="Times" font-size="9pt">
                <!-- group name -->
                <fo:block font-size="14pt" font-weight="bold" id="{generate-id()}">
                    <xsl:value-of select="@group-name"/>
                </fo:block>
                
                <fo:list-block margin-left="0mm">
                     <xsl:for-each select="competitor">
                         <fo:list-item>
                             <fo:list-item-label>
                                 <fo:block>
                                     <xsl:value-of select="position()"/>.
                                 </fo:block>
                             </fo:list-item-label>
                             <fo:list-item-body start-indent="4mm">
                                 <fo:block>
                                      <xsl:value-of select="text()" /> (<xsl:value-of select="id(@country-id)/@country-name"/>)
                                 </fo:block>
                             </fo:list-item-body>
                         </fo:list-item>                
                     </xsl:for-each>
                </fo:list-block>
            </fo:flow>
        </fo:page-sequence>    
    </xsl:template>
    
    <xsl:template match="tournament/match" mode="detail">
        <fo:page-sequence master-reference="tournament-page">
            <xsl:call-template name="header">
                <xsl:with-param name="right" select="id(@round-id)/@round-name"/>
            </xsl:call-template>
            
            <fo:static-content flow-name="tournament-footer">
                <fo:block font-size="7pt" text-align="end">
                    page <fo:page-number/>
                </fo:block>
            </fo:static-content>
            
            <fo:flow flow-name="xsl-region-body" font-family="Times" font-size="9pt">
                <!-- round name -->
                <fo:block font-size="14pt" font-weight="bold" id="{generate-id()}">
                    <xsl:value-of select="id(@round-id)/@round-name"/>
                </fo:block>
                
                <fo:block font-size="14pt" font-weight="bold">
                    <xsl:value-of select="@start-time"/> - <xsl:value-of select="@end-time"/>
                </fo:block>
                
                <xsl:for-each select="archer-score">
                    <xsl:variable name="competitor" select="id(@competitor-id)" />
                    
                    <fo:block font-size="8px" font-weight="bold" padding-top="10mm" id="{generate-id($competitor)}">
                        <xsl:value-of select="$competitor/text()"/>
                    </fo:block>
                    
                     <fo:table>
                         <!-- First column for target -->
                         <fo:table-column column-width="20mm"/>
                         
                         <!-- Column for each arrow -->
                         <xsl:for-each select="target/score/@arrow">
                             <fo:table-column column-width="20mm"/>
                         </xsl:for-each>
                         
                         <fo:table-header background-color="#dedede">
                             <fo:table-row>
                                 <fo:table-cell border="solid 1px bold" text-align="center"> 
                                     <fo:block font-weight="bold" width="30mm" font-size="8px">
                                         Target 
                                     </fo:block> 
                                 </fo:table-cell>
                                 <fo:table-cell border="solid 1px bold" text-align="center" > 
                                     <fo:block font-weight="bold" width="30mm" font-size="8px">
                                         Arrow 1 
                                     </fo:block> 
                                 </fo:table-cell>
                                 <fo:table-cell border="solid 1px bold" text-align="center" > 
                                     <fo:block font-weight="bold" width="30mm" font-size="8px">
                                         Arrow 2 
                                     </fo:block> 
                                 </fo:table-cell>
                                 <fo:table-cell border="solid 1px bold" text-align="center" > 
                                     <fo:block font-weight="bold" width="30mm" font-size="8px">
                                         Arrow 3 
                                     </fo:block> 
                                 </fo:table-cell>
                                 <fo:table-cell border="solid 1px bold" text-align="center" > 
                                     <fo:block font-weight="bold" width="30mm" font-size="8px">
                                         Arrow 4 
                                     </fo:block> 
                                 </fo:table-cell>
                             </fo:table-row>
                         </fo:table-header>
                         
                         <fo:table-body>
                             <xsl:for-each select="target">
                             <fo:table-row>
                                 <fo:table-cell border="solid 1px bold" text-align="center" > 
                                     <fo:block font-weight="bold" width="30mm" font-size="8px">
                                         <xsl:value-of select="@nr" /> 
                                     </fo:block> 
                                 </fo:table-cell>
                                 <xsl:for-each select="score">
                                     <fo:table-cell border="solid 1px bold" text-align="center" > 
                                         <fo:block font-weight="bold" width="30mm" font-size="8px">
                                             <xsl:value-of select="@points" />
                                         </fo:block> 
                                     </fo:table-cell>
                                 </xsl:for-each>
                             </fo:table-row>
                             </xsl:for-each>
                         </fo:table-body>
                     </fo:table>
                </xsl:for-each>
                
            </fo:flow>
        </fo:page-sequence>    
    </xsl:template>
</xsl:stylesheet>