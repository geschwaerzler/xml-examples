<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns="http://www.w3.org/1999/xhtml">

	<xsl:template match="/archery-tournament">
		<!-- TODO: Auto-generated template -->
		<html>

			<head>
				<style>
					td {text-align: right;}
					th, td {
					padding: 5px;
					}

				</style>

				<title>
					<xsl:value-of select="@name" />
				</title>

			</head>

			<body>


				<h1>
					<xsl:value-of select="@name" />
				</h1>

				<h2> Table of Content </h2>

				<ul>

					<xsl:apply-templates select="tournament"
						mode="toc" />

				</ul>

				<xsl:apply-templates select="tournament"
					mode="details" />
				<h2> Athletes </h2>

				<ol>

					<xsl:apply-templates select="athlete"
						mode="toc" />

				</ol>

				<!-- <xsl:for-each select="athlete"> <h3 xml:space="preserve"> <xsl:value-of 
					select="@firstname" /> <xsl:value-of select="text()" /> </h3> -->

				<xsl:variable name="athleteID" select="@id" />

				<!-- <ul> <xsl:for-each select="//athlete[@athlete-id = @athleteID]"> 
					<xsl:sort select="firstname" /> <li> <xsl:variable name="mem" select="." 
					/> <xsl:variable name="athmem" select="//athlete[@id=$mem/@athlete-id]" /> 
					<xsl:value-of select="$athmem/firstname" /> <xsl:value-of select="$athmem/lastname" 
					/> </li> </xsl:for-each> </ul> -->

				<!-- </xsl:for-each> -->



				<xsl:apply-templates select="athlete"
					mode="detail" />

				<br />


			</body>

		</html>

	</xsl:template>

	<xsl:template match="tournament" mode="toc">

		<xsl:variable name="t" select="." />
		<xsl:variable name="athletes"
			select="//scorecard[@tournament-id=$t/@id]/.." />
		<xsl:variable name="groups"
			select="//member[@athlete-id=$athletes/@id]/.." />
		<xsl:if test="$athletes">

			<li>
				<a href="#{generate-id($t)}">
					<xsl:value-of select="@name" />
				</a>

				<ul>

					<xsl:for-each select="$groups">
						<li>
							<a href="#{generate-id(.)}">
								<xsl:value-of select="@name" />
							</a>
						</li>

					</xsl:for-each>


				</ul>
			</li>

		</xsl:if>
	</xsl:template>


	<xsl:template match="tournament" mode="details">

		<xsl:variable name="t" select="." />
		<xsl:variable name="athletes"
			select="//scorecard[@tournament-id=$t/@id]/.." />
		<xsl:variable name="groups"
			select="//member[@athlete-id=$athletes/@id]/.." />
		<xsl:if test="$athletes">

			<hr />

			<h2 id="#{generate-id($t)}">
				<xsl:value-of select="$t/@name" />
			</h2>
			<li>
				<a id="#{generate-id()}">
					<xsl:value-of select="@name" />
				</a>

				<ul>

					<xsl:for-each select="$groups" mode="toc">
						<li id="{generate-id(.)}">

							<xsl:value-of select="./@name" />

							<ol>

								<xsl:for-each select="member">


									<li>
										<a href="#{@athlete-id}">
											<xsl:variable name="mem" select="." />
											<xsl:variable name="athmem"
												select="//athlete[@id=$mem/@athlete-id]" />
											<xsl:value-of select="$athmem/firstname" />
											<xsl:value-of select="$athmem/lastname" />
										</a>
									</li>

								</xsl:for-each>

							</ol>
						</li>


					</xsl:for-each>


				</ul>
			</li>

		</xsl:if>
	</xsl:template>

	<xsl:template match="athlete" mode="toc">

		<li>
			<a href="#{@id}">
				<xsl:value-of select="firstname" />
				<xsl:value-of select="lastname" />
			</a>
		</li>

	</xsl:template>

	<xsl:template match="athlete" mode="detail">

		<hr />

		<h2 id="athlete-id{position()}">
			<xsl:value-of select="firstname" />
			<xsl:value-of select="lastname" />
		</h2>

		<p xml:space="preserve">
			<xsl:value-of select="id(@athlete-id)/@firstname" />
			<xsl:value-of select="id(@athlete-id)/text()" />
			<xsl:value-of select="id(@athlete-id)/@lastname" />
			<xsl:value-of select="id(@athlete-id)/text()" />
		</p>

		<xsl:apply-templates select="scorecard" />

	</xsl:template>

	<xsl:template match="scorecard">


		<a id="{../@id}">
			<xsl:value-of select="@athlete" />
		</a>


		<table border="1">

			<tr bgcolor="white">
				<td />
				<th colspan="3"> Score per Arrow </th>
			</tr>
			<xsl:for-each select="total_score/target_score">
				<tr>
					<th>
						<xsl:value-of select="@target-id" />
					</th>
					<td>
						<xsl:value-of
							select="score_per_arrow[@name='arrow1']" />
					</td>
					<td>
						<xsl:value-of
							select="score_per_arrow[@name='arrow2']" />
					</td>
					<td>
						<xsl:value-of
							select="score_per_arrow[@name='arrow3']" />
					</td>

				</tr>
			</xsl:for-each>

		</table>



	</xsl:template>

</xsl:stylesheet>