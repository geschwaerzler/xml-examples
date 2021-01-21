<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:template match="/">
        <html>
            <head>
                <title>Tournaments</title>
            </head>
            <body>
                <xsl:apply-templates/>
            </body>
        </html>
    </xsl:template>


    <xsl:template match="tournament">
        <h1><xsl:value-of select="@name"></xsl:value-of></h1>

        <h2>Funktionäre</h2>
        <table style="border: 1px solid black">
            <tr style="border: 1px solid black">
                <th style="border: 1px solid black">Name</th>
                <th style="border: 1px solid black">Function</th>
            </tr>
            <xsl:apply-templates select="employee"/>
        </table>

        <br/>

        <h2>Gruppenverzeichnis</h2>
        <ol style="list-style-type:upper-roman">
            <xsl:for-each select="round/group">
                <li><a href="#{@group_id}"><xsl:value-of select="@group_id"></xsl:value-of></a></li>
            </xsl:for-each>
        </ol>



        <br/>
        <h2>Runden</h2>
        <xsl:apply-templates select="round"/>

        <br/>
        <h2>Scorecards</h2>
        <xsl:apply-templates select="archer"/>





    </xsl:template>


    <xsl:template match="round">

        <h3>Runde: <xsl:value-of select="@round_id"></xsl:value-of></h3>

        <xsl:apply-templates select="group"/>

        <hr/>
        <h4>Rundenrangliste</h4>
        <ol>
            <xsl:apply-templates select="group/has_member">
                <xsl:sort select="sum(id(@archer_id)/scorecard/point/@target_points)" data-type="number" order="descending"/>
            </xsl:apply-templates>
        </ol>

        <br/>

    </xsl:template>

    <xsl:template match="group">
        <hr/>
        <h4 id="{@group_id}"><xsl:value-of select="@group_id"></xsl:value-of></h4>
        <ol>
            <xsl:apply-templates select="has_member">
                <xsl:sort select="sum(id(@archer_id)/scorecard/point/@target_points)" data-type="number" order="descending"/>
            </xsl:apply-templates>
        </ol>
        <br/>
    </xsl:template>


    <xsl:template match="has_member">
        <li><xsl:value-of select="concat(id(id(@archer_id)/@person_id)/@fname,
                                    '&#160;'
                                    ,id(id(@archer_id)/@person_id)/@lname)"></xsl:value-of>&#160;
            <a href="#{@archer_id}"><sum>
                (<xsl:value-of select="sum(id(@archer_id)/scorecard/point/@target_points)"/>)
            </sum></a>
        </li>
    </xsl:template>



    <xsl:template match="archer">

        <hr/>

        <h3 id="{@archer_id}"><xsl:value-of select="concat('Scorecard von&#160;', id(id(@archer_id)/@person_id)/@fname,
                        '&#160;'
                        ,id(id(@archer_id)/@person_id)/@lname, ':')"></xsl:value-of></h3>

        <table style="border: 1px solid black">
            <tr style="border: 1px solid black">
                <th style="border: 1px solid black">Target</th>
                <th style="border: 1px solid black">Point</th>
            </tr>
            <xsl:apply-templates select="scorecard/point"/>

        </table>

        <br/>
        <br/>

    </xsl:template>

    <xsl:template match="scorecard/point">
        <tr style="border: 1px solid black">
            <td style="border: 1px solid black"><xsl:value-of select="@target_no"></xsl:value-of></td>
            <td style="border: 1px solid black"><xsl:value-of select="@target_points"></xsl:value-of></td>
        </tr>
    </xsl:template>

    <xsl:template match="employee">
        <tr style="border: 1px solid black">
            <td style="border: 1px solid black"><xsl:value-of select="concat(id(@person_id)/@fname,
                                                                            '&#160;',
                                                                            id(@person_id)/@lname)"></xsl:value-of></td>
            <td style="border: 1px solid black"><xsl:value-of select="@function"></xsl:value-of></td>
        </tr>
    </xsl:template>

</xsl:stylesheet>