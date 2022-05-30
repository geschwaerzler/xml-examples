<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    
    <xsl:template match="/">
        <html>
            <body>
                <h1>World Outdoor Flint Archery Mail Match </h1>
                <h2>Inhaltsverzeichnis</h2>
                
                
                <th> <a href="#gruppe1">Group 1 - 15.05.2022</a> </th>
                
                <p> <a href="#gruppe2">Group 2 - 15.05.2022</a> </p>
                
                <p> <a href="#gruppe3">Group 3 - 16.05.2022</a> </p>
                
                <a href="#gruppe4">Group 4 - 16.05.2022</a>
                
                <h2>Gruppen</h2>
                
                <xsl:apply-templates select="bow-tournament/group"/>
                
 
                    <xsl:variable name="archer" select="id(@archer-id)"/>
                    <h3>1-st Day scoring</h3>
                    <table border="1"  cellpadding="5">	  
                        <tr>
                            <th>Archer</th>
                            <th>Score</th>
                        </tr>	
                        <xsl:for-each select="bow-tournament/archer[@id='a1' or @id='a2' or @id='a3' or @id='a4' or @id='a5' or @id='a6' or @id='a7' or @id='a8']">		  
                            <tr>
                                <td><xsl:value-of select="firstname"/></td>
                                <td><xsl:value-of select="sum(//bow-tournament/group/member[@archer-id=current()/@id]/score[@target-id]/arrow/@points)"/></td>	
                                
                            </tr>	  
                        </xsl:for-each> 
                    </table>
                
                
                <h3>2-nd Day scoring</h3>
                <table border="1"  cellpadding="5">	  
                    <tr>
                        <th>Archer</th>
                        <th>Score</th>
                    </tr>	
                    <xsl:for-each select="bow-tournament/archer[@id='a9' or @id='a10' or @id='a11' or @id='a12' or @id='a13' or @id='a14' or @id='a15' or @id='a16']">		  
                        <tr>
                            <td><xsl:value-of select="firstname"/></td>
                            <td><xsl:value-of select="sum(//bow-tournament/group/member[@archer-id=current()/@id]/score[@target-id]/arrow/@points)"/></td>		      			      
                        </tr>	  
                    </xsl:for-each> 
                </table>
                
                <h2>Scorecards</h2>
                
                <xsl:for-each select="bow-tournament/archer">
                    
                    <h3><xsl:value-of select="firstname"/></h3>
                    
                    <table border="1"  cellpadding="5">	  
                        <tr>
                            <th>Target #</th>
                            <th>Arrow 1</th>
                            <th>Arrow 2</th>
                            <th>Arrow 3</th>
                        </tr>	
                        
                        <tr>
                            <th>Target 1</th>
                            
                            <td><xsl:value-of select="//bow-tournament/group/member[@archer-id=current()/@id]/score[@target-id = 't1']/arrow[@pID='p1']/@points"/></td>	
                            <td><xsl:value-of select="//bow-tournament/group/member[@archer-id=current()/@id]/score[@target-id = 't1']/arrow[@pID='p2']/@points"/></td>
                            <td><xsl:value-of select="//bow-tournament/group/member[@archer-id=current()/@id]/score[@target-id = 't1']/arrow[@pID='p3']/@points"/></td>
                        </tr>
                        
                        <tr>
                            <th>Target 2</th>
                            
                            <td><xsl:value-of select="//bow-tournament/group/member[@archer-id=current()/@id]/score[@target-id = 't2']/arrow[@pID='p1']/@points"/></td>	
                            <td><xsl:value-of select="//bow-tournament/group/member[@archer-id=current()/@id]/score[@target-id = 't2']/arrow[@pID='p2']/@points"/></td>
                            <td><xsl:value-of select="//bow-tournament/group/member[@archer-id=current()/@id]/score[@target-id = 't2']/arrow[@pID='p3']/@points"/></td>
                        </tr>
                        
                        <tr>
                            <th>Target 3</th>
                            
                            <td><xsl:value-of select="//bow-tournament/group/member[@archer-id=current()/@id]/score[@target-id = 't3']/arrow[@pID='p1']/@points"/></td>	
                            <td><xsl:value-of select="//bow-tournament/group/member[@archer-id=current()/@id]/score[@target-id = 't3']/arrow[@pID='p2']/@points"/></td>
                            <td><xsl:value-of select="//bow-tournament/group/member[@archer-id=current()/@id]/score[@target-id = 't3']/arrow[@pID='p3']/@points"/></td>
                        </tr>
                        
                        
                    </table>
                    
                </xsl:for-each> 
                
            </body>
        </html>
    </xsl:template>
    
    
    <xsl:template match="group">
        <h3 id=""><xsl:value-of select="@tag"/></h3>  
        <h3 id=""><xsl:value-of select="@name"/></h3>  
        
        <table border="1" cellpadding="5">	  
            <tr>
                <th>Archer</th>
                
                <xsl:for-each select="member[1]/score">
                    <th>Target <xsl:value-of select="@target-id"/></th>
                </xsl:for-each>
                <th>Score Summe</th>
            </tr>
            <xsl:for-each select="member">
                <xsl:variable name="archer" select="id(@archer-id)"/>
                <tr>
                    <td><xsl:value-of select="$archer/firstname"/></td>
                    
                    <xsl:for-each select="score">
                        <td><xsl:value-of select="sum(arrow/@points)"/></td>
                    </xsl:for-each>
                    <td><xsl:value-of select="sum(score/arrow/@points)"/></td>
                </tr>	  
            </xsl:for-each> 
        </table>
        
    </xsl:template>
    
    
</xsl:stylesheet>