<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format">
    
    <xsl:template match="/">
         <fo:root>
             <fo:layout-master-set>
                 <fo:simple-page-master master-name="aktiva-page"
                     page-height="297.0mm" page-width="209.9mm"
                     margin-bottom="8mm" margin-left="20mm" margin-right="20mm" margin-top="10mm">     
                     <fo:region-body margin-bottom="28mm" margin-left="0mm" margin-right="16mm" margin-top="22.6mm"/>
                     <fo:region-before extent="24pt" region-name="aktiva-header"/>
                     <fo:region-after extent="24pt" region-name="aktiva-footer"/>
                 </fo:simple-page-master>
             </fo:layout-master-set>
             
             <fo:page-sequence master-reference="aktiva-page">
                 <fo:flow flow-name="xsl-region-body" font-family="sans-serif" font-size="36pt">
                     <fo:block>
                         <xsl:value-of select="'Aktiva Arbeiter'"/>
                     </fo:block>
                 </fo:flow>
             </fo:page-sequence>
             
             <fo:page-sequence master-reference="aktiva-page">
                 <xsl:call-template name="header">
                     <xsl:with-param name="right" select="'Inhaltsverzeichnis'"/>
                 </xsl:call-template>
                
                 <fo:flow flow-name="xsl-region-body" font-family="serif" font-size="16pt">
                     <fo:block font-weight="bold">Inhaltsverzeichnis</fo:block>
                     <fo:list-block space-before="24pt">
                         <xsl:apply-templates select="aktiva/worker" mode="toc"/>
                     </fo:list-block>
                 </fo:flow>
             </fo:page-sequence>
             
             <xsl:apply-templates select="aktiva/worker" mode="worker"/>
             
         </fo:root>
    </xsl:template>
    
    <!-- ...................... TABLE OF CONTENTS TEMPLATE ................... -->
    <xsl:template match="worker" mode="toc" xml:space="preserve">
        <fo:list-item>
            <fo:list-item-label>
                <fo:block><xsl:value-of select="position()"/>.</fo:block>
            </fo:list-item-label>
            <fo:list-item-body start-indent="8mm">
                <fo:block text-align-last="justify">
                    <xsl:value-of select="@fname"/> 
                    <xsl:value-of select="@lname"/>
                    <fo:leader leader-pattern="dots"></fo:leader>
                    <fo:page-number-citation ref-id="{generate-id()}"/>
                </fo:block>   
            </fo:list-item-body>
        </fo:list-item>
    </xsl:template>
    
    <!-- ...................... WORKERS TEMPLATE................... -->
    <xsl:template match="aktiva/worker" mode="worker" xml:space="preserve">
         <fo:page-sequence master-reference="aktiva-page">
           <xsl:call-template name="header">
               <xsl:with-param name="right" select="concat(@fname, ' ', @lname)"/>
           </xsl:call-template>
           
           <fo:static-content flow-name="aktiva-footer">
             <fo:block font-size="7pt" text-align="end">
               Seite <fo:page-number/>
             </fo:block>
           </fo:static-content>
         
               
           <fo:flow flow-name="xsl-region-body" font-family="serif" font-size="9pt">   
              <fo:block font-size="20pt" font-weight="bold" id="{generate-id()}" break-after="page">
                  <xsl:value-of select="@fname"/> 
                  <xsl:value-of select="@lname"/>
                  <fo:block font-size="18pt" font-weight="bold" margin-top="20">
                      Qualifikation:
                  </fo:block>
                  <fo:block font-size="15pt" margin-top="20">
                      <xsl:value-of select="@qualification"/>
                  </fo:block>
                  <fo:block font-size="18pt" font-weight="bold" margin-top="30">
                      Lebenslauf:
                  </fo:block>
                  <xsl:apply-templates select="cv-entry" mode="cventry"/>
                  <fo:block font-size="18pt" font-weight="bold" margin-top="30">
                      Verträge bei aktiva:
                  </fo:block>
                  <xsl:apply-templates select="worker-contract" mode="contract"/>
              </fo:block>
            </fo:flow>
                
         </fo:page-sequence>    
    </xsl:template>
    
    <xsl:template match="cv-entry" mode="cventry" xml:space="preserve">
        <fo:block font-size="15pt" margin-top="15">
                <xsl:value-of select="@start"/> - <xsl:value-of select="@end"/> bei <xsl:value-of select="@company-name"/>
        </fo:block>
    </xsl:template>
    
    <xsl:template match="worker-contract" mode="contract">
        <xsl:variable name="qual" select="ancestor::worker/@qualification"/>
        <fo:block font-size="15pt" margin-top="15">
            <xsl:value-of select="id(id(@offer-id)/@request-id)/request-entry[@qualification=$qual]/@start"/> - 
            <xsl:choose>
                <xsl:when test="id(id(@offer-id)/@request-id)/request-entry[@qualification=$qual]/@end">
                    <xsl:value-of select="id(id(@offer-id)/@request-id)/request-entry[@qualification=$qual]/@end"/>
                </xsl:when>
                <xsl:otherwise>heute </xsl:otherwise>
            </xsl:choose>
            als
            <xsl:value-of select="$qual"/> bei
            <xsl:variable name="offer" select="@offer-id"/>
            <xsl:value-of select="ancestor::aktiva/company/company-contract[@offer-id=$offer]/../@name"/>
        </fo:block>    
    </xsl:template>
    
    <xsl:template name="header">
        <xsl:param name="right"/>
        <fo:static-content flow-name="aktiva-header">
            <fo:block font-size="10pt" text-align-last="justify">
                <xsl:value-of select="'Aktiva Arbeiter'"/>
                <fo:leader/>
                <xsl:value-of select="$right"/>
            </fo:block>
        </fo:static-content>        
    </xsl:template>
</xsl:stylesheet>