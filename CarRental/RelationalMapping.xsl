<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:template match="/">
	
		<car-rental-relational>
			<xsl:apply-templates select="car-rental/stadt"/>
			<xsl:apply-templates select="car-rental/stadt/vermiet-station"/>
			
			<sql-script>
				<xsl:apply-templates select="car-rental/autokategorie"/>
				<xsl:apply-templates select="car-rental/autokategorie/autotyp"/>
			</sql-script>
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
	INSERT INTO Autokategorie(kategorie_bezeichnung, grundtarif, km_preis)
	VALUES("<xsl:value-of select="@kategorie_bezeichnung"/>", <xsl:value-of select="@grundtarif"/>, <xsl:value-of select="@km_preis"/>);
	</xsl:template>

	<xsl:template match="autotyp">
	INSERT INTO Autotyp(typ_bezeichnung, benzinverbrauch, kategorie_bezeichnung)
	VALUES("<xsl:value-of select="@typ_bezeichnung"/>", <xsl:value-of select="@benzinverbrauch"/>, <xsl:value-of select="../@kategorie_bezeichnung"/>);
	</xsl:template>
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
</xsl:stylesheet>