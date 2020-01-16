<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format">
    
    <!-- ............................ ROOT TEMPLATE .......................... -->
    <xsl:template match="/">
        <fo:root>
            
            <!-- define the layout of the document -->
            <fo:layout-master-set>
                <!-- here we define the layout of pages. There might be differrent page masters with e.g. different margin settings -->
                <fo:simple-page-master master-name="recipe-page"
                    page-height="297.0mm" page-width="209.9mm"
                    margin-bottom="8mm" margin-left="25mm" margin-right="10mm" margin-top="10mm">
                    
                    <!-- the content will be placed into the region-body -->
                    <fo:region-body margin-bottom="28mm" margin-left="0mm" margin-right="44mm" margin-top="60mm"/>
                    
                </fo:simple-page-master>
            </fo:layout-master-set>
            
            
            <!-- Here comes the content.
                 Printed content consists of one or more page-sequences. Each page-sequence starts on a new page. -->
            
            <!-- front page -->
            <fo:page-sequence master-reference="recipe-page">
                <fo:flow flow-name="xsl-region-body" font-family="sans-serif" font-size="28pt">
                    <fo:block>
                        <xsl:value-of select="collection/description"/>
                    </fo:block>
                </fo:flow>
            </fo:page-sequence>
            
        </fo:root>
    </xsl:template>
    
</xsl:stylesheet>
