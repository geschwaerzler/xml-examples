<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html"/>

	<xsl:key name="p_id" match="/archery_event/tournament/group/target/score/@participant_id"
		use="."/>

	<xsl:template match="/archery_event">
		<html>
			<script src="https://www.kryogenix.org/code/browser/sorttable/sorttable.js"/>

			<head>
				<title>
					<xsl:apply-templates select="tournament" mode="getTournamentName"/>
				</title>
			</head>

			<body>
				<style>
					table,
					th,
					td {
					    border: 1px solid black;
					    border-collapse: collapse;
					}</style>

				<!-- tournament name -->
				<h1>
					<xsl:apply-templates select="tournament" mode="getTournamentName"/>
				</h1>
				
				<img src="arch.jpg" height="300" align="left"/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>
				
				<!-- divisions with participants -->
				<h2>Classes</h2>
				<xsl:apply-templates select="tournament/division" mode="getDivisions"/>

				<!-- all groups with scores -->
				<h2>Groups (sortable Tables)</h2>
				<xsl:apply-templates select="tournament" mode="getGroupRanking"/>

				<!-- scores of invidual participants -->
				<h2>Individual Scores</h2>
				<xsl:for-each select="//participant">
					<xsl:call-template name="getScoresPerParticipant">
						<xsl:with-param name="p_id" select="@id"/>
					</xsl:call-template>
				</xsl:for-each>
			</body>
		</html>
	</xsl:template>


	<!-- tournament name -->
	<xsl:template match="tournament" mode="getTournamentName">
		<xsl:value-of select="./@tournament_name"/>
	</xsl:template>

	<!-- all participants with link -->
	<xsl:template match="participant" mode="getParticipants">
		<ul>
			<xsl:for-each select=".">
				<li>
					<a href="#{generate-id(key('p_id', @id))}">
						<xsl:value-of select="@lname"/>
						<xsl:text>, </xsl:text>
						<xsl:value-of select="@fname"/>
						<xsl:text> (</xsl:text>
						<xsl:value-of select="@country"/>
						<xsl:text>)</xsl:text>
					</a>
				</li>
			</xsl:for-each>
		</ul>
	</xsl:template>

	<!-- all divisions seperated by gender and class -->
	<xsl:template match="division" mode="getDivisions">
		<h3>
			<xsl:value-of select="@division_name"/>
			<xsl:text> (</xsl:text>
			<xsl:value-of select="@age_from"/>
			<xsl:text> - </xsl:text>
			<xsl:value-of select="@age_to"/>
			<xsl:text>)</xsl:text>
		</h3>
		<xsl:for-each select="class">
			<xsl:apply-templates select="." mode="getGender"/>
			<xsl:apply-templates select="participant" mode="getParticipants"/>
		</xsl:for-each>
	</xsl:template>


	<!-- rename gender -->
	<xsl:template match="class" mode="getGender">
		<xsl:if test="@gender = 'M'">
			<h4>Männer</h4>
		</xsl:if>
		<xsl:if test="@gender = 'F'">
			<h4>Frauen</h4>
		</xsl:if>
	</xsl:template>


	<!-- list the groups with scores and ranking -->
	<xsl:template match="tournament" mode="getGroupRanking">
		<xsl:for-each select="group">

			<h3>
				<xsl:value-of select="@group_id"/>
			</h3>
			<table class="sortable">
				<th>Name</th>
				<th>Target 1</th>
				<th>Target 2</th>
				<th>Overall</th>

				<h4>
					<xsl:value-of select="../@target_id"/>
				</h4>
				<xsl:for-each
					select="target/score/@participant_id[generate-id() = generate-id(key('p_id', .))]">
					<tr>
						<xsl:variable name="score1">
							<xsl:call-template name="getScorePerParticipantAndTarget">
								<xsl:with-param name="p_id" select="."/>
								<xsl:with-param name="t_id" select="../../@target_id"/>
							</xsl:call-template>
						</xsl:variable>
						
						<xsl:variable name="number">
							<xsl:value-of select="number(substring(../../@target_id, 7)) + 1"/>
						</xsl:variable>
						
						<xsl:variable name="score2">
							<xsl:call-template name="getScorePerParticipantAndTarget">
								<xsl:with-param name="p_id" select="."/>
								<xsl:with-param name="t_id"
									select="concat('target', string($number))"/>
							</xsl:call-template>
						</xsl:variable>

						<td>
							<a href="#{generate-id(key('p_id', ../@participant_id))}">
								<xsl:call-template name="getNameOfParticipant">
									<xsl:with-param name="p_id" select="."/>
								</xsl:call-template>
							</a>
						</td>
						<td>
							<xsl:value-of select="$score1"/>
						</td>
						<td>
							<xsl:value-of select="$score2"/>
						</td>
						<td>
							<xsl:value-of select="$score1 + $score2"/>
						</td>
					</tr>
				</xsl:for-each>
			</table>
		</xsl:for-each>
	</xsl:template>


	<!-- name for participant -->
	<xsl:template name="getNameOfParticipant">
		<xsl:param name="p_id"/>
		<xsl:for-each select="//participant">
			<xsl:if test="@id = $p_id">
				<xsl:value-of select="@lname"/>
				<xsl:text>, </xsl:text>
				<xsl:value-of select="@fname"/>
			</xsl:if>
		</xsl:for-each>
	</xsl:template>


	<!-- score of participant at one target -->
	<xsl:template name="getScorePerParticipantAndTarget">
		<xsl:param name="p_id"/>
		<xsl:param name="t_id"/>
		<xsl:for-each select="//score[(@participant_id = $p_id)]">
			<xsl:if test="(../@target_id = $t_id)">
				<xsl:value-of select="@target_score"/>
			</xsl:if>
		</xsl:for-each>
	</xsl:template>


	<!-- scores per particpant -->
	<xsl:template name="getScoresPerParticipant">
		<xsl:param name="p_id"/>
		<xsl:for-each select="//participant">
			<xsl:if test="@id = $p_id">
				<h4 id="{generate-id(key('p_id', @id))}">
					<xsl:value-of select="@lname"/>
					<xsl:text>, </xsl:text>
					<xsl:value-of select="@fname"/>
					<xsl:text> (</xsl:text>
					<xsl:value-of select="@country"/>
					<xsl:text>)</xsl:text>
				</h4>
			</xsl:if>
		</xsl:for-each>

		<xsl:for-each select="//score">
			<xsl:if test="@participant_id = $p_id">
				<h5>
					<xsl:text>Target: </xsl:text>
					<xsl:value-of select="../@target_id"/>
					<xsl:text> (Size: </xsl:text>
					<xsl:value-of select="../@size"/>
					<xsl:text>)</xsl:text>
				</h5>
				<h6>
					<xsl:text>Score: </xsl:text>
					<xsl:value-of select="@target_score"/>
				</h6>
			</xsl:if>
		</xsl:for-each>
	</xsl:template>

</xsl:stylesheet>
