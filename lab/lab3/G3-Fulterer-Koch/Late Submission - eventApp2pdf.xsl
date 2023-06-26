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
                <fo:simple-page-master master-name="eventApp"
                    page-height="297.0mm" page-width="209.9mm"
                    margin-bottom="8mm" margin-left="25mm" margin-right="10mm" margin-top="10mm">
                    
                    <!-- the content will be placed into the region-body -->
                    <fo:region-body margin-bottom="28mm" margin-left="0mm" margin-right="44mm" margin-top="28mm"/>
                    
                    <!-- region-before is the page header -->
                    <fo:region-before extent="24pt" region-name="event-header"/>
                    
                    <!-- region-after is the page footer -->
                    <fo:region-after extent="24pt" region-name="event-footer"/>
                    
                </fo:simple-page-master>
            </fo:layout-master-set>
            <!--
            <fo:page-sequence master-reference="eventApp">
                <fo:table-of-contents>
                    <fo:table-of-contents-title>Table of Contents</fo:table-of-contents-title>
                    <fo:block>
                        <fo:bookmark tree="yes">
                            <fo:bookmark-title>Chapter 1: Introduction</fo:bookmark-title>
                            <fo:basic-link internal-destination="chapter1">Chapter 1</fo:basic-link>
                        </fo:bookmark>
                    </fo:block>
                    <fo:block>
                        <fo:bookmark tree="yes">
                            <fo:bookmark-title>Chapter 2: Methods</fo:bookmark-title>
                            <fo:basic-link internal-destination="chapter2">Chapter 2</fo:basic-link>
                        </fo:bookmark>
                    </fo:block>
                </fo:table-of-contents>
            </fo:page-sequence>
            -->
            
            <!-- Here comes the content.
      Printed content consists of one or more page-sequences. Each page-sequence starts on a new page. -->
            
            <!-- front page -->
            <fo:page-sequence master-reference="eventApp">
                <fo:flow flow-name="xsl-region-body" font-family="sans-serif" font-size="28pt">
                    <fo:block margin-top="40mm">
                        <xsl:value-of select="eventFinder/description"/>
                    </fo:block>
                </fo:flow>
            </fo:page-sequence>
            
            <!-- table of contents -->
            <fo:page-sequence master-reference="eventApp">
                <!-- place a page description into the page header -->
                <xsl:call-template name="header">
                    <xsl:with-param name="right" select="'Table of Contents'"/>
                </xsl:call-template>
                
                <!-- place the table of contents into region-body -->
                <fo:flow flow-name="xsl-region-body" font-family="Times" font-size="12pt">
                    <fo:block font-weight="bold" margin-top="40mm">Table of Contents</fo:block>
                    <fo:list-block space-before="24pt">
                        <xsl:apply-templates select="eventFinder/eventPlanner/event" mode="toc"/>
                    </fo:list-block>
                </fo:flow>
            </fo:page-sequence>
            
            <!-- events -->
            <xsl:apply-templates select="eventFinder/eventPlanner/event" mode="detail"/>
            
        </fo:root>
    </xsl:template>
    
    <!-- ...................... TABLE OF CONTENTS TEMPLATE ................... -->
    <xsl:template match="event" mode="toc">
        <fo:list-item>
            <fo:list-item-label>
                <fo:block><xsl:value-of select="position()"/>.</fo:block>
            </fo:list-item-label>
            <fo:list-item-body start-indent="4mm">
                <fo:block text-align-last="justify">
                    <xsl:value-of select="@name"/>
                    <fo:leader leader-pattern="dots"></fo:leader>
                    <fo:page-number-citation ref-id="{generate-id()}"/>
                </fo:block>
            </fo:list-item-body>
        </fo:list-item>
    </xsl:template>
    
    <!-- Events -->
    <xsl:template match="event" mode="detail" xml:space="preserve">
        <fo:page-sequence master-reference="eventApp">
            <xsl:call-template name="header">
                <xsl:with-param name="right" select="@name"/>
            </xsl:call-template>
            
            <fo:static-content flow-name="event-footer">
                <fo:block font-size="7pt" text-align="end">
                    page <fo:page-number/>
                </fo:block>
            </fo:static-content>
            
            <fo:flow flow-name="xsl-region-body" font-family="Times" font-size="9pt">
                <!-- Define the formatting for the element -->
                <fo:block font-size="14pt" font-weight="bold" id="{generate-id()}">
                    <!-- Content of the element -->
                    Event: <xsl:value-of select="@name"/>
                    <fo:block space-after="1em"/>
                </fo:block>
                <fo:block text-decoration="underline">
                    Establishment: <xsl:value-of select="id(@establishmentID)/@companyName"/>
                    <fo:block/>
                    Date: <xsl:value-of select="@date"/>
                </fo:block>
                <fo:block space-after="1em"/>
                <fo:block>
                    <fo:block/>
                    <xsl:value-of select="."/>
                    <fo:block space-after="12pt"/>
                </fo:block>
                <fo:block font-weight="bold">
                    Address:
                </fo:block>
                <fo:block>
                    <fo:table>
                        
                        <!-- Table Body -->
                        <fo:table-body>
                            <fo:table-row>
                                <fo:table-cell>
                                    <fo:block>Country</fo:block>
                                </fo:table-cell>
                                <fo:table-cell>
                                    <fo:block><xsl:value-of select="id(@locationID)/address/@country"/></fo:block>
                                </fo:table-cell>
                            </fo:table-row>
                            <fo:table-row>
                                <fo:table-cell>
                                    <fo:block>City</fo:block>
                                </fo:table-cell>
                                <fo:table-cell>
                                    <fo:block><xsl:value-of select="id(@locationID)/address/@city"/></fo:block>
                                </fo:table-cell>
                            </fo:table-row>
                            <fo:table-row>
                                <fo:table-cell>
                                    <fo:block>Street</fo:block>
                                </fo:table-cell>
                                <fo:table-cell>
                                    <fo:block><xsl:value-of select="id(@locationID)/address/@street"/></fo:block>
                                </fo:table-cell>
                            </fo:table-row>
                            <fo:table-row>
                                <fo:table-cell>
                                    <fo:block>Number</fo:block>
                                </fo:table-cell>
                                <fo:table-cell>
                                    <fo:block><xsl:value-of select="id(@locationID)/address/@number"/></fo:block>
                                </fo:table-cell>
                            </fo:table-row>
                        </fo:table-body>
                    </fo:table>
                </fo:block>
                <fo:block space-after="12pt"/>
                <xsl:variable name="eventRef" select="./@eventID"/>
                <fo:block font-weight="bold">
                    Tickets:
                </fo:block>
                <fo:block  font-size="10pt">
                    <xsl:for-each select="/eventFinder/plebeian">
                        <xsl:for-each select="ticket">
                            <xsl:if test="@eventID = $eventRef">
                                <fo:table>
                                    <!--
                                    <fo:table-header>
                                        <fo:table-row>
                                            <fo:table-cell>
                                                <fo:block font-weight="bold">Column 1</fo:block>
                                            </fo:table-cell>
                                            <fo:table-cell>
                                                <fo:block font-weight="bold">Column 2</fo:block>
                                            </fo:table-cell>
                                        </fo:table-row>
                                    </fo:table-header>
                                    -->
                                    
                                    <!-- Table Body -->
                                    <fo:table-body>
                                        <fo:table-row>
                                            <fo:table-cell>
                                                <fo:block>Ticket-ID:</fo:block>
                                            </fo:table-cell>
                                            <fo:table-cell>
                                                <fo:block><xsl:value-of select="@id"/></fo:block>
                                            </fo:table-cell>
                                        </fo:table-row>
                                        <fo:table-row>
                                            <fo:table-cell>
                                                <fo:block>First-name:</fo:block>
                                            </fo:table-cell>
                                            <fo:table-cell>
                                                <fo:block><xsl:value-of select="../@accountFName"/></fo:block>
                                            </fo:table-cell>
                                        </fo:table-row>
                                        <fo:table-row>
                                            <fo:table-cell>
                                                <fo:block>Last-name:</fo:block>
                                            </fo:table-cell>
                                            <fo:table-cell>
                                                <fo:block><xsl:value-of select="../@accountLName"/></fo:block>
                                            </fo:table-cell>
                                        </fo:table-row>
                                        <xsl:for-each select="../telephonenumber">
                                            <fo:table-row>
                                                <fo:table-cell>
                                                    <fo:block>Telephone-number:</fo:block>
                                                </fo:table-cell>
                                                <fo:table-cell>
                                                    <fo:block><xsl:value-of select="@number"/></fo:block>
                                                </fo:table-cell>
                                            </fo:table-row>
                                        </xsl:for-each>
                                        <xsl:for-each select="../email">
                                            <fo:table-row>
                                                <fo:table-cell>
                                                    <fo:block>Email:</fo:block>
                                                </fo:table-cell>
                                                <fo:table-cell>
                                                    <fo:block><xsl:value-of select="@email"/></fo:block>
                                                </fo:table-cell>
                                            </fo:table-row>
                                        </xsl:for-each>
                                        
                                        <xsl:for-each select="../bankaccount">
                                            <fo:table-row>
                                                <fo:table-cell>
                                                    <fo:block>Bankaccount:</fo:block>
                                                </fo:table-cell>
                                            </fo:table-row>
                                            <fo:table-row>
                                                <fo:table-cell>
                                                    <fo:block>Number:</fo:block>
                                                </fo:table-cell>
                                                <fo:table-cell>
                                                    <fo:block><xsl:value-of select="@number"/></fo:block>
                                                </fo:table-cell>
                                            </fo:table-row>
                                            <fo:table-row>
                                                <fo:table-cell>
                                                    <fo:block>CV:</fo:block>
                                                </fo:table-cell>
                                                <fo:table-cell>
                                                    <fo:block><xsl:value-of select="@cv"/></fo:block>
                                                </fo:table-cell>
                                            </fo:table-row>
                                        </xsl:for-each>
                                    </fo:table-body>
                                </fo:table>
                                <fo:block space-after="12pt"/>
                            </xsl:if>
                        </xsl:for-each>
                    </xsl:for-each>
                </fo:block>
                <fo:block space-after="12pt"/>
                <fo:block font-weight="bold">
                    Event Planner:
                </fo:block>block>
                <fo:block  font-size="10pt">
                    <fo:table>
                        <!--
                                    <fo:table-header>
                                        <fo:table-row>
                                            <fo:table-cell>
                                                <fo:block font-weight="bold">Column 1</fo:block>
                                            </fo:table-cell>
                                            <fo:table-cell>
                                                <fo:block font-weight="bold">Column 2</fo:block>
                                            </fo:table-cell>
                                        </fo:table-row>
                                    </fo:table-header>
                                    -->
                        
                        <!-- Table Body -->
                        <fo:table-body>
                            <fo:table-row>
                                <fo:table-cell>
                                    <fo:block>First-name:</fo:block>
                                </fo:table-cell>
                                <fo:table-cell>
                                    <fo:block><xsl:value-of select="../@accountFName"/></fo:block>
                                </fo:table-cell>
                            </fo:table-row>
                            <fo:table-row>
                                <fo:table-cell>
                                    <fo:block>Last-name:</fo:block>
                                </fo:table-cell>
                                <fo:table-cell>
                                    <fo:block><xsl:value-of select="../@accountLName"/></fo:block>
                                </fo:table-cell>
                            </fo:table-row>
                            <xsl:for-each select="../telephonenumber">
                                <fo:table-row>
                                    <fo:table-cell>
                                        <fo:block>Telephone-number:</fo:block>
                                    </fo:table-cell>
                                    <fo:table-cell>
                                        <fo:block><xsl:value-of select="@number"/></fo:block>
                                    </fo:table-cell>
                                </fo:table-row>
                            </xsl:for-each>
                            <xsl:for-each select="../email">
                                <fo:table-row>
                                    <fo:table-cell>
                                        <fo:block>Email:</fo:block>
                                    </fo:table-cell>
                                    <fo:table-cell>
                                        <fo:block><xsl:value-of select="@email"/></fo:block>
                                    </fo:table-cell>
                                </fo:table-row>
                            </xsl:for-each>
                            <xsl:for-each select="../bankaccount">
                                <fo:table-row>
                                    <fo:table-cell>
                                        <fo:block>Bankaccount:</fo:block>
                                    </fo:table-cell>
                                </fo:table-row>
                                <fo:table-row>
                                    <fo:table-cell>
                                        <fo:block>Number:</fo:block>
                                    </fo:table-cell>
                                    <fo:table-cell>
                                        <fo:block><xsl:value-of select="@number"/></fo:block>
                                    </fo:table-cell>
                                </fo:table-row>
                                <fo:table-row>
                                    <fo:table-cell>
                                        <fo:block>CV:</fo:block>
                                    </fo:table-cell>
                                    <fo:table-cell>
                                        <fo:block><xsl:value-of select="@cv"/></fo:block>
                                    </fo:table-cell>
                                </fo:table-row>
                            </xsl:for-each>
                        </fo:table-body>
                    </fo:table>
                </fo:block>
                <fo:block space-after="12pt"/>
                <fo:block space-after="12pt"/>
            </fo:flow>
        </fo:page-sequence>
    </xsl:template>
    
    <xsl:template name="header">
        <xsl:param name="right"/>
        <!-- page header: left: booklet title; left: recipe title -->
        <fo:static-content flow-name="event-header">
            <fo:block font-size="7pt" text-align-last="justify">
                <xsl:value-of select="/eventFinder/description"/>
                <fo:leader/>
                <xsl:value-of select="$right"/>
            </fo:block>
        </fo:static-content>        
    </xsl:template>
    
</xsl:stylesheet>