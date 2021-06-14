<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
    <xsl:template match="/">
        <html>
            <head>
                <title>
                    <xsl:value-of select="tournament/@title"/>
                </title>
                <body>
                    <h1>OVERVIEW</h1>
                    <h2>Attendees by Classfication</h2>
                    <xsl:apply-templates select="tournament"/>
                    <xsl:apply-templates select="tournament/tournamentday"/>
                    
                </body>
            </head>
        </html>
    </xsl:template>
    <xsl:template match="tournament">
        <xsl:for-each-group select="person" group-by="@classification">
            <xsl:sort select="@classification" data-type="text" order="descending"/>
            
            <h2>Kategorie: <xsl:value-of select="current-grouping-key()" /></h2><br />
            
            <xsl:for-each select="current-group()">
                <h3><a href="Archery.html#{@personID}">personID: <xsl:value-of select="./@personID" /> <xsl:value-of select="short_country"/> <xsl:value-of select="lastname"/> <xsl:value-of select="firstname"/>(<xsl:value-of select="birthddate" />)</a></h3>
            </xsl:for-each>
        </xsl:for-each-group>
    </xsl:template>
    <xsl:template match="tournament/tournamentday">
        <xsl:for-each select=".">
            <h2>Tag: <xsl:value-of select="@number"/>, am <xsl:value-of select="@date" /></h2>
            <xsl:for-each-group select="shot" group-by="@shooter-id" >
                <xsl:sort select="@station-id" data-type="name"/>
                
                <div id="{@shooter-id}">
                    <h3><xsl:value-of select="current-grouping-key()"/></h3></div>
                <table>
                    <tr>
                        <th>Target#</th>
                        <th>Arrow1</th>
                        <th>Arrow2</th>
                        <th>Arrow3</th>
                        <th>Arrow4</th>
                    </tr>
                    <xsl:for-each-group select="current-group()" group-by="@station-id">
                        <xsl:sort select="@try" data-type="number"/>
                        <tr>
                            <td><xsl:value-of select="@station-id"/></td>
                            <xsl:for-each select="current-group()">
                                <td>    
                                    <xsl:value-of select="score"/>
                                </td>
                            </xsl:for-each>
                        </tr>                            
                    </xsl:for-each-group>
                </table><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>
            </xsl:for-each-group>
        </xsl:for-each>
        
    </xsl:template>
    
    <xsl:template match="*">
    </xsl:template>
</xsl:stylesheet>