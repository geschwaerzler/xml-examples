<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:template match="/">
		<html>
			<head>
				<title>Some beautiful recipes</title>
			</head>
			<body>
				<h1>Some beautiful recipes</h1>
				
				<h2>Here is the list!</h2>
				<ol>
					<xsl:for-each select="/collection/recipe">
						<li><xsl:value-of select="title"/></li>
					</xsl:for-each>
				</ol>
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>