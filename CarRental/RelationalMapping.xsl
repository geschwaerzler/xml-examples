<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:template match="/">
	
		<car-rental-relational>
			<xsl:apply-templates select="car-rental/stadt"/>
			<xsl:apply-templates select="car-rental/stadt/vermiet-station"/>			
			<xsl:apply-templates select="car-rental/autokategorie"/>
			<xsl:apply-templates select="car-rental/autokategorie/autotyp"/>
		</car-rental-relational>
			
	</xsl:template>
	
	<xsl:template match="stadt">
		<stadt StadtCode="{@stadtcode}" Name="{@name}" EinwohnerAnzahl="{@einwohner_anzahl}"/>
	</xsl:template>
	
	<xsl:template match="vermiet-station">
		<vermiet-station
			StadtCode="{../@stadtcode}"
			StationsName="{@stations_name}"
			Adresse="{@adresse}"
			MitarbeiterAnzahl="{@mitarbeiter_anzahl}"/>
	</xsl:template>
	
	<xsl:template match="autokategorie">
		<autokategorie KategorieBezeichnung="{@kategorie_bezeichnung}" GrundTarif="{@grundtarif}" km_preis="{@km_preis}"/>
	</xsl:template>

	<xsl:template match="autotyp">
		<autotyp TypBezeichnung="{@typ_bezeichnung}" BenzinVerbrauch="{@benzinverbrauch}" KategorieBezeichnung="{../@kategorie_bezeichnung}"/>
	</xsl:template>

</xsl:stylesheet>