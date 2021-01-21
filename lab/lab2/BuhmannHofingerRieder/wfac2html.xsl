<?xml version="1.0" encoding="UTF-8"?>
<!-- Buhmann Tobias, Hofinger Victoria, Rieder David -->

<xsl:stylesheet
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xs="http://www.w3.org/2001/XMLSchema"
	exclude-result-prefixes="xs" version="2.0">

	<xsl:output method="html"></xsl:output>
	<xsl:template match="/">
		<html>
			<head>
				<title>
					WFAC
				</title>
			</head>
			<body>
				<h1 color="#0101DF">
					Overview
				</h1>
				<div>
					<ul>
						<xsl:apply-templates
							select="tournament/tournamentday/group" mode="toc"></xsl:apply-templates>
					</ul>
				</div>
				<xsl:apply-templates
					select="tournament/tournamentday" mode="toc"></xsl:apply-templates>
				<br />
				<h1 color="#0101DF">
					Scorecards
				</h1>
				<h3 color="#2ECCFA">
					<xsl:apply-templates
						select="tournament/tournamentday/group/competitor" mode="scc"></xsl:apply-templates>
				</h3>
			</body>
		</html>
	</xsl:template>


	<xsl:template match="group" mode="toc">
		<a href="#{generate-id()}">
			<li>

				<xsl:value-of select="tournament/tournamentday/group" />
				Group
				<xsl:variable name="gid" select="@id" />
				<xsl:value-of select="substring-after($gid,'g')" />
				, 
				<xsl:value-of select="../@date" />

			</li>
		</a>
	</xsl:template>

	<xsl:template match="tournamentday" mode="toc">
		<h2 color="#0080FF">
			<xsl:value-of select="position()" />
			. Day,
			<xsl:value-of select="@date" />
		</h2>
		<xsl:apply-templates select="group" mode="detail">

		</xsl:apply-templates>
		<h2 color="#0080FF">
			<xsl:value-of select="position()" />
			. Day, scoring
		</h2>

		<xsl:for-each select="group/competitor">
			<xsl:sort select="scorecard/@totalscore" data-type="number"
				order="descending" />
			<xsl:value-of select="position()" />
			.
			<xsl:variable name="id" select="@person_id" />
			<xsl:variable name="fname" select="id($id)/@fname" />
			<xsl:variable name="lname" select="id($id)/@lname" />
			<xsl:value-of select="concat($fname,' ', $lname)" />
			,
			<xsl:value-of select="scorecard/@totalscore" />

			<br />
		</xsl:for-each>
	</xsl:template>

	<xsl:template match="group" mode="scoring">

	</xsl:template>


	<xsl:template match="group" mode="detail">
		<xsl:value-of select="group" />
		<h2 id="{generate-id()}" color="#0080FF">
			Group
			<xsl:variable name="gid" select="@id" />
			<xsl:value-of select="substring-after($gid,'g')" />
		</h2>
		<xsl:for-each select="competitor">
			<xsl:variable name="idg" select="../@id" />
			<xsl:variable name="idp" select="@person_id" />
			<xsl:variable name="fname" select="id($idp)/@fname" />
			<xsl:variable name="lname" select="id($idp)/@lname" />
			<xsl:value-of select="concat($fname,' ', $lname)" />
			<a>
				<xsl:attribute name="href">
                    <xsl:value-of
					select="concat('#',$idg,$idp)" />
                </xsl:attribute>
				,
				<xsl:value-of select="scorecard/@totalscore" />

			</a>
			<br />
		</xsl:for-each>



	</xsl:template>




	<xsl:template match="competitor" mode="scc">
		<xsl:variable name="idg" select="../@id" />
		<xsl:variable name="idp" select="@person_id" />
		<h2 color="#0080FF">
			<xsl:attribute name="id">
                <xsl:value-of select="concat($idg,$idp)" />
            </xsl:attribute>
			<xsl:value-of select="id($idp)/@fname" />
			<xsl:text>  </xsl:text>
			<xsl:value-of select="id($idp)/@lname" />
			Group
			<xsl:value-of select="substring-after($idg,'g')" />
			,
			<xsl:value-of select="../../@date" />
		</h2>


		<table border="1" style="border-collapse:collapse" background-color="#000000" color="#FFFFFF">
			<tr>
				<th>target</th>
				<th>1. arrow</th>
				<th>2. arrow</th>
				<th>3. arrow</th>
				<th>4. arrow</th>
			</tr>
			<xsl:for-each select="scorecard">
				<xsl:for-each select="station">
					<tr>
						<td>
							<xsl:value-of select="position()" />
						</td>
						<xsl:for-each select="Scorentry">
							<td>
								<xsl:value-of select="@points" />
							</td>
						</xsl:for-each>
					</tr>
				</xsl:for-each>
			</xsl:for-each>

		</table>

	</xsl:template>

</xsl:stylesheet>