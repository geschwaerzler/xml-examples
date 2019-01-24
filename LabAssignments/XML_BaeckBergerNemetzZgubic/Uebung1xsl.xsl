<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    
    <xsl:template match= "/breakdance-datenbank">
        <html>
        <head>
            <title>Unsere Tanzschule</title>        
        </head>
        <body>
            <h1>Alle Tanzgruppen</h1>
           <xsl:for-each select="crew">
               <xsl:sort></xsl:sort>
               <li> 
                   <a href="#{generate-id(.)}"><xsl:value-of select="@crew_name"/></a>
               </li>
               
           </xsl:for-each>
                      
            <xsl:apply-templates select="crew"/>
            
            <h1>Index</h1>
           
            <xsl:for-each select="person[@personen_typ ='lehrer']">
                <xsl:variable name="Lehrer" select="@id"/>
                <li xml:space="preserve">
                
                    <a href="#{generate-id(.)}"><xsl:value-of select="@vname"/>
                    <xsl:value-of select="@nname"/></a>
                   <xsl:for-each select="//crew[@lehrer_id = $Lehrer]">
                       <xsl:value-of select="@crew_name"/>
                   </xsl:for-each>
                   
                    
                </li>
                
                
            </xsl:for-each>
           
     
        </body>
               
     
        </html>
    </xsl:template>
    
    <xsl:template match = "crew">
        
        <h1 id = "{generate-id(.)}"><xsl:value-of select="@crew_name" /></h1>
        
        <h2 id = "{generate-id(.)}">Lehrer</h2>
        <xsl:value-of select="id(@lehrer_id)/@vname"/>    
                
        <h2>Mitglieder</h2>
        <ul>
        <xsl:for-each select="crewmember">
            <li>
                <xsl:apply-templates select="id(@schueler_id)"/>
            </li>                   
        </xsl:for-each>
        </ul>
        <h2>Unterrichtseinheit</h2>
        <xsl:variable name="CrewId" select="@id"/>
        <ul>
            
            <xsl:for-each select="../schulstandort/raum/unterrichtseinheit[@crew_id = $CrewId]">
                <xsl:sort select="@ue_wochentag"></xsl:sort>
                <li xml:space="preserve">
                    <xsl:value-of select="@ue_wochentag"/>
                    <xsl:value-of select="@ue_startZeit"/>
                    
                </li>                 
            </xsl:for-each>
        </ul>
        
 
    </xsl:template>
    
    
    <xsl:template match="person" xml:space="preserve" >
                    
        <xsl:value-of select="@vname"/>
         <xsl:value-of select="@nname"/>    
    </xsl:template> 
    
    <xsl:variable name="Crew" select="//person/@id"/>
    
    
    
</xsl:stylesheet>