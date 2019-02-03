<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format">
    
<xsl:template match="/szene-open-air">
        <fo:root>
            <fo:layout-master-set>
                <fo:simple-page-master master-name="person-card"
                    page-height="148mm"
                    page-width="210mm"
                    margin="1em">
                    
                    <fo:region-body />
                    <fo:region-before extent="24pt" region-name="festival-header"/>
                    <fo:region-after extent="18pt" region-name="festival-footer"/>
                   
                </fo:simple-page-master>
            </fo:layout-master-set>
            
            
            <fo:page-sequence master-reference="person-card">
                <fo:flow flow-name="xsl-region-body">
                    <fo:block font-size="50" text-align="center" margin-top="200">Person Cards</fo:block>
                </fo:flow>
            </fo:page-sequence>
            
            <!-- Table of contents -->
            <fo:page-sequence master-reference="person-card">
                <fo:static-content flow-name="festival-footer">
                    <fo:block>
                        Seite <fo:page-number/>
                    </fo:block>
                </fo:static-content>
                <fo:flow flow-name="xsl-region-body">
                    <fo:block margin-bottom="7mm" font-size="30" margin-left="4mm" margin-top="5mm">Table of Contents</fo:block>
                    <fo:list-block text-align-last="justify">
                        <xsl:for-each select="//person">
                            <xsl:sort select="@lname"/>
                            <fo:list-item>
                                
                                <fo:list-item-label>
                                    <fo:block margin-left="4mm"><xsl:value-of select="position()"/>.</fo:block>
                                </fo:list-item-label>
                                <fo:list-item-body start-indent="12mm">
                                    <fo:block text-align="justify">                                        
                                        <fo:basic-link internal-destination="{@person-id}">
                                            <xsl:call-template name="getPersonName"/>     
                                            <fo:leader leader-pattern="dots"/>
                                            <fo:page-number-citation ref-id="{@person-id}"/>
                                        </fo:basic-link>
                                    </fo:block>
                                </fo:list-item-body>
                            </fo:list-item>
                        </xsl:for-each>
                    </fo:list-block>
                       
                   
                </fo:flow>
            </fo:page-sequence>
       
       
       <xsl:for-each select="//person">
           <xsl:sort select="@lname"/>
           <fo:page-sequence master-reference="person-card" id="{@person-id}">
               <fo:static-content flow-name="festival-footer">
                   <fo:block>
                       Seite <fo:page-number/>
                   </fo:block>
               </fo:static-content>
               <fo:flow flow-name="xsl-region-body">
                   <fo:block text-align="center" font-size="30"><xsl:call-template name="getPersonName"/></fo:block>
                   <fo:block font-size="25">Address:</fo:block>
                   <fo:block linefeed-treatment="preserve"><xsl:call-template name="getPersonAddress"/></fo:block>
                   <fo:block margin-top="10mm" margin-bottom="5mm" font-size="25">Jobs:</fo:block>
                   <fo:table>
                       
                       <fo:table-column />
                       <fo:table-column/>
                       <fo:table-column/>
                       <fo:table-header>
                           <fo:table-row>
                               <fo:table-cell font-size="22"><fo:block>Job</fo:block></fo:table-cell>
                               <fo:table-cell font-size="22"><fo:block>Year</fo:block></fo:table-cell>
                               <fo:table-cell font-size="22"><fo:block>Ressort</fo:block></fo:table-cell>
                           </fo:table-row>
                       </fo:table-header>
                       <fo:table-body>
                           <fo:table-row>
                               <fo:table-cell><fo:block></fo:block></fo:table-cell>
                           </fo:table-row>
                           <xsl:variable name="temp" select="@person-id"/>                           
                           <xsl:for-each select="//helper-festival[id(@helper-id)/@person-id = $temp]">                             
                             <fo:table-row>
                                 <fo:table-cell><fo:block><xsl:value-of select="id(@job-id)/@description"/></fo:block></fo:table-cell>
                                 <fo:table-cell><fo:block><xsl:value-of select="substring(../@festival-year,15)"/></fo:block></fo:table-cell>
                                 <fo:table-cell><fo:block><xsl:value-of select="id(@job-id)/ancestor::ressort/@description"/></fo:block></fo:table-cell>
                             </fo:table-row>
                           </xsl:for-each>
                       </fo:table-body>
                   </fo:table>
               </fo:flow>
           </fo:page-sequence>
       </xsl:for-each>
            
        </fo:root>
    </xsl:template>
    
    
    <!-- Table of contents template -->
    
    <xsl:template name="getPersonName" match="//person" xml:space="preserve">  
        <xsl:value-of select="@fname"/> <xsl:value-of select="@lname"/>
    </xsl:template>
    
    <xsl:template name="getPersonAddress" match="//person" xml:space="preserve">
        <xsl:value-of select="../@street"/> <xsl:value-of select="../@number"/>
        <xsl:value-of select="../@zip"/> <xsl:value-of select="../@city"/>
        <xsl:value-of select="../@country"/>
    </xsl:template>
    
    
    
    
</xsl:stylesheet>