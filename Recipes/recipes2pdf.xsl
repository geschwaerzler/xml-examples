<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format">

    <xsl:template match="/">
        <fo:root xml:space="preserve">
            
            <fo:layout-master-set>
                <fo:simple-page-master master-name="a4page">
                    <fo:region-body margin="2.5cm"/>
                </fo:simple-page-master>
            </fo:layout-master-set>
            
            <fo:page-sequence master-reference="a4page" font-family="serif" font-size="9pt">
                <fo:flow flow-name="xsl-region-body">
                    <fo:block font-size="14pt" font-style="italic">
                        <fo:inline color="red">H</fo:inline>ello
                        <fo:inline font-weight="bold">World</fo:inline>!
                    </fo:block>
                </fo:flow>
            </fo:page-sequence>
            
        </fo:root>
    </xsl:template>
    
</xsl:stylesheet>
