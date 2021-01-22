<?xml version="1.0" encoding="UTF-8"?>
 <xsl:stylesheet version="2.0"
        xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
        xmlns:fo="http://www.w3.org/1999/XSL/Format">
        
    <xsl:template match="/tournament">
        <fo:root>
            <fo:layout-master-set>
                <!-- Layout festlegen-->
                <fo:simple-page-master master-name="archery-page"
                    page-height="297.0mm" page-width="209.9mm"
                    margin-bottom="8mm" margin-left="25mm" margin-right="10mm" margin-top="10mm">
                    
                    <!-- region-body -->
                    <fo:region-body margin-bottom="28mm" margin-left="0mm" margin-right="44mm" margin-top="60mm"/>
                    
                    <!-- region-before = Kopfzeile -->
                    <fo:region-before extent="24pt" region-name="archery-header"/>
                    
                    <!-- region-after = Fußzeile -->
                    <fo:region-after extent="24pt" region-name="archery-footer"/>
                
                </fo:simple-page-master>
            </fo:layout-master-set>
            
            <!-- Titelseite -->
            <fo:page-sequence master-reference="archery-page">
                <fo:flow flow-name="xsl-region-body" font-family="sans-serif" font-size="28pt">
                    <fo:block>
                        World Outdoor Flint Archery Mail Match
                    </fo:block>
                    
                    <fo:block font-size="12pt" margin-top="24pt">
                        By Kasper Bianca, Jaeger Martha and Pleterski Philip
                    </fo:block>
                </fo:flow>
            </fo:page-sequence>
            
            
            <!-- Inhaltsverzeichnis -->
            <fo:page-sequence master-reference="archery-page">
                
                <!-- Kopfzeile: left: ID des Tournament; right: Table of Contents -->
                <xsl:call-template name="generate-header">
                    <xsl:with-param name="title-right" select="'Table of Contents'"/>
                </xsl:call-template>
                
                <fo:flow flow-name="xsl-region-body" font-family="Times" font-size="9pt">
                    <fo:block font-size="12pt" font-weight="500">Table of Contents</fo:block>
                    
                    <fo:list-block margin-top="24pt">
                        <xsl:for-each select="group" xml:space="preserve">
                            <fo:list-item>
                                <fo:list-item-label>
                                    <fo:block><xsl:value-of select="position()"/>.</fo:block>
                                </fo:list-item-label>
                                <fo:list-item-body start-indent="4mm">
                                    <fo:block text-align-last="justify">       
                                        Group 
                                        <xsl:value-of select="@id"/>  
                                        <xsl:value-of select = "@group_name"/>
                                        <fo:leader leader-pattern="dots"/>
                                        <fo:page-number-citation ref-id="{generate-id()}"/>
                                    </fo:block>
                                </fo:list-item-body>
                            </fo:list-item>
                        </xsl:for-each>
                    </fo:list-block>
                </fo:flow>
            </fo:page-sequence>
            
            <xsl:apply-templates select="/tournament/group"/>
 
        </fo:root>
    </xsl:template>
     
     <xsl:template name="generate-header">
         <xsl:param name="title-right"/>
         <!-- Titelblatt: links: ; rechts: tournament id -->
         <fo:static-content flow-name="archery-header">
             <fo:block font-size="7pt" text-align-last="justify">
                 World Outdoor Flint Archery Mail Match
                 <fo:leader/>
                 <xsl:value-of select="$title-right"/>
             </fo:block>
         </fo:static-content>
     </xsl:template>
     
     
     <xsl:template name="header">
         <xsl:param name="right"/>
         <!-- page header: left: booklet title; left: recipe title -->
         <fo:static-content flow-name="archery-header">
             <fo:block font-size="7pt" text-align-last="justify">
                 World Outdoor Flint Archery Mail Match
                 <fo:leader/>
                 <xsl:value-of select="$right"/>
             </fo:block>
         </fo:static-content>        
     </xsl:template>
     
     
     <xsl:template match="group" xml:space="preserve">
        <fo:page-sequence master-reference="archery-page">
            <xsl:call-template name="header">
                <xsl:with-param name="right" select="concat('Group ',@id, ' ', @group_name)"/>
            </xsl:call-template> 
            
            <fo:static-content flow-name="archery-footer">
                <fo:block font-size="7pt" text-align="end">
                    page <fo:page-number/>
                </fo:block>
            </fo:static-content>
        
            <fo:flow flow-name="xsl-region-body" font-family="Times" font-size="9pt">
                <!-- title -->
                <fo:block font-size="14pt" font-weight="bold" id="{generate-id()}">
                    Group
                    <xsl:value-of select="@id"/>
                    <xsl:value-of select="@group_name"/>
                </fo:block>  
               
             <fo:block font-size="10pt" font-weight="bold" space-before="12pt">
              Participants
             </fo:block>
             
              <fo:list-block margin-top = "20pt">
                 <xsl:apply-templates select = "participant"/>
              </fo:list-block>            

            </fo:flow>
        </fo:page-sequence>    
    </xsl:template>
     
     <xsl:template match = "participant" xml:space = "preserve">
         <xsl:variable name = "person" select = "id(@person_id)"/>
          <fo:list-item>
             <fo:list-item-label>
                 <fo:block>
                     <xsl:value-of select="position()"/>.
                 </fo:block>         
             </fo:list-item-label>
             <fo:list-item-body start-indent="3em">
                 <fo:block> 
                     <xsl:value-of select="$person/@firstname"/>
                     <xsl:value-of select="$person/@lastname"/>
                 </fo:block>
             </fo:list-item-body>
         </fo:list-item>                
     </xsl:template>
     
</xsl:stylesheet>