<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                exclude-result-prefixes="xs"
                version="2.0">

    <xsl:template match="/goat-hood">
        <html>
            <head>
                <title>Goat-Hood</title>
                <link rel="stylesheet" href="goat-hood.css"/>
            </head>
            <body>
                <div class="wrapper">
                    <h1><xsl:value-of select="beschreibung"/></h1>

                    <h2>Spieler:</h2>
                    <ul>
                        <xsl:apply-templates select="spieler" mode="spieler-uebersicht">
                            <xsl:sort select="rueckennummer"></xsl:sort>
                        </xsl:apply-templates>
                    </ul>

                    <h2>Ereignisse:</h2>
                    <table>
                        <thead>
                            <tr>
                                <th>Datum - Uhrzeit</th>
                                <th>Typ</th>
                                <th>Spielort - Ergebnis</th>
                            </tr>
                        </thead>
                        <tbody><xsl:apply-templates select="ereignis" mode="ereignis-uebersicht">
                            <xsl:sort select="ereignis-datum/@datum"></xsl:sort></xsl:apply-templates>
                        </tbody>
                    </table>

                    <h2>Strafen:</h2>
                    <table>
                        <thead>
                            <tr>
                                <th>Strafentyp</th>
                                <th>Preis</th>
                                <th>Definition</th>
                            </tr>
                        </thead>
                        <tbody><xsl:apply-templates select="strafentyp" mode="strafe-uebersicht"/></tbody>
                    </table>

                    <h2>Strafen der Spieler:</h2>
                    <xsl:apply-templates select="spieler" mode="spieler-strafen"/>
                </div>
                <link href="https://fonts.googleapis.com/css?family=Montserrat" rel="stylesheet"/>
            </body>
        </html>
    </xsl:template>

    <xsl:template match="spieler" mode="spieler-uebersicht">
        <li xml:space="preserve">
            <a href="#{@id}">
                <xsl:value-of select="rueckennummer"/> - 
                <xsl:value-of select="vorname"/> 
                <xsl:value-of select="nachname"/> - 
                <xsl:value-of select="geburtsdatum"/>
            </a>
        </li>
    </xsl:template>

    <xsl:template match="ereignis" mode="ereignis-uebersicht">
        <tr>
            <td>
                <xsl:value-of select="ereignis-datum"/> -
                <xsl:value-of select="ereignis-uhrzeit"/>
            </td>
            <td>
                <xsl:if test="spiel-ort">
                    <xsl:if test="spiel-ort!=''">Spiel</xsl:if>
                </xsl:if>
                <xsl:if test="not(spiel-ort)">Training</xsl:if>
                <xsl:if test="spiel-ort=''">Training</xsl:if>
            </td>
            <td>
                <xsl:if test="spiel-ort"><xsl:if test="spiel-ort!=''">
                    <xsl:value-of select="spiel-ort"/> -
                    <xsl:value-of select="spiel-ergebnis"/>
                </xsl:if></xsl:if>
            </td>
        </tr>
    </xsl:template>

    <xsl:template match="strafentyp" mode="strafe-uebersicht">
        <tr>
            <td>
                <xsl:value-of select="strafentyp-bezeichnung"/>
            </td>
            <td>
                <xsl:value-of select="preis"/>
            </td>
            <td>
                <xsl:value-of select="definition"/>
            </td>
        </tr>
    </xsl:template>

    <xsl:template match="spieler" mode="spieler-strafen">
        <xsl:variable name="spielerId" select="@id"/>
        <xsl:if test="//strafe[@spieler-id=$spielerId]">
            <h3 id="{@id}" xml:space="preserve">
               <xsl:value-of select="rueckennummer"/> - 
               <xsl:value-of select="vorname"/> 
               <xsl:value-of select="nachname"/>
           </h3>
            <table>
                <xsl:for-each select="//strafe[@spieler-id=$spielerId]">
                    <tr>
                        <xsl:variable name="ereignisId" select="@ereignis-id"/>
                        <xsl:variable name="strafentypId" select="@strafentyp"/>

                        <td>
                            <xsl:value-of select="//ereignis[@id=$ereignisId]/ereignis-datum"/>
                        </td>
                        <td><xsl:value-of select="//strafentyp[@id=$strafentypId]/preis"/>,- </td>
                        <td><xsl:value-of select="//strafentyp[@id=$strafentypId]/strafentyp-bezeichnung"/></td>
                    </tr>
                </xsl:for-each>
            </table>
        </xsl:if>
    </xsl:template>
</xsl:stylesheet>