<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:fo="http://www.w3.org/1999/XSL/Format"
    exclude-result-prefixes="xs"
    version="2.0">
    
    <xsl:template match="/music_database">
        <fo:root>
            <fo:layout-master-set>
                <fo:simple-page-master master-name="music_page">
                    <fo:region-body margin="28mm" region-name="region-body"/>
                    <fo:region-before extent="24pt" region-name="region-header"/>
                    <fo:region-after extent="24pt" region-name="region-footer"/>
                </fo:simple-page-master>
            </fo:layout-master-set>      
          <!--Inhaltsverzeichnis-->
           <fo:page-sequence master-reference="music_page">
               <xsl:call-template name="header_and_footer"/>  
               <fo:flow flow-name="region-body">   
                   <fo:block font-weight="bold" font-size="16pt" font-style="italic">Music-Datenbanken</fo:block>
                   <fo:block font-weight="bold"  font-size="12pt" font-style="italic">Meine-Alben</fo:block>
                   <fo:block>
                        <xsl:apply-templates select="album" mode="get_title"/>
                   </fo:block>
               </fo:flow>
           </fo:page-sequence>
          <!--Ein Album pro Seite-->
           <xsl:apply-templates select="album" mode="get_details"/>
          <!--Song auflistung-->
           <xsl:apply-templates select="genre" mode="get_genres"/>
        </fo:root>
    </xsl:template>
    
    <xsl:template match="album" mode="get_title">
        <fo:list-block>
            <fo:list-item>
                 <fo:list-item-label>
                     <fo:block>*</fo:block>
                 </fo:list-item-label>
                 <fo:list-item-body start-indent="4mm">
                     <fo:block text-align-last="justify">
                         <xsl:value-of select="@album_name"/>
                         <fo:leader leader-pattern="dots"></fo:leader>
                         <fo:page-number-citation ref-id="{generate-id()}"/>
                     </fo:block>
                 </fo:list-item-body>
            </fo:list-item>
        </fo:list-block>
    </xsl:template>

    <xsl:template match="album" mode="get_details">
        <fo:page-sequence master-reference="music_page">
            <xsl:call-template name="header_and_footer"/>  
            <fo:flow flow-name="region-body">
                <!--Albumname-->
                <fo:block ref-id="{@album_id}" font-weight="bold" font-size="14pt" id="{generate-id()}">
                     <xsl:value-of select="@album_name"/> 
                </fo:block>
                <xsl:variable name="m" select="id(@musician_id)"/>
                <!--Albumbesitzer-->
                <fo:block margin-top="1mm">
                     <xsl:choose>
                         <xsl:when test="$m/@artist_name != ''">
                             <xsl:value-of select="$m/@artist_name"/>
                         </xsl:when>
                         <xsl:otherwise>
                             <xsl:value-of select="$m/@first_name"/>
                             <xsl:text> </xsl:text>
                             <xsl:value-of select="$m/@last_name"/>
                         </xsl:otherwise>
                     </xsl:choose>
                </fo:block>
                <!--Songs-->
                <xsl:for-each select="contains">
                    <fo:list-block>
                        <fo:list-item>
                            <!--Index-->
                            <fo:list-item-label>
                                <fo:block><xsl:value-of select="position()"/>.</fo:block>
                            </fo:list-item-label>
                            <fo:list-item-body start-indent="6mm">
                                <xsl:variable name="s" select="id(@song_id)"/>
                                <fo:block><xsl:value-of select="$s/@title"/></fo:block>                    
                                <fo:block start-indent="10mm">* Vocalist:
                                    <xsl:for-each select="$s/sings_song">
                                        <xsl:variable name="p" select="id(@person_id)"/>
                                        <xsl:choose>
                                            <xsl:when test="$p/@artist_name != ''">
                                                <fo:block start-indent="20mm">
                                                    <xsl:value-of select="$p/@artist_name"/>
                                                </fo:block>
                                            </xsl:when>
                                            <xsl:otherwise>
                                                <fo:block start-indent="20mm">
                                                    <xsl:value-of select="$p/@first_name"/>
                                                    <xsl:text> </xsl:text>
                                                    <xsl:value-of select="$p/@last_name"/>
                                                </fo:block>
                                            </xsl:otherwise>
                                        </xsl:choose>
                                    </xsl:for-each>
                                </fo:block>
                                <fo:block start-indent="10mm">* Writer:
                                   <xsl:for-each select="$s/writes_song">
                                       <xsl:variable name="p" select="id(@person_id)"/>
                                       <xsl:choose>
                                           <xsl:when test="$p/@artist_name != ''">
                                               <fo:block start-indent="20mm">
                                                    <xsl:value-of select="$p/@artist_name"/>
                                               </fo:block>
                                           </xsl:when>
                                           <xsl:otherwise>
                                               <fo:block start-indent="20mm">
                                                     <xsl:value-of select="$p/@first_name"/>
                                                     <xsl:text> </xsl:text>
                                                     <xsl:value-of select="$p/@last_name"/>
                                               </fo:block>
                                           </xsl:otherwise>
                                       </xsl:choose>
                                   </xsl:for-each>
                                </fo:block>
                                <fo:block start-indent="10mm">* Dauer:		
                                    <a>Dauer: </a>
                                    <xsl:value-of select="$s/@duration"/>
                                    <a> Sekunden </a>
                                </fo:block>	
                                <fo:block start-indent="10mm">* Erscheinungsjahr:	
                                    <xsl:value-of select="$s/@release_date"/>
                                </fo:block>   
                                <fo:block>&#x00A0;</fo:block>
                            </fo:list-item-body>
                        </fo:list-item>
                    </fo:list-block>
                </xsl:for-each>        
            </fo:flow>
      </fo:page-sequence>
    </xsl:template> 

    <xsl:template match="genre" mode="get_genres">
        <fo:page-sequence master-reference="music_page">            
            <xsl:call-template name="header_and_footer"/>          
            <fo:flow flow-name="region-body">
                <fo:block font-weight="bold" font-size="14pt">
                    <xsl:value-of select="@name"/>
                </fo:block>
                <xsl:for-each select="has">				
                    <xsl:variable name="sid" select="@song_id"/>
                    <xsl:variable name="s" select="id(@song_id)"/>
                    <fo:block start-indent="4mm">*
                        <xsl:value-of select="$s/@title"/>
                    </fo:block>
                    <xsl:for-each select="//album[contains/@song_id = $sid]">
                       <fo:list-block>
                           <fo:list-item>
                               <fo:list-item-label start-indent="8mm">
                                   <fo:block>-</fo:block>
                               </fo:list-item-label>
                               <fo:list-item-body>
                                   <fo:block text-align-last="justify" start-indent="10mm">
                                       <xsl:value-of select="@album_name"/>
                                       <fo:leader leader-pattern="dots"></fo:leader>
                                       <fo:page-number-citation ref-id="{generate-id()}"/>
                                   </fo:block>
                               </fo:list-item-body>
                           </fo:list-item>
                       </fo:list-block>
                    </xsl:for-each>										
                </xsl:for-each>	
            </fo:flow>
        </fo:page-sequence>
    </xsl:template>

    <xsl:template name="header_and_footer">
        <fo:static-content flow-name="region-header">
            <fo:block text-align="end" margin-right="5mm" margin-top="5mm">XMLlab3</fo:block>
            <fo:block margin-left="5mm" margin-top="-5mm">Muhammed Güzel, Efza Yildirim, Cindy Cebastian, Melih Sahin</fo:block>
        </fo:static-content>
        <fo:static-content flow-name="region-footer">
            <fo:block font-size="10pt" text-align="end" margin-right="5mm">page
                <fo:page-number/>
            </fo:block>
        </fo:static-content>
    </xsl:template>
</xsl:stylesheet>