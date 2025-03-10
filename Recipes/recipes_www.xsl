<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
>

	<xsl:template match="/collection">
		<html>
			<head>
				<title><xsl:value-of select="description"/></title>
			</head>
			<body>
				<h1><xsl:value-of select="description"/></h1>
				
				<h2>Table of Contents</h2>
				
				<ol>
					<xsl:for-each select="recipe">
						<li><xsl:value-of select="title"/></li>
					</xsl:for-each>
				</ol>
				
			</body>
		</html>
	</xsl:template>
	
	
</xsl:stylesheet>