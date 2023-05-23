<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format">
    
    <!-- ............................ ROOT TEMPLATE .......................... -->
    <xsl:template match="/media-library">
        <fo:root>
            
            <!-- define the layout of the document -->
            <fo:layout-master-set>
                <!-- here we define the layout of pages. There might be differrent page masters with e.g. different margin settings -->
                <fo:simple-page-master master-name="media-page"
                    page-height="297.0mm" page-width="209.9mm"
                    margin-bottom="8mm" margin-left="25mm" margin-right="10mm" margin-top="10mm">
                    
                    <!-- the content will be placed into the region-body -->
                    <fo:region-body margin-bottom="28mm" margin-left="0mm" margin-right="44mm" margin-top="20mm"/>
                    
                    <!-- region-before is the page header -->
                    <fo:region-before extent="24pt" region-name="media-header"/>
                    
                    <!-- region-after is the page footer -->
                    <fo:region-after extent="24pt" region-name="media-footer"/>
                    
                </fo:simple-page-master>
            </fo:layout-master-set>
            
            
            <!-- Here comes the content.
                 Printed content consists of one or more page-sequences. Each page-sequence starts on a new page. -->
            
            
                
            
            
            
            <!-- front page -->
            <fo:page-sequence master-reference="media-page">
                <fo:flow flow-name="xsl-region-body" font-family="sans-serif" font-size="12pt">
                    
                    <!-- General Headline -->
                    <xsl:call-template name="h1">
                        <xsl:with-param name="headline">Media-Library</xsl:with-param>
                    </xsl:call-template>
                    
                    <!-- headline 2: TOC -->
                    <xsl:call-template name="h2">
                        <xsl:with-param name="headline">Kunden</xsl:with-param>
                    </xsl:call-template>
                    
                    
                    <fo:block>
                        <xsl:apply-templates select="person" mode="toc"/>
                    </fo:block>
                    
                </fo:flow>
            </fo:page-sequence>
            
            <xsl:apply-templates select="/media-library" mode="detail"/>
            
            <xsl:apply-templates select="/media-library" mode="index"/>
            
            
            
        </fo:root>
    </xsl:template>
    
    
    <!-- helper templates -->
    
    
    <xsl:template name="h1">
        <xsl:param name="headline"/>
        <fo:block font-size="20pt" font-weight="800" margin-top="14pt">
            <xsl:value-of select="$headline"/>
        </fo:block>
    </xsl:template>
    
    <xsl:template name="h2">
        <xsl:param name="headline"/>
        <fo:block font-size="14pt" font-weight="800" margin-top="14pt">
            <xsl:value-of select="$headline"/>
        </fo:block>
    </xsl:template>
    
    <xsl:template name="h3">
        <xsl:param name="headline"/>
        <fo:block font-size="11pt" font-weight="800" margin-top="14pt">
            <xsl:value-of select="$headline"/>
        </fo:block>
    </xsl:template>
    
    
    <!-- Person TOC -->
    <xsl:template match="person" mode="toc">
        <fo:list-block margin-top="5pt">
            <fo:list-item>          
                <fo:list-item-label>
                    <fo:block>
                    </fo:block>
                </fo:list-item-label>
                <fo:list-item-body>
                    
                    <fo:block text-align-last="justify">
                        <xsl:value-of select="@firstname"/>
                        
                        <fo:leader leader-pattern="dots"></fo:leader>
                        <fo:page-number-citation ref-id="{generate-id()}"/>
                    </fo:block>      
                </fo:list-item-body>
            </fo:list-item>
        </fo:list-block>
            
                
    </xsl:template>
    
    
    
    <!-- Media Library Detail-->
    <xsl:template match="/media-library" mode="detail">
        

               <xsl:for-each select="person">
                   
                   <fo:page-sequence master-reference="media-page">
                       
                       <fo:static-content flow-name="media-header" text-align="left">
                           <fo:block text-align="right">
                               Page: <fo:page-number/>
                           </fo:block>
                           <xsl:call-template name="h2">
                               <xsl:with-param name="headline" >Favourite-Lists</xsl:with-param>
                           </xsl:call-template>
                           
                       </fo:static-content>
                       
                       <fo:flow flow-name="xsl-region-body" font-family="sans-serif" font-size="9pt">
                           
                       <fo:block id="{generate-id()}">
                       <xsl:call-template name="h2">
                           <xsl:with-param name="headline">
                               <xsl:value-of select="@firstname"/>
                           </xsl:with-param>
                       </xsl:call-template>
                       
                       
                   </fo:block>
                   
                   <xsl:variable name="a-personal-number" select="@personal-number"/>
                   
                   <!-- TODO ul -->
                   <fo:block>
                       <xsl:apply-templates select="//media-list[@person-personal-number = $a-personal-number]" mode="detail"/>
                   </fo:block>
            </fo:flow>
        </fo:page-sequence>
                 </xsl:for-each>
        
    </xsl:template>
    
    
    <!-- Media List Detail-->
    <xsl:template match="media-list" mode="detail">
        
        
        <xsl:variable name="a-person-personal-number" select="@person-personal-number"/>
        <fo:block>
            
            <xsl:call-template name="h3">
                <xsl:with-param name="headline">
                    <xsl:value-of select="@name"/>                    
                </xsl:with-param>
            </xsl:call-template>
            
            
        </fo:block>
            
        <fo:list-block>
            <xsl:for-each select="media-list-item">
            <xsl:variable name="a-media-id" select="@media-id"/>
            <fo:list-item>
                <fo:list-item-label>
                    <fo:block id="{generate-id($a-media-id)}">
                    </fo:block>
                </fo:list-item-label>
                <fo:list-item-body>
                    <fo:block text-align-last="justify" margin-right="160pt">
                    <xsl:value-of select="//media[@id = $a-media-id]/@title"/>
                    <fo:leader leader-pattern="space"></fo:leader>
                    <xsl:if test="count(//rating[@media-id = $a-media-id and @person-personal-number = $a-person-personal-number]/@score)>0">
                        Rating: 
                        <xsl:value-of select="sum(//rating[@media-id = $a-media-id and @person-personal-number = $a-person-personal-number]/@score) div count(//rating[@media-id = $a-media-id and @person-personal-number = $a-person-personal-number]/@score)"/> 
                    </xsl:if>
                    </fo:block>
                 </fo:list-item-body>
            </fo:list-item>
            </xsl:for-each>
        </fo:list-block>
        
    </xsl:template>
    
    
    
    <!-- Index Detail-->
    <xsl:template match="/media-library" mode="index">
        
        <fo:page-sequence master-reference="media-page">
            
            <fo:static-content flow-name="media-header" text-align="left">
                <fo:block text-align="right">
                    Page: <fo:page-number/>
                </fo:block>
                <xsl:call-template name="h2">
                    <xsl:with-param name="headline" >Media Index</xsl:with-param>
                </xsl:call-template>
                
            </fo:static-content>
            
            <fo:flow flow-name="xsl-region-body" font-family="sans-serif" font-size="9pt">
            
            
        <xsl:for-each select="person">
            
            
                
                
                    
                    
                    
                    <xsl:variable name="a-personal-number" select="@personal-number"/>
                    
                    <!-- TODO ul -->
                    <fo:block>
                        <xsl:apply-templates select="//media-list[@person-personal-number = $a-personal-number]" mode="index"/>
                    </fo:block>
                
        </xsl:for-each>
            </fo:flow>
        </fo:page-sequence>
    </xsl:template>
    
    
    <!-- Index Detail-->
    <xsl:template match="media-list" mode="index">
        
        
        <xsl:variable name="a-person-personal-number" select="@person-personal-number"/>
  
        
        <fo:table>
            <xsl:for-each select="media-list-item">
                <xsl:variable name="a-media-id" select="@media-id"/>
                <fo:table-body border-width="1px" border-style="solid">
                    <fo:table-row border-width="1px" border-style="solid">
                    

                    <fo:table-cell >
                            <fo:block>
                            <xsl:value-of select="//media[@id = $a-media-id]/@title"/> 
                            </fo:block>
                    </fo:table-cell>
                    <fo:table-cell>
                        <fo:block>
                            <fo:leader leader-pattern="space"></fo:leader>
                            <xsl:value-of select="../@name"/> 
                        </fo:block>
                    </fo:table-cell>
                    <fo:table-cell>
                        <fo:block>
                            <fo:leader leader-pattern="space"></fo:leader>
                            <xsl:value-of select="//person[@personal-number = $a-person-personal-number]/@firstname"/>
                        </fo:block>
                    </fo:table-cell>
                    <fo:table-cell >
                        <fo:block>
                            <fo:leader leader-pattern="space"></fo:leader>
                            Page: <fo:page-number-citation ref-id="{generate-id($a-media-id)}"/>
                            </fo:block>
                    </fo:table-cell>
                            
                        
                </fo:table-row>
                </fo:table-body>
            </xsl:for-each>
        </fo:table>
        
    </xsl:template>
    
    
    
    
    
</xsl:stylesheet>