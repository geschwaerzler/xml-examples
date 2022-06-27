<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fo="http://www.w3.org/1999/XSL/Format">


    <xsl:key name="divisions" match="division" use="@id"/>
    <xsl:key name="disciplines" match="discipline" use="@id"/>
    <xsl:key name="archers" match="archer" use="@id"/>
    <xsl:key name="targets" match="target" use="concat(@id,@name)"/>
    <xsl:key name="points-of-member" match="point" use="concat(@pID,@pname)"/>
    <xsl:key name="groups-of-discipline" match="group" use="@discipline-id"/>

    <xsl:attribute-set name="title1">
        <xsl:attribute name="font-size">36pt</xsl:attribute>
        <xsl:attribute name="space-after">16px</xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="title2">
        <xsl:attribute name="font-size">26pt</xsl:attribute>
        <xsl:attribute name="space-after">10px</xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="title3">
        <xsl:attribute name="font-size">20pt</xsl:attribute>
        <xsl:attribute name="space-after">6px</xsl:attribute>
    </xsl:attribute-set>

    <xsl:template match="/bow-tournament">
        <fo:root font-family="sans-serif" font-size="9pt">

            <fo:layout-master-set>
             
                <fo:simple-page-master master-name="page"
                                       page-height="297.0mm" page-width="209.9mm"
                                       margin-bottom="8mm" margin-left="25mm" margin-right="10mm" margin-top="10mm">

          
                    <fo:region-body margin-bottom="28mm" margin-left="0mm" margin-right="44mm" margin-top="20mm"/>

                    <fo:region-before extent="24pt" region-name="header"/>
                    <fo:region-after extent="24pt" region-name="footer"/>

                </fo:simple-page-master>
            </fo:layout-master-set>


            <fo:page-sequence master-reference="page">
                <fo:flow flow-name="xsl-region-body" font-size="28pt">
                    <fo:block margin-top="40mm">
                        BOW TOURNAMENT 2022
                    </fo:block>
                </fo:flow>
            </fo:page-sequence>

            <fo:page-sequence master-reference="page">
 
                <xsl:call-template name="header">
                    <xsl:with-param name="right" select="'Table of Contents'"/>
                </xsl:call-template>

   
                <fo:flow flow-name="xsl-region-body">
                    <fo:block xsl:use-attribute-sets="title1">
                        Table of Contents
                    </fo:block>
                    <fo:list-block>
                        <xsl:apply-templates select="discipline" mode="toc"/>
                    </fo:list-block>
                </fo:flow>
            </fo:page-sequence>

            <xsl:apply-templates select="discipline" mode="content"/>
        </fo:root>
    </xsl:template>

    <xsl:template name="header">
        <xsl:param name="right"/>
        <fo:static-content flow-name="header">
            <fo:block font-size="7pt" text-align-last="justify">
                <xsl:value-of select="/bow-tournament/@name"/>
                <fo:leader/>
                <xsl:value-of select="$right"/>
            </fo:block>
        </fo:static-content>
    </xsl:template>

    <xsl:template name="footer">
        <fo:static-content flow-name="footer">
            <fo:block font-size="7pt" text-align="end">
                page
                <fo:page-number/>
            </fo:block>
        </fo:static-content>
    </xsl:template>


    <xsl:template match="discipline" mode="content">
        <xsl:variable name="dsc" select="."/>
        <xsl:variable name="grp" select="key('groups-of-discipline',$dsc/@id)"/>

        <xsl:if test="$grp">
            <xsl:for-each select="$grp">
                <fo:page-sequence master-reference="page">
                    <xsl:call-template name="header">
                        <xsl:with-param name="right" select="$dsc"/>
                    </xsl:call-template>
                    <xsl:call-template name="footer"/>

                    <fo:flow flow-name="xsl-region-body">
                        <xsl:if test="position()=1">
                         
                            <fo:block xsl:use-attribute-sets="title1" id="{generate-id($dsc)}">
                                <xsl:value-of select="$dsc"/>
                            </fo:block>
                        </xsl:if>
                     
                        <xsl:apply-templates select="."/>
                    </fo:flow>
                </fo:page-sequence>
            </xsl:for-each>
        </xsl:if>
    </xsl:template>

    <xsl:variable name="label-offset" select="4"/>
    <xsl:template name="list-label">
        <fo:list-item-label>
            <fo:block>&#8226;</fo:block>
        </fo:list-item-label>
    </xsl:template>

    <xsl:template match="discipline" mode="toc">
        <xsl:variable name="dsc" select="."/>
        <xsl:variable name="grp" select="key('groups-of-discipline',$dsc/@id)"/>

        <xsl:if test="$grp">
            <xsl:call-template name="list-entry">
                <xsl:with-param name="text" select="$dsc"/>
                <xsl:with-param name="destination" select="generate-id($dsc)"/>
            </xsl:call-template>

            <xsl:value-of select="@name"/>
            <xsl:for-each select="$grp">
                <xsl:call-template name="list-entry">
                    <xsl:with-param name="text" select="@name"/>
                    <xsl:with-param name="destination" select="generate-id(.)"/>
                    <xsl:with-param name="level" select="1"/>
                </xsl:call-template>
            </xsl:for-each>
        </xsl:if>
    </xsl:template>

    <xsl:variable name="level-offset" select="'8'"/>
    <xsl:template name="list-entry">
        <xsl:param name="level" select="0"/>
        <xsl:param name="text"/>
        <xsl:param name="destination"/>

        <fo:list-item start-indent="{($level-offset*$level)}mm">
            <xsl:call-template name="list-label"/>
            <fo:list-item-body start-indent="{$label-offset+($level-offset*$level)}mm">
                <fo:block text-align-last="justify">
                    <fo:basic-link internal-destination="{$destination}">
                        <xsl:value-of select="$text"/>
                        <fo:leader leader-pattern="dots"/>
                        <fo:page-number-citation ref-id="{$destination}"/>
                    </fo:basic-link>
                </fo:block>
            </fo:list-item-body>
        </fo:list-item>
    </xsl:template>

    
    <xsl:template match="group">
        <xsl:variable name="g" select="."/>
        <fo:block xsl:use-attribute-sets="title2" id="{generate-id($g)}">
            <xsl:value-of select="$g/@name"/>
        </fo:block>

        <fo:block space-after="20px">
            <fo:block>
                <xsl:value-of select="key('divisions',@division-id)"/>
            </fo:block>
            <fo:block>
                <xsl:value-of select="key('disciplines',@discipline-id)"/>
            </fo:block>
        </fo:block>

        
        <fo:block>
            <fo:block xsl:use-attribute-sets="title3">Members</fo:block>
            <fo:table>
                <fo:table-column column-width="1in"/>
                <fo:table-column column-width="0.5in"/>

                <fo:table-body>
                    <xsl:for-each select="member">
                        <xsl:sort select="key('archers',@archer-id)/lastname" order="ascending"/>
                        <xsl:variable name="a" select="key('archers',@archer-id)"/>
                        <xsl:variable name="score-set"
                            select="score/arrow/@points"/>

                        <xsl:variable name="total-score">
                   
                                    <xsl:value-of select="sum(score/arrow/@points)"/>
                            
                        </xsl:variable>
                          
                        <fo:table-row>
                            <fo:table-cell>
                                <fo:block>
                                    <xsl:apply-templates select="$a" mode="name"/>
                                </fo:block>
                            </fo:table-cell>
                            <fo:table-cell>
                                <fo:block>
                                    (<fo:basic-link internal-destination="{generate-id(.)}">
                                        <xsl:value-of select="$total-score"/>
                                    </fo:basic-link>)
                                
                                </fo:block>
                               
                            </fo:table-cell>
                        </fo:table-row>
                    </xsl:for-each>
                </fo:table-body>
            </fo:table>
        </fo:block>

    </xsl:template>

    <xsl:template match="archer" mode="name" xml:space="preserve">
        <fo:inline white-space="pre">
            <xsl:value-of select="firstname"/>
            <xsl:value-of select="lastname"/>
        </fo:inline>
    </xsl:template>

</xsl:stylesheet>