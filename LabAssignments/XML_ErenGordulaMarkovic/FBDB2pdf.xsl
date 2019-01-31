<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"    
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format">
    
    <xsl:template match="/">
    <fo:root>
        <fo:layout-master-set>
            <fo:simple-page-master master-name="FBDB"
                page-height="297.0mm" page-width="209.9mm"
                margin-bottom="8mm" margin-left="25mm" margin-right="10mm" margin-top="10mm">
                
                <fo:region-body margin-bottom="28mm" margin-left="0mm" margin-right="44mm" margin-top="20mm"/>
             
            </fo:simple-page-master>
        </fo:layout-master-set>
        
        <fo:page-sequence master-reference="FBDB">
            <fo:flow flow-name="xsl-region-body" font-family="serif" font-size="12pt">
                <fo:block font-weight="bold" font-size="30pt" margin-bottom="20pt">FBDB</fo:block>
                <fo:block font-weight="bold" font-size="15pt" margin-bottom="2pt">Inhaltsverzeichnis:</fo:block>
                <xsl:apply-templates select="/fbdb/team" mode="content"/>
                <fo:block font-weight="bold" font-size="20pt" margin-bottom="5pt" margin-top="18pt">Teams:</fo:block>
                <xsl:apply-templates select="/fbdb/team" mode="team"/>
                <xsl:apply-templates select="/fbdb/team" mode="player-stats"/>
            </fo:flow>
        </fo:page-sequence>
    </fo:root>
    </xsl:template>
        
    <!-- ........................................................ -->

    <xsl:template match="team" mode="content">
        <fo:list-block>
           <fo:list-item>
               <fo:list-item-label>
                   <fo:block><xsl:value-of select="position()"/>.</fo:block>
               </fo:list-item-label>
               <fo:list-item-body start-indent="4mm">
                   <fo:block text-align-last="justify">
                       <!-- Geht nicht -->
                       <fo:basic-link internal-destination="{generate-id(.)}"><xsl:value-of select="@team-name"/></fo:basic-link>
                       <!--<fo:page-number-citation ref-id="{generate-id()}"/>-->
                   </fo:block>
               </fo:list-item-body>
           </fo:list-item>
        </fo:list-block>
    </xsl:template>

 
    <xsl:template match="team" mode="team">
        <fo:block margin-top="5pt" font-size="15pt" font-weight="bold">
            <xsl:value-of select="@team-name"/>
        </fo:block>
        <fo:block> Trainer: <xsl:apply-templates select="id(employee/@person-id)" mode="trainer"/></fo:block>
        <fo:block margin-top="5pt" font-weight="bold"> Spieler:</fo:block>
        <fo:list-block>
            <fo:list-item>
                <fo:list-item-label>
                    <fo:block></fo:block>
                </fo:list-item-label>
                <fo:list-item-body>
                    <!-- Problem: Verlinkung geht nicht -->
                    <fo:block><fo:basic-link internal-destination="{generate-id(.)}"><xsl:apply-templates select="id(player/@person-id)" mode="player"/></fo:basic-link></fo:block>
                    <!--<fo:block id="{generate-id(.)}"><xsl:apply-templates select="id(player/@person-id)" mode="player"/></fo:block>-->
                </fo:list-item-body>
            </fo:list-item>
        </fo:list-block>   
    </xsl:template>
        <!-- ............................................................................ -->
        
        <xsl:template match="person" mode="trainer">
            <xsl:value-of select="@fname"/>&#160;
            <xsl:value-of select="@lname"/>
        </xsl:template>
        
        <xsl:template match="person" mode="player">
            <fo:block>
                <xsl:value-of select="@fname"/>&#160;
                <xsl:value-of select="@lname"/>
            </fo:block>
        </xsl:template>
        
    <xsl:template match="team" mode="player-stats">
        <fo:block font-size="16pt" margin-top="7pt" margin-bottom="5pt" font-weight="bold">Spielerstatistiken <xsl:value-of select="@team-name"/>:</fo:block>
            <xsl:for-each select="player">
                <!-- Problem: Verlinkung geht nicht -->
                <!--<fo:block margin-top="7pt"><fo:basic-link internal-destination="{generate-id(.)}"><xsl:apply-templates select="id(@person-id)" mode="player"/></fo:basic-link></fo:block>-->
                <fo:block margin-top="7pt" ref-id="{generate-id(.)}"><xsl:apply-templates select="id(@person-id)" mode="player"/></fo:block>
                <xsl:for-each select="assessment">
                    <fo:block margin-top="1pt">
                        <xsl:apply-templates select="id(@category_id)" mode="c"/>:&#160;
                        <xsl:apply-templates select="@score" mode="s"/>&#160;
                        gegen Mannschaft:&#160;
                        <xsl:apply-templates select="id(@game_id)" mode="game"/> 
                    </fo:block>
                </xsl:for-each>
            </xsl:for-each>   
    </xsl:template>
        
        <xsl:template match="category" mode="c">
            <xsl:value-of select="@category_description"/>
        </xsl:template>
        
        <xsl:template match="game" mode="game">
            <xsl:value-of select="@enemy_team"/>
        </xsl:template>

</xsl:stylesheet>