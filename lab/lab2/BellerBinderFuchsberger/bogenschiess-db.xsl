<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:template match="/">
        <html>
            <head>
                <link rel="stylesheet" href="main.css"></link>
                <title>
                    Bogenschiess DB
                </title>
            </head>
            <body>

                <xsl:apply-templates select="bogenschiess-db/tournament" mode="m1"></xsl:apply-templates>

            </body>
        </html>


    </xsl:template>


    <xsl:template match="tournament" mode="m1">
        <h1>Year
            <xsl:value-of select="@event_year"/>
        </h1>
        <span class="subtext">
            Tournament in
            <xsl:value-of select="@host_country"/> in City (<xsl:value-of select="@host_city_code"/>)
        </span>
        <h2>Persons</h2>
        <p>A list of all involved Persons</p>
        <table>
            <th>Profilepic</th>
            <th>Name</th>
            <th>Punkte</th>
            <th>zu Teilnehmer springen</th>
            <xsl:for-each select="//person[contains(@tournament_role, 'PARTICIPANT')]">
                <tr>
                    <td>
                        <img class="preview-pic" src="{@profile_pic}"/>
                    </td>
                    <td><xsl:value-of select="@firstname"/>,
                        <xsl:value-of select="@lastname"/>
                    </td>
                    <td>
                        <xsl:value-of select="sum(//result[@person-id=current()/@id]/@points)"></xsl:value-of>
                        pts.
                    </td>
                    <td>
                        <a href="#person-{@id}">zu Person</a>
                    </td>
                </tr>
            </xsl:for-each>
        </table>
        <h2>Personen im Detail</h2>
        <xsl:apply-templates select="//person[contains(@tournament_role, 'PARTICIPANT')]"></xsl:apply-templates>
        <h2>Runden und Ergebnisse im Detail</h2>
        <p>A list of all Rounds</p>
        <ul>
            <xsl:for-each select="round">
                <li id='{generate-id()}' xml:space="preserve">
                    <a href="#round-{@id}">
                        Round <xsl:value-of select="@round_number"/>
                        <xsl:value-of select="@place"/>
                    </a>
                </li>
            </xsl:for-each>
        </ul>
        <xsl:apply-templates select="round"></xsl:apply-templates>
    </xsl:template>

    <xsl:template match="person">
        <div id="person-{@id}" class="person-container">
            <div class="person_name">
                <h3><xsl:value-of select="@firstname"/>,
                    <xsl:value-of select="@lastname"/>
                </h3>
            </div>
            <div class="profile_pic">
                <img src="{@profile_pic}"/>
            </div>
            <xsl:for-each select="participant">
                <div class="pers_details">
                    <h5>Personendetails</h5>
                    <b>Gender:</b>
                    <xsl:value-of select="@gender"/>
                    <br/>
                    <b>Professionell:</b>
                    <xsl:value-of select="@is_professional"/>
                </div>
                <div class="style_division">
                    <h5>Style and Division</h5>
                    <b>Style-Name:</b>
                    <xsl:value-of select="./style-and-division/shooting-style/@style_name"/>
                    <br/>
                    <b>Bogentyp:</b>
                    <xsl:value-of select="./style-and-division/shooting-style/@bow_type"/>
                    <br/>
                    <b>Altersgruppe:</b>
                    <xsl:value-of select="./style-and-division/age-group/@gr_name"/>
                </div>
                <div class="point_sum">
                    <xsl:variable name="p-id" select="../@id"></xsl:variable>
                    <xsl:value-of select="sum(//result[@person-id=$p-id]/@points)"></xsl:value-of>
                    pts.
                </div>
                <div class="result_table">
                    <h4>Runden und Ergebnisse</h4>
                    <xsl:variable name="p-id2" select="../@id"></xsl:variable>
                    <table>
                        <th>Ort</th>
                        <th>Runden Nummer</th>
                        <th>Start Zeit</th>
                        <th>Runden Typ</th>
                        <th>Gruppenrolle</th>
                        <th>Punkte</th>
                        <xsl:for-each select="//result[@person-id=$p-id2]/ancestor::round">
                            <tr>
                                <td>
                                    <a href="#round-{@id}">
                                        <xsl:value-of select="@place"/>
                                    </a>
                                </td>
                                <td>
                                    <xsl:value-of select="@round_number"/>
                                </td>
                                <td>
                                    <xsl:value-of select="@start_time"/>
                                </td>
                                <td>
                                    <xsl:value-of select="@round_type_name"/>
                                </td>
                                <td>
                                    <xsl:value-of select="./group/group-role[@person-id=$p-id2]/@group-role"/>
                                </td>
                                <td>
                                    <xsl:value-of select="./result[@person-id=$p-id2]/@points"/>
                                </td>
                            </tr>
                        </xsl:for-each>
                    </table>
                </div>
            </xsl:for-each>
        </div>
    </xsl:template>

    <xsl:template match="round">
        <div class="round-container">

            <h2 id="round-{@id}">Runde
                <xsl:value-of select="@round_number"/> -
                <xsl:value-of select="@place"/>
            </h2>

            <xsl:apply-templates select="group"></xsl:apply-templates>

            <h3>Ergebniss in der Runde</h3>

            <xsl:apply-templates select="result"></xsl:apply-templates>

        </div>

    </xsl:template>

    <xsl:template match="group">
        <h3>Gruppe
            <xsl:value-of select="@id"/>
        </h3>
        <xsl:apply-templates select="group-role"></xsl:apply-templates>
    </xsl:template>

    <xsl:template match="group-role">
        <p>

            <a href="#person-{@person-id}">
                <xsl:value-of select="//person[@id=current()/@person-id]/@firstname"/>,
                <xsl:value-of select="//person[@id=current()/@person-id]/@lastname"/>
            </a>
             -
            <xsl:value-of select="@group-role"/>
        </p>
    </xsl:template>

    <xsl:template match="result">
        <p>

            <img class="preview-pic small" src="{/bogenschiess-db/tournament/person[@id=current()/@person-id]/@profile_pic}"/>

            <a href="#person-{@person-id}">

            <xsl:value-of select="/bogenschiess-db/tournament/person[@id=current()/@person-id]/@firstname"/>,
            <xsl:value-of select="//person[@id=current()/@person-id]/@lastname"/>
            </a>
            -
            <b>
                <xsl:value-of select="@points"/> Points
            </b>
        </p>

    </xsl:template>

</xsl:stylesheet>