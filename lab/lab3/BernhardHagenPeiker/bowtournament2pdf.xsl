<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:fo="http://www.w3.org/1999/XSL/Format">
	
	<xsl:template match="/bow-tournament">
	<fo:root>
	
		<fo:layout-master-set>
			<!-- here we define the layout of pages. There might be differrent page masters with e.g. different margin settings -->
			<fo:simple-page-master master-name="bow-tournament-page"
				page-height="297.0mm" page-width="209.9mm"
				margin-bottom="15mm" margin-left="15mm" margin-right="15mm" margin-top="15mm">
				
				<!-- the content will be placed into the region-body -->
				<fo:region-body margin-bottom="15mm" margin-left="15mm" margin-right="15mm" margin-top="15mm"/>
				
				<!-- region-before is the page header -->
				<fo:region-before extent="24pt" region-name="bow-tournament-header"/>
				
				<!-- region-after is the page footer -->
				<fo:region-after extent="24pt" region-name="bow-tournament-footer"/>
			</fo:simple-page-master>
		</fo:layout-master-set>
	
		<!-- front page -->
		<fo:page-sequence master-reference="bow-tournament-page" font-family="sans-serif" font-size="9pt">
			<fo:flow flow-name="xsl-region-body">
				<fo:block font-size="36pt" font-style="normal" text-align="center">
					<fo:inline font-weight="600">World Outdoor Field Archery 2022</fo:inline>
				</fo:block>
			</fo:flow>
		</fo:page-sequence>
		
		<!-- table of contents -->
		<fo:page-sequence master-reference="bow-tournament-page">
			
			<xsl:call-template name="header">
				<xsl:with-param name="right" select="'Table of contents'"/>
			</xsl:call-template>
			
			<xsl:call-template name="footer">
				<xsl:with-param name="right"/>
			</xsl:call-template>
			
			<fo:flow flow-name="xsl-region-body" font-family="sans-serif" font-size="9pt">
				<fo:block font-weight="bold" margin-top="40mm">Table of contents</fo:block>
				<fo:list-block space-before="24pt">
					<!-- Groups -->
					<xsl:apply-templates select="group" mode="toc"/>
					
					<!-- Overall Playerlist -->
					<fo:list-item>
						<fo:list-item-label>
							<fo:block>
								<xsl:value-of select="count(//group)+1"/>
							</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="4mm">
							<fo:block text-align-last="justify">
								<fo:basic-link internal-destination="{generate-id()}">
									<fo:inline>Overall Playerlist</fo:inline>
									<fo:leader leader-pattern="dots"/>
									<fo:page-number-citation ref-id="{generate-id()}"/>
								</fo:basic-link>
							</fo:block>
						</fo:list-item-body>
					</fo:list-item>
					
					<!-- Group Scores -->
					<xsl:for-each select="group">
						<fo:list-item>
							<fo:list-item-label>
								<fo:block>
									<xsl:value-of select="count(//group)+1+position()"/>
								</fo:block>
							</fo:list-item-label>
							<fo:list-item-body start-indent="4mm">
								<fo:block text-align-last="justify">
									<fo:basic-link internal-destination="result-{generate-id()}">
										<xsl:value-of select="'Results - '"/>
										<xsl:value-of select="@name"/>
										<fo:leader leader-pattern="dots"/>
										<fo:page-number-citation ref-id="result-{generate-id()}"/>
									</fo:basic-link>
								</fo:block>
							</fo:list-item-body>
						</fo:list-item>
					</xsl:for-each>
					
					<!-- Scoreboards -->
					<xsl:for-each select="group">
						<fo:list-item>
							<fo:list-item-label>
								<fo:block>
									<xsl:value-of select="2*count(//group)+1+position()"/>
								</fo:block>
							</fo:list-item-label>
							<fo:list-item-body start-indent="4mm">
								<fo:block text-align-last="justify">
									<fo:basic-link internal-destination="scorecard-{generate-id()}">
										<xsl:value-of select="'Scorecards - '"/>
										<xsl:value-of select="@name"/>
										<fo:leader leader-pattern="dots"/>
										<fo:page-number-citation ref-id="scorecard-{generate-id()}"/>
									</fo:basic-link>
								</fo:block>
							</fo:list-item-body>
						</fo:list-item>
					</xsl:for-each>
				</fo:list-block>
			</fo:flow>	
		</fo:page-sequence>
		
		<!-- groups -->
		<xsl:apply-templates select="group" mode="detail"/>
		
		<!-- players -->
		<fo:page-sequence master-reference="bow-tournament-page">
			
			<xsl:call-template name="header">
				<xsl:with-param name="right" select="'Overall Playerlist'"/>
			</xsl:call-template>
			
			<xsl:call-template name="footer">
				<xsl:with-param name="right"/>
			</xsl:call-template>
			
			<fo:flow flow-name="xsl-region-body" font-family="sans-serif" font-size="9pt">
				<fo:block font-weight="bold" margin-top="0mm" id="{generate-id()}">
					Overall playerlist
				</fo:block>
				<fo:list-block space-before="24pt">
					<xsl:for-each select="player">
						<xsl:sort select="@lastname" order="ascending"/>
						<xsl:call-template name="player-list"/>
					</xsl:for-each>
				</fo:list-block>
			</fo:flow>
		</fo:page-sequence>
		
		<!-- group results -->
		<xsl:apply-templates select="group" mode="result"/>
		
		<!-- scorecards -->
		<xsl:apply-templates select="group" mode="scorecard"/>
	
	</fo:root>
	</xsl:template>
	
	<!-- .......................... PLAYER LIST TEMPLATE .......................... -->
	<xsl:template name="player-list" xml:space="preserve">
		<fo:list-item>
			<fo:list-item-label>
				<fo:block>
					<xsl:value-of select="position()"/>
				</fo:block>
			</fo:list-item-label>
			<fo:list-item-body start-indent="4mm">
				<fo:block>
					<xsl:value-of select="lastname/text()"/>
					<xsl:value-of select="firstname/text()"/>
				</fo:block>
			</fo:list-item-body>
		</fo:list-item>
	</xsl:template>
	
	<!-- .......................... GROUP DETAIL TEMPLATE .......................... -->
	<xsl:template match="group" mode="detail" xml:space="preserve">
		<fo:page-sequence master-reference="bow-tournament-page">
			
			<xsl:call-template name="header">
				<xsl:with-param name="right" select="'Groups'"/>
			</xsl:call-template>
			
			<xsl:call-template name="footer">
				<xsl:with-param name="right"/>
			</xsl:call-template>
			
			<fo:flow flow-name="xsl-region-body" font-family="sans-serif" font-size="9pt">
				<fo:block font-weight="bold" margin-top="0mm" id="{generate-id()}">
					<xsl:value-of select="@name"/>
				</fo:block>
				<fo:list-block space-before="24pt">
					<xsl:for-each select="member">
						<xsl:sort select="id(@player-id)/lastname" order="ascending"/>
						<xsl:call-template name="member-list"></xsl:call-template>
					</xsl:for-each>
				</fo:list-block>
			</fo:flow>
		</fo:page-sequence>
	</xsl:template>
	
	<xsl:template name="member-list" xml:space="preserve">
		<fo:list-item>
			<fo:list-item-label>
				<fo:block>
				</fo:block>
			</fo:list-item-label>
			<fo:list-item-body start-indent="0mm">
				<fo:block>
					<xsl:value-of select="id(@player-id)/lastname"/>
					<xsl:value-of select="id(@player-id)/firstname"/>
				</fo:block>
			</fo:list-item-body>
		</fo:list-item>
	</xsl:template>
	
	<!-- .......................... GROUP RESULT TEMPLATE .......................... -->
	<xsl:template match="group" mode="result" xml:space="preserve">
		<fo:page-sequence master-reference="bow-tournament-page">
			
			<xsl:call-template name="header">
				<xsl:with-param name="right" select="'Group Results'"/>
			</xsl:call-template>
			
			<xsl:call-template name="footer">
				<xsl:with-param name="right"/>
			</xsl:call-template>
			
			<fo:flow flow-name="xsl-region-body" font-family="sans-serif" font-size="9pt">
				<fo:block font-weight="bold" margin-top="0mm" id="result-{generate-id()}">
					Results -  
					<xsl:value-of select="@name"/>
				</fo:block>
				
				<fo:table border-width="2" border-color="black" border-style="solid" space-before="24pt">
					<fo:table-body>
						<fo:table-row>
							<fo:table-cell width="15mm" border-width="0.5pt" border-color="black" border-style="solid" border-bottom-width="2" border-right-width="2">
								<fo:block text-align="center">
									Ranking
								</fo:block>
							</fo:table-cell>
							<fo:table-cell border-width="0.5pt" border-color="black" border-style="solid" border-bottom-width="2" border-right-width="2">
								<fo:block start-indent="1mm" text-align="left">
									Player
								</fo:block>
							</fo:table-cell>
							<fo:table-cell width="15mm" border-width="0.5pt" border-color="black" border-style="solid" border-bottom-width="2" border-right-width="2">
								<fo:block start-indent="1mm" text-align="center">
									Score
								</fo:block>
							</fo:table-cell>
						</fo:table-row>
						
						<xsl:for-each select="member">
							<xsl:sort select="sum(scorecard//arrow/text())" order="descending"/>
							<xsl:call-template name="group-member"/>
						</xsl:for-each>
					</fo:table-body>
				</fo:table>
			</fo:flow>
		</fo:page-sequence>
	</xsl:template>
	
	<xsl:template name="group-member" xml:space="preserve">
		<fo:table-row>
			<fo:table-cell border-width="0.5pt" border-color="black" border-style="solid" border-right-width="2">
				<fo:block start-indent="1mm" text-align="center">
					<xsl:value-of select="position()"/>
				</fo:block>
			</fo:table-cell>
			<fo:table-cell border-width="0.5pt" border-color="black" border-style="solid" border-right-width="2">
				<fo:block start-indent="1mm" text-align="left">
					<xsl:value-of select="id(@player-id)/lastname"/>
					<xsl:value-of select="id(@player-id)/firstname"/>
				</fo:block>
			</fo:table-cell>
			<fo:table-cell border-width="0.5pt" border-color="black" border-style="solid" border-right-width="2">
				<fo:block start-indent="1mm" text-align="center">
					<xsl:value-of select="sum(scorecard//arrow/text())"/>
				</fo:block>
			</fo:table-cell>
		</fo:table-row>
	</xsl:template>
		
	<xsl:template name="member-result" xml:space="preserve">
		<fo:list-item>
			<fo:list-item-label>
				<fo:block>
					<xsl:value-of select="position()"/>
				</fo:block>
			</fo:list-item-label>
			<fo:list-item-body start-indent="4mm">
				<fo:block>
					<xsl:value-of select="id(@player-id)/lastname"/>
					<fo:inline width="100mm"><xsl:value-of select="id(@player-id)/firstname"/></fo:inline>
					<xsl:value-of select="sum(scorecard//arrow/text())"/>
				</fo:block>
			</fo:list-item-body>
		</fo:list-item>
	</xsl:template>
	
	<!-- .......................... SCORECARD TEMPLATE .......................... -->
	<xsl:template match="group" mode="scorecard" xml:space="preserve">
		<fo:page-sequence master-reference="bow-tournament-page">
			
			<xsl:call-template name="header">
				<xsl:with-param name="right" select="'Scorecards'"/>
			</xsl:call-template>
			
			<xsl:call-template name="footer">
				<xsl:with-param name="right"/>
			</xsl:call-template>
			
			<fo:flow flow-name="xsl-region-body" font-family="sans-serif" font-size="9pt">
				<fo:block font-weight="bold" margin-top="0mm" space-after="24pt" id="scorecard-{generate-id()}">
					<fo:block>Scorecards - <xsl:value-of select="@name"/></fo:block>
				</fo:block>
				<xsl:for-each select="member">
					<xsl:sort select="id(@player-id)/lastname" order="ascending"/>
					<xsl:call-template name="member-scorecard"/>
				</xsl:for-each>
			</fo:flow>
		</fo:page-sequence>
	</xsl:template>
	
	<xsl:template name="member-scorecard" xml:space="preserve">
		<fo:block space-before="12pt">
			<xsl:value-of select="id(@player-id)/lastname"/>
			<xsl:value-of select="id(@player-id)/firstname"/>
			-
			<xsl:value-of select="../@name"/>
		</fo:block>
		<fo:table border-width="2" border-color="black" border-style="solid">
			<fo:table-body>
				<fo:table-row>
					<fo:table-cell border-width="0.5pt" border-color="black" border-style="solid" border-bottom-width="2" border-right-width="2">
						<fo:block start-indent="0.5mm" text-align="center">
							Target
						</fo:block>
					</fo:table-cell>
					<fo:table-cell border-width="0.5pt" border-color="black" border-style="solid" border-bottom-width="2" border-right-width="2">
						<fo:block start-indent="0.5mm" text-align="center">
							Arrow 1
						</fo:block>
					</fo:table-cell>
					<fo:table-cell border-width="0.5pt" border-color="black" border-style="solid" border-bottom-width="2" border-right-width="2">
						<fo:block start-indent="0.5mm" text-align="center">
							Arrow 2
						</fo:block>
					</fo:table-cell>
					<fo:table-cell border-width="0.5pt" border-color="black" border-style="solid" border-bottom-width="2" border-right-width="2">
						<fo:block start-indent="0.5mm" text-align="center">
							Arrow 3
						</fo:block>
					</fo:table-cell>
					<fo:table-cell border-width="0.5pt" border-color="black" border-style="solid" border-bottom-width="2" border-right-width="2">
						<fo:block start-indent="0.5mm" text-align="center">
							Arrow 4
						</fo:block>
					</fo:table-cell>
				</fo:table-row>
				<xsl:for-each select="scorecard/score">
					<xsl:call-template name="scorecard-score"/>
				</xsl:for-each>
			</fo:table-body>
		</fo:table>
	</xsl:template>
	
	<xsl:template name="scorecard-score">
		<fo:table-row>
			<fo:table-cell border-width="0.5pt" border-color="black" border-style="solid" border-right-width="2">
				<fo:block start-indent="0.5mm">
					<xsl:value-of select="id(@target-id)/text()"/>
				</fo:block>
			</fo:table-cell>
			<xsl:for-each select="arrow">
				<xsl:call-template name="score-arrow"/>
			</xsl:for-each>
		</fo:table-row>
	</xsl:template>
	
	<xsl:template name="score-arrow">
		<fo:table-cell border-width="0.5pt" border-color="black" border-style="solid" border-right-width="2">
			<fo:block start-indent="0.5mm" text-align="center">
				<xsl:value-of select="text()"/>
			</fo:block>
		</fo:table-cell>	
	</xsl:template>
	
	<!-- .......................... HEADER TEMPLATE .......................... -->
	<xsl:template name="header" mode="group">
		<xsl:param name="right"/>
		<fo:static-content flow-name="bow-tournament-header">
			<fo:block font-size="7pt" text-align-last="justify">
				<fo:inline>World Outdoor Field Archery 2022</fo:inline>
				<fo:leader/>
				<xsl:value-of select="$right"/>
			</fo:block>
		</fo:static-content>        
	</xsl:template>
	
	<!-- .......................... FOOTER TEMPLATE .......................... -->
	<xsl:template name="footer" mode="group">
		<xsl:param name="right"/>
		<fo:static-content flow-name="bow-tournament-footer">
			<fo:block font-size="7pt" text-align-last="right">
				<xsl:value-of select="'Page '"/>
				<fo:page-number/>
				<fo:leader/>
				<xsl:value-of select="$right"/>
			</fo:block>
		</fo:static-content>        
	</xsl:template>
	
	<!-- .......................... GROUP TOC TEMPLATE .......................... -->
	<xsl:template match="group" mode="toc">
		<fo:list-item>
			<fo:list-item-label>
				<fo:block><xsl:value-of select="position()"/></fo:block>
			</fo:list-item-label>
			<fo:list-item-body start-indent="4mm">
				<fo:block text-align-last="justify">
					<fo:basic-link internal-destination="{generate-id()}">
						<xsl:value-of select="@name"/>
						<fo:leader leader-pattern="dots"/>
						<fo:page-number-citation ref-id="{generate-id()}"/>
					</fo:basic-link>
				</fo:block>
			</fo:list-item-body>
		</fo:list-item>
	</xsl:template>
		
</xsl:stylesheet>