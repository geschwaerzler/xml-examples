<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:fo="http://www.w3.org/1999/XSL/Format">
	
	
	
	
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
                
                <fo:flow flow-name="xsl-region-body" font-family="sans-serif" font-size="28pt"> <!--Body-->
                
                    <fo:block margin-top="40mm" font-weight="bold">
                        <xsl:value-of select="turnier/headline"/>
                    </fo:block>
                    
            

                    
                </fo:flow> <!--Body Ende-->
            </fo:page-sequence>
	    
	    <!-- Übersicht Seite -->
	    
	    <fo:page-sequence master-reference="turnier-page">
	        
	        <fo:flow flow-name="xsl-region-body" font-family="sans-serif" font-size="28pt"> <!--Body-->
	            
       
	            <fo:block margin-top="20mm" font-family="italic" font-size="22pt">
	                <fo:inline font-weight="bold">Übersicht</fo:inline>      
	            </fo:block>
	            

	            <fo:list-block space-before="36pt">
	                <fo:list-item>
	                    <fo:list-item-label>
	                        <fo:block font-size="16pt" >1</fo:block>
	                    </fo:list-item-label>
	                    <fo:list-item-body start-indent="4mm">
	                        <fo:block font-size="16pt" margin-left="2mm" text-align-last="justify">
	                            <fo:inline font-family="italic">Gruppen </fo:inline>
	                            <fo:page-number-citation ref-id="{generate-id()}"/>    
	                        </fo:block>
	                    </fo:list-item-body>
	                </fo:list-item>
	                <xsl:apply-templates select="//gruppe" mode="toc"/>
	                
	                <fo:list-item space-before="24pt">
	                    <fo:list-item-label>
	                        <fo:block font-size="16pt" >2</fo:block>
	                    </fo:list-item-label>
	                    <fo:list-item-body start-indent="4mm">
	                        <fo:block font-size="16pt" margin-left="2mm" text-align-last="justify">
	                            <fo:inline font-family="italic">Scoreboards </fo:inline>
	                            <fo:page-number-citation ref-id="{generate-id()}"/>
	                        </fo:block>
	                    </fo:list-item-body>
	                </fo:list-item>
	                <xsl:apply-templates select="//scoreboard" mode="toc"/>
	            </fo:list-block>
	            
	            <!-- <xsl:apply-templates select="//gruppe" mode="toc" /> /> -->        
	            <!-- <xsl:apply-templates select="//gruppe/mitglied" mode="toc" /> -->
	            
   
	        </fo:flow> <!--Body Ende-->
	    </fo:page-sequence>
	    
	    <fo:page-sequence master-reference="turnier-page">
	        <fo:static-content flow-name="turnier-footer">
	            <fo:block font-size="10pt" text-align="end" margin-right="10mm">
	                Seite <fo:page-number/>
	            </fo:block>
	        </fo:static-content>
	        <fo:flow flow-name="xsl-region-body" font-family="Times">
	            <fo:block margin-top="20mm" font-size="28pt" font-weight="800">
	                Gruppen
	            </fo:block>
	            <fo:block>
	                <xsl:apply-templates select="//gruppe" mode="details"/>
	            </fo:block>
	        </fo:flow>
	    </fo:page-sequence>
	    
	    
	    <fo:page-sequence master-reference="turnier-page">
	        <fo:static-content flow-name="turnier-footer">
	           
	            <fo:block font-size="10pt" text-align="end" margin-right="10mm">
	                Seite <fo:page-number/>
	            </fo:block>
	            
	        </fo:static-content>
	        
	        <fo:flow flow-name="xsl-region-body" font-family="Times">
	            <fo:block margin-top="20mm" font-size="28pt" font-weight="800">
	                Scoreboards
	            </fo:block>
	            
	            <fo:block>
	                <xsl:apply-templates select="//scoreboard" mode="table"/>
	            </fo:block>
	        </fo:flow>
	    </fo:page-sequence>
    
	</fo:root>
	    
	</xsl:template>
    
  
    
    <!-- Templates -->
    
    <xsl:template match="//gruppe" mode="toc">
        <fo:list-item>
            <fo:list-item-label>
                <fo:block font-size="20">1.<xsl:value-of select="position()"/>.</fo:block>
            </fo:list-item-label>
            
            <fo:list-item-body start-indent="8mm">
                <fo:block font-size="20" margin-left="10" text-align-last="justify"> Gruppe 
                    <xsl:value-of select="@id"/>
                    (<xsl:value-of select="id(@klassen-id)"/>)
                    <fo:leader leader-pattern="space"/>
                    
                    S. <fo:page-number-citation ref-id="{generate-id()}"/>
                </fo:block>
            </fo:list-item-body>
        </fo:list-item>
    </xsl:template>
     
    
    <xsl:template match="//gruppe" mode="details">        
        <fo:block padding-top="20pt" padding-bottom="5pt" font-size="20pt" font-weight="bold" id="{generate-id()}">
            Gruppe <xsl:value-of select="@id"/>: <xsl:value-of select="id(@klassen-id)"/>
        </fo:block>
        <fo:block start-indent="20mm" padding-left="10pt" border-left="solid 2pt black">
            <fo:inline font-size="14pt" font-weight="bold">Mitglieder:</fo:inline>
            <xsl:for-each select="mitglied" xml:space="preserve">
                <fo:block start-indent="25mm" font-size="11pt">
                    
                    <xsl:variable name="Schuetze" select="id(@schuetze-id)"/>       
                    
                    <xsl:value-of select="$Schuetze/firstname"/>
                    <xsl:value-of select="$Schuetze/lastname"/>
        
                    <fo:list-block>
                        <fo:list-item>
                            <fo:list-item-label>
                                <fo:block></fo:block>
                            </fo:list-item-label>
                            <fo:list-item-body start-indent="30mm">
                                <fo:block></fo:block>
                            </fo:list-item-body>
                        </fo:list-item>
                        <fo:list-item>
                            <fo:list-item-label>
                                <fo:block>--</fo:block>
                            </fo:list-item-label>
                            <fo:list-item-body start-indent="30mm">
                                <fo:block></fo:block>
                            </fo:list-item-body>
                        </fo:list-item>
                    </fo:list-block>
                </fo:block>
            </xsl:for-each>
        </fo:block>
    </xsl:template>
    
    <xsl:template match="//scoreboard" mode="toc">
        
     
   
        
        
        <fo:list-item>
            <fo:list-item-label>
                
                <fo:block font-size="20">2.<xsl:value-of select="position()"/></fo:block>
            </fo:list-item-label>
           
            <fo:list-item-body start-indent="8mm"> 
                <fo:block font-size="20" margin-left="10" text-align-last="justify"> 
                    
                         
                        Schütze        
                    <xsl:variable name="Schuetze2" select="//id(@schuetze-id)"/>           
                    <xsl:value-of select="$Schuetze2/firstname"/> 
                    <xsl:value-of select="$Schuetze2/lastname"/> 
                   
            
  
                    
                    <fo:leader leader-pattern="space"/>
                    S. <fo:page-number-citation ref-id="{generate-id()}"/>
                </fo:block>
                
            </fo:list-item-body>
            
        </fo:list-item>
       
        
    </xsl:template>
    
    <xsl:template match="//scoreboard" mode="table">
        
        
        
            <xsl:variable name="Schuetz3e" select="//id(@schuetze-id)"/>
            <fo:block font-size="12pt" id="{generate-id()}" margin-top="5">
                
                Scoreboard von:  
                <xsl:value-of select="$Schuetz3e/firstname"/>_
                <xsl:value-of select="$Schuetz3e/lastname"/> 
                 
            </fo:block>
        
        <fo:table>
            
            
           
            
            <fo:table-body>
                <fo:table-row>
                    <fo:table-cell>
                        <fo:block font-weight="600" min-width="100">Target</fo:block>    
                    </fo:table-cell>
                    <fo:table-cell>
                        <fo:block font-weight="600" min-width="100">Shot 1</fo:block>    
                    </fo:table-cell>
                    <fo:table-cell>
                        <fo:block font-weight="600" min-width="100">Shot 2</fo:block>    
                    </fo:table-cell>
                    <fo:table-cell>
                        <fo:block font-weight="600" min-width="100">Shot 3</fo:block>    
                    </fo:table-cell>
                    <fo:table-cell>
                        <fo:block font-weight="600" min-width="100">Gesamt</fo:block>    
                    </fo:table-cell>
                </fo:table-row>
               <xsl:for-each select="//scoreboard/ziele">
               
               <fo:table-row>
                   <fo:table-cell>
                   <fo:block>
                       <xsl:variable name="zielid" select="@target-id"></xsl:variable>
                       <xsl:value-of select="//target[@id = $zielid]/text()"/>
                  </fo:block>
                   </fo:table-cell>
                   <fo:table-cell>
                       <fo:block>
                           <xsl:value-of select="punkte[position()=1]"/>
                           <xsl:value-of select="punkte[position()=2]"/>
                           <xsl:value-of select="punkte[position()=3]"/>
                           <xsl:value-of select="sum(punkte/text())"/></fo:block>
                   </fo:table-cell>
               </fo:table-row>
                   
               
                
               
               
               </xsl:for-each>
              <fo:table-row>
                  <fo:table-cell>
                      <fo:block></fo:block>
                  </fo:table-cell>
                  <fo:table-cell>
                      <fo:block></fo:block>
                  </fo:table-cell>
                  <fo:table-cell>
                      <fo:block></fo:block>
                  </fo:table-cell>
                  
              </fo:table-row>
              <fo:table-row>
                  <fo:table-cell>
                      <fo:block></fo:block>
                  </fo:table-cell>
              </fo:table-row>
                
            </fo:table-body>
        </fo:table>
        
    
            
            
            
        

        
           
    </xsl:template>
	                                   
          
	
	
</xsl:stylesheet>