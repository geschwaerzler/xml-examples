<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    <xsl:template match="/fbdb">
        <html>
            <head>
                <title>FC Wolfurt</title>
            </head>
            <body>
                <h1>Teams</h1>
                  <xsl:apply-templates select="team" mode="team"></xsl:apply-templates>
                <h2>Players:</h2>
                 <xsl:apply-templates select ="team" mode="players"></xsl:apply-templates>
            </body>
        </html>
    </xsl:template>
    
    <xsl:template match="team" mode="team">
        <h1><xsl:value-of select="@team-name"/></h1>
        <p>Trainer:
            <!-- Wie funktioniert das?: Das programm erkennt wenn I uf person Tag zugriffa tuan,
                deshalb griftt er o uf des untere Template, wo erstellt hond zua und 
                woas i die "person" darstellen, mode isch dafür do falls i mehrere templates hab zu differenzieren -->
            <xsl:apply-templates select="id(employee/@person-id)" mode="trainer"/>
        </p>
        <h2>Spieler:</h2>
        <ol>
            <xsl:for-each select="player">
                <li>
                   <!--Des funkt o  <xsl:value-of select="id(@person-id)/@fname"/> -->
                    <!--  <xsl:value-of select="@person-id"/> -->
                    <a href="#{generate-id(.)}"><xsl:apply-templates select="id(@person-id)" mode="player"/></a>
                </li>
            </xsl:for-each>
        </ol>
    </xsl:template>
    
   
    <xsl:template match="team" mode="players"> <!-- Wieso brauche ich dieses Tag? -->
    <xsl:for-each select="player">
        <h3>
            <p id="{generate-id(.)}">
                <xsl:value-of select="id(@person-id)/@fname"/>
            </p>
        </h3>
        <xsl:for-each select="assessment">
           <li>
               <xsl:value-of select="@score"/>&#160;
                <xsl:value-of select="id(@category_id)/@category_description"/>
           </li>  
        </xsl:for-each>    
            

    </xsl:for-each>
    </xsl:template>
    
    <xsl:template match="person" mode="trainer">
        <p>
        <xsl:value-of select="@fname"/>&#160;
        <xsl:value-of select="@lname"/>
        </p>
    </xsl:template>
    <xsl:template match="person" mode="player">
        <p>
            <xsl:value-of select="@fname"/>&#160;
            <xsl:value-of select="@lname"/>
        </p>
    </xsl:template>
    
</xsl:stylesheet>