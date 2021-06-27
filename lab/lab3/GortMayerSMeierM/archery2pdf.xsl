<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format">
    
    <!-- root template -->
    <xsl:template match="/">
        <fo:root>
            <fo:layout-master-set>
                <!-- here we define the layout of pages. There might be differrent page masters with e.g. different margin settings -->
                <fo:simple-page-master master-name="archery-page"
                    page-height="297.0mm" page-width="209.9mm"
                    margin-bottom="8mm" margin-left="25mm" margin-right="10mm" margin-top="10mm">
                    
                    <!-- the content will be placed into the region-body -->
                    <fo:region-body margin-bottom="28mm" margin-left="0mm" margin-right="44mm" margin-top="20mm"/>
                    
                    <!-- region-before is the page header -->
                    <fo:region-before extent="24pt" region-name="archery-header"/>
                    
                    <!-- region-after is the page footer -->
                    <fo:region-after extent="24pt" region-name="archery-footer"/>
                    
                </fo:simple-page-master>
            </fo:layout-master-set>
            
            <!-- front page -->
            <fo:page-sequence master-reference="archery-page">
                <fo:flow flow-name="xsl-region-body" font-family="serif" font-size="28pt" color="red">
                    <fo:block margin-top="40mm">
                        <xsl:value-of select="tournament/description"/>
                    </fo:block>
                </fo:flow>
            </fo:page-sequence>
            
            <!-- table of contents -->
            <fo:page-sequence master-reference="archery-page">
                <!-- description into the page header -->
                <xsl:call-template name="header">
                    <xsl:with-param name="right" select="'Table of Contents'"/>
                </xsl:call-template>
                
                <!-- table of contents into region-body -->
                <fo:flow flow-name="xsl-region-body" font-family="serif" font-size="10pt">
                    <fo:block font-weight="bold" margin-top="40mm">Table of Contents</fo:block>
                    <fo:list-block space-before="24pt">
                        <xsl:apply-templates select="tournament/team" mode="toc"/>
                    </fo:list-block>
                </fo:flow>
            </fo:page-sequence>
            
            <!-- teams -->
            <xsl:apply-templates select="tournament/team" mode="list"/>
            
            <!-- teams description -->
            <xsl:apply-templates select="tournament/team/competitor" mode="score"/>
            
            
        </fo:root>
        
        
        
    </xsl:template>
    
    
    
    <!-- table of contents template -->
    <xsl:template match="team" mode="toc">
        <fo:list-item>
            <fo:list-item-label>
                <fo:block><xsl:value-of select="position()"/>.</fo:block>
            </fo:list-item-label>
            <fo:list-item-body start-indent="4mm">
                <fo:block text-align-last="justify">
                    <xsl:value-of select="title"/>
                    <fo:leader leader-pattern="dots"/>
                    <fo:page-number-citation ref-id="{generate-id()}"/>
                </fo:block>
            </fo:list-item-body>
        </fo:list-item>
    </xsl:template>
    
    
    
    <!-- archery template -->
    <xsl:template match="team" mode="list">
        <fo:page-sequence master-reference="archery-page">
            <xsl:call-template name="header">
                <xsl:with-param name="right" select="title"/>
            </xsl:call-template>
            
            <fo:static-content flow-name="archery-footer">
                <fo:block font-family="serif" font-size="8pt" text-align="end">
                    page <fo:page-number/>
                </fo:block>
            </fo:static-content>
            
            
            <fo:flow flow-name="xsl-region-body" font-family="serif">
                <fo:block font-size="20pt" font-weight="500" id="{generate-id()}">
                    <xsl:value-of select="title"/>
                </fo:block>
                
                <fo:block>
                    <fo:block space-before="18pt" font-size="16pt">Overview</fo:block>
                    <fo:list-block space-before="8pt" font-size="12pt">
                       <fo:list-item>
                           <fo:list-item-label>
                               <fo:block></fo:block>
                           </fo:list-item-label>
                           <fo:list-item-body>
                               <fo:block>Team-ID: <xsl:value-of select="@id"/></fo:block>
                           </fo:list-item-body>
                       </fo:list-item>
                       <fo:list-item>
                           <fo:list-item-label>
                               <fo:block></fo:block>
                           </fo:list-item-label>
                           <fo:list-item-body>
                               <fo:block>Nationality: <xsl:value-of select="@nationality"/></fo:block>
                           </fo:list-item-body>
                       </fo:list-item>
                       <fo:list-item>
                           <fo:list-item-label>
                               <fo:block></fo:block>
                           </fo:list-item-label>
                           <fo:list-item-body>
                               <fo:block>Team Size: <xsl:value-of select="@group-size"/></fo:block>
                           </fo:list-item-body>
                       </fo:list-item>
                   </fo:list-block>
                </fo:block>
                <fo:block>
                    <fo:block space-before="18pt" font-size="16pt">Team Members</fo:block>
                    <xsl:apply-templates select="competitor" mode="list"/>
                </fo:block>
            </fo:flow>
            
            
            <xsl:value-of select="title"/>
        
        </fo:page-sequence>
    </xsl:template>
    
    <xsl:template match="competitor" mode="score">
        <fo:page-sequence master-reference="archery-page">
            <xsl:call-template name="header">
                <xsl:with-param name="right" select="title"/>
            </xsl:call-template>
            
            <fo:static-content flow-name="archery-footer">
                <fo:block font-family="serif" font-size="8pt" text-align="end">
                    page <fo:page-number/>
                </fo:block>
            </fo:static-content>
            
            
            <fo:flow flow-name="xsl-region-body" font-family="serif">
                <fo:block font-size="20pt" font-weight="500" id="{generate-id()}">
                    <xsl:value-of select="title"/>
                </fo:block>
                
                <fo:block>
                    <fo:block space-before="18pt" font-size="16pt">Scores</fo:block>
                    <fo:block space-before="18pt" font-size="14pt"><xsl:value-of select="@id"/></fo:block>
                    <fo:block space-before="8pt" font-size="12pt">Target-Nr: <xsl:value-of select="scores/target-score/@target-nr"/></fo:block>   
                                        
                    <xsl:apply-templates select="scores/target-score"/>                    
                </fo:block>  
            </fo:flow>
            
            
            <xsl:value-of select="title"/>
            
        </fo:page-sequence>
        
    </xsl:template>
    
    <xsl:template name="target-score">
        <fo:list-block>
            <fo:list-item>
                <fo:list-item-label>
                    <fo:block></fo:block>
                </fo:list-item-label>
                <fo:list-item-body>
                    <fo:block>Arrow-Nr: <xsl:value-of select="score/@arrow-nr"/>, Score: <xsl:value-of select="scores/target-score/score/@score"/></fo:block>
                </fo:list-item-body>
            </fo:list-item>
            <fo:list-item>
                <fo:list-item-label>
                    <fo:block></fo:block>
                </fo:list-item-label>
                <fo:list-item-body>
                    <fo:block>Arrow-Nr: <xsl:value-of select="score/@arrow-nr"/>, Score: <xsl:value-of select="scores/target-score/score/@score"/></fo:block>
                </fo:list-item-body>
            </fo:list-item>
        </fo:list-block>
    </xsl:template>
    
    
    <xsl:template name="header">
        <xsl:param name="right"/>
        <!-- page header: left: booklet title; left: archery title -->
        <fo:static-content flow-name="archery-header">
            <fo:block font-family="serif" font-size="8pt" text-align-last="justify">
                <xsl:value-of select="/tournament/description"/>
                <fo:leader/>
                <xsl:value-of select="$right"/>
            </fo:block>
        </fo:static-content>
    </xsl:template>
    
    <xsl:template match="competitor" mode="list">
        <fo:block space-before="8pt">
            <xsl:value-of select="@id"/>
        </fo:block>
        <fo:list-block>
            <fo:list-item>
                <fo:list-item-label start-indent="5mm">
                    <fo:block font-family="Symbol">-</fo:block>
                </fo:list-item-label>
                <fo:list-item-body start-indent="10mm">
                    <fo:block>First Name: <xsl:value-of select="@firstname"/></fo:block>
                </fo:list-item-body>
            </fo:list-item>
            <fo:list-item>
                <fo:list-item-label start-indent="5mm">
                    <fo:block font-family="Symbol">-</fo:block>
                </fo:list-item-label>
                <fo:list-item-body start-indent="10mm">
                    <fo:block>Last Name: <xsl:value-of select="@lastname"/></fo:block>
                </fo:list-item-body>
            </fo:list-item>
            <fo:list-item>
                <fo:list-item-label start-indent="5mm">
                    <fo:block font-family="Symbol">-</fo:block>
                </fo:list-item-label>
                <fo:list-item-body start-indent="10mm">
                    <fo:block>Year of Birth: <xsl:value-of select="@year-of-birth"/></fo:block>
                </fo:list-item-body>
            </fo:list-item>
            <fo:list-item>
                <fo:list-item-label start-indent="5mm">
                    <fo:block font-family="Symbol">-</fo:block>
                </fo:list-item-label>
                <fo:list-item-body start-indent="10mm">
                    <fo:block>Gender: <xsl:value-of select="@gender"/></fo:block>
                </fo:list-item-body>
            </fo:list-item>
        </fo:list-block>
    </xsl:template>
</xsl:stylesheet>