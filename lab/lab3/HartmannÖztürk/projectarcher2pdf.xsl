<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/1999/XMLSchema"
    xmlns:fo="http://www.w3.org/1999/XSL/Format"
    exclude-result-prefixes="xs"
    version="2.0">
    <xsl:template name="generate-footer">
        <fo:static-content flow-name="archer-footer">
            <fo:block font-size="12" text-align="end">
                Page <fo:page-number/>
            </fo:block>
        </fo:static-content>    
    </xsl:template>
    
    <xsl:template name="generate-header">
        <xsl:param name="title-right"/>
        <fo:static-content flow-name="archer-header">
            <fo:block font-size="12" text-align-last="justify">
                <xsl:value-of select="/project-archer/description"/>
                <fo:leader/>
                <xsl:value-of select="$title-right"/>
            </fo:block>
        </fo:static-content>    
    </xsl:template>

    <xsl:template match="/project-archer">
        <fo:root>       
            <!-- define the layout of the document -->
            <fo:layout-master-set>
                <!-- here we define the layout of pages. There might be differrent page masters with e.g. different margin settings -->
                <fo:simple-page-master master-name="archer-page"
                    page-height="297.0mm" page-width="209.9mm"
                    margin-bottom="8mm" margin-left="25mm" margin-right="10mm" margin-top="10mm">
                    
                    <!-- the content will be placed into the region-body -->
                    <fo:region-body margin-bottom="28mm" margin-left="0mm" margin-right="44mm" margin-top="40mm"/>
                    
                    <!-- Page Header -->
                    <fo:region-before extent="24pt" region-name="archer-header"/>
                    
                    <!-- Page Footer -->
                    <fo:region-after extent="24pt" region-name="archer-footer"/>
                  
                    
                </fo:simple-page-master>
            </fo:layout-master-set>
            <!-- Here comes the content.
                 Printed content consists of one or more page-sequences. Each page-sequence starts on a new page. -->
            
            <!-- front page -->
            <fo:page-sequence master-reference="archer-page">
                <fo:flow flow-name="xsl-region-body" font-family="sans-serif" font-size="28pt">
                    <fo:block>
                        <xsl:value-of select="description/text()"/>
                    </fo:block>                  
                    <fo:block  linefeed-treatment="preserve" font-style = "italic" font-size = "12pt" margin-top = "5pt">
                        By the legendary Benjamin Hartmann and Mert Öztürk  
                        Computer Science - Software and Information Engineering
                        WS 2020/21, 3rd Semester
                    </fo:block>
             
                    <fo:block>
                        <fo:external-graphic src = "url('wfac_bild.jpg')" content-width="62%"/>                      
                    </fo:block>
                             
                </fo:flow>
            </fo:page-sequence> 
            <!-- Archer-Page -->
            <fo:page-sequence master-reference="archer-page">
                
                <xsl:call-template name="generate-header">
                    <xsl:with-param name="title-right" select="'Table of Contents'"/>
                </xsl:call-template>           
                <fo:flow flow-name="xsl-region-body" font-family="Times" font-size="12pt">
                    <fo:block font-size="28pt" font-weight="700">Table of Contents</fo:block>
                    
                    <fo:list-block margin-top="24pt">
                        
                        <fo:list-item>
                            <fo:list-item-label>
                                <fo:block>1.</fo:block>                                
                            </fo:list-item-label>
                            <fo:list-item-body start-indent="4mm">
                                <fo:block text-align-last="justify">
                                    Teams
                                    <fo:leader leader-pattern="dots"></fo:leader>
                                    <fo:page-number-citation ref-id="teams"/>
                                </fo:block>
                                <!-- inner list begin-->
                                     <fo:list-block margin-top="5pt">
                                         <xsl:for-each select="team">
                                            <fo:list-item>
                                                <fo:list-item-label>
                                                    <fo:block>1.<xsl:value-of select="position()"/></fo:block>
                                                </fo:list-item-label>
                                                <fo:list-item-body start-indent="8mm">
                                                    <fo:block margin-left="8pt" text-align-last="justify">
                                                        Team #<xsl:value-of select="substring-after(@id, '-')"/>
                                                        <fo:leader leader-pattern="dots"></fo:leader>
                                                        <fo:page-number-citation ref-id="team-{generate-id()}"/>
                                                    </fo:block>
                                                </fo:list-item-body>
                                            </fo:list-item>
                                         
                                         </xsl:for-each>
                                     </fo:list-block>
                                <!-- inner list end-->
                            </fo:list-item-body>                            
                        </fo:list-item>
                        
                        <fo:list-item margin-top="7pt">
                            <fo:list-item-label>
                                <fo:block>2.</fo:block>                                
                            </fo:list-item-label>
                            <fo:list-item-body start-indent="4mm">
                                <fo:block text-align-last="justify">                                   
                                    Stations
                                    <fo:leader leader-pattern="dots"></fo:leader>
                                    <fo:page-number-citation ref-id="stations"/>
                                </fo:block>
                                   <!-- inner list begin-->
                                   <fo:list-block margin-top="5pt">
                                       <xsl:for-each select="station">
                                           <fo:list-item>
                                               <fo:list-item-label>
                                                   <fo:block>2.<xsl:value-of select="position()"/></fo:block>
                                               </fo:list-item-label>
                                               <fo:list-item-body start-indent="8mm">
                                                   <fo:block margin-left="8pt" text-align-last="justify">
                                                       Station #<xsl:value-of select="substring-after(@id, '-')"/>
                                                       <fo:leader leader-pattern="dots"></fo:leader>
                                                       <fo:page-number-citation ref-id="station-{generate-id()}"/>
                                                   </fo:block>
                                               </fo:list-item-body>
                                           </fo:list-item>
                                           
                                       </xsl:for-each>
                                   </fo:list-block>
                                   <!-- inner list end-->
                            </fo:list-item-body>
                        </fo:list-item>
                        
                        <fo:list-item margin-top="7pt">
                            <fo:list-item-label>
                                <fo:block>3.</fo:block>                                
                            </fo:list-item-label>
                            <fo:list-item-body start-indent="4mm">
                                <fo:block text-align-last="justify">
                                    Rounds
                                    <fo:leader leader-pattern="dots"></fo:leader>
                                    <fo:page-number-citation ref-id="rounds"/>
                                </fo:block>
                                      <!-- inner list begin-->
                                      <fo:list-block margin-top="5pt">
                                          <xsl:for-each select="round">
                                              <fo:list-item>
                                                  <fo:list-item-label>
                                                      <fo:block>3.<xsl:value-of select="position()"/></fo:block>
                                                  </fo:list-item-label>
                                                  <fo:list-item-body start-indent="8mm">
                                                      <fo:block margin-left="8pt" text-align-last="justify">
                                                          Round #<xsl:value-of select="substring-after(@id, '-')"/>
                                                          <fo:leader leader-pattern="dots"></fo:leader>
                                                          <fo:page-number-citation ref-id="round-{generate-id()}"/>
                                                      </fo:block>
                                                  </fo:list-item-body>
                                              </fo:list-item>
                                              
                                          </xsl:for-each>
                                      </fo:list-block>
                                      <!-- inner list end-->           
                            </fo:list-item-body>
                        </fo:list-item>
                    </fo:list-block>
                </fo:flow>
            </fo:page-sequence>
            
            <!-- Page Teams -->          
            <fo:page-sequence master-reference="archer-page">
                <xsl:call-template name="generate-header">
                    <xsl:with-param name="title-right" select="'Teams'"/>
                </xsl:call-template>
                <xsl:call-template name="generate-footer"/>
                <fo:flow flow-name="xsl-region-body" font-family="Times" font-size="12pt">
                    <fo:block font-size="28pt" font-weight="700" id = "teams">Teams</fo:block>
                        <xsl:apply-templates select="team"/>
                </fo:flow>
            </fo:page-sequence>
            
            <!-- Page Stations -->
            <fo:page-sequence master-reference="archer-page">
                <xsl:call-template name="generate-header">
                    <xsl:with-param name="title-right" select="'Stations'"/>
                </xsl:call-template>
                <xsl:call-template name="generate-footer"/>
                <fo:flow flow-name="xsl-region-body" font-family="Times" font-size="12pt">
                    <fo:block font-size="28pt" font-weight="700"  id = "stations">Stations</fo:block>
                    <xsl:apply-templates select="station"/>
                </fo:flow>
            </fo:page-sequence>
            
            <!-- Page Rounds -->
            <fo:page-sequence master-reference="archer-page">
                <xsl:call-template name="generate-header">
                    <xsl:with-param name="title-right" select="'Rounds'"/>
                </xsl:call-template>
                <xsl:call-template name="generate-footer"/>
                <fo:flow flow-name="xsl-region-body" font-family="Times" font-size="12pt">
                    <fo:block font-size="28pt" font-weight="700"  id = "rounds">Rounds</fo:block>
                    <xsl:apply-templates select="round"/>
                </fo:flow>
            </fo:page-sequence>              
        </fo:root>
    </xsl:template>
    
    <!-- TEMPLATE TEAM -->
    <xsl:template match="team">
        <fo:block id="team-{generate-id()}" font-size="18pt" font-weight="500" margin-bottom="7pt" margin-top="24pt" font-style="italic">Team #<xsl:value-of select="substring-after(@id, '-')"/></fo:block>
        <fo:block font-size="12pt">Team-Leader: <xsl:value-of select="concat(id(@leader_id)/@fname, ' ', id(@leader_id)/@lname)"/></fo:block>
            <fo:list-block start-indent="4mm" margin-top="5pt">
                <xsl:for-each select="team_member">
                    <fo:list-item>
                        <fo:list-item-label>
                            <fo:block>&#x2022;</fo:block>
                        </fo:list-item-label>
                        <fo:list-item-body>
                            <fo:block margin-left="8pt"> <xsl:value-of select="concat(id(@id)/@fname, ' ', id(@id)/@lname)"/></fo:block>
                        </fo:list-item-body>
                    </fo:list-item>
                 </xsl:for-each>
            </fo:list-block>
        <fo:block font-size="12pt" margin-top="7pt">Responsible for Station:</fo:block>
            <xsl:variable name="t" select="@id"/>
            <fo:list-block start-indent="4mm" margin-top="5pt">
                <xsl:for-each select="../station[responsible_for/@id=$t]">
                   <fo:list-item>
                       <fo:list-item-label>
                           <fo:block>&#x2022;</fo:block>
                       </fo:list-item-label>
                       <fo:list-item-body>
                           <fo:block margin-left="8pt">Station <xsl:value-of select="substring-after(@id, '-')"/></fo:block>
                       </fo:list-item-body>
                   </fo:list-item>
            </xsl:for-each>
            </fo:list-block>   
    </xsl:template>
    
    <!-- TEMPLATE STATION -->
    <xsl:template match = "station">
        <fo:block id="station-{generate-id()}" font-size="18pt" font-weight="500" margin-bottom="7pt" margin-top="24pt" font-style="italic">Station #<xsl:value-of select="substring-after(@id, '-')"/></fo:block>
        <fo:block font-size="12pt">Located at: <xsl:value-of select="concat(@position_ns, ',   ', @position_we)"/></fo:block>
               
        <fo:block font-size="12pt" margin-top="7pt">Targets at Station:</fo:block>
        <fo:list-block start-indent="4mm" margin-top="5pt">
            <xsl:for-each select="position_at">
                <fo:list-item>
                    <fo:list-item-label>
                        <fo:block>&#x2022;</fo:block>
                    </fo:list-item-label>
                    <fo:list-item-body>
                        <fo:block margin-left="8pt">Target - <xsl:value-of select="substring-after(@id, '-')"/></fo:block>
                    </fo:list-item-body>
                </fo:list-item>
            </xsl:for-each>
        </fo:list-block> 
    
    </xsl:template>
    
    <!-- TEMPLATE ROUND -->
    <xsl:template match="round">
        <fo:block id="round-{generate-id()}" font-size="18pt" font-weight="500" margin-bottom="7pt" margin-top="24pt" font-style="italic">Round #<xsl:value-of select="substring-after(@id, '-')"/></fo:block>
        <fo:block font-size="12pt">Date: <xsl:value-of select="@day"/></fo:block> 
        
        <xsl:for-each select="standard_unit">
            <fo:table border = "1 solid black" text-align="center" margin-top="16pt" border-collapse="collapse">
                 <fo:table-body>
                     
                     <fo:table-row>
                         <fo:table-cell border-collapse="collapse" background-color="orange" border="1pt solid black" number-columns-spanned="6">
                             <fo:block font-weight="700">
                                 Discipline: <xsl:value-of select="@id"/>
                             </fo:block>
                         </fo:table-cell>
                     </fo:table-row>   
                     <fo:table-row>
                         <fo:table-cell border-collapse="collapse" number-rows-spanned="{2 + count(target_type/target)}" background-color="lightgray" border="1pt solid black" text-align="center">
                             <fo:block>
                                 Standard-Unit <xsl:value-of select="position()"/>
                             </fo:block>
                         </fo:table-cell>
                     </fo:table-row>
                     
                 
                     <fo:table-row>                       
                         <fo:table-cell border-collapse="collapse" padding="6pt" border="1pt solid black">
                             <fo:block font-weight="700">Target ID</fo:block>
                         </fo:table-cell>
                         <fo:table-cell border-collapse="collapse" padding="6pt" border="1pt solid black">
                             <fo:block font-weight="700">Target-Size</fo:block>
                         </fo:table-cell>
                         <fo:table-cell border-collapse="collapse" padding="6pt" border="1pt solid black">
                             <fo:block font-weight="700">Seniors / Veterans / Adults / Young Adults  
                                 (Marker: <xsl:value-of select="distinct-values(target_type/target/division[@division_name='adult']/@coloring)"></xsl:value-of>)</fo:block>           
                         </fo:table-cell>
                         <fo:table-cell border-collapse="collapse" padding="6pt" border="1pt solid black">
                             <fo:block font-weight="700">Juniors 
                                 (Marker: <xsl:value-of select="distinct-values(target_type/target/division[@division_name='junior']/@coloring[1])"/>)</fo:block>
                             
                         </fo:table-cell>
                         <fo:table-cell border-collapse="collapse" padding="6pt" border="1pt solid black">
                             <fo:block font-weight="700">Cubs 
                                 (Marker: <xsl:value-of select="distinct-values(target_type/target/division[@division_name='cub']/@coloring[1])"/>)</fo:block>                            
                         </fo:table-cell>
                     </fo:table-row>
                     
                     <!-- remaining row -->
                     <xsl:for-each select="target_type/target">
                         <fo:table-row>
                             <fo:table-cell border-collapse="collapse" padding="6pt" border="1pt solid black">
                                 <fo:block> <xsl:value-of select="substring-after(@id, '-')"/></fo:block>
                             </fo:table-cell>
                             <fo:table-cell padding="6pt" border="1pt solid black">
                                <fo:block> <xsl:value-of select="substring-after(../@id, '-')"/> cm</fo:block>
                             </fo:table-cell>
                             
                             <fo:table-cell border-collapse="collapse" padding="6pt" border="1pt solid black">
                                 <fo:block><xsl:for-each select="division[@division_name='adult']/shooting_position">
                                     <xsl:value-of select="@distance"/>
                                     <xsl:choose>
                                         <xsl:when test="position() != last()">-</xsl:when>
                                     </xsl:choose>
                                 </xsl:for-each>
                                     Yards </fo:block>
                             </fo:table-cell>
                             
                             <fo:table-cell border-collapse="collapse" padding="6pt" border="1pt solid black">
                                 <fo:block>
                                     <xsl:for-each select="division[@division_name='junior']/shooting_position">
                                         <xsl:value-of select="@distance"/>
                                         <xsl:choose>
                                             <xsl:when test="position() != last()">-</xsl:when>
                                         </xsl:choose>
                                     </xsl:for-each>
                                     Yards
                                 </fo:block>
                                 
                             </fo:table-cell>
                             
                             <fo:table-cell border-collapse="collapse" padding="6pt" border="1pt solid black">
                                 <fo:block>
                                     <xsl:for-each select="division[@division_name='cub']/shooting_position">
                                         <xsl:value-of select="@distance"/>
                                         <xsl:choose>
                                             <xsl:when test="position() != last()">-</xsl:when>
                                         </xsl:choose>
                                     </xsl:for-each>
                                     Yards 
                                 </fo:block>                            
                             </fo:table-cell>
                         </fo:table-row>                        
                     </xsl:for-each>          
                 </fo:table-body>
            </fo:table>
        </xsl:for-each>
    </xsl:template>
</xsl:stylesheet>