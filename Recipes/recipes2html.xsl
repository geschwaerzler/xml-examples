<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="2.0">
    
    <xsl:output encoding="UTF-8" method="html"/>
    
    <xsl:decimal-format name="austria" decimal-separator="," grouping-separator="."/>
    
    <xsl:template match="/collection">
        <html>
            <head>
                <title><xsl:value-of select="description"/></title>
            </head>
            <body>
                <h1><xsl:value-of select="description"/></h1>
                
                <h2>Table of Contents</h2>
                <ol>
                    <!-- iterative solution:
                    <xsl:for-each select="recipe">
                        <li><xsl:value-of select="title"/></li>
                    </xsl:for-each>
                    -->
                    <xsl:apply-templates select="recipe" mode="table-of-contents"/>
                    
                </ol>
                
                <xsl:apply-templates select="recipe" mode="detail"/>
                
                <h2>Index of Ingredients</h2>
                <ul>
                    <xsl:for-each-group select="//ingredient" group-by="lower-case(@name)">
                        <xsl:sort select="current-grouping-key()"/>
                        <li xml:space="preserve">
                            <xsl:value-of select="@name"/>
                            <xsl:value-of select="@unit"/>
                            <i>used in recipes</i>:
                            <ul>
                                <xsl:for-each select="current-group()">
                                    <li>
                                        <xsl:value-of select="ancestor::recipe/title"/>
                                    </li>
                                </xsl:for-each>
                            </ul>
                        </li>
                    </xsl:for-each-group>
                    <!--
                    <xsl:for-each select="//ingredient">
                        <xsl:sort select="lower-case(@name)"/>
                        <li><xsl:value-of select="@name"/></li>
                    </xsl:for-each>
                    -->
                </ul>
                
            </body>
        </html>
    </xsl:template>
    
    <xsl:template match="recipe" mode="table-of-contents">
        <li><a href="#{generate-id(.)}"><xsl:value-of select="title"/></a></li>
    </xsl:template>
    
    <xsl:template match="recipe" mode="detail">
        <h2 id="{generate-id(.)}"><xsl:value-of select="title"/></h2>
        <xsl:if test="@author-id" xml:space="preserve">
            <xsl:value-of select="id(@author-id)/@title"/>
            <xsl:value-of select="id(@author-id)/text()"/>
        </xsl:if>
        <h3>Nutrition</h3>
        <p>Calories: <xsl:value-of select="format-number(nutrition/@calories, '#.##0', 'austria')"/></p>
        <h3>Ingredients</h3>
        <ul>
            <xsl:for-each select="ingredient">
                <li>
                    <xsl:if test="not (@unit)" xml:space="preserve">
                        <xsl:call-template name="readable-number">
                            <xsl:with-param name="nr" select="@amount"/>
                        </xsl:call-template>
                    </xsl:if>
                    <xsl:value-of select="@name"/>
                    <xsl:if test="@unit" xml:space="preserve">,
                        <xsl:call-template name="readable-number">
                            <xsl:with-param name="nr" select="@amount"/>
                        </xsl:call-template>
                        <xsl:value-of select="@unit"/>
                    </xsl:if>
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
    
    <xsl:template name="readable-number">
        <xsl:param name="nr"/>
        <xsl:choose>
            <xsl:when test="$nr = 0.25">¼</xsl:when>
            <xsl:when test="$nr = 0.5">½</xsl:when>
            <xsl:when test="$nr = 0.75">¾</xsl:when>
            <xsl:when test="$nr = 1">one</xsl:when>
            <xsl:when test="$nr = 1.5">1½</xsl:when>
            <xsl:when test="$nr = 2">two</xsl:when>
            <xsl:when test="$nr = 3">three</xsl:when>
            <xsl:when test="$nr = 4">four</xsl:when>
            <xsl:otherwise><xsl:value-of select="$nr"/></xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
</xsl:stylesheet>