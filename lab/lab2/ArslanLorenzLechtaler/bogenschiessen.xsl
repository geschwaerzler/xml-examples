<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    
    <xsl:template match="/">
        <html>
            <head>
                
                <title>Bogenschießen</title>
                
            </head>
            <body>
                <font face="Arial">
                <title>Bogenschießen</title>
                
                <xsl:apply-templates select="bogenschiessen/turniere"></xsl:apply-templates>
                <xsl:apply-templates select="bogenschiessen/punktestände"></xsl:apply-templates>    
                </font>
            </body>
        </html>
                
    </xsl:template>
   
    
    
    
    
    <xsl:template match="turniere">
        
        <xsl:for-each select="turnier">
            <table>
                <h1><xsl:value-of select="@Name"/></h1>
                <tr> <td>ID</td><td>Jahr</td><td>Land</td></tr>
                <tr>
                    <td><xsl:value-of select="@lfd_nummer"/></td>
                    <td><xsl:value-of select="@jahr"/></td>
                    <td><xsl:value-of select="@land"/></td>
                </tr>
            </table>
            
            <!-- Inhaltsverzeichniss -->
            <h2>Inhaltsverzeichniss</h2>
            
            <xsl:for-each select="/bogenschiessen/turniere/turnier">
                <xsl:for-each select="Runde">
                    <xsl:variable name="date"><xsl:value-of select="@date"/></xsl:variable>
                    <xsl:for-each select="Gruppe">
                        <br>Group: <a href="#{generate-id()}"><xsl:value-of select="@gruppen_id"/></a>, <xsl:value-of select="$date"/></br>
                    </xsl:for-each>
                </xsl:for-each>
            </xsl:for-each>
           
           <hr/>
            <!-- Gruppen Auflistung -->
            
            <h3>Groups</h3>
            
            <xsl:for-each select="Runde">
                
                <h4><xsl:value-of select="@runden_id"/></h4>
                <xsl:for-each select="Gruppe">
                    
                    
                    <a name="{generate-id()}"><h5>Gruppen ID: <xsl:value-of select="@gruppen_id"/></h5></a>
                    <table>
                        <!-- Setup 
                        <tr>
                            <td>Spieler ID</td><td>Vorname</td><td>Nachnahme</td><td>Rolle</td>
                        </tr>
                        -->
                        <!-- Content -->
                        
                        <xsl:for-each select="schütze">
                            <xsl:variable name="person"><xsl:value-of select="@person_id"/></xsl:variable> 
                            <tr>
                                <td><xsl:value-of select="/bogenschiessen/turnier_teilnehmer/teilnehmer[@person_id=$person]/teilnehmer_Vn"></xsl:value-of>
                                    <n> </n>
                                    <xsl:value-of select="/bogenschiessen/turnier_teilnehmer/teilnehmer[@person_id=$person]/teilnehmer_Nn"></xsl:value-of></td>  
                                
                                <xsl:for-each select="/bogenschiessen/turnier_teilnehmer/teilnehmer[@person_id=$person]">
             
                                    <td><a href="#{generate-id()}"><xsl:value-of select="@person_id"/></a></td>                             
                                </xsl:for-each>
                            </tr>
                        </xsl:for-each>
                    </table>
                    
                    <hr/>
                </xsl:for-each>
                    
                </xsl:for-each>
                
            
        </xsl:for-each>
        
        
        
    </xsl:template>
   

    <xsl:template match="punktestände">
        
        <h2>Scorecards</h2>
        
        <xsl:for-each select="turnier_punkte">
            
            
            <xsl:variable name="turnier"><xsl:value-of select="@turnier_id"/></xsl:variable>
            
                <xsl:for-each select="/bogenschiessen/turnier_teilnehmer/teilnehmer">
            
                    <xsl:variable name="person"><xsl:value-of select="@person_id"/></xsl:variable>
                    
                    <h3>
                        <xsl:value-of select="/bogenschiessen/turnier_teilnehmer/teilnehmer[@person_id=$person]/teilnehmer_Vn"></xsl:value-of>
                        <n> </n>
                        <xsl:value-of select="/bogenschiessen/turnier_teilnehmer/teilnehmer[@person_id=$person]/teilnehmer_Nn"></xsl:value-of>
                        <n> </n>
                        <xsl:for-each select="/bogenschiessen/turnier_teilnehmer/teilnehmer[@person_id=$person]">
                            <a name="{generate-id()}"><xsl:value-of select="@person_id"/></a>
                            
                        </xsl:for-each>
                    </h3> 
                   
                                
                 <xsl:for-each select="/bogenschiessen/punktestände/turnier_punkte[@turnier_id=$turnier]/punktestand[@person_id=$person]">                  
               
                
                             <xsl:for-each select="Runde_punkte">
                                 <h4>Runden Name: <xsl:value-of select="@runden_id"/></h4>
                                 
                                 <table style="width:60%">
                                     <!-- Setup -->
                                     <tr>
                                         <th>Scheibe</th>
                                         <th>Schuss 1</th>
                                         <th>Schuss 2</th>
                                         <th>Schuss 3</th>
                                     </tr>
                                     <!-- Content -->
                                     <xsl:variable name="parcur"/>
                                     <xsl:variable name="runde"><xsl:value-of select="@runden_id"/></xsl:variable>
                                     <xsl:for-each select="/bogenschiessen/turniere/turnier/Runde[@runden_id=$runde]">
                           
                                         <xsl:variable name="parcur"><xsl:value-of select="@parkur_id"/></xsl:variable>
                                         
                                         <xsl:for-each select="/bogenschiessen/pacours/parkur[@parkur_id=$parcur]/scheiben">
                                             <tr>
                                                 <td style="text-align: center; vertical-align: middle;"><xsl:value-of select="@scheiben_id"/></td>
                                                 <xsl:variable name="scheibe"><xsl:value-of select="@scheiben_id"/></xsl:variable>
                                                 <xsl:for-each select="/bogenschiessen/punktestände/turnier_punkte[@turnier_id=$turnier]/punktestand[@person_id=$person]/Runde_punkte[@runden_id=$runde]/scheiben_punkte[@scheiben_id=$scheibe]">
                                                     
                                                     <xsl:for-each select="schüsse">
                                                         <td style="text-align: center; vertical-align: middle;"><xsl:value-of select="."/></td>
                                                     </xsl:for-each>
                                                     
                                                 </xsl:for-each>
                                                 
                                             </tr>
                                         </xsl:for-each>      
                                     </xsl:for-each>
                                            
                                 </table>
                                 
                                 
                                 
                             </xsl:for-each>
               
               
               
                 </xsl:for-each>
            
            
                    <hr/> 
            
        </xsl:for-each>
        
        
        </xsl:for-each>
        
        
    </xsl:template>

    
    
    

        
        
        
        
        
</xsl:stylesheet>