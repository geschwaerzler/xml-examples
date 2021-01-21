<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                exclude-result-prefixes="xs"
                version="2.0">

    <xsl:output method="html"></xsl:output>
    <xsl:template match="/">
        <html>
            <head>
                <title>
                    WFAC
                </title>
            </head>
            <body>
                <h1>Inhaltsverzeichnis</h1>
                <ul>
                    <xsl:apply-templates select="wfac/group" mode="toc"/>
                </ul>

                <h1>Gruppen</h1>
                <div>
                    <xsl:apply-templates select="wfac/group" mode="detail"/>
                </div>

                <h1>Scorecards</h1>
                <div>
                    <xsl:apply-templates select="wfac/competitor" mode="competitor"/>
                </div>

            </body>
        </html>
    </xsl:template>

    <xsl:template match="group" mode="toc">
            <li>
                <a href="#g-{position()}">
                    Group
                    <xsl:variable name="gid" select="@id"/><xsl:value-of select="substring-after($gid,'G-')"/>
                </a>
            </li>

    </xsl:template>

    <xsl:template match="group" mode="detail">
        <h2>
            <b id="g-{position()}">
                Group
                <xsl:variable name="gid" select="@id"/><xsl:value-of select="substring-after($gid,'G-')"/>
            </b>

        </h2>
        <ul>
            <xsl:for-each select="groupmember">
                <xsl:call-template name="competitorList">
                    <xsl:with-param name="grpRegId" select="id(@registration_id)"/>
                </xsl:call-template>
            </xsl:for-each>
        </ul>
    </xsl:template>

    <xsl:template name="competitorList" match="wfac/competitor">
        <xsl:param name="grpRegId"/>
        <li>
            <a href="#c-{position()}">
                <xsl:value-of select="$grpRegId/@fname"/>
                <xsl:text>&#160;</xsl:text>
                <xsl:value-of select="$grpRegId/@lname"/>
                <xsl:text>&#160;</xsl:text>
                <i><xsl:value-of select="@role"/></i>
            </a>
        </li>
    </xsl:template>

    <xsl:template match="competitor" mode="competitor">
        <h3 id="c-{position()}">
            <xsl:value-of select="@fname"/>
            <xsl:text>&#160;</xsl:text>
            <xsl:value-of select="@lname"/>
        </h3>
        <table border = "2">
            <tr>
                <td><b>target#</b></td>
                <td><b>score</b></td>
            </tr>
            <xsl:for-each select="scorecard/scorecard_entry">
                <xsl:call-template name="scorecard"/>
            </xsl:for-each>
        </table>
    </xsl:template>

    <xsl:template name="scorecard" match="wfac/competitor/scorecard">
            <tr>
                <td>
                    <xsl:value-of select="@entry_number"/>
                </td>
                <td>
                    <xsl:value-of select="@score"/>
                </td>
            </tr>
    </xsl:template>
</xsl:stylesheet>