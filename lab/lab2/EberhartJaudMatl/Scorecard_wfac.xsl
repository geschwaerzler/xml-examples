<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.w3.org/2001/XMLSchema" version="2.0">
    <xsl:output method="html"/>
    
    <xsl:template match="/">
    
        <html>
            <head>
                <title>Scorecard - WFAC</title>
                <link rel="stylesheet" href="style.css" />
                <!-- <style>
                    table {
                        border: 1px solid black;
                        border-collapse: collapse;
                    }
                    th {
                        border: 1px solid black;
                        border-collapse: collapse;
                        text-align: center;
                    }
                    td {
                        border: 1px solid black;
                        border-collapse: collapse;
                        text-align: center;
                    }
                </style> -->
            </head>
            <body>
                <div class="container">
                <h1 class="title">Scorecard - WFAC</h1>
                <h1>Groups</h1>
                <xsl:for-each select="wfac/group">
                    <h3><xsl:value-of select="@group-id"/> am <xsl:value-of select="@date"/></h3>

                    <table border="1px solid black">
                        <tr>
                            <th>Function</th>
                            <th>Name</th>
                            <th>Scorecard</th>
                        </tr>
                        <xsl:for-each select="participant" xml:space="preserve">
                            <xsl:variable name="p" select="id(@registration-id)"/>
                            <tr>
                                <td><xsl:value-of select="@role"/></td>
                                <td><xsl:value-of select="$p/@fname"/> <xsl:value-of select="$p/@lname"/></td>
                                <td><a href="#{scorecard/@scorecard-id}"><xsl:value-of select="scorecard/@scorecard-id"/></a></td>
                            </tr>
                        </xsl:for-each>
                        
                        
                    </table>
                </xsl:for-each>
                
                <h1>Scorecards</h1>
                <xsl:for-each select="wfac/group/participant" xml:space="preserve">
                        <xsl:variable name="p" select="id(@registration-id)"/>
                        <h3 id="{scorecard/@scorecard-id}">Card_ID: <xsl:value-of select="scorecard/@scorecard-id"></xsl:value-of> - <xsl:value-of select="$p/@fname"/> <xsl:value-of select="$p/@lname"/></h3>
                        
                        <table>
                            <tr>
                                <th>target</th>
                                <th>arrow 1</th>
                                <th>arrow 2</th>
                                <th>arrow 3</th>
                                <th>arrow 4</th>
                            </tr>
                            
                            
                            <tr>
                                <th>target 1</th>
                                <xsl:for-each select="scorecard/scorecard-entry[@target-id = 'target-1']">                                
                                    <td><xsl:value-of select="@score" /></td>
                                </xsl:for-each>
                            </tr>
                            <tr>
                                <th>target 2</th>
                                <xsl:for-each select="scorecard/scorecard-entry[@target-id = 'target-2']">                                
                                    <td><xsl:value-of select="@score" /></td>
                                </xsl:for-each>
                            </tr>
                            <xsl:if test="scorecard/scorecard-entry[@target-id = 'target-3']">    
                                <tr>
                                    <th>target 3</th>
                                <xsl:for-each select="scorecard/scorecard-entry[@target-id = 'target-3']">                               
                                    
                                    <td><xsl:value-of select="@score" /></td>
                                </xsl:for-each>
                            </tr>
                            </xsl:if>
                            
                            
                        </table>
                    
                </xsl:for-each>
                </div>
            </body>
            
        </html>

    </xsl:template>
    

</xsl:stylesheet>