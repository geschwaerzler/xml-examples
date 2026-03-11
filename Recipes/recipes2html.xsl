<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="2.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns="http://www.w3.org/1999/xhtml" xmlns:xst="http://www.w3.org/1999/xhtml"
>

    <xsl:template match="/collection">
        <html lang="en">
            <head>
                <title><xsl:value-of select="description"/></title>
            </head>
            <body>
                <h1><xsl:value-of select="description"/></h1>

                <h2>Table of Contents</h2>
                <ol>
                    <xsl:for-each select="recipe">
                        <li><a href="#recipe-{position()}"><xsl:value-of select="title"/></a></li>
                    </xsl:for-each>
                </ol>

                <xsl:apply-templates select="recipe"/>

            </body>
        </html>
    </xsl:template>

    <xsl:template match="recipe">
        <h2 id="recipe-{position()}">
            <xsl:value-of select="position()"/>.
            <xsl:value-of select="title"/>
        </h2>
        <img src="{image}" height="240px"/>

        <h3>Ingredients</h3>
        <ul>
            <xsl:for-each select="ingredient">
                <li>
                    <xsl:value-of select="@name"/>
                </li>
            </xsl:for-each>
        </ul>

        <h3>Preparation</h3>
        <ol>
            <xsl:for-each select="preparation/step">
                <li><xsl:value-of select="."/> </li>
            </xsl:for-each>
        </ol>
    </xsl:template>

</xsl:stylesheet>