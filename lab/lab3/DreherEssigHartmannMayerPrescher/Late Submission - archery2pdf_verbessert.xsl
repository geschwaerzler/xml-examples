<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:fo="http://www.w3.org/1999/XSL/Format"
    exclude-result-prefixes="xs"
    version="2.0">
    
    <!-- ............................ ROOT TEMPLATE .......................... -->
    <xsl:template match=".">
        <fo:root>

            <!-- define the layout of the document -->
            <fo:layout-master-set>
                <!-- here we define the layout of pages. There might be differrent page masters with e.g. different margin settings -->
                <fo:simple-page-master master-name="archery-page" page-height="297.0mm"
                    page-width="209.9mm" margin-bottom="8mm" margin-left="25mm" margin-right="10mm"
                    margin-top="10mm">

                    <!-- the content will be placed into the region-body -->
                    <fo:region-body margin-bottom="28mm" margin-left="0mm" margin-right="44mm"
                        margin-top="20mm"/>

                    <fo:region-before extent="24pt" region-name="archery-header"/>

                    <fo:region-after extent="24pt" region-name="archery-footer"/>

                </fo:simple-page-master>
            </fo:layout-master-set>


            <!-- Here comes the content.
                 Printed content consists of one or more page-sequences. Each page-sequence starts on a new page. -->



            <!-- table of contents -->

            <fo:page-sequence master-reference="archery-page">
                <fo:flow flow-name="xsl-region-body" font-family="sans-serif" font-size="9pt">
                    <xsl:call-template name="headline">
                        <xsl:with-param name="text" select="'Table of Contents'"/>
                    </xsl:call-template>
                    <xsl:apply-templates select="/archery-contest" mode="table-of-contents"/>

                </fo:flow>
            </fo:page-sequence>

            <!-- archery pages -->

            <fo:page-sequence master-reference="archery-page">
                <xsl:call-template name="footer"/>
                <fo:flow flow-name="xsl-region-body" font-family="sans-serif" font-size="9pt">
                    <xsl:apply-templates select="." mode="scorecards"/>

                    <xsl:apply-templates select="." mode="participant-list"/>

                    <xsl:apply-templates select="." mode="categories"/>
                </fo:flow>
            </fo:page-sequence>

            <fo:page-sequence master-reference="archery-page">
                <xsl:call-template name="footer"/>
                <fo:flow flow-name="xsl-region-body" font-family="sans-serif" font-size="9pt">
                    <xsl:apply-templates select="." mode="locations"/>
                </fo:flow>
            </fo:page-sequence>

            <fo:page-sequence master-reference="archery-page">
                <xsl:call-template name="footer"/>
                <fo:flow flow-name="xsl-region-body" font-family="sans-serif" font-size="9pt">
                    <xsl:apply-templates select="." mode="schedules"/>--> </fo:flow>
            </fo:page-sequence>

        </fo:root>

        
    </xsl:template>

    <xsl:template name="headline">
        <xsl:param name="text"/>
        <xsl:param name="id"/>
      
        <fo:block margin-top="24pt" font-family="serif" font-weight="bold" font-size="14pt" id="{$id}" margin-bottom="3mm">
            <xsl:value-of select="$text"/>
        </fo:block>
        
    </xsl:template>
    <xsl:template name="footer">
        <fo:static-content flow-name="archery-footer">
            <fo:block text-align="right" font-size="7pt"> page <fo:page-number/>
            </fo:block>
        </fo:static-content>
    </xsl:template>
    
    <xsl:template match="/archery-contest" mode="table-of-contents">

        <fo:list-block>
            <fo:list-item>
                <fo:list-item-label end-indent="label-end()">
                    <fo:block>
                        <fo:inline>-</fo:inline>
                    </fo:block>
                </fo:list-item-label>
                <fo:list-item-body start-indent="body-start()"><fo:block text-align-last="justify">Scorecard <fo:leader leader-pattern="dots"/> 2</fo:block></fo:list-item-body>
            </fo:list-item>
            <fo:list-item>
                <fo:list-item-label end-indent="label-end()">
                    <fo:block>
                        <fo:inline>-</fo:inline>
                    </fo:block>
                </fo:list-item-label>
                <fo:list-item-body start-indent="body-start()"><fo:block text-align-last="justify">Participants <fo:leader leader-pattern="dots"/> 2</fo:block></fo:list-item-body>
            </fo:list-item>
            <fo:list-item>
                <fo:list-item-label end-indent="label-end()">
                    <fo:block>
                        <fo:inline>-</fo:inline>
                    </fo:block>
                </fo:list-item-label>
                <fo:list-item-body start-indent="body-start()"><fo:block text-align-last="justify">Categories <fo:leader leader-pattern="dots"/> 2</fo:block></fo:list-item-body>
            </fo:list-item>
            <fo:list-item>
                <fo:list-item-label end-indent="label-end()">
                    <fo:block>
                        <fo:inline>-</fo:inline>
                    </fo:block>
                </fo:list-item-label>
                <fo:list-item-body start-indent="body-start()"><fo:block text-align-last="justify">Locations and Courses <fo:leader leader-pattern="dots"/> 3</fo:block></fo:list-item-body>
            </fo:list-item>
            <fo:list-item>
                <fo:list-item-label end-indent="label-end()">
                    <fo:block>
                        <fo:inline>-</fo:inline>
                    </fo:block>
                </fo:list-item-label>
                <fo:list-item-body start-indent="body-start()"><fo:block text-align-last="justify">Schedules  <fo:leader leader-pattern="dots"/> 4</fo:block></fo:list-item-body>
            </fo:list-item>
        </fo:list-block>
        

    </xsl:template>
    
    
    <xsl:template match="/archery-contest" mode="scorecards">
   
                <xsl:call-template name="headline">
                    <xsl:with-param name="text" select="'Scorecards'"></xsl:with-param>
                </xsl:call-template>
        <fo:table border="solid" >
            <fo:table-header >
                <fo:table-row  background-color="#D5D4CB">
                    <fo:table-cell border="solid" padding="1mm" font-weight="bold"><fo:block>Value</fo:block></fo:table-cell>
                    <fo:table-cell border="solid" padding="1mm" font-weight="bold"><fo:block>Year</fo:block></fo:table-cell>
                    <fo:table-cell border="solid" padding="1mm" font-weight="bold"><fo:block>Participant</fo:block></fo:table-cell>
                </fo:table-row>
            </fo:table-header>
            <fo:table-body>

                <xsl:for-each select="scorecard">
                    <xsl:variable name="player" select="id(@participant-id)"/>
                    <fo:table-row>
                        <fo:table-cell border="solid" padding="1mm">
                            <fo:block>
                            <xsl:value-of select="value"/>
                            </fo:block>
                        </fo:table-cell >
                        <fo:table-cell border="solid" padding="1mm">
                            <fo:block>
                            <xsl:value-of select="year"/>
                            </fo:block>
                        </fo:table-cell >
                        <fo:table-cell border="solid" padding="1mm">
                            <fo:block>

                            <xsl:value-of
                                select="concat($player/first_name, ' ', $player/last_name)"/>
                            </fo:block>

                        </fo:table-cell>

                    </fo:table-row>
                </xsl:for-each>
            </fo:table-body>
        </fo:table>
                
    </xsl:template>
    
    <xsl:template match="/archery-contest"
        mode="participant-list">
 
                <xsl:call-template name="headline">
                    <xsl:with-param name="text" select="'Participants'"></xsl:with-param>
                </xsl:call-template>
        <fo:table>
            <fo:table-header background-color="#CFDCCF">
                <fo:table-row>
                    <fo:table-cell border="solid" padding="1mm" font-weight="bold"><fo:block>Vorname</fo:block></fo:table-cell>
                    <fo:table-cell border="solid" padding="1mm" font-weight="bold"><fo:block>Nachname</fo:block></fo:table-cell>
                    <fo:table-cell border="solid" padding="1mm" font-weight="bold"><fo:block>Alter</fo:block></fo:table-cell>
                    <fo:table-cell border="solid" padding="1mm" font-weight="bold"><fo:block>Geschlecht</fo:block></fo:table-cell>
                    <fo:table-cell border="solid" padding="1mm" font-weight="bold"><fo:block>Land</fo:block></fo:table-cell>
                </fo:table-row>
            </fo:table-header>
            <fo:table-body>
                
                <xsl:for-each select="participant">
                    <fo:table-row id="{@id}">
                        <fo:table-cell border="solid" padding="1mm">
                            <fo:block>
                            <xsl:value-of select="first_name" />
                            </fo:block>
                            
                        </fo:table-cell>
                        <fo:table-cell border="solid" padding="1mm">
                            <fo:block>
                            <xsl:value-of select="last_name" />
                            </fo:block>
                        </fo:table-cell>
                        <fo:table-cell border="solid" padding="1mm">
                            <fo:block>
                            <xsl:value-of select="age" />
                            </fo:block>
                        </fo:table-cell>
                        <fo:table-cell border="solid" padding="1mm">
                            <fo:block>
                            <xsl:value-of select="gender" />
                            </fo:block>
                        </fo:table-cell>
                        <fo:table-cell border="solid" padding="1mm">
                            <fo:block>
                            <xsl:value-of select="country" />
                            </fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                </xsl:for-each>
            </fo:table-body>
        </fo:table>
    </xsl:template>
    
    
    
    <xsl:template match="/archery-contest" mode="categories">
   
                <xsl:call-template name="headline">
                    <xsl:with-param name="text" select="'Categories'"></xsl:with-param>
                </xsl:call-template>
        <fo:table>
            <fo:table-header background-color="#BDCAC9">
                <fo:table-row>
                    <fo:table-cell border="solid" padding="1mm" font-weight="bold"><fo:block>Name</fo:block></fo:table-cell>
                    <fo:table-cell border="solid" padding="1mm" font-weight="bold"><fo:block>Description</fo:block></fo:table-cell>
                    <fo:table-cell border="solid" padding="1mm" font-weight="bold"><fo:block>Style</fo:block></fo:table-cell>
                </fo:table-row>
            </fo:table-header>
            
            <fo:table-body>
                <xsl:for-each select="category">
                    <fo:table-row id="{@id}">
                        <fo:table-cell border="solid" padding="1mm">
                            <fo:block>
                            <xsl:value-of select="name" />
                            </fo:block>
                        </fo:table-cell>
                        <fo:table-cell border="solid" padding="1mm">
                            <fo:block>
                            <xsl:value-of select="description" />
                            </fo:block>
                        </fo:table-cell>
                        <fo:table-cell border="solid" padding="1mm">
                            <fo:block>
                            <xsl:value-of select="style" />
                            </fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                </xsl:for-each>
                
            </fo:table-body>
            
            
        </fo:table>
        
        
    </xsl:template>
    
    
    <xsl:template match="/archery-contest" mode="locations">
 
                <xsl:call-template name="headline">
                    <xsl:with-param name="text" select="'Locations and Courses'"></xsl:with-param>
                </xsl:call-template>
        <fo:table>
            <fo:table-column column-width="20mm"/>
            <fo:table-column column-width="20mm"/>
            <fo:table-column column-width="30mm"/>
            <fo:table-column column-width="20mm"/>
            <fo:table-column column-width="30mm"/>
            <fo:table-column column-width="20mm"/>
            <fo:table-header background-color="#E8DFE8">
                <fo:table-row>
                    <fo:table-cell padding="1mm" font-weight="bold" border="solid" ><fo:block>Course Name</fo:block></fo:table-cell>
                    <fo:table-cell padding="1mm" font-weight="bold" border="solid" ><fo:block >Target Count</fo:block></fo:table-cell>
                    <fo:table-cell padding="1mm" font-weight="bold" border="solid" ><fo:block >Location Name</fo:block></fo:table-cell>
                    <fo:table-cell padding="1mm" font-weight="bold" border="solid" ><fo:block >Type</fo:block></fo:table-cell>
                    <fo:table-cell padding="1mm" font-weight="bold" border="solid" ><fo:block>Address</fo:block></fo:table-cell>
                    <fo:table-cell padding="1mm" font-weight="bold" border="solid" ><fo:block >Category ID</fo:block></fo:table-cell>
                </fo:table-row>
                
            </fo:table-header>
            <fo:table-body>
                <xsl:for-each select="course">
                    <xsl:for-each select="takes_place_at">
                        <xsl:variable name="location"
                            select="id(@location-id)"></xsl:variable>
                        
                        <fo:table-row>
                            <fo:table-cell border="solid" padding="1mm">
                                <fo:block><xsl:value-of select="../name"></xsl:value-of></fo:block>
                            </fo:table-cell>
                            <fo:table-cell border="solid" padding="1mm">
                                <fo:block><xsl:value-of select="../target_count"></xsl:value-of></fo:block>
                            </fo:table-cell>
                            <fo:table-cell border="solid" padding="1mm">
                                <fo:block><xsl:value-of select="$location/name"></xsl:value-of></fo:block>
                            </fo:table-cell>
                            <fo:table-cell border="solid" padding="1mm">
                                <fo:block><xsl:value-of select="$location/type"></xsl:value-of></fo:block>
                            </fo:table-cell>
                            <fo:table-cell border="solid" padding="1mm">
                                <fo:block><xsl:value-of select="$location/address"></xsl:value-of></fo:block>
                            </fo:table-cell>
                            <xsl:for-each select="../is_in_category">
                                <xsl:variable name="category"
                                    select="id(@category-id)"></xsl:variable>
                                <fo:table-cell border="solid" padding="1mm">
                                    <fo:block>
                                    <xsl:value-of select="$category/name"></xsl:value-of>
                                    </fo:block>
                                </fo:table-cell>
                            </xsl:for-each>
                        </fo:table-row>
                        
                    </xsl:for-each>
                </xsl:for-each>
                
                
            </fo:table-body>
        </fo:table>
    </xsl:template>
    
    <xsl:template match="/archery-contest" mode="schedules">
 
                <xsl:call-template name="headline">
                    <xsl:with-param name="text" select="'Schedule'"></xsl:with-param>
                </xsl:call-template>
        <xsl:for-each select="schedule">
            <xsl:variable name="course" select="id(@course-id)"></xsl:variable>
            <fo:block>
                Date:
                <xsl:value-of select="concat(date/day,'.')"></xsl:value-of>
                <xsl:value-of select="concat(date/month, '.')"></xsl:value-of>
                <xsl:value-of select="concat(date/year, ' ')"></xsl:value-of>
                
                <xsl:value-of select="start_time"></xsl:value-of>
                <fo:block>
                Course:
                <xsl:value-of select="$course/name"></xsl:value-of>
                </fo:block>
            </fo:block>
            <fo:block margin-top="5mm">
                Participants:
                <fo:list-block border-bottom-style="solid" margin-bottom="3mm" padding-after="3mm">
                    <xsl:for-each select="participates">
                        <xsl:variable name="participant"
                            select="id(@participant-id)"></xsl:variable>
                        
                        <fo:list-item>
                            <fo:list-item-label end-indent="label-end()" >
                                <fo:block>-</fo:block>
                            </fo:list-item-label>
                            <fo:list-item-body start-indent="body-start()"><fo:block>
                                
                                <xsl:value-of
                                    select="concat($participant/first_name, ' ')"></xsl:value-of>
                                
                                <xsl:value-of select="$participant/last_name"></xsl:value-of>
                                
                            </fo:block>
                            </fo:list-item-body>
                            

                        </fo:list-item>
                        
                    </xsl:for-each>
                </fo:list-block>
                <hr></hr>
            </fo:block>
        </xsl:for-each>
    </xsl:template>
    
    
</xsl:stylesheet>