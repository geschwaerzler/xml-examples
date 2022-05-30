<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:fo="http://www.w3.org/1999/XSL/Format">
	
	
	
	<!-- Ich weiß nicht was ich falsch mache, jede pdf die ich erstelle
	ist "beschädigt" oder kann zumindest nicht geöffnet werden, vielleicht ist es auch nur
	mein adobe reader. Somit konnte ich auch nie überprüfen wo die Fehler liegen, tut mir sehr leid-->
	
	
	
	
	
	
		<!-- 		Root Template		 -->
	<xsl:template match="/">
	<fo:root>
		<!-- Defining the layout of the document -->
        <fo:layout-master-set>
            
               <!-- here we define the layout of pages. 
               There might be different page masters with e.g. different margin settings -->
               
               <fo:simple-page-master master-name="turnier-page"
                    page-height="297.0mm" page-width="209.9mm"
                    margin-bottom="8mm" margin-left="25mm" margin-right="10mm" margin-top="10mm">
                    
                    <!-- the content will be placed into the region-body -->
                    <fo:region-body margin-bottom="28mm" margin-left="0mm" margin-right="44mm" margin-top="20mm"/>
                    
                    <!-- region-before is the page header -->
                    <fo:region-before extent="24pt" region-name="turnier-header"/>
                    
                    <!-- region-after is the page footer -->
                    <fo:region-after extent="24pt" region-name="turnier-footer"/>
                    
           		</fo:simple-page-master>
          </fo:layout-master-set>	
	
	  <!-- Here comes the content.
      Printed content consists of one or more page-sequences. 
      Each page-sequence starts on a new page. -->
	
	
	         <!--      Front page      -->
            <fo:page-sequence master-reference="turnier-page">
                <fo:flow flow-name="xsl-region-body" font-family="sans-serif" font-size="28pt">
                
                    <fo:block margin-top="40mm">
                        <xsl:value-of select="turnier/headline"/>
                    </fo:block>
                    
                </fo:flow>
            </fo:page-sequence>
            
            
            
               <!-- Overview -->
            <fo:page-sequence master-reference="turnier-page">
            
                <!-- place a page description into the page header -->
                
                <xsl:call-template name="header">
                    <xsl:with-param name="right" select="'Overview'"/>
                </xsl:call-template>
                
                <!-- place the table of contents into region-body, flow = body -->
                
                <fo:flow flow-name="xsl-region-body" font-family="Times" font-size="9pt">
                    <fo:block font-weight="bold" margin-top="40mm">Overview</fo:block>
                    <fo:list-block space-before="24pt">
                    
                        <xsl:apply-templates select="turnier/gruppe" mode="toc"/> 
                        
                    </fo:list-block>
                </fo:flow>
                
            </fo:page-sequence>
            
             <!-- Gruppen -->
            <xsl:apply-templates select="turnier/gruppe" mode="detail"/>
          
          <!-- Scoreboard -->
            <fo:page-sequence master-reference="turnier-page">
                <xsl:call-template name="header">
                    <xsl:with-param name="right" select="'Scoreboard'"/>
                </xsl:call-template>
              
                <fo:flow flow-name="xsl-region-body" font-family="Times" font-size="9pt">
                    <fo:block font-weight="bold" margin-top="40mm">Scoreboard</fo:block>
                    <fo:list-block space-before="24pt">
                    
                        <xsl:apply-templates select="turnier/gruppe/mitglied/scoreboard/ziele" mode="toc"/> 
                        
                    </fo:list-block>
                </fo:flow>
                
            </fo:page-sequence>
            
            
           
                        
	</fo:root>	
	</xsl:template>
	
	    <!-- ...................... Overview Template ................... -->
    <xsl:template match="gruppe" mode="toc">
        <fo:list-item>
            <fo:list-item-label>
                <fo:block><xsl:value-of select="position()"/>.</fo:block>
            </fo:list-item-label>
            <fo:list-item-body start-indent="4mm">
                <fo:block text-align-last="justify">
                
                    <xsl:value-of select="title"/>
                    
                    <fo:leader leader-pattern="dots"></fo:leader>
                    <fo:page-number-citation ref-id="{generate-id()}"/>
                </fo:block>
            </fo:list-item-body>
        </fo:list-item>
    </xsl:template>
	
	
    <!-- .......................... Gruppe Template .......................... -->
    <xsl:template match="gruppe" mode="detail" xml:space="preserve">
        <fo:page-sequence master-reference="turnier-page">
            <xsl:call-template name="header">
            
                <xsl:with-param name="right" select="title"/>
                
            </xsl:call-template>
        
            <fo:static-content flow-name="turnier-footer">
                <fo:block font-size="7pt" text-align="end">
                
                    page <fo:page-number/>
                </fo:block>
            </fo:static-content>
        
            <fo:flow flow-name="xsl-region-body" font-family="Times" font-size="9pt">
                <!-- gruppe title -->
                
                <fo:block font-size="14pt" font-weight="bold" id="{generate-id()}">
                    <xsl:value-of select="title"/>
                </fo:block>
                                
                <!-- Mitglieder -->
                <fo:block font-size="10pt" font-weight="bold" space-before="12pt">
                    Schützen
                </fo:block>
                <xsl:for-each select="mitglied">
                    <xsl:call-template name="schuetze-detail">
                        <xsl:with-param name="schuetze" select="."/>
                        <xsl:with-param name="indent" select="0"/>
                    </xsl:call-template>
                </xsl:for-each>
            </fo:flow>
        </fo:page-sequence>    
    </xsl:template>	
    
    <!-- ...................... Scoreboard Template ................... -->
    <xsl:template match="scoreboard" mode="toc">
        <fo:list-item>
            <fo:list-item-label>
                <fo:block><xsl:value-of select="position()"/>.</fo:block>
            </fo:list-item-label>
            <fo:list-item-body start-indent="4mm">
                <fo:block text-align-last="justify">
                
                    <fo:leader leader-pattern="dots"></fo:leader>           
                    
                </fo:block>
            </fo:list-item-body>
        </fo:list-item>
    </xsl:template>
	
	

	
	    <xsl:template name="header">
        <xsl:param name="right"/>
        <!-- page header: left: ? ; left: ? -->
        <fo:static-content flow-name="turnier-header">
            <fo:block font-size="7pt" text-align-last="justify">
                <xsl:value-of select="/turnier/headline"/>
                <fo:leader/>
                <xsl:value-of select="$right"/>
            </fo:block>
        </fo:static-content>        
    </xsl:template>
    
    
    
    <xsl:template name="schuetze-detail">
        <xsl:param name="schuetze"/>
        <xsl:param name="indent"/>
        
        <xsl:if test="not($schuetze/firstname)" xml:space="preserve">
            <fo:block start-indent="{$indent}mm">    
                
                <xsl:value-of select="$schuetze/@id"/>
                <xsl:value-of select="$schuetze/firstname"/>
                <xsl:value-of select="$schuetze/lastname"/>
                
            </fo:block>
            
        </xsl:if>
        
        
        <xsl:if test="$schuetze/firstname">
            <fo:block start-indent="{$indent}mm" font-weight="bold" space-before="6pt">
                <xsl:value-of select="$schuetze/@id"/>
            </fo:block>
            
            <xsl:for-each select="$schuetze/firstname">
            
                <xsl:call-template name="schuetze-detail">
                    <xsl:with-param name="schuetze" select="."/>
                    <xsl:with-param name="indent" select="$indent+4"/>
                </xsl:call-template>                                
            </xsl:for-each>
          
        </xsl:if>            
    </xsl:template>
	
	
</xsl:stylesheet>