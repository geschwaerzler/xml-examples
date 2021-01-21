<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:template match="/">
        
        <!-- Head -->

        <html>
            <Head>
                <title>
                    <xsl:value-of select="archery_db/description"/>
                </title>
            </Head>
            
            <!-- Body -->            
          
            <body>

                <h1>
                    <xsl:value-of select="archery_db/description"/>
                </h1>
                
                <!-- Inhaltsverzeichnis -->
                
                <h2>Inhaltsverzeichnis</h2>
                
                <table>
                    <xsl:for-each select="archery_db/turnier/gruppe">
                        <xsl:sort select="@gruppen_ID"/>
                        <tr>
                            <td>
                                <a href="#{@gruppen_ID}">
                                    <xsl:value-of select="@gruppen_ID"/>
                                </a>
                            </td>
                        </tr>
                    </xsl:for-each>
                </table>
                
                <!-- Gruppen -->

                <h1>Gruppen</h1>

                <xsl:for-each select="archery_db/turnier/gruppe">                      
                    <hr/>
                    
                    <h2 id="{@gruppen_ID}">
                        <xsl:value-of select="@gruppen_ID"/>
                    </h2>

                    <table>
                        <xsl:for-each select="mitglied" xml:space="preserve">                  
                           <tr>                               
                               <td>
                                   <xsl:value-of select="id(@teilnehmer-ID)/@vorname"/>                                
                                   <xsl:value-of select="id(@teilnehmer-ID)/@nachname"/>   
                                   <xsl:value-of select="id(@teilnehmer-ID)/@nachname"/> 
                               </td>
                               
                               <td> 
                                   <a href="#{@teilnehmer-ID}"><xsl:value-of select="@teilnehmer-ID"/> </a>                                   
                               </td>                               
                           </tr>                         
                       </xsl:for-each>
                    </table>
                </xsl:for-each>
                
                <!-- Scorecards -->

                <h1>Scorecards</h1>

                <xsl:for-each select="archery_db/turnier/gruppe/mitglied" xml:space="preserve">                   
                  <hr/> 
                                      
                   <h2 id="{@teilnehmer-ID}"> <xsl:value-of select="id(@teilnehmer-ID)/@vorname"/> <xsl:value-of select="id(@teilnehmer-ID)/@nachname"/> <xsl:value-of select="@teilnehmer-ID"/> </h2>
                   
                   <table cellspacing="1" bgcolor="#000000" cellpadding="10" border="5">
                       
                       <tr bgcolor="#ffffff">                
                           <th>Round</th>
                           <th>Target</th>
                           <th>Score</th>
                       </tr>
                      
                      <xsl:for-each select="punktestand">
                          
                          <tr bgcolor="#ffffff">                              
                              <td> <xsl:value-of select="../../@runde-ID"/> </td>
                              <td> <xsl:value-of select="@scheibe-ID"/> </td>
                              <td> <xsl:value-of select="@punkte"/> </td>                           
                          </tr>                        
                          
                       </xsl:for-each>                     
                       
                   </table>                   
               </xsl:for-each>

            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>
