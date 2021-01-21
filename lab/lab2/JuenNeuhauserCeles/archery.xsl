<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    <xsl:output method="html"/>

    <xsl:template match="/">
        <html>
            <head>
                <title>Bogenturnier Aufbau Information</title>
            </head>
            <body>
               <h1>Bogenturnier Aufbau Information
                </h1>
                
                <table style="width:90%">
                    <tr> <td><h2>Ortliste</h2></td><td><h2>Lagerliste</h2></td><td><h2>Mitarbeiterliste</h2></td><td><h2>Parkourliste</h2></td><td><h2>Aufgabenliste</h2></td></tr>
                    <tr>
                        <td> <xsl:for-each select="archery/ort">
                            <li> <a href="#{generate-id()}"> <xsl:value-of select="@ort_name"/> </a> </li>
                        </xsl:for-each></td>
                        <td><xsl:for-each select="archery/lager">
                            <li> <a href="#{generate-id()}"> <xsl:value-of select="@lager_name"/> </a> </li>
                        </xsl:for-each></td>
                        <td>  <xsl:for-each select="archery/mitarbeiter"> 
                            <li> <a href="#{generate-id()}"> <xsl:value-of select="@fname"/> 
                                <n></n> 
                                <xsl:value-of select="@lname"/> 
                            </a> </li> 
                        </xsl:for-each>  </td>
                        <td><xsl:for-each select="archery/parkour">
                            <li>  <a href="#{generate-id()}"> <xsl:value-of select="@parkour_name"/> </a> </li>
                        </xsl:for-each></td>
                        <td><xsl:for-each select="archery/aufgabe">
                            <li>  <a href="#{generate-id()}"> <xsl:value-of select="@aufgabe_bezeichnung"/> </a> </li>
                        </xsl:for-each></td>
                    </tr>
                    
                </table>
                <h3>Orte im Detail</h3>
                    <ul><xsl:for-each select="archery/ort">
                        <h3 id="{generate-id()}"> <xsl:value-of select="@ort_name"/></h3> 
                        <ul> <xsl:text> ort_id:</xsl:text>
                            <n> </n>
                            <xsl:value-of select="@ort_id"/>
                            <br></br> <br></br>
                            <xsl:text> GPS-Koordinaten:</xsl:text> <n></n> <xsl:value-of select="@gps_daten"/>
                        </ul>
                         
                    </xsl:for-each>
                    </ul>
                
                <h3>Lagerinformationen</h3>
                <ul><xsl:for-each select="archery/lager">
                    <h3 id="{generate-id()}"><xsl:value-of select="@lager_name"/></h3> 
                    <ul> <xsl:text> lager_id:</xsl:text>
                        <n> </n> 
                        <xsl:value-of select="@lager_id"/> 
                        <br></br> <br></br>
                        <xsl:text> befindet sich in: 
                        </xsl:text>
                        <xsl:value-of select="id(@ort_id)/@ort_name"/>
                        <br></br> <br></br>
                        <xsl:text> lagert:</xsl:text>
                        <br></br> 
                        <xsl:for-each select="lagert"> <br></br>
                            <li> <xsl:value-of select="id(@material_id)/@material_bezeichnung"/>  
                                <xsl:text>,</xsl:text>  <n></n>
                                <xsl:text> Materialzustand:</xsl:text> <n></n>
                                <xsl:value-of select="id(@material_id)/@material_zustand"/> 
                                <xsl:text>,</xsl:text> 
                                <xsl:text> material_id:</xsl:text> <n></n>
                                <xsl:value-of select="@material_id"/></li>  
                    
                        </xsl:for-each>
                    </ul>
                    
                </xsl:for-each>
                </ul>
            
            <h3> Mitarbeiterinformationen</h3>
             <ul > <xsl:for-each select="archery/mitarbeiter">
                 <h3 id="{generate-id()}"  > <xsl:value-of select="@fname"/> <n></n> <xsl:value-of select="@lname"/> </h3>
                <ul>  <xsl:text>TelNr.: </xsl:text><xsl:value-of select="@tel_nr"/>
                    <xsl:for-each select="hatRolle"> <br></br> <br></br> 
                     <xsl:text>Rolle: </xsl:text><xsl:value-of select="id(@rolle_id)/@titel"/>
                    </xsl:for-each> <br></br> <br></br> 
                    <xsl:text>hat Aufgabe: </xsl:text>
                    
                     <xsl:for-each select="hatAufgabe"> 
                         <li> <a href="#{generate-id()}"> <xsl:value-of select="id(@aufgabe_id)/@aufgabe_bezeichnung"/> </a> </li>
                 </xsl:for-each>
                 </ul>      
             </xsl:for-each>
              </ul>
                
               <h3>Parkourdetails</h3>
                <ul><xsl:for-each select="archery/parkour">
                    <h3 id="{generate-id()}"> <xsl:value-of select="@parkour_name"/></h3> 
                    <table style="width:40%">
                        <tr> <td><h4>Station</h4></td><td><h4>Ort</h4></td><td><h4>benoetigt</h4></td> </tr>
                    <tr>
                   <td> <xsl:for-each select="station"> 
                       <xsl:value-of select="@station_nr"/> <br></br>
                   </xsl:for-each>
                   </td>
                        <td> <xsl:for-each select="station"> 
                            <xsl:value-of select="id(@ort_id)/@ort_name"/> <br></br> </xsl:for-each> </td>
                        
                        <td> <xsl:for-each select="station"> 
                            <xsl:for-each select="benoetigt"> 
                                <xsl:value-of select="id(@material_id)/@material_bezeichnung"/> <br></br> 
                            </xsl:for-each> 
                        </xsl:for-each>  
                        </td>
                    </tr>
                            </table>
           
                </xsl:for-each>
                </ul>
                
                <h3>Aufgabendetails</h3>
                <ul><xsl:for-each select="archery/aufgabe">
                    <h3 id="{generate-id()}"> <xsl:value-of select="@aufgabe_bezeichnung"/></h3> 
                    <ul> <xsl:text>Aufgabe_id: </xsl:text>
                        <n> </n> 
                        <xsl:value-of select="@aufgabe_id"/> 
                        <br></br> <br></br>
                        <xsl:text>gehe zu:  </xsl:text>
                        <xsl:for-each select="an"> 
                            <li><xsl:value-of select="id(@ort_id)/@ort_name"/> <br></br></li>
                        </xsl:for-each> 
                        <br></br>
                        <xsl:text>verwende:  </xsl:text>  
                        <xsl:for-each select="verwende"> 
                            <li> <xsl:value-of select="id(@material_id)/@material_bezeichnung"/>
                                <xsl:text> mit der ID: </xsl:text>
                                <xsl:value-of select="@material_id"/>
                                <br></br>
                            </li>
                        </xsl:for-each> 
                        <br></br>
                        <xsl:text>am:  </xsl:text>
                        <xsl:for-each select="termin"> 
                            <li><xsl:value-of select="@datum"/>
                                <xsl:text>, beginnt: </xsl:text>
                                <xsl:value-of select="@beginn_uhrzeit"/>
                                <xsl:text>, endet: </xsl:text>
                                <xsl:value-of select="@ende_uhrzeit"/> 
                                <br></br>
                            </li>
                        </xsl:for-each> 
    
                    </ul>
                </xsl:for-each> 
              </ul>
          </body>

        </html>
 
    </xsl:template>
    
 
        
        
        
    
    
    
    
    
    
    
    
    
</xsl:stylesheet>