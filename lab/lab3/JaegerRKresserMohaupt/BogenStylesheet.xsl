<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:fo="http://www.w3.org/1999/XSL/Format">
	<xsl:output method="xml" omit-xml-declaration="no" version="1.0" encoding="UTF-8" indent="yes" />
	<xsl:template match="/">
		<fo:root>
			<fo:layout-master-set>
				<fo:simple-page-master master-name="DIN-A4" page-height="297mm" page-width="210mm">
					<fo:region-body region-name="inhalt" margin="2cm" />
					<fo:region-after region-name="xsl-region-after" extent="2cm"/>
				</fo:simple-page-master>
			</fo:layout-master-set>
			<fo:page-sequence master-reference="DIN-A4" font-family="Times" font-size="9pt" initial-page-number="1">
				<fo:static-content flow-name="xsl-region-after">
					<fo:block text-align="center">
							Seite <fo:page-number/>
					</fo:block>
				</fo:static-content>
				<fo:flow flow-name="inhalt">
					<fo:block font-family="Times" font-size="14pt"> BOGENTURNIER </fo:block>
					<fo:block white-space-collapse="false" white-space-treatment="preserve" font-size="0pt" line-height="15px">.
					</fo:block>
					<fo:list-block>
						<fo:list-item>
							<fo:list-item-label>
								<fo:block font-family="Times" font-size="12pt"> Inhalt </fo:block>
							</fo:list-item-label>
							<fo:list-item-body>
								<fo:block>
								</fo:block>
							</fo:list-item-body>
						</fo:list-item>
						<fo:list-item>
							<fo:list-item-label>
								<fo:block></fo:block>
							</fo:list-item-label>
							<fo:list-item-body>
								<fo:block>
									<fo:basic-link internal-destination = "Gruppe1"> 
										Gruppe 1: 19.04.2022 Seite: <fo:page-number-citation ref-id="Gruppe1"/>
										<fo:inline>
											<fo:leader rule-style="double" rule-thickness="2pt" color="blue" leader-pattern="dots"/>
										</fo:inline>
									</fo:basic-link>
								</fo:block>
							</fo:list-item-body>
						</fo:list-item>
						<fo:list-item>
							<fo:list-item-label>
								<fo:block>
								</fo:block>
							</fo:list-item-label>
							<fo:list-item-body>
								<fo:block>
									<fo:basic-link internal-destination = "Gruppe2"> 
										Gruppe 2: 20.04.2022 Seite: <fo:page-number-citation ref-id="Gruppe2"/>
										<fo:inline>
											<fo:leader rule-style="double" rule-thickness="2pt" color="blue" leader-pattern="dots"/>
										</fo:inline>
									</fo:basic-link>
								</fo:block>
							</fo:list-item-body>
						</fo:list-item>
						<fo:list-item>
							<fo:list-item-label>
								<fo:block></fo:block>
							</fo:list-item-label>
							<fo:list-item-body>
								<fo:block>
									<fo:basic-link internal-destination = "ScoreboardOS"> 
										Scoreboard Olaf Scholz Seite: <fo:page-number-citation ref-id="ScoreboardOS"/>
										<fo:inline>
											<fo:leader rule-style="double" rule-thickness="2pt" color="blue" leader-pattern="dots"/>
										</fo:inline>
									</fo:basic-link>
								</fo:block>
							</fo:list-item-body>
						</fo:list-item>
						<fo:list-item>
							<fo:list-item-label>
								<fo:block></fo:block>
							</fo:list-item-label>
							<fo:list-item-body>
								<fo:block>
									<fo:basic-link internal-destination = "ScoreboardCL"> 
										Scoreboard Christian Lindner Seite: <fo:page-number-citation ref-id="ScoreboardCL"/>
										<fo:inline>
											<fo:leader rule-style="double" rule-thickness="2pt" color="blue" leader-pattern="dots"/>
										</fo:inline>
									</fo:basic-link>
								</fo:block>
							</fo:list-item-body>
						</fo:list-item>
					</fo:list-block>
					<fo:block white-space-collapse="false" white-space-treatment="preserve" font-size="0pt" line-height="15px">.
					</fo:block>
					<fo:block id="Gruppe1">
						<fo:block font-family="Times" font-size="12pt">
							Gruppe 1
						</fo:block>
						<fo:block white-space-collapse="false" white-space-treatment="preserve" font-size="0pt" line-height="15px">.
						</fo:block>
						<fo:table background-color = "white">
							<fo:table-body>
								<fo:table-row>
									<fo:table-cell border="solid 1px black" text-align="center" font-weight="bold">
										<fo:block>
										 Schuetzen Nr
										</fo:block>
									</fo:table-cell>
									<fo:table-cell border="solid 1px black" text-align="center" font-weight="bold">
										<fo:block>
										 Schuetze Vorname
										</fo:block>
									</fo:table-cell>
									<fo:table-cell border="solid 1px black" text-align="center" font-weight="bold">
										<fo:block>
										 Schuetze Nachname
										</fo:block>
									</fo:table-cell>
									<fo:table-cell border="solid 1px black" text-align="center" font-weight="bold">
										<fo:block>
										 Nationalitaet
										</fo:block>
									</fo:table-cell>
									<fo:table-cell border="solid 1px black" text-align="center" font-weight="bold">
										<fo:block>
										 Punktezahl
										</fo:block>
									</fo:table-cell>
								</fo:table-row>
								<xsl:for-each select="Bogenturnier/Schuetzenprofil/Schuetze[Gruppe/@id='g1']">
									<fo:table-row>
										<fo:table-cell border="solid 1px black" text-align="center" font-weight="bold">
											<fo:block>
												<xsl:value-of select="schuetze_id"/>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell border="solid 1px black" text-align="center" font-weight="bold">
											<fo:block>
												<xsl:value-of select="Schuetze_Vorname"/>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell border="solid 1px black" text-align="center" font-weight="bold">
											<fo:block>
												<xsl:value-of select="Schuetze_Nachname"/>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell border="solid 1px black" text-align="center" font-weight="bold">
											<fo:block>
												<xsl:value-of select="Nationalitaet"/>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell border="solid 1px black" text-align="center" font-weight="bold">
											<fo:block>
												<xsl:value-of select="Gesamtpunkte"/>
											</fo:block>
										</fo:table-cell>
									</fo:table-row>
								</xsl:for-each>
							</fo:table-body>
						</fo:table>
					</fo:block>
					<fo:block white-space-collapse="false" white-space-treatment="preserve" font-size="0pt" line-height="15px">.
					</fo:block>
					<fo:block page-break-after="always">
						<fo:block id="Gruppe2">
							<fo:block font-family="Times" font-size="12pt">
							Gruppe 2
							</fo:block>
							<fo:block white-space-collapse="false" white-space-treatment="preserve" font-size="0pt" line-height="15px">.
							</fo:block>
							<fo:table background-color = "white">
								<fo:table-body>
									<fo:table-row>
										<fo:table-cell border="solid 1px black" text-align="center" font-weight="bold">
											<fo:block>
										 Schuetzen Nr
											</fo:block>
										</fo:table-cell>
										<fo:table-cell border="solid 1px black" text-align="center" font-weight="bold">
											<fo:block>
										 Schuetze Vorname
											</fo:block>
										</fo:table-cell>
										<fo:table-cell border="solid 1px black" text-align="center" font-weight="bold">
											<fo:block>
										 Schuetze Nachname
											</fo:block>
										</fo:table-cell>
										<fo:table-cell border="solid 1px black" text-align="center" font-weight="bold">
											<fo:block>
										 Nationalitaet
											</fo:block>
										</fo:table-cell>
										<fo:table-cell border="solid 1px black" text-align="center" font-weight="bold">
											<fo:block>
										 Punktezahl
											</fo:block>
										</fo:table-cell>
									</fo:table-row>
									<xsl:for-each select="Bogenturnier/Schuetzenprofil/Schuetze[Gruppe/@id='g2']">
										<fo:table-row>
											<fo:table-cell border="solid 1px black" text-align="center" font-weight="bold">
												<fo:block>
													<xsl:value-of select="schuetze_id"/>
												</fo:block>
											</fo:table-cell>
											<fo:table-cell border="solid 1px black" text-align="center" font-weight="bold">
												<fo:block>
													<xsl:value-of select="Schuetze_Vorname"/>
												</fo:block>
											</fo:table-cell>
											<fo:table-cell border="solid 1px black" text-align="center" font-weight="bold">
												<fo:block>
													<xsl:value-of select="Schuetze_Nachname"/>
												</fo:block>
											</fo:table-cell>
											<fo:table-cell border="solid 1px black" text-align="center" font-weight="bold">
												<fo:block>
													<xsl:value-of select="Nationalitaet"/>
												</fo:block>
											</fo:table-cell>
											<fo:table-cell border="solid 1px black" text-align="center" font-weight="bold">
												<fo:block>
													<xsl:value-of select="Gesamtpunkte"/>
												</fo:block>
											</fo:table-cell>
										</fo:table-row>
									</xsl:for-each>
								</fo:table-body>
							</fo:table>
						</fo:block>
					</fo:block>
				</fo:flow>
			</fo:page-sequence>
			<fo:page-sequence master-reference="DIN-A4" font-family="Times" font-size="9pt" initial-page-number="2">
				<fo:static-content flow-name="xsl-region-after">
					<fo:block text-align="center">
							Seite <fo:page-number/>
					</fo:block>
				</fo:static-content>
				<fo:flow flow-name="inhalt">
					<fo:block page-break-after="always">
						<fo:block id="ScoreboardOS">
							<fo:block font-family="Times" font-size="12pt">
							Scorecard Olaf Scholz
							</fo:block>
							<fo:block white-space-collapse="false" white-space-treatment="preserve" font-size="0pt" line-height="15px">.
							</fo:block>
							<fo:table background-color = "white">
								<fo:table-body>
									<fo:table-row>
										<fo:table-cell border="solid 1px black" text-align="center" font-weight="bold">
											<fo:block>
										 Ziel Nr
											</fo:block>
										</fo:table-cell>
										<fo:table-cell border="solid 1px black" text-align="center" font-weight="bold">
											<fo:block>
										 Ziel Name
											</fo:block>
										</fo:table-cell>
										<fo:table-cell border="solid 1px black" text-align="center" font-weight="bold">
											<fo:block>
										 Punkte
											</fo:block>
										</fo:table-cell>
									</fo:table-row>
									<xsl:for-each select="Bogenturnier/ParkourOS/target">
										<fo:table-row>
											<fo:table-cell border="solid 1px black" text-align="center" font-weight="bold">
												<fo:block>
													<xsl:value-of select="target_id"/>
												</fo:block>
											</fo:table-cell>
											<fo:table-cell border="solid 1px black" text-align="center" font-weight="bold">
												<fo:block>
													<xsl:value-of select="target_name"/>
												</fo:block>
											</fo:table-cell>
											<fo:table-cell border="solid 1px black" text-align="center" font-weight="bold">
												<fo:block>
													<xsl:value-of select="punkte"/>
												</fo:block>
											</fo:table-cell>
										</fo:table-row>
									</xsl:for-each>
								</fo:table-body>
							</fo:table>
						</fo:block>
					</fo:block>
				</fo:flow>
			</fo:page-sequence>

			<fo:page-sequence master-reference="DIN-A4" font-family="Times" font-size="9pt" initial-page-number="3">
				<fo:static-content flow-name="xsl-region-after">
					<fo:block text-align="center">
							Seite <fo:page-number/>
					</fo:block>
				</fo:static-content>
				<fo:flow flow-name="inhalt">
					<fo:block page-break-after="always">
						<fo:block id="ScoreboardCL">
							<fo:block font-family="Times" font-size="12pt">
										Scorecard Christian Lindner
							</fo:block>
							<fo:block white-space-collapse="false" white-space-treatment="preserve" font-size="0pt" line-height="15px">.
							</fo:block>
							<fo:table background-color = "white">
								<fo:table-body>
									<fo:table-row>
										<fo:table-cell border="solid 1px black" text-align="center" font-weight="bold">
											<fo:block>
										 Ziel Nr
											</fo:block>
										</fo:table-cell>
										<fo:table-cell border="solid 1px black" text-align="center" font-weight="bold">
											<fo:block>
										 Ziel Name
											</fo:block>
										</fo:table-cell>
										<fo:table-cell border="solid 1px black" text-align="center" font-weight="bold">
											<fo:block>
										 Punkte
											</fo:block>
										</fo:table-cell>
									</fo:table-row>
									<xsl:for-each select="Bogenturnier/ParkourCL/target">
										<fo:table-row>
											<fo:table-cell border="solid 1px black" text-align="center" font-weight="bold">
												<fo:block>
													<xsl:value-of select="target_id"/>
												</fo:block>
											</fo:table-cell>
											<fo:table-cell border="solid 1px black" text-align="center" font-weight="bold">
												<fo:block>
													<xsl:value-of select="target_name"/>
												</fo:block>
											</fo:table-cell>
											<fo:table-cell border="solid 1px black" text-align="center" font-weight="bold">
												<fo:block>
													<xsl:value-of select="punkte"/>
												</fo:block>
											</fo:table-cell>
										</fo:table-row>
									</xsl:for-each>
								</fo:table-body>
							</fo:table>
						</fo:block>
					</fo:block>
				</fo:flow>
			</fo:page-sequence>
		</fo:root>
	</xsl:template>
</xsl:stylesheet>