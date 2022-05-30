<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format"
    version="2.0"
>
    <xsl:template match="/tournament">
        <fo:root>
            <!-- layout -->
            <fo:layout-master-set>
                <!-- layout of pages -->
                <fo:simple-page-master master-name="tournament" 
                    page-height="297.0mm" page-width="210.0mm" 
                    margin-bottom="28mm" margin-left="0mm" margin-right="44mm" margin-top="10mm">
                    
                    <!-- content in the body -->
                    <fo:region-body margin-bottom="28mm" margin-left="55mm" margin-right="44mm" margin-top="20mm"/>
                    <fo:region-before extent="10mm"/>
                    <fo:region-after extent="10mm"/>
                </fo:simple-page-master>
            </fo:layout-master-set>
            
            <!-- printed content. each page-sequence starts on a new page -->
            
            <!-- header footer -->
            <fo:page-sequence master-reference="tournament">
                <!-- content header-->
                <fo:static-content flow-name="xsl-region-before">
                    <!-- content in fo:block -->
                    <fo:block>Archery before</fo:block>
                </fo:static-content>
                <!-- content footer-->
                <fo:static-content flow-name="xsl-region-after">
                    <!-- content in fo:block -->
                    <fo:block>Archery after</fo:block>
                </fo:static-content>
                <fo:flow flow-name="xsl-region-body">
                    <fo:block></fo:block>
                </fo:flow>
            </fo:page-sequence>
            
            <!-- front page -->
            
            <fo:page-sequence master-reference="tournament">
                <fo:flow flow-name="xsl-region-body" font-family="sans-serif" font-size="30pt">
                    <fo:block>
                        <xsl:value-of select="@name"/>
                    </fo:block>
                </fo:flow>
            </fo:page-sequence>
            
            <xsl:apply-templates select="group"></xsl:apply-templates>
        </fo:root>
    </xsl:template>
    
    <xsl:template match="group">
        <fo:page-sequence master-reference="tournament">
            <fo:flow flow-name="xsl-region-body">
                <fo:block font-size ="20pt" font-weight="500">
                    <xsl:value-of select="concat(@name, ' ', id(@divison-id)/text(), ' ', id(@discipline-id))"/>
                </fo:block>
            </fo:flow>
        </fo:page-sequence>
    </xsl:template>
    
</xsl:stylesheet>