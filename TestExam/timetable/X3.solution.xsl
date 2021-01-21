<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

  <xsl:template match="/">
    <html>
      <head>
        <title>Vienna International Airport - Timetables</title>
      </head>
      <body>
        <h1>Departures</h1>
        <table border="1px">
          <tr><th>Sched.</th><th>Flight</th><th>to</th></tr>
          <xsl:apply-templates select="timetable/flight[departure/@airport-id='vie']" mode="departure"/>
        </table>
        
        <h1>Arrivals</h1>
        <table border="1px">
          <tr><th>Sched.</th><th>Flight</th><th>from</th></tr>
          <xsl:apply-templates select="timetable/flight[arrival/@airport-id='vie']" mode="arrival"/>
        </table>
      </body>
    </html>
  </xsl:template>
  
  <!-- here comes your work -->
  <xsl:template match='flight' mode='departure'>
  	<tr>
  		<td><xsl:value-of select="substring(departure/time[@zone='local']/@time, 1, 5)"/></td>
  		<td><xsl:value-of select="concat(@operator-id, ' ', @nr)"/></td>
  		<td><xsl:value-of select="id(arrival/@airport-id)/name[@lang='en']"/></td>
  	</tr>
  </xsl:template>
    
  <xsl:template match='flight' mode='arrival'>
  	<tr>
  	  <td><xsl:value-of select="substring(arrival/time[@zone='local']/@time, 1, 5)"/></td>
  		<td><xsl:value-of select="concat(@operator-id, ' ', @nr)"/></td>
  		<td><xsl:value-of select="id(departure/@airport-id)/name[@lang='en']"/></td>
  	</tr>
  </xsl:template>

</xsl:stylesheet>
