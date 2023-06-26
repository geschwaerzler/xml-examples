<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format">
    
    <xsl:output method="xml" indent="yes"/>
    
    <!-- Root template -->
    <xsl:template match="/">
        <fo:root>
            <fo:layout-master-set>
                <fo:simple-page-master master-name="content" page-height="11in" page-width="8.5in">
                    <fo:region-body margin="1in"/>
                </fo:simple-page-master>
            </fo:layout-master-set>
            <fo:page-sequence master-reference="content">
                <fo:flow flow-name="xsl-region-body">
                    <xsl:apply-templates select="bibliothek"/>
                </fo:flow>
            </fo:page-sequence>
        </fo:root>
    </xsl:template>
    
    <!-- Template for "bibliothek" -->
    <xsl:template match="bibliothek">
        <fo:block font-size="18pt" text-align="center" font-weight="bold">
            Bibliothek
        </fo:block>
        
        <!-- Kundendaten -->
        <fo:block font-size="14pt" font-weight="bold" margin-top="1.5em">
            Kundendaten
        </fo:block>
        <xsl:apply-templates select="kunden/kunde"/>
        
        <!-- Buchdaten -->
        <fo:block font-size="14pt" font-weight="bold" margin-top="1.5em">
            Buchdaten
        </fo:block>
        <xsl:apply-templates select="buecher/buch"/>
        
        <!-- Zeitschriftendaten -->
        <fo:block font-size="14pt" font-weight="bold" margin-top="1.5em">
            Zeitschriftendaten
        </fo:block>
        <xsl:apply-templates select="zeitschriften/zeitschrift"/>
    </xsl:template>
    
    <!-- Template for "kunde" -->
    <xsl:template match="kunde">
        <fo:block>
            <fo:block>
                <fo:inline font-weight="bold">Name: </fo:inline>
                <xsl:value-of select="name"/>
            </fo:block>
            <fo:block>
                <fo:inline font-weight="bold">Adresse: </fo:inline>
                <xsl:value-of select="adresse"/>
            </fo:block>
            <fo:block>
                <fo:inline font-weight="bold">Telefon: </fo:inline>
                <xsl:value-of select="teln"/>
            </fo:block>
            <fo:block>
                <fo:inline font-weight="bold">E-Mail: </fo:inline>
                <xsl:value-of select="email"/>
            </fo:block>
            <fo:block>&#xA0;</fo:block>
        </fo:block>
    </xsl:template>
    
    <!-- Template for "buch" -->
    <xsl:template match="buch">
        <fo:block>
            <fo:block>
                <fo:inline font-weight="bold">Titel: </fo:inline>
                <xsl:value-of select="titel"/>
            </fo:block>
            <fo:block>
                <fo:inline font-weight="bold">Autor: </fo:inline>
                <xsl:value-of select="autor"/>
            </fo:block>
            <fo:block>
                <fo:inline font-weight="bold">Publisher: </fo:inline>
                <xsl:value-of select="publisher"/>
            </fo:block>
            <fo:block>
                <fo:inline font-weight="bold">Erscheinungsdatum: </fo:inline>
                <xsl:value-of select="erscheinungsdatum"/>
            </fo:block>
            <fo:block>
                <fo:inline font-weight="bold">ISBN: </fo:inline>
                <xsl:value-of select="isbn"/>
            </fo:block>
            <fo:block>
                <fo:inline font-weight="bold">Kategorie: </fo:inline>
                <xsl:value-of select="kategorie"/>
            </fo:block>
            <fo:block>
                <fo:inline font-weight="bold">Bewertung: </fo:inline>
                <xsl:value-of select="bewertung"/>
            </fo:block>
            <fo:block>&#xA0;</fo:block>
        </fo:block>
    </xsl:template>
    
    <!-- Template for "zeitschrift" -->
    <xsl:template match="zeitschrift">
        <fo:block>
            <fo:block>
                <fo:inline font-weight="bold">Titel: </fo:inline>
                <xsl:value-of select="titel"/>
            </fo:block>
            <fo:block>
                <fo:inline font-weight="bold">Publisher: </fo:inline>
                <xsl:value-of select="publisher"/>
            </fo:block>
            <fo:block>
                <fo:inline font-weight="bold">Erscheinungsdatum: </fo:inline>
                <xsl:value-of select="erscheinungsdatum"/>
            </fo:block>
            <fo:block>
                <fo:inline font-weight="bold">Kategorie: </fo:inline>
                <xsl:value-of select="kategorie"/>
            </fo:block>
            <fo:block>
                <fo:inline font-weight="bold">Bewertung: </fo:inline>
                <xsl:value-of select="bewertung"/>
            </fo:block>
            <fo:block>&#xA0;</fo:block>
        </fo:block>
    </xsl:template>
    
</xsl:stylesheet>
