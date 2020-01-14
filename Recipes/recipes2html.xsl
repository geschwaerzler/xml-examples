<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.w3.org/1999/xhtml"
    version="2.0">
    
    <xsl:output method="html"/>
    
    <xsl:decimal-format name="austrian" decimal-separator="," grouping-separator="."/>
    
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
                
                <!-- Details zu den Rezepten -->
                <xsl:apply-templates select="collection/recipe" mode="detail"/>
                
                <h2>Index of Ingredients</h2>
                <ul>
                    <xsl:for-each select="//ingredient">
                        <xsl:sort select="upper-case(@name)"/>
                        <li xml:space="preserve">
                            <xsl:value-of select="@name"/><xsl:if test="@amount or @unit">, 
                                <xsl:value-of select="@amount"/>
                                <xsl:value-of select="@unit"/>
                            </xsl:if>
                        </li>
                    </xsl:for-each>                    
                </ul>
                
            </body>
        </html>
    </xsl:template>
    
    <xsl:template match="recipe" mode="toc">
        <li><a href="#{generate-id()}"><xsl:value-of select="title"/></a></li>
    </xsl:template>
    
    <xsl:template match="recipe" mode="detail">
        <h2 id="{generate-id()}"><xsl:value-of select="title"/></h2>
        
        <h3>Author</h3>
        <!-- Zugtiff per XPath mit Hilfe einer Vriablen-->
        <xsl:variable name="a-id" select="@author-id"/>
        <div xml:space="preserve">
            Author:
            <xsl:value-of select="//author[@id = $a-id]/@title"/>
            <xsl:value-of select="//author[@id = $a-id]"/>
        </div>
        
        <!-- Zugriff per id() Funktion -->
        <div xml:space="preserve">
            Author:
            <xsl:value-of select="id(@author-id)/@title"/>
            <xsl:value-of select="id(@author-id)"/>
        </div>
        
        <!-- und nun etwas eleganter per template -->
        <xsl:apply-templates select="id(@author-id)"/>
        
        <h3>Nutrition</h3>
        <dl>
            <dt>calories</dt>
            <dd>
                <xsl:value-of select="format-number(nutrition/@calories, '#.##0', 'austrian')"/>
            </dd>
            <dt>fat</dt><dd><xsl:value-of select="nutrition/@fat"/></dd>
            <dt>carbohydrates</dt><dd><xsl:value-of select="nutrition/@carbohydrates"/></dd>
            <dt>protein</dt><dd><xsl:value-of select="nutrition/@protein"/></dd>
            <dt>alcohol</dt><dd><xsl:value-of select="nutrition/@alcohol"/></dd>
        </dl>
        
        <img src="{image}"></img>
        
        <h3>Preparation</h3>
        <ol>
            <xsl:for-each select="preparation/step">
                <li><xsl:value-of select="."/></li>
            </xsl:for-each>
        </ol>
    </xsl:template>
    
    <xsl:template match="author" xml:space="preserve">
        <div>
            Author:
            <xsl:value-of select="@title"/>
            <xsl:value-of select="."/>
        </div>
    </xsl:template>
    
</xsl:stylesheet>