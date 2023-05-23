<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    
    <xsl:template match="/">
        <html>
            <head>
                <title>Bibliothek Übersicht</title>
                <style type="text/css">
                    body {
                    font-family: Arial, sans-serif;
                    margin: 0;
                    padding: 0;
                    }
                    
                    h1, h2 {
                    color: #333;
                    }
                    
                    table {
                    width: 100%;
                    border-collapse: collapse;
                    }
                    
                    th, td {
                    border: 1px solid #333;
                    padding: 8px;
                    }
                    
                    th {
                    background-color: #f2f2f2;
                    font-weight: bold;
                    text-align: left;
                    }
                    
                    ul {
                    list-style-type: none;
                    padding: 0;
                    }
                    
                    li {
                    margin-bottom: 5px;
                    }
                    
                    a {
                    color: #333;
                    text-decoration: none;
                    }
                    
                    h1 {
                    text-align: center;
                    margin-top: 20px;
                    }
                    
                    ul {
                    text-align: center;
                    }
                    
                    h2 {
                    margin-top: 30px;
                    }
                    
                    table {
                    margin-top: 10px;
                    }
                </style>
            </head>
            <body>
                <h1>Bibliothek Übersicht</h1>
                <ul>
                    <li><a href="#kunden">Kunden</a></li>
                    <li><a href="#buecher">Bücher</a></li>
                    <li><a href="#zeitschriften">Zeitschriften</a></li>
                    <li><a href="#ausleihen">Ausleihen</a></li>
                </ul>
                
                <!-- Kunden -->
                <h2 id="kunden">Kunden</h2>
                <table>
                    <tr>
                        <th>Name</th>
                        <th>Adresse</th>
                        <th>Telefonnummer</th>
                        <th>E-Mail</th>
                    </tr>
                    <xsl:for-each select="bibliothek/kunden/kunde">
                        <tr>
                            <td><xsl:value-of select="name"/></td>
                            <td><xsl:value-of select="adresse"/></td>
                            <td><xsl:value-of select="teln"/></td>
                            <td><xsl:value-of select="email"/></td>
                        </tr>
                    </xsl:for-each>
                </table>
                <!-- Bücher -->
                <h2 id="buecher">Bücher</h2>
                <table>
                    <tr>
                        <th>Titel</th>
                        <th>Autor</th>
                        <th>Publischer</th>
                        <th>Erscheinungsdatum</th>
                        <th>ISBN</th>
                        <th>Kategorie</th>
                        <th>Bewertung</th>
                        <th>Exemplare</th>
                    </tr>
                    <xsl:for-each select="bibliothek/buecher/buch">
                        <tr>
                            <td><xsl:value-of select="titel"/></td>
                            <td><xsl:value-of select="autor"/></td>
                            <td><xsl:value-of select="publisher"/></td>
                            <td><xsl:value-of select="erscheinungsdatum"/></td>
                            <td><xsl:value-of select="isbn"/></td>
                            <td><xsl:value-of select="kategorie"/></td>
                            <td><xsl:value-of select="bewertung"/></td>
                            <td>
                                <xsl:variable name="buchId" select="@id"/>
                                <xsl:value-of select="//verfuegbarkeiten/verfuegbarkeit[buch/@id = $buchId]/verfuegbar"/>
                            </td>
                        </tr>
                    </xsl:for-each>
                </table>
                <!-- Zeitschriften -->
                <h2 id="zeitschriften">Zeitschriften</h2>
                <table>
                    <tr>
                        <th>Titel</th>
                        <th>Publischer</th>
                        <th>Erscheinungsdatum</th>
                        <th>Kategorie</th>
                        <th>Bewertung</th>
                    </tr>
                    <xsl:for-each select="bibliothek/zeitschriften/zeitschrift">
                        <tr>
                            <td><xsl:value-of select="titel"/></td>
                            <td><xsl:value-of select="publisher"/></td>
                            <td><xsl:value-of select="erscheinungsdatum"/></td>
                            <td><xsl:value-of select="kategorie"/></td>
                            <td><xsl:value-of select="bewertung"/></td>
                        </tr>
                    </xsl:for-each>
                </table>
                <!-- Ausleihen -->
                <h2 id="ausleihen">Ausleihen</h2>
                <table>
                    <tr>
                        <th>Medium</th>
                        <th>Ausleiher</th>
                        <th>Ausleih-Datum</th>
                        <th>Rückgabedatum</th>
                        
                    </tr>
                    <xsl:for-each select="bibliothek/ausleihen/ausleihe">
                        <tr>
                            <td>
                                <xsl:value-of select="../../buecher/buch[@id=current()/medium/@id]/titel"/>
                                <xsl:if test="current()/medium/@id != ''">
                                    <xsl:text> (Buch)</xsl:text>
                                </xsl:if>
                                <xsl:if test="current()/medium/@id = ''">
                                    <xsl:text> (Zeitschrift)</xsl:text>
                                </xsl:if>
                            </td>
                            <td>
                                <xsl:value-of select="../../kunden/kunde[@id=current()/kunde/@id]/name"/>
                            </td>
                            <td>
                                <xsl:value-of select="datum"/>
                            </td>
                            <td>
                                <xsl:value-of select="rueckgabedatum"/>
                            </td>
                        </tr>
                    </xsl:for-each>
                </table>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>