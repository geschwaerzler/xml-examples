<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	
	<xsl:template match="/brew-recipes">
		<html>
			<head>
				<title>Some Recipes from "Brew Your Own" Magazine</title>
			</head>
			<body>
				<h1>Some Recipes from "Brew Your Own" Magazine</h1>
				
				<xsl:apply-templates select="recipe"/>
				
				<h2>Index of Grains</h2>
				<ul>
					<xsl:apply-templates select="recipe/ingredients/grain">
						<xsl:sort select="@type"/>
					</xsl:apply-templates>
				</ul>
			</body>
		</html>
	</xsl:template>
	
	<!-- Hier wird Ihr Lösungscode eingesetzt. -->
	
	<xsl:template match="recipe">
		<h2 id="{generate-id()}"><xsl:value-of select="@name"/></h2>
		
		<img src="{reference[@type='img']}" style="float:right; width:240px"></img>
		
		<h3>Ingredients</h3>
		<ul>
			<xsl:for-each select="ingredients/grain">
				<li>
					<xsl:choose>
						<xsl:when test="@color">
							<xsl:value-of select="concat(@type, ' (', @color, ') (', @amount, ')')"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="concat(@type, ' (', @amount, ')')"/>							
						</xsl:otherwise>
					</xsl:choose>
				</li>
			</xsl:for-each>
			<xsl:for-each select="ingredients/hops">
				<li>
					<xsl:value-of select="concat(./text(), ' (', @amount, ' at ', @alpha, ' alpha acids, ', @minutes-before-boil-end, ' min.)')"/>
				</li>
			</xsl:for-each>
			<li>
				<xsl:value-of select="ingredients/yeast"/>
			</li>
		</ul>
		
		<h3>Steps</h3>
		<p>
			<xsl:for-each select="step">
				<xsl:value-of select="."/>
			</xsl:for-each>
		</p>
		
	</xsl:template>
	
	
	<xsl:template match="grain" xml:space="preserve">
		<li>
			<xsl:value-of select="@type"/>
			<i>
				used in:
				<a href="#{generate-id(../..)}"><xsl:value-of select="../../@name"/></a>
			</i>
		</li>
	</xsl:template>

</xsl:stylesheet>
