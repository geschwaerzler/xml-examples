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
						<xsl:sort select="upper-case(@type)"/>
					</xsl:apply-templates>
				</ul>
			</body>
		</html>
	</xsl:template>
	
	<!-- Hier wird Ihr Lösungscode eingesetzt. -->
	
	<xsl:template match="recipe">
		<h2 id="{generate-id()}"><xsl:value-of select="@name"/></h2>
		
		<h3>Ingredients</h3>
		<ul>
			<xsl:for-each select="ingredients/grain" xml:space="preserve">
				<li>
					<xsl:value-of select="@type"/>
					<xsl:if test="@color">(<xsl:value-of select="@color"/>)</xsl:if>
					(<xsl:value-of select="@amount"/>)
				</li>
			</xsl:for-each>
			<xsl:for-each select="ingredients/hops">
				<li>
					<xsl:value-of select="."/>
					(<xsl:value-of select="@amount"/> at 
					 <xsl:value-of select="@alpha"/> alpha acids, 
					<xsl:value-of select="@minutes-before-boil-end"/> min.)
				</li>
			</xsl:for-each>
			<xsl:if test="ingredients/yeast">
				<li>
					<xsl:value-of select="ingredients/yeast"/>
				</li>
			</xsl:if>
		</ul>
		
		<!-- alternative solution 
		<ul>
			<xsl:apply-templates select="ingredients/*" mode="ingredients-list"/>
		</ul>
		
		and: templates for grain, hops, yeast 
		-->

		<h3>Steps</h3>
		<p>
			<xsl:for-each select="step" xml:space="preserve">
				<xsl:value-of select="."/>
			</xsl:for-each>
		</p>
	</xsl:template>
	
	<xsl:template match="grain">
		<li>
			<xsl:value-of select="@type"/>
			<i>
				<xsl:variable name="recipe" select="../.."/>
				used in:
				<a href="#{generate-id($recipe)}"><xsl:value-of select="$recipe/@name"/></a>
			</i>
		</li>
	</xsl:template>

</xsl:stylesheet>
