<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.w3.org/1999/xhtml"
    version="2.0">
    
    <xsl:output method="html"/>
    
    <xsl:template match="/">
        <html>
            <head>
                <title><xsl:value-of select="collection/description"/></title>
            </head>
            <body>
                <h1><xsl:value-of select="collection/description"/></h1>
                
                <div>This is a collection of
                    <xsl:if test="count(collection/recipe) = 1">
                        one recipe.
                    </xsl:if>
                    <xsl:if test="count(collection/recipe) > 1">
                        <xsl:value-of select="count(collection/recipe)"/>
                        recipes.
                    </xsl:if>
                </div>
                
                <h2>Table of Contents</h2>
                <ol>
                    <xsl:for-each select="collection/recipe">
                        <li><xsl:value-of select="title"/></li>
                    </xsl:for-each>
                </ol>
                
                <h2>Table of Contents - with subtemplates</h2>
                <ol>
                    <xsl:apply-templates select="collection/recipe" mode="toc"/>
                </ol>
                
                <xsl:apply-templates select="collection/recipe" mode="detail"/>
            </body>
        </html>
    </xsl:template>
    
    <xsl:template match="recipe" mode="toc">
        <li><a href="#{generate-id()}"><xsl:value-of select="title"/></a></li>
    </xsl:template>
    
    <xsl:template match="recipe" mode="detail">
        <h2 id="{generate-id()}"><xsl:value-of select="title"/></h2>
        <img src="{image}"></img>
        
        <h3>Preparation</h3>
        <ol>
            <xsl:for-each select="preparation/step">
                <li><xsl:value-of select="."/></li>
            </xsl:for-each>
        </ol>
    </xsl:template>
    
</xsl:stylesheet>