<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format">
    
	<xsl:template match="/Championships">
		
		<fo:root>
				
			<fo:layout-master-set>
				<fo:simple-page-master master-name="Standardseite"
					page-height="400mm" page-width="300mm"
					margin-top="10mm" margin-left="15mm"
					margin-bottom="10mm" margin-right="15mm">
						
					<fo:region-body margin-top="20mm" margin-left="5mm" margin-bottom="20mm" margin-right="5mm"/>
					<fo:region-before extent="15mm"/>
					<fo:region-after extent="15mm"/>
				</fo:simple-page-master>
			</fo:layout-master-set>
			<fo:page-sequence master-reference="Standardseite" initial-page-number="1">
				
				<fo:static-content flow-name="xsl-region-before">
					<fo:block background-color="lightgray" font-family="Helvetica" font-size="22pt" padding="5pt">
						WFAC Championships
					</fo:block>
				</fo:static-content>
				
				<fo:static-content flow-name="xsl-region-after">
					<fo:block background-color="lightgray" font-family="Helvetica" font-size="18pt">
						Seite:
						<fo:page-number/>
					</fo:block>
				</fo:static-content>
				
				<fo:flow flow-name="xsl-region-body">
					<fo:block space-before="50pt" font-size="36pt">
						<fo:inline color="green">
							Table of Contents
						</fo:inline>
					</fo:block>
					<fo:block font-weight="bold" margin-top="30mm"/>
					<fo:list-block space-before="24pt">
						<xsl:apply-templates select="Tournament" mode="toc"/>
					</fo:list-block>
				</fo:flow>
			</fo:page-sequence>
			<xsl:apply-templates select = "Tournament"/>
			
			<fo:page-sequence master-reference="Standardseite">
				
				<fo:static-content flow-name="xsl-region-before">
					<fo:block background-color="lightgray" font-family="Helvetica" font-size="22pt" padding="5pt">
						WFAC Championships
					</fo:block>
				</fo:static-content>
				
				<fo:static-content flow-name="xsl-region-after">
					<fo:block background-color="lightgray" font-family="Helvetica" font-size="18pt">
						Seite:
						<fo:page-number/>
					</fo:block>
				</fo:static-content>
				
				<fo:flow flow-name="xsl-region-body">
					<fo:block space-before="15pt" font-size="36pt">
						<fo:inline color="green">
							Personen-Index
						</fo:inline>
					</fo:block>
					<xsl:apply-templates select = "Tournament/Venue/Match/Person" mode= "index">
						<xsl:sort select = '@name'></xsl:sort>
					</xsl:apply-templates>	
				</fo:flow>
				
			</fo:page-sequence>
			
		</fo:root>
		
	</xsl:template>
	
	<xsl:template match="Tournament" mode="toc">
		<fo:list-item>
			<fo:list-item-label>
				<fo:block><xsl:value-of select="position()"/>.</fo:block>
			</fo:list-item-label>
			<fo:list-item-body start-indent="10mm">
				<fo:block text-align-last="justify">
					<fo:inline color="darkgreen">
						<xsl:value-of select="@year"/> - Tournament <xsl:value-of select="@id"/>
					</fo:inline>
					<fo:leader leader-pattern="dots"></fo:leader>
					<fo:page-number-citation ref-id="{generate-id()}"/>
				</fo:block>
			</fo:list-item-body>
		</fo:list-item>
	</xsl:template>
	
	<xsl:template match="Tournament">
		<fo:page-sequence master-reference="Standardseite">
			
			<fo:static-content flow-name="xsl-region-before">
				<fo:block background-color="lightgray" font-family="Helvetica" font-size="22pt" padding="5pt">
					WFAC Championships
				</fo:block>
			</fo:static-content>
			
			<fo:static-content flow-name="xsl-region-after">
				<fo:block background-color="lightgray" font-family="Helvetica" font-size="18pt">
					Seite:
					<fo:page-number/>
				</fo:block>
			</fo:static-content>
			
			<fo:flow flow-name="xsl-region-body">
				<fo:block space-before="15pt" font-size="36pt" id="{generate-id()}">
					<fo:inline color="green">
							<xsl:value-of select="@year"/> - Tournament <xsl:value-of select="@id"/>
					</fo:inline>
				</fo:block>
				<xsl:apply-templates select = "Venue"/>
			</fo:flow>
			
		</fo:page-sequence>
	</xsl:template>
	
	<xsl:template match="Venue">
		<fo:block space-before="15pt" font-size="24pt">
			<xsl:value-of select="@description"/>
		</fo:block>
		<xsl:apply-templates select = "Match"/>
	</xsl:template>
	
	<xsl:template match="Match">
		<fo:block space-before="40pt" font-size="24pt">
			<fo:inline color="green">
				<xsl:value-of select="@m_id"/> - <xsl:value-of select="@description"/>
			</fo:inline>
		</fo:block>
		<xsl:apply-templates select = "Person" mode="match"/>
	</xsl:template>
	
	<xsl:template match="Person" mode="match">
		<fo:block space-before="30pt" font-size="20pt">
			<fo:inline color = "darkgreen">
				<xsl:value-of select= "@p_id"/> - <xsl:value-of select= "@name"/>
			</fo:inline>
		</fo:block>
		<xsl:apply-templates select = "Score"/>
	</xsl:template>
	
	<xsl:template match="Score">
		<fo:block space-before="15pt" font-size="16pt">
			Score Total: <xsl:value-of select= "@score_total"/>
		</fo:block>
		<xsl:apply-templates select = "Points"/>
	</xsl:template>
	
	<xsl:template match="Points">
		<fo:block space-before="15pt" font-size="14pt">
			Target: <xsl:value-of select= "@target"/> | Arrow:  <xsl:value-of select= "@arrow"/> | Points: <xsl:value-of select= "@points_arrow"/>
		</fo:block>
	</xsl:template>
	
	<xsl:template match="Person" mode="index">
				<fo:block space-before="30pt" font-size="22pt">
					<fo:inline color = "darkgreen">
						<xsl:value-of select= "@name"/> - <xsl:value-of select= "@p_id"/>
					</fo:inline>
				</fo:block>
				<fo:block space-before="10pt" font-size="18pt">
					<xsl:value-of select= "email"/>
					<xsl:if test="email and fon">
						-
					</xsl:if>
					<xsl:value-of select= "fon"/>
				</fo:block>
	</xsl:template>
	
</xsl:stylesheet>