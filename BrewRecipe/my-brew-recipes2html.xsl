<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet
        xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
        version="2.0">

    <xsl:template match="/brew-recipes">
        <html>
            <head>
                <title>My Brew Recipes for Lab 2</title>
            </head>
            <body>
                <h1>My Brew Recipes for Lab 2</h1>

                <xsl:apply-templates select="brew"/>

            </body>
        </html>
    </xsl:template>

    <xsl:template match="brew">
        <h2><xsl:value-of select="title"/></h2>

    </xsl:template>


</xsl:stylesheet>