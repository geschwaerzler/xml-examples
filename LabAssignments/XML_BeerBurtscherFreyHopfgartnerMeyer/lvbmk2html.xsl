<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                exclude-result-prefixes="xs"
                version="2.0">

    <xsl:output method="html" doctype-system="html"/>
    <xsl:key name="personKey" match="/LVBMK/Person" use="@pers_id"/>
    <xsl:key name="artikelKey" match="/LVBMK/Artikel" use="@artikel_id"/>
    <xsl:key name="vereinKey" match="/LVBMK/Verein" use="@zvr"/>
    <xsl:template match="/LVBMK">
        <html>
            <head>
                <title>LVBMK</title>
                <style>
                    table, th, td {
                    border: 1px solid black;
                    }
                </style>
            </head>
            <body>
                <h1>Personen</h1>
                <table>
                    <thead>
                        <th>Name</th>
                        <th>Geburtsdatum</th>
                        <th>Telefonnr.</th>
                        <th>Straße</th>
                        <th>Straßennummer</th>
                        <th>ZIP</th>
                        <th>Verein</th>
                    </thead>
                    <tbody>
                        <xsl:apply-templates select="Person" mode="person_table"/>
                    </tbody>
                </table>

                <h1>Vorgänge pro Person:</h1>
                <xsl:apply-templates select="Person" mode="vorgaenge_pro_person"/>

                <h1>Bekleidung:</h1>
                <table>
                    <thead>
                        <th>Bezeichnung</th>
                        <th>Seriennummer</th>
                        <th>Hersteller</th>
                        <th>Größe</th>
                    </thead>
                    <tbody>

                        <xsl:apply-templates select="Artikel[Bekleidung]" mode="clothing_table">
                            <xsl:sort select="@bezeichnung"/>
                        </xsl:apply-templates>
                    </tbody>
                </table>

                <h1>Equipment:</h1>
                <table>
                    <thead>
                        <th>Bezeichnung</th>
                        <th>Seriennummer</th>
                        <th>Hersteller</th>
                    </thead>
                    <tbody>

                        <xsl:apply-templates select="Artikel[Equipment]" mode="equipment_table">
                            <xsl:sort select="@bezeichnung"/>
                        </xsl:apply-templates>
                    </tbody>
                </table>

                <h1>Inventar:</h1>
                <table>
                    <thead>
                        <th>Bezeichnung</th>
                        <th>Anzahl</th>
                    </thead>
                    <tbody>
                        <xsl:for-each-group select="Artikel" group-by="@bezeichnung">
                            <tr>
                                <td>
                                    <xsl:value-of select="@bezeichnung"/>
                                </td>
                                <td>
                                    <xsl:value-of select="count(current-group())"/>
                                </td>
                            </tr>
                        </xsl:for-each-group>
                    </tbody>
                </table>

            </body>
        </html>
    </xsl:template>

    <xsl:template match="Person" mode="person_table">
        <tr>
            <td>
                <a xml:space="preserve" href="#{@pers_id}">
                    <xsl:value-of select="@vname"/>
                    <xsl:value-of select="@nname"/></a>
            </td>
            <td>
                <xsl:value-of select="@geburtsdatum"/>
            </td>
            <td>
                <xsl:value-of select="@telefon_nr"/>
            </td>
            <xsl:apply-templates select="Adresse" mode="adresse"/>
            <td>
                <xsl:if test="Ist_In/@adatum">
                    <xsl:for-each select="key('vereinKey',Ist_In/@zvr)">
                        <xsl:value-of select="@vereinsname"/>
                    </xsl:for-each>
                </xsl:if>
            </td>
        </tr>
    </xsl:template>

    <xsl:template match="Adresse" mode="adresse">
        <td>
            <xsl:value-of select="@strasse"/>
        </td>
        <td>
            <xsl:value-of select="@strassennr"/>
        </td>
        <td>
            <xsl:value-of select="@plz"/>
        </td>
    </xsl:template>

    <xsl:template match="Person" mode="vorgaenge_pro_person">

        <xsl:variable name="id" select="@pers_id"/>
        <h4 xml:space="preserve" id="{@pers_id}">
            <xsl:value-of select="@vname"/> <xsl:value-of select="@nname"/>:
        </h4>
        <ul>
            <xsl:for-each select="//Vorgang">
                <xsl:if test="@pers_id = $id">
                    <li>
                        <ul>
                            <b xml:space="preserve"><xsl:value-of select="@bezeichnung"/> -
                                <xsl:for-each select="key('artikelKey',@artikel_id)"><xsl:value-of select="@bezeichnung"/></xsl:for-each></b>
                            <li xml:space="preserve">Startdatum: <xsl:value-of select="@startdatum"/></li>
                            <xsl:if test="@enddatum">
                                <li xml:space="preserve">Enddatum: <xsl:value-of select="@enddatum"/></li>
                            </xsl:if>
                        </ul>
                    </li>
                </xsl:if>
            </xsl:for-each>
        </ul>
    </xsl:template>

    <xsl:template match="Artikel[Bekleidung]" mode="clothing_table">
        <tr>
            <td>
                <xsl:value-of select="@bezeichnung"/>
            </td>
            <td>
                <xsl:value-of select="Bekleidung/@seriennummer"/>
            </td>
            <td>
                <xsl:value-of select="@hersteller"/>
            </td>
            <td>
                <xsl:value-of select="Bekleidung/@groesse"/>
            </td>
        </tr>
    </xsl:template>

    <xsl:template match="Artikel[Equipment]" mode="equipment_table">
        <tr>
            <td>
                <xsl:value-of select="@bezeichnung"/>
            </td>
            <td>
                <xsl:value-of select="Equipment/@seriennummer"/>
            </td>
            <td>
                <xsl:value-of select="@hersteller"/>
            </td>
        </tr>
    </xsl:template>

</xsl:stylesheet>