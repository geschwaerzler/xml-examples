<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="2.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
>

    <xsl:template match="/collection">
        <html lang="en">
            <head>
                <title><xsl:value-of select="description" /></title>
            </head>
            <body>
                <h1><xsl:value-of select="description"/></h1>

                <h2>Table of Contents</h2>
                <ol>
                    <xsl:apply-templates select="recipe" mode="table-of-contents"/>
                    <!--xsl:for-each select="recipe">
                        <li><a href="#recipe-{position()}"><xsl:value-of select="title"/></a></li>
                    </xsl:for-each -->
                </ol>

                <xsl:apply-templates select="recipe" mode="detail"/>

                <h2>Index of Ingredients</h2>
                <table>
                    <xsl:for-each select="//ingredient">
                        <xsl:sort select="lower-case(@name)"/>
                        <tr>
                            <td><xsl:value-of select="@name"/></td>
                            <td>
                                <xsl:variable name="parent-recipe" select="ancestor::recipe"/>
                                <a href="#{generate-id($parent-recipe)}">
                                    <xsl:value-of select="$parent-recipe/title"/>
                                </a>
                            </td>
                        </tr>
                    </xsl:for-each>
                </table>

            </body>
        </html>
    </xsl:template>


    <xsl:template match="recipe" mode="table-of-contents">
        <li><a href="#{generate-id()}"><xsl:value-of select="title"/></a></li>
    </xsl:template>


    <xsl:template match="recipe" mode="detail">
        <h2 id="{generate-id()}">
            <xsl:value-of select="position()"/>.
            <xsl:value-of select="title"/>
        </h2>

        <xsl:if test="@author-id">
            <xsl:variable name="author" select="id(@author-id)"/>
            <p xml:space="preserve">Author:
                <xsl:value-of select="$author/@title"/>
                <xsl:value-of select="$author/text()"/>
            </p>
        </xsl:if>

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