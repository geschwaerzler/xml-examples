<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:template match="/archery-contest">

		<html>

			<head>
				<title>World Archery Championship</title>
			</head>

			<body>

				<h1>Table of Contents</h1>


				<ol>
					<li>
						<a href="#title1">Scorecards</a>
					</li>
					<li>
						<a href="#title2">Participant List</a>
					</li>
					<li>
						<a href="#title3">Categories</a>
					</li>
					<li>
						<a href="#title4">Locations and Courses</a>
					</li>
					<li>
						<a href="#title5">Schedules</a>
					</li>
				</ol>

				<h1 id="title1">Scorecards</h1>


				<xsl:apply-templates select="."
					mode="scorecards" />


				<h1 id="title2">Participant List</h1>
				<xsl:apply-templates select="."
					mode="participant-list" />

				<h1 id="title3">Categories</h1>

				<xsl:apply-templates select="."
					mode="categories" />

				<h1 id="title4">Locations and Courses</h1>
				<xsl:apply-templates select="." mode="locations" />

				<h1 id="title5">Schedules</h1>
				<xsl:apply-templates select="." mode="schedules" />

			</body>
		</html>

	</xsl:template>


	<xsl:template match="/archery-contest"
		mode="participant-list">
		<table>
			<thead>
				<tr>
					<th>Vorname</th>
					<th>Nachname</th>
					<th>Alter</th>
					<th>Geschlecht</th>
					<th>Land</th>
				</tr>
			</thead>
			<tbody>

				<xsl:for-each select="participant">
					<tr id="{@id}">
						<td>

							<xsl:value-of select="first_name" />

						</td>
						<td>

							<xsl:value-of select="last_name" />

						</td>
						<td>

							<xsl:value-of select="age" />

						</td>
						<td>

							<xsl:value-of select="gender" />

						</td>
						<td>

							<xsl:value-of select="country" />

						</td>
					</tr>
				</xsl:for-each>
			</tbody>
		</table>
	</xsl:template>

	<xsl:template match="/archery-contest" mode="scorecards">

		<table>
			<thead>
				<tr>
					<th>Value</th>
					<th>Year</th>
					<th>Participant</th>
				</tr>
			</thead>
			<tbody>

				<xsl:for-each select="scorecard">
					<xsl:variable name="player"
						select="id(@participant-id)"></xsl:variable>
					<tr>
						<td>
							<xsl:value-of select="value" />
						</td>
						<td>
							<xsl:value-of select="year" />
						</td>
						<td>
							<a href="#{@participant-id}">
								<xsl:value-of
									select="concat($player/first_name, ' ' , $player/last_name)" />
							</a>
						</td>

					</tr>
				</xsl:for-each>
			</tbody>
		</table>


	</xsl:template>

	<xsl:template match="/archery-contest" mode="categories">

		<table>
			<thead>
				<tr>
					<th>Name</th>
					<th>Description</th>
					<th>Style</th>
				</tr>
			</thead>

			<tbody>
				<xsl:for-each select="category">
					<tr id="{@id}">
						<td>
							<xsl:value-of select="name" />
						</td>
						<td>
							<xsl:value-of select="description" />
						</td>
						<td>
							<xsl:value-of select="style" />
						</td>
					</tr>
				</xsl:for-each>

			</tbody>


		</table>

	</xsl:template>

	<xsl:template match="/archery-contest" mode="locations">
		<table>
			<thead>
				<tr>
					<th>Course Name</th>
					<th>Target Count</th>
					<th>Location Name</th>
					<th>Location Type</th>
					<th>Address</th>
					<th>Category ID</th>
				</tr>

			</thead>
			<tbody>
				<xsl:for-each select="course">
					<xsl:for-each select="takes_place_at">
						<xsl:variable name="location"
							select="id(@location-id)"></xsl:variable>

						<tr>
							<td>
								<xsl:value-of select="../name"></xsl:value-of>
							</td>
							<td>
								<xsl:value-of select="../target_count"></xsl:value-of>
							</td>
							<td>
								<xsl:value-of select="$location/name"></xsl:value-of>
							</td>
							<td>
								<xsl:value-of select="$location/type"></xsl:value-of>
							</td>
							<td>
								<xsl:value-of select="$location/address"></xsl:value-of>
							</td>
							<xsl:for-each select="../is_in_category">
								<xsl:variable name="category"
									select="id(@category-id)"></xsl:variable>
								<td>
									<xsl:value-of select="$category/name"></xsl:value-of>
								</td>
							</xsl:for-each>
						</tr>

					</xsl:for-each>
				</xsl:for-each>


			</tbody>
		</table>
	</xsl:template>

	<xsl:template match="/archery-contest" mode="schedules">
		<!-- <thead> <xsl:for-each select="schedule"> <tr> <th><xsl:value-of select="date"></xsl:value-of></th> 
			</tr> </xsl:for-each> </thead> -->
		<xsl:for-each select="schedule">
			<xsl:variable name="course" select="id(@course-id)"></xsl:variable>
			<p>
				Date:
				<xsl:value-of select="concat(date/day,'.')"></xsl:value-of>
				<xsl:value-of select="concat(date/month, '.')"></xsl:value-of>
				<xsl:value-of select="concat(date/year, ' ')"></xsl:value-of>

				<xsl:value-of select="start_time"></xsl:value-of>
				<br />
				Course:
				<xsl:value-of select="$course/name"></xsl:value-of>
			</p>
			<p>
				Participants:
				<ul>
					<xsl:for-each select="participates">
						<xsl:variable name="participant"
							select="id(@participant-id)"></xsl:variable>

						<li>


							<xsl:value-of
								select="concat($participant/first_name, ' ')"></xsl:value-of>

							<xsl:value-of select="$participant/last_name"></xsl:value-of>


						</li>
					</xsl:for-each>
				</ul>
				<hr></hr>
			</p>
		</xsl:for-each>
	</xsl:template>
</xsl:stylesheet>