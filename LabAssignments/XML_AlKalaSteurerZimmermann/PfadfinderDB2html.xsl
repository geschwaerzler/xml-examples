<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:output encoding="UTF-8" method="html" />

	<xsl:decimal-format name="austria"
		decimal-separator="," grouping-separator="." />

	<xsl:template match="/PfadfinderDB">
		<html>
			<head>
				<title>
					<xsl:value-of select="Description" />
				</title>
			</head>
			<body>
				<h1>
					<xsl:value-of select="Description" />
				</h1>
				<h2>Table of Contents</h2>
				<h3>Resources</h3>
				<ol>
					<xsl:apply-templates select="Resource"
						mode="table-of-contents" />
				</ol>
				<h3>Leaders</h3>
				<ol>
					<xsl:apply-templates select="Leader"
						mode="table-of-contents" />
				</ol>
				<h3>Invitations</h3>
				<ol>
					<xsl:apply-templates select="Invitation"
						mode="table-of-contents" />
				</ol>
				<h3>Events</h3>
				<ol>
					<xsl:apply-templates select="Event"
						mode="table-of-contents" />
				</ol>
				<h3>Tasks</h3>
				<ol>
					<xsl:apply-templates select="Task"
						mode="table-of-contents" />
				</ol>

				<xsl:apply-templates select="Resource"
					mode="detail" />
				<xsl:apply-templates select="Leader"
					mode="detail" />
				<xsl:apply-templates select="Invitation"
					mode="detail" />
				<xsl:apply-templates select="Event"
					mode="detail" />
				<xsl:apply-templates select="Task" mode="detail" />

				<h3>Index</h3>
				<ol>
					<xsl:apply-templates
						select="Resource|Leader|Invitation|Event|Task" mode="index">
						<xsl:sort select="@name" />
					</xsl:apply-templates>
				</ol>


			</body>
		</html>
	</xsl:template>

	<xsl:template match="Resource" mode="table-of-contents">
		<li>
			<a href="#{@id}">
				<xsl:value-of select="@name" />
			</a>
		</li>
	</xsl:template>

	<xsl:template match="Leader" mode="table-of-contents">
		<li>
			<a href="#{@id}">
				<xsl:value-of select="@name" />
			</a>
		</li>
	</xsl:template>

	<xsl:template match="Invitation" mode="table-of-contents">
		<li>
			<a href="#{@id}">
				<xsl:value-of select="@name" />
			</a>
		</li>
	</xsl:template>

	<xsl:template match="Event" mode="table-of-contents">
		<li>
			<a href="#{@id}">
				<xsl:value-of select="@name" />
			</a>
		</li>
	</xsl:template>

	<xsl:template match="Task" mode="table-of-contents">
		<li>
			<a href="#{@id}">
				<xsl:value-of select="@name" />
			</a>
		</li>
	</xsl:template>

	<xsl:template match="Resource" mode="detail">
		<h3>
			<a id="{@id}"></a>
			<xsl:value-of select="@name" />
		</h3>
		<p>
			<b>ID: </b>
			<xsl:value-of select="@id" />
			<br />
			<b>Info: </b>
			<xsl:value-of select="@info" />
		</p>
	</xsl:template>

	<xsl:template match="Leader" mode="detail">
		<h3>
			<a id="{@id}"></a>
			<xsl:value-of select="@name" />
		</h3>
		<p>
			<b>ID: </b>
			<xsl:value-of select="@id" />
		</p>
	</xsl:template>

	<xsl:template match="Invitation" mode="detail">
		<h3>
			<a id="{@id}"></a>
			<xsl:value-of select="@name" />
		</h3>
		<p>
			<b>ID: </b>
			<xsl:value-of select="@id" />
			<br />
			<b>Invitation for: </b>
			<xsl:for-each select="for">
				<xsl:value-of select="@leader-id" />
				<br />
			</xsl:for-each>
			<b>Accepted: </b>
			<xsl:value-of select="@accepted" />
		</p>
	</xsl:template>

	<xsl:template match="Event" mode="detail">
		<h3>
			<a id="{@id}"></a>
			<xsl:value-of select="@name" />
		</h3>
		<p>
			<b>ID: </b>
			<xsl:value-of select="@id" />
			<br />
			<b>Info: </b>
			<xsl:value-of select="@info" />
			<br />
			<b>Startdate: </b>
			<xsl:value-of select="@startdate" />
			<br />
			<b>Enddate: </b>
			<xsl:value-of select="@enddate" />
			<br />
			<b>used resources: </b>
			<xsl:for-each select="uses">
				<br />
				<xsl:value-of select="@resource-id" />
			</xsl:for-each>
			<br />
			<b>invited leaders: </b>
			<xsl:for-each select="invited">
				<br />
				<xsl:value-of select="@invitation-id" />
			</xsl:for-each>
		</p>
	</xsl:template>

	<xsl:template match="Task" mode="detail">
		<h3>
			<a id="{@id}"></a>
			<xsl:value-of select="@name" />
		</h3>
		<p>
			<b>ID: </b>
			<xsl:value-of select="@id" />
			<br />
			<b>Info: </b>
			<xsl:value-of select="@info" />
			<br />
			<b>Duedate: </b>
			<xsl:value-of select="@duedate" />
			<br />
			<b>assigned to: </b>
			<xsl:for-each select="assigned">
				<br />
				<xsl:value-of select="@leader-id" />
			</xsl:for-each>
		</p>
	</xsl:template>

	<xsl:template match="Resource" mode="index">
		<li>
			<a href="#{@id}">
				<xsl:value-of select="@name" />
			</a>
		</li>
	</xsl:template>

	<xsl:template match="Leader" mode="index">
		<li>
			<a href="#{@id}">
				<xsl:value-of select="@name" />
			</a>
		</li>
	</xsl:template>

	<xsl:template match="Invitation" mode="index">
		<li>
			<a href="#{@id}">
				<xsl:value-of select="@name" />
			</a>
		</li>
	</xsl:template>

	<xsl:template match="Event" mode="index">
		<li>
			<a href="#{@id}">
				<xsl:value-of select="@name" />
			</a>
		</li>
	</xsl:template>

	<xsl:template match="Task" mode="index">
		<li>
			<a href="#{@id}">
				<xsl:value-of select="@name" />
			</a>
		</li>
	</xsl:template>

</xsl:stylesheet>