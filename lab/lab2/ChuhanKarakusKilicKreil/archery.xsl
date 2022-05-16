<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:template match="/">
	  <html>
		  <body>
		  <h1>World Outdoor Flint Archery Mail Match </h1>
		  <h2>Inhaltsverzeichnis</h2>
		  
		  	
		  <th> <a href="gruppe1">Group 1 - 20.12.2019</a> </th>
		  
		  <p> <a href="gruppe2">Group 2 - 20.12.2019</a> </p>
		  
		  <p> <a href="gruppe3">Group 3 - 21.12.2019</a> </p>
		  
		  <a href="gruppe4">Group 4 - 21.12.2019</a>  
		  	
		  <h2> 1-st Day, 20.12.2019</h2> 
		  <h3 id="gruppe1">Gruppe 1</h3>
	  
		  <table border="1" cellpadding="5">	  
			  <tr>
			      <th>Archer</th>
			      <th>Score</th>
			  </tr>			  
			  <xsl:for-each select="bow-tournament/archer[@id='a1' or @id='a2' or @id='a3' or @id='a4']">		  
			  <tr>
			      <td><xsl:value-of select="firstname"/></td>
			      <td><xsl:value-of select="//bow-tournament/group[@name='Gruppe Recurve Outdoor']/member[@archer-id=current()/@id]/score[@target-id='t1']/arrow/@points"/></td>			      			      
    		  </tr>	  
    		  </xsl:for-each> 
		  </table>
		  
		  <h3 id="gruppe2">Gruppe 2</h3>	  
		  <table border="1" cellpadding="5">	  
		  	<tr>
			      <th>Archer</th>
			      <th>Score</th>
			</tr>	
			<xsl:for-each select="bow-tournament/archer[@id='a5' or @id='a6' or @id='a7' or @id='a8']">		  
			  <tr>
			      <td><xsl:value-of select="firstname"/></td>
			      <td><xsl:value-of select="//bow-tournament/group[@name='Gruppe Barebow Division']/member[@archer-id=current()/@id]/score[@target-id='t1']/arrow/@points"/></td>
			      		      			      
    		  </tr>	  
    		  </xsl:for-each> 
		  </table>
		  
		  <h3>1-st Day scoring</h3>
		  <table border="1"  cellpadding="5">	  
		  	<tr>
			      <th>Archer</th>
			      <th>Score</th>
			</tr>	
			<xsl:for-each select="bow-tournament/archer[@id='a1' or @id='a2' or @id='a3' or @id='a4' or @id='a5' or @id='a6' or @id='a7' or @id='a8']">		  
			  <tr>
			      <td><xsl:value-of select="firstname"/></td>
			      <td><xsl:value-of select="//bow-tournament/group[@name='Gruppe Recurve Outdoor']/member[@archer-id=current()/@id]/score[@target-id='t1']/arrow/@points"/><xsl:value-of select="//bow-tournament/group[@name='Gruppe Barebow Division']/member[@archer-id=current()/@id]/score[@target-id='t1']/arrow/@points"/></td>
				      			      
    		  </tr>	  
    		  </xsl:for-each> 
		  </table>
	  
		  <h2> 2-nd Day, 21.12.2019 </h2>
		  <h3 id="gruppe3">Gruppe 3</h3>
		  
		  <table border="1" cellpadding="5">	  
		  	<tr>
			      <th>Archer</th>
			      <th>Score</th>
			</tr>	
			<xsl:for-each select="bow-tournament/archer[@id='a9' or @id='a10' or @id='a11' or @id='a12']">		  
			  <tr>
			      <td><xsl:value-of select="firstname"/></td>
			      <td><xsl:value-of select="//bow-tournament/group[@name='Gruppe Barebow Division']/member[@archer-id=current()/@id]/score[@target-id='t1']/arrow/@points"/></td>		      			      
    		  </tr>	  
    		  </xsl:for-each> 
		  </table>
		  
		  <h3 id="gruppe4">Gruppe 4</h3>	  
		  <table border="1" cellpadding="5">	  
		  <tr>
			      <th>Archer</th>
			      <th>Score</th>
			  </tr>	
			  
			  <xsl:for-each select="bow-tournament/archer[@id='a13' or @id='a14' or @id='a15' or @id='a16']">
			  
			  <tr>
			      <td><xsl:value-of select="firstname"/></td>
			      <td><xsl:value-of select="//bow-tournament/group[@name='Gruppe Bowhunter Fingers Division']/member[@archer-id=current()/@id]/score[@target-id='t1']/arrow/@points"/></td>
			      			      
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
			      <td><xsl:value-of select="//bow-tournament/group[@name='Gruppe Barebow Division']/member[@archer-id=current()/@id]/score[@target-id='t1']/arrow/@points"/><xsl:value-of select="//bow-tournament/group[@name='Gruppe Bowhunter Fingers Division']/member[@archer-id=current()/@id]/score[@target-id='t1']/arrow/@points"/></td>		      			      
    		  </tr>	  
    		  </xsl:for-each> 
		  </table>
		  
		  <h2>Scorecards</h2>
		  <xsl:for-each select="bow-tournament/archer[@id='a1' or @id='a2' or @id='a2' or @id='a4']">
		  <h3><xsl:value-of select="firstname"/> - Gruppe 1 20.12.2019</h3>
		  <table border="1"  cellpadding="5">	  
		  	<tr>
			      <th>Target #</th>
			      <th>Arrow 1</th>
			      <th>Arrow 2</th>
			      <th>Arrow 3</th>
			</tr>	
			
			<tr>
			      <th>Target 1</th>
			      
			      <th><xsl:value-of select="//bow-tournament/group[@name='Gruppe Recurve Outdoor']/member[@archer-id=current()/@id]/score[@target-id='t1']/arrow/@points"/></th>
			      <th><xsl:value-of select="//bow-tournament/group[@name='Gruppe Recurve Outdoor']/member[@archer-id=current()/@id]/score[@target-id='t1']/arrow[@pID='p2']/@points"/></th>
			      <th><xsl:value-of select="//bow-tournament/group[@name='Gruppe Recurve Outdoor']/member[@archer-id=current()/@id]/score[@target-id='t1']/arrow[@pID='p3']/@points"/></th>
			</tr>
			
			<tr>
			      <th>Target 2</th>
			      
			     <th><xsl:value-of select="//bow-tournament/group[@name='Gruppe Recurve Outdoor']/member[@archer-id=current()/@id]/score[@target-id='t2']/arrow/@points"/></th>
			      <th><xsl:value-of select="//bow-tournament/group[@name='Gruppe Recurve Outdoor']/member[@archer-id=current()/@id]/score[@target-id='t2']/arrow[@pID='p2']/@points"/></th>
			      <th><xsl:value-of select="//bow-tournament/group[@name='Gruppe Recurve Outdoor']/member[@archer-id=current()/@id]/score[@target-id='t2']/arrow[@pID='p3']/@points"/></th>
			</tr>
			
			<tr>
			      <th>Target 3</th>
			      
			      <th><xsl:value-of select="//bow-tournament/group[@name='Gruppe Recurve Outdoor']/member[@archer-id=current()/@id]/score[@target-id='t3']/arrow/@points"/></th>
			      <th><xsl:value-of select="//bow-tournament/group[@name='Gruppe Recurve Outdoor']/member[@archer-id=current()/@id]/score[@target-id='t3']/arrow[@pID='p2']/@points"/></th>
			      <th><xsl:value-of select="//bow-tournament/group[@name='Gruppe Recurve Outdoor']/member[@archer-id=current()/@id]/score[@target-id='t3']/arrow[@pID='p3']/@points"/></th>
			</tr>
			
    		  
		  </table>
		  
		  </xsl:for-each>
		  
		  <xsl:for-each select="bow-tournament/archer[@id='a5' or @id='a6' or @id='a7' or @id='a8']">
		  <h3><xsl:value-of select="firstname"/> - Gruppe 2 20.12.2019</h3>
		  <table border="1"  cellpadding="5">	  
		  	<tr>
			      <th>Target #</th>
			      <th>Arrow 1</th>
			      <th>Arrow 2</th>
			      <th>Arrow 3</th>
			</tr>	
			
			<tr>
			      <th>Target 1</th>
			      
			      <th><xsl:value-of select="//bow-tournament/group[@name='Gruppe Barebow Division']/member[@archer-id=current()/@id]/score[@target-id='t1']/arrow/@points"/></th>
			      <th><xsl:value-of select="//bow-tournament/group[@name='Gruppe Barebow Division']/member[@archer-id=current()/@id]/score[@target-id='t1']/arrow[@pID='p2']/@points"/></th>
			      <th><xsl:value-of select="//bow-tournament/group[@name='Gruppe Barebow Division']/member[@archer-id=current()/@id]/score[@target-id='t1']/arrow[@pID='p3']/@points"/></th>
			</tr>
			
			<tr>
			      <th>Target 2</th>
			      
			     <th><xsl:value-of select="//bow-tournament/group[@name='Gruppe Barebow Division']/member[@archer-id=current()/@id]/score[@target-id='t2']/arrow/@points"/></th>
			      <th><xsl:value-of select="//bow-tournament/group[@name='Gruppe Barebow Division']/member[@archer-id=current()/@id]/score[@target-id='t2']/arrow[@pID='p2']/@points"/></th>
			      <th><xsl:value-of select="//bow-tournament/group[@name='Gruppe Barebow Division']/member[@archer-id=current()/@id]/score[@target-id='t2']/arrow[@pID='p3']/@points"/></th>
			</tr>
			
			<tr>
			      <th>Target 3</th>
			      
			      <th><xsl:value-of select="//bow-tournament/group[@name='Gruppe Barebow Division']/member[@archer-id=current()/@id]/score[@target-id='t3']/arrow/@points"/></th>
			      <th><xsl:value-of select="//bow-tournament/group[@name='Gruppe Barebow Division']/member[@archer-id=current()/@id]/score[@target-id='t3']/arrow[@pID='p2']/@points"/></th>
			      <th><xsl:value-of select="//bow-tournament/group[@name='Gruppe Barebow Division']/member[@archer-id=current()/@id]/score[@target-id='t3']/arrow[@pID='p3']/@points"/></th>
			</tr>
			
    		  
		  </table>
		  
		  </xsl:for-each>
		  
		  <xsl:for-each select="bow-tournament/archer[@id='a9' or @id='a10' or @id='a11' or @id='a12']">
		  <h3><xsl:value-of select="firstname"/> - Gruppe 3 21.12.2019</h3>
		  <table border="1"  cellpadding="5">	  
		  	<tr>
			      <th>Target #</th>
			      <th>Arrow 1</th>
			      <th>Arrow 2</th>
			      <th>Arrow 3</th>
			</tr>	
			
			<tr>
			      <th>Target 1</th>
			      
			      <th><xsl:value-of select="//bow-tournament/group[@name='Gruppe Barebow Division']/member[@archer-id=current()/@id]/score[@target-id='t1']/arrow/@points"/></th>
			      <th><xsl:value-of select="//bow-tournament/group[@name='Gruppe Barebow Division']/member[@archer-id=current()/@id]/score[@target-id='t1']/arrow[@pID='p2']/@points"/></th>
			      <th><xsl:value-of select="//bow-tournament/group[@name='Gruppe Barebow Division']/member[@archer-id=current()/@id]/score[@target-id='t1']/arrow[@pID='p3']/@points"/></th>
			</tr>
			
			<tr>
			      <th>Target 2</th>
			      
			      <th><xsl:value-of select="//bow-tournament/group[@name='Gruppe Barebow Division']/member[@archer-id=current()/@id]/score[@target-id='t2']/arrow/@points"/></th>
			      <th><xsl:value-of select="//bow-tournament/group[@name='Gruppe Barebow Division']/member[@archer-id=current()/@id]/score[@target-id='t2']/arrow[@pID='p2']/@points"/></th>
			      <th><xsl:value-of select="//bow-tournament/group[@name='Gruppe Barebow Division']/member[@archer-id=current()/@id]/score[@target-id='t2']/arrow[@pID='p3']/@points"/></th>
			</tr>
			
			<tr>
			      <th>Target 3</th>
			      
			      <th><xsl:value-of select="//bow-tournament/group[@name='Gruppe Barebow Division']/member[@archer-id=current()/@id]/score[@target-id='t3']/arrow/@points"/></th>
			      <th><xsl:value-of select="//bow-tournament/group[@name='Gruppe Barebow Division']/member[@archer-id=current()/@id]/score[@target-id='t3']/arrow[@pID='p2']/@points"/></th>
			      <th><xsl:value-of select="//bow-tournament/group[@name='Gruppe Barebow Division']/member[@archer-id=current()/@id]/score[@target-id='t3']/arrow[@pID='p3']/@points"/></th>
			</tr>
			
    		  
		  </table>
		  
		  </xsl:for-each>
		  
		  <xsl:for-each select="bow-tournament/archer[@id='a13' or @id='a14' or @id='a15' or @id='a16']">
		  <h3><xsl:value-of select="firstname"/> - Gruppe 4 21.12.2019</h3>
		  <table border="1"  cellpadding="5">	  
		  	<tr>
			      <th>Target #</th>
			      <th>Arrow 1</th>
			      <th>Arrow 2</th>
			      <th>Arrow 3</th>
			</tr>	
			
			<tr>
			      <th>Target 1</th>
			      
			      <th><xsl:value-of select="//bow-tournament/group[@name='Gruppe Bowhunter Fingers Division']/member[@archer-id=current()/@id]/score[@target-id='t1']/arrow/@points"/></th>
			      <th><xsl:value-of select="//bow-tournament/group[@name='Gruppe Bowhunter Fingers Division']/member[@archer-id=current()/@id]/score[@target-id='t1']/arrow[@pID='p2']/@points"/></th>
			      <th><xsl:value-of select="//bow-tournament/group[@name='Gruppe Bowhunter Fingers Division']/member[@archer-id=current()/@id]/score[@target-id='t1']/arrow[@pID='p3']/@points"/></th>
			</tr>
			
			<tr>
			      <th>Target 2</th>
			      
			     <th><xsl:value-of select="//bow-tournament/group[@name='Gruppe Bowhunter Fingers Division']/member[@archer-id=current()/@id]/score[@target-id='t2']/arrow/@points"/></th>
			      <th><xsl:value-of select="//bow-tournament/group[@name='Gruppe Bowhunter Fingers Division']/member[@archer-id=current()/@id]/score[@target-id='t2']/arrow[@pID='p2']/@points"/></th>
			      <th><xsl:value-of select="//bow-tournament/group[@name='Gruppe Bowhunter Fingers Division']/member[@archer-id=current()/@id]/score[@target-id='t2']/arrow[@pID='p3']/@points"/></th>
			</tr>
			
			<tr>
			      <th>Target 3</th>
			      
			      <th><xsl:value-of select="//bow-tournament/group[@name='Gruppe Bowhunter Fingers Division']/member[@archer-id=current()/@id]/score[@target-id='t3']/arrow/@points"/></th>
			      <th><xsl:value-of select="//bow-tournament/group[@name='Gruppe Bowhunter Fingers Division']/member[@archer-id=current()/@id]/score[@target-id='t3']/arrow[@pID='p2']/@points"/></th>
			      <th><xsl:value-of select="//bow-tournament/group[@name='Gruppe Bowhunter Fingers Division']/member[@archer-id=current()/@id]/score[@target-id='t3']/arrow[@pID='p3']/@points"/></th>
			</tr>
			
    		  
		  </table>
		  
		  </xsl:for-each>
		  
		  		  		 
		  </body>
	  </html>
</xsl:template>
</xsl:stylesheet>