<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format">
    <xsl:output method="xml" indent="yes"/>
    
    <!-- Inhaltsverzeichnis -->
    <xsl:template match="/club">
        <fo:root>
            <fo:layout-master-set>
                <!-- Define page layout -->
                <fo:simple-page-master master-name="content-page" page-height="297.0mm" page-width="209.9mm"
                    margin-bottom="8mm" margin-left="25mm" margin-right="10mm" margin-top="10mm">
                    <fo:region-body margin-bottom="28mm" margin-left="0mm" margin-right="44mm" margin-top="20mm"/>
                    
                    <!-- region-before is the page header -->
                    <fo:region-before extent="24pt" region-name="club-header"/>
                    
                    <!-- region-after is the page footer -->
                    <fo:region-after extent="24pt" region-name="club-footer"/>
                    
                </fo:simple-page-master>
            </fo:layout-master-set>
            
            <fo:page-sequence master-reference="content-page">
                <fo:flow flow-name="xsl-region-body">
                    
                    <fo:block font-size="36pt" text-align="center" font-weight="bold" margin-top="100mm">FC EGG</fo:block>
                    
                    <fo:block font-size="14pt" margin-top="20mm">
                        <xsl:apply-templates select="//member"/>
                    </fo:block>
                </fo:flow>
            </fo:page-sequence>
            
            <!-- table of contents -->
            <fo:page-sequence master-reference="content-page">
                <!-- place a page description into the page header -->
                <xsl:call-template name="header">
                    <xsl:with-param name="right" select="'Inhaltsverzeichnis'"/>
                </xsl:call-template>
                
                <!-- place the table of contents into region-body -->
                <fo:flow flow-name="xsl-region-body" font-family="Times" font-size="14pt">
                    <fo:block font-weight="bold" margin-top="40mm" margin-bottom="10mm" font-size="20pt">Inhaltsverzeichnis</fo:block>
                    <fo:list-block>
                        <fo:list-item>
                            <fo:list-item-label>
                                <fo:block>1.</fo:block>
                            </fo:list-item-label>
                            <fo:list-item-body start-indent="5mm">
                                <fo:block text-align-last="justify">
                                    Vorstand
                                    <fo:leader leader-pattern="dots"></fo:leader>
                                    <fo:page-number-citation ref-id="vorstand"/>
                                </fo:block>
                            </fo:list-item-body>
                        </fo:list-item>
                        <fo:list-item>
                            <fo:list-item-label>
                                <fo:block>2.</fo:block>
                            </fo:list-item-label>
                            <fo:list-item-body start-indent="5mm">
                                <fo:block text-align-last="justify">
                                    Manager
                                    <fo:leader leader-pattern="dots"></fo:leader>
                                    <fo:page-number-citation ref-id="manager"/>
                                </fo:block>
                            </fo:list-item-body>
                        </fo:list-item>
                        <fo:list-item>
                            <fo:list-item-label>
                                <fo:block>3.</fo:block>
                            </fo:list-item-label>
                            <fo:list-item-body start-indent="5mm">
                                <fo:block text-align-last="justify">
                                    Trainer
                                    <fo:leader leader-pattern="dots"></fo:leader>
                                    <fo:page-number-citation ref-id="trainer"/>
                                </fo:block>
                            </fo:list-item-body>
                        </fo:list-item>
                        <fo:list-item>
                            <fo:list-item-label>
                                <fo:block>4.</fo:block>
                            </fo:list-item-label>
                            <fo:list-item-body start-indent="5mm">
                                <fo:block text-align-last="justify">
                                    Betreuer
                                    <fo:leader leader-pattern="dots"></fo:leader>
                                    <fo:page-number-citation ref-id="supervisor"/>
                                </fo:block>
                            </fo:list-item-body>
                        </fo:list-item>
                        <fo:list-item>
                            <fo:list-item-label>
                                <fo:block>5.</fo:block>
                            </fo:list-item-label>
                            <fo:list-item-body start-indent="5mm">
                                <fo:block text-align-last="justify">
                                    Mannschaft
                                    <fo:leader leader-pattern="dots"></fo:leader>
                                    <fo:page-number-citation ref-id="player"/>
                                </fo:block>
                            </fo:list-item-body>
                        </fo:list-item>
                        <fo:list-item>
                            <fo:list-item-label>
                                <fo:block>6.</fo:block>
                            </fo:list-item-label>
                            <fo:list-item-body start-indent="5mm">
                                <fo:block text-align-last="justify">
                                    Mitglieder
                                    <fo:leader leader-pattern="dots"></fo:leader>
                                    <fo:page-number-citation ref-id="member"/>
                                </fo:block>
                            </fo:list-item-body>
                        </fo:list-item>
                    </fo:list-block>

                </fo:flow>
            </fo:page-sequence>
            
            <fo:page-sequence master-reference="content-page">
                <xsl:call-template name="header">
                    <xsl:with-param name="right" select="'Vorstand, Manager, Trainer, Betreuer'"/>
                </xsl:call-template>
                
                <fo:static-content flow-name="club-footer">
                    <fo:block font-size="7pt" text-align="end">
                        Seite <fo:page-number/>
                    </fo:block>
                </fo:static-content>
                
                <!-- Vorstand -->
                <fo:flow flow-name="xsl-region-body">
                    <xsl:call-template name="h2">
                        <xsl:with-param name="headline">Vorstand</xsl:with-param>
                    </xsl:call-template>
                    <fo:block id="vorstand">
                        <xsl:apply-templates select="boardofdirectors" mode="board"/>
                    </fo:block>
                    
                    <!-- Manager -->
                    <xsl:call-template name="h2">
                        <xsl:with-param name="headline">Manager</xsl:with-param>
                    </xsl:call-template>
                    <fo:block id="manager">
                        <xsl:apply-templates select="team" mode="manager"/>
                    </fo:block>
                    
                    <!-- Trainer -->
                    <xsl:call-template name="h2">
                        <xsl:with-param name="headline">Trainer</xsl:with-param>
                    </xsl:call-template>
                    <fo:block id="trainer">
                        <xsl:apply-templates select="team" mode="trainer"/>
                    </fo:block>
                    
                    <!-- Betreuer -->
                    <xsl:call-template name="h2">
                        <xsl:with-param name="headline">Betreuer</xsl:with-param>
                    </xsl:call-template>
                    <fo:block id="supervisor">
                        <xsl:apply-templates select="team" mode="supervisor"/>
                    </fo:block>
                    
                </fo:flow>
                
            </fo:page-sequence>

            <!-- Spieler -->
            <fo:page-sequence master-reference="content-page">
                <xsl:call-template name="header">
                    <xsl:with-param name="right" select="'Mannschaft'"/>
                </xsl:call-template>
                
                <fo:static-content flow-name="club-footer">
                    <fo:block font-size="7pt" text-align="end">
                        Seite <fo:page-number/>
                    </fo:block>
                </fo:static-content>
                
                <fo:flow flow-name="xsl-region-body">
                    <xsl:call-template name="h2">
                        <xsl:with-param name="headline">Mannschaft</xsl:with-param>
                    </xsl:call-template> 
                    <fo:block id="player">
                        <xsl:apply-templates select="team" mode="player"/>
                    </fo:block>
                </fo:flow>
            </fo:page-sequence>
            
            <!-- Mitglieder -->
            <fo:page-sequence master-reference="content-page">
                <xsl:call-template name="header">
                    <xsl:with-param name="right" select="'Mitglieder'"/>
                </xsl:call-template>
                
                <fo:static-content flow-name="club-footer">
                    <fo:block font-size="7pt" text-align="end">
                        Seite <fo:page-number/>
                    </fo:block>
                </fo:static-content>
                
                <fo:flow flow-name="xsl-region-body">
                    <xsl:call-template name="h2">
                        <xsl:with-param name="headline">Mitglieder</xsl:with-param>
                    </xsl:call-template> 
                    <fo:block id="member">
                        <xsl:apply-templates select="." mode="member"/>
                    </fo:block>
                </fo:flow>
            </fo:page-sequence>
            
        </fo:root>
        
    </xsl:template>
    
    <xsl:template name="header">
        <xsl:param name="right"/>
        <!-- page header: left: booklet title; left: recipe title -->
        <fo:static-content flow-name="club-header">
            <fo:block font-size="7pt" text-align-last="justify">
                FC Egg
                <fo:leader/>
                <xsl:value-of select="$right"/>
            </fo:block>
        </fo:static-content>        
    </xsl:template>
    
    <!-- Vorstand Template -->
    <xsl:template match="boardofdirectors" mode="board">
        <xsl:for-each select="member">
            <xsl:sort select="@firstname"/>
            <fo:list-block>
                <fo:list-item margin-bottom="5mm">
                    <fo:list-item-label>
                        <fo:block>- </fo:block>
                    </fo:list-item-label>
                    <fo:list-item-body>
                        <fo:block start-indent="5mm">
                            <xsl:value-of select="@firstname"></xsl:value-of> <xsl:text> </xsl:text> <xsl:value-of select="@lastname"></xsl:value-of>
                            (Mitgliedseintrag Seite <fo:page-number-citation ref-id="{@memberid}"/>)
                        </fo:block>
                        
                    </fo:list-item-body>
                </fo:list-item>
            </fo:list-block>
            
        </xsl:for-each>
    </xsl:template>
    
    <!-- Manager Template -->
    <xsl:template match="team" mode="manager">
        <xsl:for-each select="manager">
            <xsl:sort select="member/@firstname"/>
            <fo:list-block>
                <fo:list-item margin-bottom="5mm">
                    <fo:list-item-label>
                        <fo:block>- </fo:block>
                    </fo:list-item-label>
                    <fo:list-item-body>
                        <fo:block start-indent="5mm">
                            <xsl:value-of select="member/@firstname"></xsl:value-of> <xsl:text> </xsl:text> <xsl:value-of select="member/@lastname"></xsl:value-of>
                            (Mitgliedseintrag Seite <fo:page-number-citation ref-id="{member/@memberid}"/>)
                        </fo:block>
                        <fo:block margin-left="5mm">
                            Salary: <xsl:value-of select="@salary"></xsl:value-of> Euro
                        </fo:block>
                    </fo:list-item-body>
                </fo:list-item>
            </fo:list-block>
        </xsl:for-each>
    </xsl:template>
    
    <!-- Trainer Template -->
    <xsl:template match="team" mode="trainer">
        <xsl:for-each select="trainer">
            <xsl:sort select="member/@firstname"/>
            <fo:list-block>
                <fo:list-item margin-bottom="5mm">
                    <fo:list-item-label>
                        <fo:block>- </fo:block>
                    </fo:list-item-label>
                    <fo:list-item-body>
                        <fo:block start-indent="5mm">
                            <xsl:value-of select="member/@firstname"></xsl:value-of> <xsl:text> </xsl:text> <xsl:value-of select="member/@lastname"></xsl:value-of>
                            (Mitgliedseintrag Seite <fo:page-number-citation ref-id="{member/@memberid}"/>)
                        </fo:block>
                        <fo:block margin-left="5mm">
                            Salary: <xsl:value-of select="@salary"></xsl:value-of> Euro
                        </fo:block>
                    </fo:list-item-body>
                </fo:list-item>
            </fo:list-block>
        </xsl:for-each>
    </xsl:template>	
    
    <!-- Betreuer Template -->
    <xsl:template match="team" mode="supervisor">
        <xsl:for-each select="supervisor">
            <xsl:sort select="member/@firstname"/>
            <fo:list-block>
                <fo:list-item margin-bottom="5mm">
                    <fo:list-item-label>
                        <fo:block>- </fo:block>
                    </fo:list-item-label>
                    <fo:list-item-body>
                        <fo:block start-indent="5mm">
                            <xsl:value-of select="member/@firstname"></xsl:value-of> <xsl:text> </xsl:text> <xsl:value-of select="member/@lastname"></xsl:value-of>
                            (Mitgliedseintrag Seite <fo:page-number-citation ref-id="{member/@memberid}"/>)
                        </fo:block>
                        <fo:block margin-left="5mm">
                            Salary: <xsl:value-of select="@salary"></xsl:value-of> Euro
                        </fo:block>
                    </fo:list-item-body>
                </fo:list-item>
            </fo:list-block>
        </xsl:for-each>
    </xsl:template>	
    
    <!-- Mannschaft Template -->
    <xsl:template match="team" mode="player">
        <xsl:for-each select="player">
            <xsl:sort select="member/@firstname"/>
            <fo:list-block>
                <fo:list-item margin-bottom="5mm">
                    <fo:list-item-label>
                        <fo:block>- </fo:block>
                    </fo:list-item-label>
                    <fo:list-item-body>
                        <fo:block start-indent="5mm">
                            <xsl:value-of select="member/@firstname"></xsl:value-of> <xsl:text> </xsl:text> <xsl:value-of select="member/@lastname"></xsl:value-of>
                            (Mitgliedseintrag Seite <fo:page-number-citation ref-id="{member/@memberid}"/>)
                        </fo:block>
                        <fo:block margin-left="5mm">
                            Status: <xsl:value-of select="@status"></xsl:value-of>
                        </fo:block>
                        <fo:block margin-left="5mm">
                            Salary: <xsl:value-of select="@salary"></xsl:value-of> Euro
                        </fo:block>
                        <fo:block margin-left="5mm">
                            Position: <xsl:value-of select="@position"></xsl:value-of>
                        </fo:block>
                        <fo:block margin-left="5mm">
                            Tore: <xsl:value-of select="statistic/@goal"></xsl:value-of>
                        </fo:block>
                        <fo:block margin-left="5mm">
                            Gelbe Karten: <xsl:value-of select="statistic/@yellowcard"></xsl:value-of>
                        </fo:block>
                        <fo:block margin-left="5mm">
                            Rote Karten: <xsl:value-of select="statistic/@redcard"></xsl:value-of>
                        </fo:block>
                        <fo:block margin-left="5mm">
                            Fauls: <xsl:value-of select="statistic/@foul"></xsl:value-of>
                        </fo:block>
                        <fo:block margin-left="5mm">
                            Zweikampfstärke: <xsl:value-of select="statistic/@duelstrength"></xsl:value-of>
                        </fo:block>
                        <fo:block margin-left="5mm">
                            Distanz pro Match: <xsl:value-of select="statistic/@distancepermatch"></xsl:value-of>
                        </fo:block>
                    </fo:list-item-body>
                </fo:list-item>
            </fo:list-block>
        </xsl:for-each>
    </xsl:template>
    
    <!-- Mitglieder Template -->
    <xsl:template match="club" mode="member">
        <xsl:for-each select="//member">
            <xsl:sort select="@firstname"/>
            <fo:list-block>
                <fo:list-item margin-bottom="5mm">
                    <fo:list-item-label>
                        <fo:block>- </fo:block>
                    </fo:list-item-label>
                    <fo:list-item-body>
                        <fo:block start-indent="5mm" id="{@memberid}">
                            <xsl:value-of select="@firstname"></xsl:value-of> <xsl:text> </xsl:text> <xsl:value-of select="@lastname"></xsl:value-of>
                        </fo:block>
                        <fo:block margin-left="5mm">
                            ID: <xsl:value-of select="@memberid"></xsl:value-of>
                        </fo:block>
                        <fo:block margin-left="5mm">
                            Geburtstag: <xsl:value-of select="@birthdate"></xsl:value-of>
                        </fo:block>
                        <fo:block margin-left="5mm">
                            Addresse: <xsl:value-of select="address/@city"></xsl:value-of>, <xsl:value-of select="address/@street"></xsl:value-of>, <xsl:value-of select="address/@housenumber"></xsl:value-of>, Stockwerk: <xsl:value-of select="address/@floor"></xsl:value-of>
                        </fo:block>
                        <fo:block margin-left="5mm">
                            Telefonnummer: <xsl:value-of select="contact/@phonenumber"></xsl:value-of>
                        </fo:block>
                        <fo:block margin-left="5mm">
                            Email-Adresse: <xsl:value-of select="contact/@email"></xsl:value-of>
                        </fo:block>
                        <fo:block margin-left="5mm">
                            Mitgliedsbeitrag: <xsl:value-of select="membershipfee/@billnumber"></xsl:value-of>
                        </fo:block>
                    </fo:list-item-body>
                </fo:list-item>
            </fo:list-block>
        </xsl:for-each>
    </xsl:template>
    
    <!-- h2 -->
    <xsl:template name="h2">
        <xsl:param name="headline"/>
        <!-- headline 2 -->
        <fo:block font-size="14pt" font-weight="400" margin-bottom="10mm" margin-top="10mm" text-align="center">
            <xsl:value-of select="$headline"/>
        </fo:block>
    </xsl:template>
    
</xsl:stylesheet>