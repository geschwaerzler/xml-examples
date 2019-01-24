<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    <xsl:output method="html"/>
    
    <xsl:template match="/szene-open-air">
        <html>
            <head>
                <title>Festival</title>
            </head>
            <body>
                <h1>TABLE OF CONTENTS</h1>
                <ul>                    
                    <li><h3><a href="#Persons">GOTO Persons</a></h3></li>
                    <li><h3><a href="#Festivals">GOTO Festivals</a></h3></li>
                    <li><h3><a href="#Aufgabenliste">GOTO Aufgabenliste</a></h3></li>
                    <li><h3><a href="#Addressen">GOTO Addressen</a></h3></li>
                </ul>
                <ol>     
                    <h2 id="Persons">Persons</h2>
                    <xsl:for-each select="address/person">
                        <xsl:sort select="@fname"/>   
                        <li id="{@person-id}"><xsl:value-of select="@fname"/>, <xsl:value-of select="@lname"/></li>                      
                    </xsl:for-each>
                </ol>
                
                <ul>
                    <h2 id="Festivals">Festivals:</h2>
                    <xsl:for-each select="festival">
                        <li id="{@festival-year}"><p><xsl:value-of select="@festival-year"/></p></li>
                        <table>                            
                          <th>JOB DESCRIPTION</th>
                          <th>PERSON</th>
                          <th>RESSORT</th>
                            <tbody>
                                <xsl:for-each select="helper-festival">
                                    <tr>
                                        <td id="{@job-id}"><xsl:value-of select="id(@job-id)/@description"/></td>
                                        <td><a href="#{(id(@helper-id)/@person-id)}"><xsl:value-of select="id(id(@helper-id)/@person-id)/@fname"/>, <xsl:value-of select="id(id(@helper-id)/@person-id)/@lname"/></a></td>
                                        <td><xsl:value-of select="id(@job-id)/../@description"/></td>
                                    </tr>
                                </xsl:for-each>
                            </tbody>
                        </table>                    
                    </xsl:for-each>
                </ul>
                
                <h2 id="Aufgabenliste">Aufgabenliste:</h2>                
                <table>
                    <th>Person</th>
                    <th>Aufgabe</th>
                    <th>Jahr</th>
                    <tbody>
                        <xsl:for-each select="festival">
                            <xsl:for-each select="helper-festival">
                                <tr>
                                    <th><a href="#{id(@helper-id)/@person-id}"><xsl:value-of select="id(id(@helper-id)/@person-id)/@fname"/></a></th>
                                    <th><a href="#{@job-id}"><xsl:value-of select="id(@job-id)/@description"/></a></th>
                                    <th><a href="#{../@festival-year}"><xsl:value-of select="../@festival-year"/></a></th>
                                </tr>
                            </xsl:for-each>
                        </xsl:for-each>
                    </tbody>
                </table> 
                
                <h2 id="Addressen">Addressen:</h2>
                <table>
                    <th>Adresse</th>
                    <th>Person(s)</th>
                    <tbody>
                        <xsl:for-each select="address">
                            <tr>
                                <td><xsl:value-of select="@street"/></td>
                                <xsl:for-each select="person">
                                <td><a href="#{@person-id}">
                                    <xsl:value-of select="@fname"/>&#160;<xsl:value-of select="@lname"/>                            
                                </a>&#160;&#160;&#160;</td>
                                </xsl:for-each>
                            </tr>
                        </xsl:for-each>
                    </tbody>
                </table>
                
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>