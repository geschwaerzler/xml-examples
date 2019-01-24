<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xls="http://www.w3.org/1999/XSL/Transform">

    <xsl:template match="/">
        <html>
            <head>
                <title>DigiTrash</title>
            </head>
            <body>
                <h1>DigiTrash</h1>
                <ol>
                    <xsl:apply-templates select="DigiTrash/Rechnung" mode="overview"/>
                </ol>
                <br/>
                <xsl:apply-templates select="DigiTrash/Rechnung" mode="detail"/>
                <h2>Verrechnete Artikel</h2>
                <ul>
                    <xsl:for-each-group select="DigiTrash/Rechnungsposten" group-by="@artikel-id">
                        <xsl:sort select="id(@artikel-id)/@bezeichnung"/>
                        <li xml:space="preserve">
                             <xls:value-of select="id(@artikel-id)/@bezeichnung"/>
                             <xls:value-of select="id(@artikel-id)/@groesse"/>
                             <xls:value-of select="id(@artikel-id)/@einheit"/>
                             <xls:value-of select="id(@artikel-id)/@packungsgroesse"/>
                             <i>In Rechnung</i>:
                             <ul>
                                 <xsl:for-each select="current-group()">
                                         <xsl:variable name="posten-id" select="@id"/>
                                         <xsl:for-each select="//Beinhaltet[@rechnungsposten-id=$posten-id]/..">
                                             <li>
                                                    <a href="#{generate-id()}">
                                                        <xsl:value-of select="@id"/>
                                                    </a>
                                             </li>
                                         </xsl:for-each>
                                 </xsl:for-each>
                             </ul>
                        </li>
                    </xsl:for-each-group>
                </ul>

            </body>
        </html>
    </xsl:template>

    <xsl:template match="Rechnung" mode="overview">
        <li>
            <a href="#{generate-id()}">
                <xsl:value-of select="@id"/>
            </a>
        </li>
    </xsl:template>

    <xsl:template match="Rechnung" mode="detail">
        <h2 xml:space="preserve" id="{generate-id()}">
            <xsl:value-of select="@id"/>
            <br/>
            Type:
            <xsl:value-of select="@type"/>
            <br/>
            Datum und Zeit:
            <xsl:value-of select="@zeitstempel"/>
        </h2>
        <h3>Rechungsposten</h3>
        <table>
            <thead>
                <tr>
                    <th>Bezeichnung</th>
                    <th>Größe</th>
                    <th>Stückpreis</th>
                    <th>Anzahl</th>
                    <th>Gesamtpreis</th>
                </tr>
            </thead>
            <tbody>
                <xsl:apply-templates select="Beinhaltet"/>
            </tbody>

        </table>
    </xsl:template>
    <xsl:template match="Beinhaltet">
        <tr>
            <xsl:apply-templates select="id(@rechnungsposten-id)"/>
        </tr>
    </xsl:template>

    <xsl:template match="Rechnungsposten">
        <td>
            <xls:value-of select="id(@artikel-id)/@bezeichnung"/>
        </td>
        <td xml:space="preserve"><xls:value-of select="id(@artikel-id)/@groesse"/>
            <xls:value-of select="id(@artikel-id)/@einheit"/></td>
        <td>
            <xls:value-of select="@stueckpreis"/>
        </td>
        <td>
            <xsl:value-of select="@anzahl"/>
        </td>
        <td>
            <xsl:value-of select="@stueckpreis * @anzahl"/>
        </td>
    </xsl:template>

</xsl:stylesheet>
