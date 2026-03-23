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
	

</xsl:stylesheet>
