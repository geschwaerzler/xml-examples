<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl"
>
  <xsl:output method="html" indent="yes" encoding="utf-8"/>

  <xsl:template match="/tournament">
    <html>
      <head>
        <style>
          body {
          font-family: Arial, Helvetica, sans-serif;
          font-size: 13px;
          }

          table {border-collapse: collapse;}
          th ,td    {padding: 6px;}
          span {padding: 6px;}
        </style>
      </head>
      <body>
        <h1>World Outdoor Flint Archery Mail Match</h1>
        <ul>
          <xsl:for-each select="group">
            <li>
              <a>
                <xsl:attribute name="href">
                  <xsl:value-of select="concat('#',@id)"/>
                </xsl:attribute>
                <xsl:text>Group </xsl:text>
                <xsl:value-of select="@id"/>

              </a>
            </li>
          </xsl:for-each>

        </ul>
        <xsl:apply-templates select="group"/>
        <xsl:apply-templates select="shooting-style"/>
      </body>
    </html>
  </xsl:template>
  
  <xsl:template match="group">
    <div>
      <xsl:attribute name="id">
        <xsl:value-of select="@id"/>
      </xsl:attribute>
      <h2>
        <xsl:text>Group </xsl:text>
        <xsl:value-of select="@id"/>
      </h2>
      <ul>
        <xsl:for-each select="participant">
          <li>
            <xsl:variable name="person_id" select="@person_id" />
            <xsl:value-of select="concat(//person[@id=$person_id]/@firstname,' ',//person[@id=$person_id]/@lastname,' (',@role,')')"/>
          </li>
        </xsl:for-each>
      </ul>
      <hr></hr>
      
      <xsl:apply-templates select="round"/>
      <hr></hr>
    </div>
  </xsl:template>
  
  
  <xsl:template match="round">
    <div>
      <span>
        <xsl:text>Round number: </xsl:text>
        <strong>
          <xsl:value-of select="@round_number"/>
        </strong>
      </span>
      <table>
        <tr>
          <th>Name</th>
          <th>Scores</th>
          <th>Points</th>
        </tr>
        
        <xsl:for-each select="results">
          <xsl:variable name="participant_id" select="@participant_id" />
          <xsl:variable name="person_id" select="//participant[@id=$participant_id]/@person_id" />
          <tr>
            <td>
              <xsl:value-of select="concat(//person[@id=$person_id]/@firstname,' ',//person[@id=$person_id]/@lastname)"/>
            </td>
            <td>
              <xsl:value-of select="count(score)"/>
            </td>
            <td>
              <xsl:value-of select="sum(score/@points)"/>
            </td>
          </tr>
        </xsl:for-each>
        
      </table>
    </div>

  </xsl:template>
  <xsl:template match="shooting-style">
    <div>
      <h2>
        <xsl:value-of select="concat('Shooting Style: ',@style_name)"/>
      </h2>
      <h3>
        <xsl:value-of select="concat('Bow Type: ',@bow_type)"/>
      </h3>
      <xsl:for-each select="division">
        <div>
          <span>
            <xsl:text>Division: </xsl:text>
            <strong>
              <xsl:value-of select="@gender"/>
            </strong>
          </span>
          <span>
            <xsl:text>Professional: </xsl:text>
            <strong>
              <xsl:value-of select="@is_professional"/>
            </strong>
          </span>
          <span>
            <xsl:text>Age: </xsl:text>
            <strong>
              <xsl:value-of select="@age_group_name"/>
            </strong>
          </span>

          <table>
            <tr>
              <th>Name</th>
              <th>email</th>
              <th>Role</th>
            </tr>
            
            <xsl:for-each select="person">
              <xsl:variable name="participant_id" select="@participant_id" />
              <xsl:variable name="person_id" select="//participant[@id=$participant_id]/@person_id" />
              <tr>
                <td>
                  <xsl:value-of select="concat(@firstname,' ',@lastname)"/>
                </td>
                <td>
                  <xsl:value-of select="@email"/>
                </td>
                <td>
                  <xsl:value-of select="@tournament_role"/>
                </td>
              </tr>
            </xsl:for-each>
            
          </table>
          <hr></hr>
        </div>
      </xsl:for-each>
    </div>
  </xsl:template>

</xsl:stylesheet>
