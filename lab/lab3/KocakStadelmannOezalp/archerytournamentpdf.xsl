<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:fo="http://www.w3.org/1999/XSL/Format">
	<xsl:template match="/archery-tournament">
		<!-- TODO: Auto-generated template -->

		<fo:root>

			<fo:layout-master-set>

				<fo:simple-page-master
					master-name="archery-page" page-height="297.0mm"
					page-width="209.9mm" margin-bottom="8mm" margin-left="25mm"
					margin-right="10mm" margin-top="10mm">

					<fo:region-body margin-bottom="28mm"
						margin-left="0mm" margin-right="44mm" margin-top="20mm" />

					<fo:region-before extent="24pt"
						region-name="archery-header" />

					<fo:region-after extent="24pt"
						region-name="archery-footer" />

				</fo:simple-page-master>

			</fo:layout-master-set>

			<fo:page-sequence master-reference="archery-page">

				<fo:flow flow-name="xsl-region-body"
					font-family="sans-serif" font-size="28pt">
					<fo:block margin-top="40mm">
						<xsl:value-of select="@name" />
					</fo:block>
				</fo:flow>

			</fo:page-sequence>

			<fo:page-sequence master-reference="archery-page">
				<xsl:call-template name="header">
					<xsl:with-param name="right"
						select="'World Championship'" />
				</xsl:call-template>
			

				<fo:flow flow-name="xsl-region-body" font-family="Times"
					font-size="9pt">
					<fo:block font-weight="bold" margin-top="40mm"> World Championship
					</fo:block>
					<fo:list-block space-before="24pt">
						<xsl:apply-templates
							select="group" mode="toc"/>
					</fo:list-block>
					
				</fo:flow>
			</fo:page-sequence>
			
			<xsl:apply-templates select="athlete"/>
			<xsl:apply-templates select="member"/>	

		</fo:root>
	</xsl:template>
	
	

	<!-- TABLE OF CONTENTS TEMPLATE -->
	<xsl:template match="group" mode="toc">
		<fo:list-item>
			<fo:list-item-label>
				<fo:block> <xsl:value-of select="position()" />. </fo:block>
			</fo:list-item-label>
			<fo:list-item-body start-indent="4mm">
				<fo:block text-align-last="justify">
					<xsl:value-of select="@name"/>
					<fo:leader leader-pattern="dots"> </fo:leader>
					<fo:page-number-citation ref-id="{generate-id()}"/>
				</fo:block>
			</fo:list-item-body>
		</fo:list-item>
		
	</xsl:template>
	
	<xsl:template match="member">
		<fo:page-sequence master-reference="archery-page">
			<xsl:call-template name="header">
				<xsl:with-param name="right" select="@name"/>
			</xsl:call-template>
			
			<fo:static-content flow-name="archery-footer">
				<fo:block font-size="7pt" text-align="end">
					page <fo:page-number/>
				</fo:block>
			</fo:static-content>
			
			<fo:flow flow-name="xsl-region-body" font-family="Times" font-size="9pt">
				<fo:block font-size="14pt" font-weight="bold" id="{generate-id()}">
					<xsl:value-of select="@name"/>
				</fo:block>
				
				<fo:block font-size="10pt" font-weight="bold" space-before="12pt">
					
				</fo:block>
				<xsl:for-each select="member">
					<xsl:value-of select="@name"/>
				</xsl:for-each>
			</fo:flow>
		</fo:page-sequence>
	</xsl:template>


	<!-- -->

	<xsl:template name="header">
		<xsl:param name="right" />
		<fo:static-content flow-name="archery-header">

			<fo:block font-size="7pt" text-align-last="justify">

				<xsl:value-of select="/archery-tournament/discipline" />
				<fo:leader />
				<xsl:value-of select="$right" />

			</fo:block>
		</fo:static-content>
	</xsl:template>
	
	<xsl:template match="athlete">
		<fo:page-sequence master-reference="archery-page">
			<fo:flow flow-name="xsl-region-body">
				<fo:block> 
					
					<xsl:value-of select="firstname"/> 
					<xsl:value-of select="lastname"/>
					
					<xsl:value-of select="id(@athlete-id)/@firstname"/>
					<xsl:value-of select="id(@athlete-id)/@lastname"/>
				</fo:block>
				<xsl:apply-templates select="scorecard"/>
			</fo:flow>
		</fo:page-sequence>
		
	</xsl:template>
	<xsl:template match="scorecard">
		<a id="{../@id}">
			<xsl:value-of select="@athlete" />
		</a>
		
		<fo:table border="0.5pt solid black"
			text-align="center"
			border-spacing="3pt">
			<fo:table-column column-width="1in"/>
			<fo:table-column column-width="0.5in" number-columns-repeated="3"/>
			<fo:table-header>❸
				<fo:table-row>
					<fo:table-cell padding="6pt"
						border="1pt solid blue"
						background-color="silver"
						number-columns-spanned="4">
						<fo:block text-align="center" font-weight="bold">
							Score per Arrow
						</fo:block>
					</fo:table-cell>
				</fo:table-row>
			</fo:table-header>
			<xsl:for-each select="total_score/target_score">
			<fo:table-body>
				<fo:table-row>
					<fo:table-cell padding="6pt"
						border="1pt solid blue"
						background-color="silver"
						number-rows-spanned="1">
						<fo:block text-align="end" font-weight="bold">
							<xsl:value-of select="@target-id"/>
						</fo:block>
					</fo:table-cell>
					<fo:table-cell padding="6pt" border="0.5pt solid black">
						<fo:block> <xsl:value-of select="score_per_arrow[@name='arrow1']"/> </fo:block>
					</fo:table-cell>
					<fo:table-cell padding="6pt" border="0.5pt solid black">
						<fo:block> <xsl:value-of select="score_per_arrow[@name='arrow2']"/> </fo:block>
					</fo:table-cell>
					<fo:table-cell padding="6pt" border="0.5pt solid black">
						<fo:block> <xsl:value-of select="score_per_arrow[@name='arrow3']"/> </fo:block>
					</fo:table-cell>
				</fo:table-row>
				
			</fo:table-body>
			</xsl:for-each>
		</fo:table>
	</xsl:template>
</xsl:stylesheet>