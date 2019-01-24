<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format">
    
    <!-- ............................ ROOT TEMPLATE .......................... -->
    <xsl:template match="/">
        <fo:root>
            
            
        <fo:layout-master-set>
            <fo:simple-page-master master-name="a4page">
                <fo:region-body margin="2cm"/>
            </fo:simple-page-master>
        </fo:layout-master-set>
        
        <fo:page-sequence master-reference="a4page" font-family="Times" font-size="15pt">
            <fo:flow flow-name="xsl-region-body">
                <fo:block font-size="40pt" font-weight="bold">
                    LVBMK
                </fo:block>
                
                <fo:block>
                    
                    <fo:table border-width="1" border-style="solid">
                        <fo:table-header>
                            <fo:table-row font-weight="bold" font-size="25pt">
                                <fo:table-cell><fo:block>Inhalt</fo:block></fo:table-cell>
                            </fo:table-row>
                        </fo:table-header>
                        
   
                            <fo:table-body>
                                <fo:table-row>
                                    <fo:table-cell>
                                        <fo:block>
                                            <fo:basic-link internal-destination="PersonenPage">
                                                Personen
                                            </fo:basic-link>
                                        </fo:block>
                                    </fo:table-cell>
                                </fo:table-row>
                                
                                <fo:table-row>
                                    <fo:table-cell>
                                        <fo:block>
                                            <fo:basic-link internal-destination="VereinsPage">
                                                Vereine
                                            </fo:basic-link>
                                        </fo:block>
                                    </fo:table-cell>
                                </fo:table-row>
                                
                                <fo:table-row>
                                    <fo:table-cell>
                                        <fo:block>
                                            <fo:basic-link internal-destination="VereinsZugehoerPage">
                                                Vereinszugehörigkeit
                                            </fo:basic-link>
                                        </fo:block>
                                    </fo:table-cell>
                                </fo:table-row>
                                
                                <fo:table-row>
                                    <fo:table-cell>
                                        <fo:block>
                                            <fo:basic-link internal-destination="PreiskatPage">
                                                Preiskategorie
                                            </fo:basic-link>
                                        </fo:block>
                                    </fo:table-cell>
                                </fo:table-row>
                                
                                <fo:table-row>
                                    <fo:table-cell>
                                        <fo:block>
                                            <fo:basic-link internal-destination="ArtikelPage">
                                                Artikel
                                            </fo:basic-link>
                                        </fo:block>
                                    </fo:table-cell>
                                </fo:table-row>
                                
                                <fo:table-row>
                                    <fo:table-cell>
                                        <fo:block>
                                            <fo:basic-link internal-destination="VorgangsPage">
                                                Vorgänge
                                            </fo:basic-link>
                                        </fo:block>
                                    </fo:table-cell>
                                </fo:table-row>
                                
                                <fo:table-row>
                                    <fo:table-cell>
                                        <fo:block>
                                            <fo:basic-link internal-destination="VorgangPersonPage">
                                                Vorgänge pro Person
                                            </fo:basic-link>
                                        </fo:block>
                                    </fo:table-cell>
                                </fo:table-row>
                            </fo:table-body>
                        
                    </fo:table>
                </fo:block> 
                
            </fo:flow>
        </fo:page-sequence>
            
        <fo:page-sequence master-reference="a4page" font-family="Times" font-size="8pt">
                <fo:flow flow-name="xsl-region-body">
                    <fo:block font-size="30pt" font-weight="bold" id="PersonenPage">
                        Personen
                    </fo:block> 
                    
                    <fo:block>
                   
                        <fo:table>
                            <fo:table-header>
                                <fo:table-row font-weight="bold">
                                    <fo:table-cell><fo:block>Vorname</fo:block></fo:table-cell>
                                    <fo:table-cell><fo:block>Nachname</fo:block></fo:table-cell>
                                    <fo:table-cell><fo:block>Geburtsdatum</fo:block></fo:table-cell>
                                    <fo:table-cell><fo:block>PLZ</fo:block></fo:table-cell>
                                    <fo:table-cell><fo:block>Strasse</fo:block></fo:table-cell>
                                    <fo:table-cell><fo:block>Nr</fo:block></fo:table-cell>
                                    <fo:table-cell><fo:block>Tel.</fo:block></fo:table-cell>
                                    <fo:table-cell><fo:block>Email</fo:block></fo:table-cell>
                                </fo:table-row>
                            </fo:table-header>
                            
                            <xsl:for-each select="LVBMK/Person">
                            <fo:table-body>
                                <fo:table-row>
                                    <fo:table-cell><fo:block id="{@pers_id}"><xsl:value-of select="@vname"/></fo:block></fo:table-cell>
                                    <fo:table-cell><fo:block><xsl:value-of select="@nname"/></fo:block></fo:table-cell>
                                    <fo:table-cell><fo:block><xsl:value-of select="@geburtsdatum"/></fo:block></fo:table-cell>
                                    <fo:table-cell><fo:block><xsl:value-of select="Adresse/@plz"/></fo:block></fo:table-cell>       
                                    <fo:table-cell><fo:block><xsl:value-of select="Adresse/@strasse"/></fo:block></fo:table-cell>
                                    <fo:table-cell><fo:block><xsl:value-of select="Adresse/@strassennr"/></fo:block></fo:table-cell>
                                    <fo:table-cell><fo:block><xsl:value-of select="@telefon_nr"/></fo:block></fo:table-cell>
                                    <fo:table-cell><fo:block><xsl:value-of select="@email"/></fo:block></fo:table-cell>
                                </fo:table-row>
                            </fo:table-body>
                            </xsl:for-each>
                        </fo:table>
                    </fo:block> 
                   
                </fo:flow>    
            </fo:page-sequence>
            
            <fo:page-sequence master-reference="a4page" font-family="Times" font-size="8pt">
                <fo:flow flow-name="xsl-region-body">
                    <fo:block font-size="30pt" font-weight="bold" id="VereinsPage">
                        Vereine
                    </fo:block> 
                    
                    <fo:block>
                        
                        <fo:table>
                            <fo:table-header>
                                <fo:table-row font-weight="bold">
                                    <fo:table-cell><fo:block>Name</fo:block></fo:table-cell>
                                    <fo:table-cell><fo:block>PLZ</fo:block></fo:table-cell>
                                    <fo:table-cell><fo:block>Land</fo:block></fo:table-cell>
                                    <fo:table-cell><fo:block>Strasse</fo:block></fo:table-cell>
                                    <fo:table-cell><fo:block>Nr</fo:block></fo:table-cell>
                                </fo:table-row>
                            </fo:table-header>
                            
                            <xsl:for-each select="LVBMK/Verein">
                                <fo:table-body>
                                    <fo:table-row>
                                    <fo:table-cell><fo:block id="{@zvr}"><xsl:value-of select="@vereinsname"/></fo:block></fo:table-cell>
                                    <fo:table-cell><fo:block><xsl:value-of select="Adresse/@plz"/></fo:block></fo:table-cell>
                                    <fo:table-cell><fo:block><xsl:value-of select="Adresse/@land"/></fo:block></fo:table-cell>        
                                    <fo:table-cell><fo:block><xsl:value-of select="Adresse/@strasse"/></fo:block></fo:table-cell>
                                    <fo:table-cell><fo:block><xsl:value-of select="Adresse/@strassennr"/></fo:block></fo:table-cell>
                                        
                                    </fo:table-row>
                                </fo:table-body>
                            </xsl:for-each>
                        </fo:table>
                        
                    </fo:block> 
                    
                </fo:flow>
            </fo:page-sequence>
            
            <fo:page-sequence master-reference="a4page" font-family="Times" font-size="8pt">
                <fo:flow flow-name="xsl-region-body">
                    <fo:block font-size="30pt" font-weight="bold" id="VereinsZugehoerPage">
                        Vereinszugehörigkeit
                    </fo:block> 
                    
                    <fo:block>
                        <xsl:for-each select="LVBMK/Person[Ist_In]">
                            <fo:block><xsl:value-of select="concat(@vname, ' ', @nname)"/></fo:block>
                            
                            <xsl:for-each select="//Verein[@zvr = current()/Ist_In/@zvr]">
                            <fo:list-block>
                                <fo:list-item>
                                    <fo:list-item-label>
                                        <fo:block>
                                            <fo:inline font-family="Symbol">+</fo:inline>
                                        </fo:block>
                                    </fo:list-item-label>
                                    <fo:list-item-body start-indent="body-start()">
                                        <fo:block>
                                            <xsl:value-of select="@vereinsname"/>
                                        </fo:block>
                                    </fo:list-item-body>
                                </fo:list-item>
                            </fo:list-block>
                            </xsl:for-each>
                                
                            
                         
   
                        </xsl:for-each>
                        
                    </fo:block> 
                    
                </fo:flow>
            </fo:page-sequence>
            
            
            
            <fo:page-sequence master-reference="a4page" font-family="Times" font-size="8pt">
                <fo:flow flow-name="xsl-region-body">
                    <fo:block font-size="30pt" font-weight="bold" id="PreiskatPage">
                        Preiskategorien
                    </fo:block> 
                    
                    <fo:block>
                        
                        <fo:table>
                            <fo:table-header>
                                <fo:table-row font-weight="bold">
                                    <fo:table-cell><fo:block>Bezeichnung</fo:block></fo:table-cell>
                                    <fo:table-cell><fo:block>Preis</fo:block></fo:table-cell>
                                </fo:table-row>
                            </fo:table-header>
                            
                            <xsl:for-each select="LVBMK/Preiskategorie">
                                <fo:table-body>
                                    <fo:table-row>
                                        <fo:table-cell><fo:block id="{@pkat_id}"><xsl:value-of select="@bezeichnung"/></fo:block></fo:table-cell>
                                        <fo:table-cell><fo:block><xsl:value-of select="concat(@preis, '€')"/></fo:block></fo:table-cell>
                                    </fo:table-row>
                                </fo:table-body>
                            </xsl:for-each>
                        </fo:table>
                        
                    </fo:block> 
                    
                </fo:flow>
            </fo:page-sequence>
            
            <fo:page-sequence master-reference="a4page" font-family="Times" font-size="8pt">
                <fo:flow flow-name="xsl-region-body">
                    <fo:block font-size="30pt" font-weight="bold" id="ArtikelPage">
                        Artikel
                    </fo:block> 
                    
                    <fo:block>
                        
                        <fo:table>
                            <fo:table-header>
                                <fo:table-row font-weight="bold">
                                    <fo:table-cell><fo:block>Bezeichnung</fo:block></fo:table-cell>
                                    <fo:table-cell><fo:block>Hersteller</fo:block></fo:table-cell>
                                    <fo:table-cell><fo:block>Kaufpreis</fo:block></fo:table-cell>
                                    <fo:table-cell><fo:block>Kaufdatum</fo:block></fo:table-cell>
                                    <fo:table-cell><fo:block>Seriennummer</fo:block></fo:table-cell>
                                </fo:table-row>
                            </fo:table-header>
                            
                            <xsl:for-each select="LVBMK/Artikel">
                                <fo:table-body>
                                    <fo:table-row>
                                        <fo:table-cell><fo:block id="{@artikel_id}"><xsl:value-of select="@bezeichnung"/></fo:block></fo:table-cell>
                                        <fo:table-cell><fo:block><xsl:value-of select="@hersteller"/></fo:block></fo:table-cell>
                                        <fo:table-cell><fo:block><xsl:value-of select="@kaufpreis"/></fo:block></fo:table-cell>        
                                        <fo:table-cell><fo:block><xsl:value-of select="@kaufdatum"/></fo:block></fo:table-cell>
                                        <fo:table-cell><fo:block><xsl:value-of select="Equipment/@seriennummer | Bekleidung/@seriennummer"/></fo:block></fo:table-cell>
                                    </fo:table-row>
                                </fo:table-body>
                            </xsl:for-each>
                        </fo:table>
                        
                    </fo:block> 
                    
                </fo:flow>
            </fo:page-sequence>
            
            
            <fo:page-sequence master-reference="a4page" font-family="Times" font-size="8pt">
                <fo:flow flow-name="xsl-region-body">
                    <fo:block font-size="30pt" font-weight="bold" id="VorgangsPage">
                        Alle Vorgänge
                    </fo:block> 
                    
                    <fo:block>
                        
                        <fo:table>
                            <fo:table-header>
                                <fo:table-row font-weight="bold">
                                    <fo:table-cell><fo:block>Bezeichnung</fo:block></fo:table-cell>
                                    <fo:table-cell><fo:block>Artikel</fo:block></fo:table-cell>
                                    <fo:table-cell><fo:block>Seriennr</fo:block></fo:table-cell>
                                    <fo:table-cell><fo:block>Preis</fo:block></fo:table-cell>
                                    <fo:table-cell><fo:block>Person</fo:block></fo:table-cell>
                                    <fo:table-cell><fo:block>StartDatum</fo:block></fo:table-cell>
                                    <fo:table-cell><fo:block>EndDatum</fo:block></fo:table-cell>
                                    <fo:table-cell><fo:block>Kommentar</fo:block></fo:table-cell>
                                </fo:table-row>
                            </fo:table-header>
                            
                            <xsl:for-each select="LVBMK/Vorgang">
                                <fo:table-body>
                                    <fo:table-row>
                                        <fo:table-cell><fo:block id="{@vorgang_id}"><xsl:value-of select="@bezeichnung"/></fo:block></fo:table-cell>
                                        <fo:table-cell>
                                            <fo:block>
                                                <fo:basic-link internal-destination="{@artikel_id}">
                                                    <xsl:value-of select="//Artikel[@artikel_id = current()/@artikel_id]/@bezeichnung"/>
                                                </fo:basic-link>
                                            </fo:block>
                                        </fo:table-cell>
                                        <fo:table-cell>
                                            <fo:block>
                                                <fo:basic-link internal-destination="{@artikel_id}">
                                                    <xsl:value-of select="//Artikel[@artikel_id = current()/@artikel_id]/Equipment/@seriennummer | //Artikel[@artikel_id = current()/@artikel_id]/Bekleidung/@seriennummer"/>
                                                </fo:basic-link>
                                            </fo:block>
                                        </fo:table-cell>
                                        <fo:table-cell>
                                            <fo:block>
                                                <fo:basic-link internal-destination="{@pkat_id}">
                                                    <xsl:value-of select="concat(//Preiskategorie[@pkat_id = current()/@pkat_id]/@preis, '€')"/>
                                                </fo:basic-link>
                                                
                                            </fo:block>
                                        </fo:table-cell>
                                        <fo:table-cell>
                                            <fo:block>
                                                <fo:basic-link internal-destination="{@pers_id}">
                                                    <xsl:value-of select="concat(//Person[@pers_id = current()/@pers_id]/@vname, ' ', //Person[@pers_id = current()/@pers_id]/@nname)"/>
                                                </fo:basic-link>
                                                
                                            </fo:block>
                                        </fo:table-cell>
                                        <fo:table-cell>
                                            <fo:block><xsl:value-of select="@startdatum"/></fo:block>
                                        </fo:table-cell>
                                        <fo:table-cell>
                                            <fo:block><xsl:value-of select="@enddatum"/></fo:block>
                                        </fo:table-cell>
                                        <fo:table-cell>
                                            <fo:block><xsl:value-of select="@kommentar"/></fo:block>
                                        </fo:table-cell>
                                    </fo:table-row>
                                </fo:table-body>
                            </xsl:for-each>
                        </fo:table>
                        
                    </fo:block> 
                    
                </fo:flow>
            </fo:page-sequence>


            <fo:page-sequence master-reference="a4page" font-family="Times" font-size="8pt">
                <fo:flow flow-name="xsl-region-body">
                    <fo:block font-size="30pt" font-weight="bold" id="VorgangPersonPage">
                        Vorgänge pro Person
                    </fo:block> 
                    
                    <fo:block>
                        <xsl:for-each select="LVBMK/Person">
                            
                            <fo:block font-size="8pt" font-weight="bold">
                                <fo:basic-link internal-destination="{@pers_id}">
                                    <xsl:value-of select="concat(@vname, ' ', @nname)"/>
                                </fo:basic-link>
                            </fo:block>
                            <fo:table border-width="1" border-style="solid">
                                <fo:table-header>
                                    <fo:table-row font-weight="bold">
                                        <fo:table-cell><fo:block>Bezeichnung</fo:block></fo:table-cell>
                                        <fo:table-cell><fo:block>Artikel</fo:block></fo:table-cell>
                                        <fo:table-cell><fo:block>Seriennr</fo:block></fo:table-cell>
                                        <fo:table-cell><fo:block>Preis</fo:block></fo:table-cell>
                                        <fo:table-cell><fo:block>StartDatum</fo:block></fo:table-cell>
                                        <fo:table-cell><fo:block>EndDatum</fo:block></fo:table-cell>
                                        <fo:table-cell><fo:block>Kommentar</fo:block></fo:table-cell>
                                    </fo:table-row>
                                </fo:table-header>
                                
                          
                                    <fo:table-body>
                                        <fo:table-row>
                                            <fo:table-cell><fo:block></fo:block>
                                            </fo:table-cell>   
                                        </fo:table-row>
                                        
                                        <xsl:for-each select="/LVBMK/Vorgang[@pers_id = current()/@pers_id]">
                                        <fo:table-row>
                                            <fo:table-cell>
                                                <fo:block><xsl:value-of select="@bezeichnung"/></fo:block>
                                            </fo:table-cell>
                                            <fo:table-cell>
                                                <fo:block>
                                                <fo:basic-link internal-destination="{@artikel_id}">
                                                    <xsl:value-of select="//Artikel[@artikel_id = current()/@artikel_id]/@bezeichnung"/>
                                                </fo:basic-link>
                                                </fo:block>
                                            </fo:table-cell>
                                            <fo:table-cell>
                                                <fo:block>
                                                    <fo:basic-link internal-destination="{@artikel_id}">
                                                        <xsl:value-of select="//Artikel[@artikel_id = current()/@artikel_id]/Equipment/@seriennummer | //Artikel[@artikel_id = current()/@artikel_id]/Bekleidung/@seriennummer"/>
                                                    </fo:basic-link>
                                                </fo:block>
                                            </fo:table-cell>
                                            
                                            <fo:table-cell>
                                                <fo:block>
                                                    <fo:basic-link internal-destination="{@pkat_id}">
                                                        <xsl:value-of select="concat(//Preiskategorie[@pkat_id = current()/@pkat_id]/@preis, '€')"/>
                                                    </fo:basic-link>
                                                    
                                                </fo:block>
                                            </fo:table-cell>
                    
                                            <fo:table-cell>
                                                <fo:block><xsl:value-of select="@startdatum"/></fo:block>
                                            </fo:table-cell>
                                            <fo:table-cell>
                                                <fo:block><xsl:value-of select="@enddatum"/></fo:block>
                                            </fo:table-cell>
                                            <fo:table-cell>
                                                <fo:block><xsl:value-of select="@kommentar"/></fo:block>
                                            </fo:table-cell>
                         
                        
                                        </fo:table-row>
                                        </xsl:for-each>
                                    </fo:table-body>
                                
                            </fo:table>
                            
                            
                            
                            
                            
                            
                        </xsl:for-each>
                    </fo:block> 
                    
                </fo:flow>
            </fo:page-sequence>
            
            
            
        </fo:root>
    </xsl:template>
</xsl:stylesheet>