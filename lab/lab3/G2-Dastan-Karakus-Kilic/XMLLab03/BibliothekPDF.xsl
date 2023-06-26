<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format">
    
    <xsl:output method="xml" indent="yes"/>
    
    <!-- Define attribute set for footer style -->
    <xsl:attribute-set name="footer-style">
        <xsl:attribute name="text-align">right</xsl:attribute>
        <xsl:attribute name="font-size">10pt</xsl:attribute>
    </xsl:attribute-set>
    
    <!-- Root template -->
    <xsl:template match="/">
        <fo:root>
            <fo:layout-master-set>
                <fo:simple-page-master master-name="content" page-height="11in" page-width="8.5in">
                    <fo:region-body margin="1in"/>
                    <fo:region-after extent="0.5in"/>
                </fo:simple-page-master>
            </fo:layout-master-set>
            
            <!-- Title page -->
            <xsl:call-template name="title-page"/>
            
            <!-- Page sequences -->
            <xsl:apply-templates select="bibliothek/kunden"/>
            <xsl:apply-templates select="bibliothek/buecher"/>
            <xsl:apply-templates select="bibliothek/zeitschriften"/>
            
        </fo:root>
    </xsl:template>
    
    <xsl:template name="title-page">
        <fo:page-sequence master-reference="content">
            <fo:static-content flow-name="xsl-region-after">
                <fo:block xsl:use-attribute-sets="footer-style">
                    <xsl:call-template name="page-number"/>
                </fo:block>
            </fo:static-content>
            <fo:flow flow-name="xsl-region-body">
                <fo:block font-size="35pt" text-align="center" font-weight="bold" margin-bottom="1em">
                    Bibliothek
                </fo:block>
                <fo:block font-size="20pt" text-align="left" font-weight="bold" margin-bottom="1em">
                    Inhaltsangabe:
                </fo:block>
                <fo:block font-size="14pt" text-align="left" margin-bottom="0.5em">
                    Kundendaten
                </fo:block>
                <fo:block font-size="14pt" text-align="left" margin-bottom="0.5em">
                    Buchdaten
                </fo:block>
                <fo:block font-size="14pt" text-align="left" margin-bottom="1em">
                    Zeitschriftendaten
                </fo:block>
            </fo:flow>
        </fo:page-sequence>
    </xsl:template>
    
    <!-- Template for "kunden" -->
    <xsl:template match="kunden">
        <fo:page-sequence master-reference="content">
            <fo:static-content flow-name="xsl-region-after">
                <fo:block xsl:use-attribute-sets="footer-style">
                    <xsl:call-template name="page-number"/>
                </fo:block>
            </fo:static-content>
            <fo:flow flow-name="xsl-region-body">
                <fo:block font-size="18pt" text-align="center" font-weight="bold" margin-bottom="1em">
                    Kundendaten
                </fo:block>
                <xsl:apply-templates/>
            </fo:flow>
        </fo:page-sequence>
    </xsl:template>
    
    <!-- Template for "kunde" -->
    <xsl:template match="kunde">
        <fo:block>
            <xsl:apply-templates/>
            <fo:block>&#xA0;</fo:block>
        </fo:block>
    </xsl:template>
    
    <!-- Template for elements within "kunde" -->
    <xsl:template match="kunde/*">
        <fo:block>
            <fo:inline font-weight="bold">
                <xsl:value-of select="concat(local-name(), ': ')"/>
            </fo:inline>
            <xsl:value-of select="."/>
        </fo:block>
    </xsl:template>
    
    <!-- Template for "buecher" -->
    <xsl:template match="buecher">
        <fo:page-sequence master-reference="content">
            <fo:static-content flow-name="xsl-region-after">
                <fo:block xsl:use-attribute-sets="footer-style">
                    <xsl:call-template name="page-number"/>
                </fo:block>
            </fo:static-content>
            <fo:flow flow-name="xsl-region-body">
                <fo:block font-size="18pt" text-align="center" font-weight="bold" margin-bottom="1em">
                    Buchdaten
                </fo:block>
                <xsl:apply-templates/>
            </fo:flow>
        </fo:page-sequence>
    </xsl:template>
    
    <!-- Template for "buch" -->
    <xsl:template match="buch">
        <fo:block>
            <xsl:apply-templates/>
            <fo:block>&#xA0;</fo:block>
        </fo:block>
    </xsl:template>
    
    <!-- Template for elements within "buch" -->
    <xsl:template match="buch/*">
        <fo:block>
            <fo:inline font-weight="bold">
                <xsl:value-of select="concat(local-name(), ': ')"/>
            </fo:inline>
            <xsl:value-of select="."/>
        </fo:block>
    </xsl:template>
    
    <!-- Template for "zeitschriften" -->
    <xsl:template match="zeitschriften">
        <fo:page-sequence master-reference="content">
            <fo:static-content flow-name="xsl-region-after">
                <fo:block xsl:use-attribute-sets="footer-style">
                    <xsl:call-template name="page-number"/>
                </fo:block>
            </fo:static-content>
            <fo:flow flow-name="xsl-region-body">
                <fo:block font-size="18pt" text-align="center" font-weight="bold" margin-bottom="1em">
                    Zeitschriftendaten
                </fo:block>
                <xsl:apply-templates/>
            </fo:flow>
        </fo:page-sequence>
    </xsl:template>
    
    <!-- Template for "zeitschrift" -->
    <xsl:template match="zeitschrift">
        <fo:block>
            <xsl:apply-templates/>
            <fo:block>&#xA0;</fo:block>
        </fo:block>
    </xsl:template>
    
    <!-- Template for elements within "zeitschrift" -->
    <xsl:template match="zeitschrift/*">
        <fo:block>
            <fo:inline font-weight="bold">
                <xsl:value-of select="concat(local-name(), ': ')"/>
            </fo:inline>
            <xsl:value-of select="."/>
        </fo:block>
    </xsl:template>
    
    <!-- Template for page number -->
    <xsl:template name="page-number">
        <fo:block text-align="end" end-indent="2cm" font-size="10pt">
            Seite <fo:page-number/>
        </fo:block>
    </xsl:template>
    
</xsl:stylesheet>
