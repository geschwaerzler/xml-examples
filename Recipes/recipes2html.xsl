<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="2.0">
    
    <xsl:template match="/">
        <html>
            <head>
                <title><xsl:value-of select="collection/description"/></title>
            </head>
            <body>
                <h1><xsl:value-of select="collection/description"/></h1>
                
                <h2>Table of Contents</h2>
                <ol>
                    <!-- iterative solution:
                    <xsl:for-each select="collection/recipe">
                        <li><xsl:value-of select="title"/></li>
                    </xsl:for-each>
                    -->
                    <xsl:apply-templates select="collection/recipe" mode="table-of-contents"/>
                </ol>
                
                <xsl:apply-templates select="collection/recipe" mode="detail"/>
                
            </body>
        </html>
    </xsl:template>
    
    <xsl:template match="recipe" mode="table-of-contents">
        <li><xsl:value-of select="title"/></li>
    </xsl:template>
    
    <xsl:template match="recipe" mode="detail">
        <h2><xsl:value-of select="title"/></h2>
        <h3>Ingredients</h3>
        <ul>
            <xsl:for-each select="ingredient">
                <li xml:space="preserve">
                    <xsl:value-of select="@name"/>,
                    <xsl:value-of select="@amount"/> <xsl:value-of select="@unit"/>
                </li>
            </xsl:for-each>
        </ul>
        
        <h3>Preparation</h3>
        <ol>
            <xsl:for-each select="preparation/step">
                <li><xsl:value-of select="text()"/></li>                
            </xsl:for-each>
        </ol>
    </xsl:template>
    
</xsl:stylesheet>