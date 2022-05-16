<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:template match="/">
		<html>
			<head>
				<title><xsl:value-of select="/archery_tournament/@name"/></title>
				<style>
				* {font-family: sans-serif}
				</style>
			</head>
			<body>
				<h1 id ="top" align="center"><xsl:value-of select="/archery_tournament/description"/></h1>
				<br/>
				<br/>
				<h2>Table of Contents</h2>
				<ol>
					<li><a href="#disciplines">Disciplines</a></li>
					<li><a href="#divisions">Divisions</a></li>
					<li><a href="#part.countr">Participating Countries</a></li>
					<li><a href="#groups">Groups</a></li>
					<li><a href="#scorecards">Scorecards</a></li>
				</ol>
				
				<hr/>
								
				<h2><a name="disciplines">Disciplines</a></h2>
				<ul>
					<xsl:for-each select="/archery_tournament/discipline">
						<xsl:sort order="ascending"/>
						<li><xsl:value-of select="."/></li>
        			</xsl:for-each>
        		</ul>
        		
        		<hr/>
        		
         		<h2><a name="divisions">Divisions</a></h2>
        		<ul>
        			<xsl:for-each select="/archery_tournament/division">
        				<xsl:sort order="ascending"/>
        				<li><xsl:value-of select="."/></li>
        			</xsl:for-each>
        		</ul>
        		
        		<hr/>
       				
        		<ul>
        			<xsl:for-each-group select="/archery_tournament/registration/participant/state" group-by=".">
        				<xsl:sort order="ascending"/>
        				<li><xsl:value-of select="."/></li>
        			</xsl:for-each-group>
        		</ul> 
        		
        		<hr/>
        		
        		<h2><a name="groups">Groups</a></h2>
        			<xsl:for-each select="/archery_tournament/group">
        				<xsl:for-each select="subgroup">
        					<h4>Subgroup <xsl:value-of select="position()"/></h4>
       							<xsl:for-each select="member"> 
       								<xsl:sort select="id(@participant-id)/lastname" order="ascending"/>		
       									<p xml:space="preserve">
       										<a href="#{@participant-id}">					
	       										<xsl:value-of select="id(@participant-id)/lastname"/>
	       										<xsl:value-of select="id(@participant-id)/firstname"/>
       										</a>
       										<br/>
       									</p>
       							</xsl:for-each>
        					<br/>
        				</xsl:for-each>
        			</xsl:for-each>
        		
        		<hr/>
        		
      	  		<h2><a name="scorecards">Scorecards</a></h2> 	
					<xsl:for-each select="//registration/participant">
						<p xml:space="preserve">
	      	  			<h4><a name="{@id}">Scorecard of </a>
		      	  			 <xsl:value-of select="lastname"/>
		     					<xsl:value-of select="firstname"/>		
		     			   </h4>	
						</p>	
		     			 <xsl:variable name="participant-id" select="@id"/>
		     			 <table border="1" cellpadding="10" border-collapse="collapse">
			     			 <tr >
			     			 	<td></td>
			     			 	<td align="center" bgcolor="#9acd32"><strong>Target 1</strong></td>
			     			 	<td align="center" bgcolor="#9acd32"><strong>Target 2</strong></td>
			     			 	<td align="center" bgcolor="#9acd32"><strong>Target 3</strong></td>
			     			 	<td align="center" bgcolor="#9acd32"><strong>Target 4</strong></td> 
			     			 </tr>
			     			 	<xsl:for-each select="//match">
			     			 		<tr>
			     			 			<td xml:space="preserve" align="center" bgcolor="#AED6F1"><strong>Match <xsl:value-of select="position()"/></strong></td>
				     			 			<xsl:for-each select="target">
				     			 				<td align="center"><xsl:value-of select="score[@participant-id = $participant-id]"/></td>
				     			 			</xsl:for-each>
			     			 		</tr>
			     			 	</xsl:for-each>
		     			 </table>
		     			 <br/>
		     			 <br/>
		     			 <br/>
		     		</xsl:for-each>				
 		
        		<br/>
      			<hr/>
        		<p><a href="#top">back to top</a></p>
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>