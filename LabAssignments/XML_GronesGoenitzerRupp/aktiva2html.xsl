<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    
    <xsl:template match="/">
        <html>
            <head>
                <title>Aktiva Profile</title>
            </head>
            <body>
                <h1>Aktiva Arbeiter</h1>
                <h2>Inhaltsverzeichnis</h2>
                    <xsl:apply-templates select="aktiva" mode="table-of-contents"/>
                <h2>Arbeiter</h2>
                    <xsl:apply-templates select="aktiva" mode="cv-entries"/>
                <h2>Qualifikationen-Index</h2>
                    <xsl:apply-templates select="aktiva" mode="index"/>
            </body>
        </html>
    </xsl:template>
    
    <xsl:template match="aktiva" mode="table-of-contents">
        <ol>
            <h3>
                <xsl:for-each select="worker">
                    <li xml:space="preserve">
                      <a href="#{@id}"><xsl:value-of select="@fname"/> <xsl:value-of select="@lname"/></a>
                    </li>
                </xsl:for-each>
            </h3>
        </ol>
    </xsl:template>
    
    <xsl:template match="aktiva" mode="cv-entries">
        <ul>
            <xsl:for-each select="worker">
                <li xml:space="preserve">
                    <a name="{@id}"><h2><xsl:value-of select="@fname"/> <xsl:value-of select="@lname"/></h2></a>
                    <h3>Qualifikation</h3>
                    <ul>
                        <li>
                            <xsl:value-of select="@qualification"/>
                        </li>
                    </ul>
                    <h3>Lebenslauf</h3>
                    <xsl:for-each select="cv-entry">
                        <ul>
                            <li xml:space="preserve">
                                <xsl:value-of select="@start"/> -
                                <xsl:choose>
                                    <xsl:when test="@end != ''">
                                        <xsl:value-of select="@end"/> 
                                    </xsl:when>
                                    <xsl:otherwise>
                                        heute
                                    </xsl:otherwise>
                                </xsl:choose>
                                bei <xsl:value-of select="@company-name"/>
                            </li>
                        </ul>
                    </xsl:for-each>
                    <xsl:if test="worker-contract">
                        <h3>Verträge bei aktiva</h3>
                        <xsl:variable name="qual" select="@qualification"/>
                        <xsl:for-each select="worker-contract" xml:space="preserve">
                        <ul>
                            <li>
                                <xsl:value-of select="distinct-values(id(id(@offer-id)/@request-id)/request-entry[@qualification=$qual]/@start)"/> - 
                                <xsl:choose>
                                    <xsl:when test="id(id(@offer-id)/@request-id)/request-entry[@qualification=$qual]/@end">
                                        <xsl:value-of select="distinct-values(id(id(@offer-id)/@request-id)/request-entry[@qualification=$qual]/@end)"/>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        heute 
                                    </xsl:otherwise>
                                </xsl:choose>
                                als
                                <xsl:value-of select="distinct-values(id(id(@offer-id)/@request-id)/request-entry[@qualification=$qual]/@qualification)"/> bei
                                <xsl:variable name="offer" select="@offer-id"/>
                                <xsl:value-of select="ancestor::aktiva/company/company-contract[@offer-id=$offer]/../@name"/>
                                <br/>
                            </li>
                        </ul>
                        </xsl:for-each>
                    </xsl:if>    
                </li>
            </xsl:for-each>
        </ul>
    </xsl:template>
    
    <xsl:template match="aktiva" mode="index">
        <xsl:for-each select="qualification">
            <xsl:sort select="@id"/>
            <ul>
                <li>
                    <h3><xsl:value-of select="@id"/></h3>
                    <ul>
                        <xsl:variable name="qual" select="@id"/>
                        <xsl:for-each select="ancestor::aktiva/worker[@qualification=$qual]">
                            <li>
                                <a href="#{@id}"><xsl:value-of select="concat(@fname, ' ', @lname)"/></a>
                                <br/>
                            </li>
                        </xsl:for-each>
                    </ul>
                </li>
            </ul>
        </xsl:for-each>
    </xsl:template>
</xsl:stylesheet>