<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet
        xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
        version="2.0"
>
    <xsl:template match="/brew-recipes">
        <html>
            <head>
                <title>Lab 2 Brews SS 2026</title>
            </head>
            <body>
                <h1>Lab 2 Brews SS 2026</h1>

                <h2>Table of Contents</h2>
                <xsl:for-each select="brew">
                    <p><xsl:value-of select="@title"/></p>
                </xsl:for-each>

                <xsl:apply-templates select="brew" mode="detail"/>
            </body>
        </html>
    </xsl:template>

    <xsl:template match="brew" mode="detail">
        <h2><xsl:value-of select="@title"/></h2>
        <h3>Properties</h3>
        <ul>
            <xsl:apply-templates select="properties/property"/>
        </ul>
    </xsl:template>

    <xsl:template match="property">
        <li>
            <xsl:value-of select="@type"/>:
            <xsl:value-of select="@amount"/>
            <xsl:value-of select="@unit"/>
        </li>
    </xsl:template>

</xsl:stylesheet>