<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:output method="html" />
	<xsl:template match="/eventFinder">
		<html>
		<head>
		<title>EventPlanning</title>
		<style>
	        .scroll-bar-description{
	        height: 70px;
	        width: 90%;
	        border: 1px solid grey;
	        font-family: 'Arial';
	        overflow: auto;
	        border: none;
	        }
	        .scroll-bar-tickets{
	        height: 20%;
	        width: 90%;
	        border: 1px solid grey;
	        font-family: 'Arial';
	        overflow: auto;
	        }
	        .scroll-bar-planner{
	        height: 10%;
	        width: 90%;
	        border: 1px solid grey;
	        font-family: 'Arial';
	        overflow: auto;
	        }
	        .event-container{
	        	display: grid;
	        	grid-template-columns: 33% 33% 33%;
	        	grid-auto-rows: 700px
	        }
        </style>
		</head>
		<body>
		<h1>Welcome to the Event Planner!</h1>
		<h2>Table of contents</h2>
		<ul>
			<xsl:for-each select="eventPlanner">
				<xsl:for-each select="event">
					<li>
					<a>
						<xsl:attribute name="href">
							<xsl:value-of select="concat('#', generate-id())"></xsl:value-of>
						</xsl:attribute>
						<xsl:value-of select="@name"></xsl:value-of>
						</a>
					</li>
				</xsl:for-each>
			</xsl:for-each>
		</ul>
		<h2>Events</h2>
		<div class="event-container">
		<xsl:apply-templates select="eventPlanner"/>
		</div>
		</body>
		</html>
	</xsl:template>
	
	<xsl:template match="eventPlanner">
		<xsl:apply-templates select="event"/>
	</xsl:template>
	
	<xsl:template match="event">
		<div class="event">
		<xsl:attribute name="id">
			<xsl:value-of select="generate-id()"/>
		</xsl:attribute>
		<h2>
			Event:
			<xsl:value-of select="@name"/>
		</h2>
		<h3>
			Establishment: <xsl:value-of select="id(@establishmentID)/@companyName"/>
			<br/>
			Date: <xsl:value-of select="@date"/>
		</h3>
		<div class="scroll-bar-description">
		<p>
			<xsl:value-of select="."/>
		</p>
		</div>
		<h3>
			Address:
		</h3>
			<table>
			<thead>
			</thead>
			<tbody>
				<tr>
					<td>Country</td>
					<td><xsl:value-of select="id(@locationID)/address/@country"/></td>
				</tr>
				<tr>
					<td>City</td>
					<td><xsl:value-of select="id(@locationID)/address/@city"/></td>
				</tr>
				<tr>
					<td>Street</td>
					<td><xsl:value-of select="id(@locationID)/address/@street"/></td>
				</tr>
				<tr>
					<td>Number</td>
					<td><xsl:value-of select="id(@locationID)/address/@number"/></td>
				</tr>
			</tbody>
			</table>
		<h3>
			Tickets:
		</h3>
			<div class="scroll-bar-tickets">
			<xsl:variable name="eventRef" select="./@eventID"/>
			 <xsl:for-each select="/eventFinder/plebeian">
			 	<xsl:for-each select="ticket">
			 	<xsl:if test="@eventID = $eventRef">
			 	<table>
			 		<thead>
					</thead>
					<tbody>
						<tr>
							<td>Ticket-ID</td>
							<td><xsl:value-of select="@id"></xsl:value-of></td>
						</tr>
						<tr>
						<td> First-name:</td>
						<td> <xsl:value-of select="../@accountFName"></xsl:value-of></td>
						</tr>
						<tr>
						<td> Last-name:</td>
						<td> <xsl:value-of select="../@accountLName"></xsl:value-of></td>
						</tr>
						<xsl:for-each select="../telephonenumber">
						<tr>
						<td> Telephone-number:</td>
						<td> <xsl:value-of select="@number"></xsl:value-of></td>
						</tr>
						</xsl:for-each>
						<xsl:for-each select="../email">
						<tr>
						<td> Email:</td>
						<td> <xsl:value-of select="@email"></xsl:value-of></td>
						</tr>
						</xsl:for-each>
						<xsl:for-each select="../bankaccount">
						<tr>
						<td> Bankaccount:</td>
						</tr>
						<tr>
						<td>Number:</td>
						<td><xsl:value-of select="@number"></xsl:value-of></td>
						</tr>
						<tr>
						<td>CV</td>
						<td><xsl:value-of select="@cv"></xsl:value-of></td>
						</tr>
						</xsl:for-each>
						
					</tbody>
			 	</table>
			 	<br/>
			 	</xsl:if>
			 	</xsl:for-each>
			 </xsl:for-each>
			 </div>
			 <h3>Event Planner</h3>
			 <div class="scroll-bar-planner">
			 	<table>
			 		<thead>
					</thead>
					<tbody>
						<tr>
						<td> First-name:</td>
						<td> <xsl:value-of select="../@accountFName"></xsl:value-of></td>
						</tr>
						<tr>
						<td> Last-name:</td>
						<td> <xsl:value-of select="../@accountLName"></xsl:value-of></td>
						</tr>
						<xsl:for-each select="../telephonenumber">
						<tr>
						<td> Telephone-number:</td>
						<td> <xsl:value-of select="@number"></xsl:value-of></td>
						</tr>
						</xsl:for-each>
						<xsl:for-each select="../email">
						<tr>
						<td> Email:</td>
						<td> <xsl:value-of select="@email"></xsl:value-of></td>
						</tr>
						</xsl:for-each>
						<xsl:for-each select="../bankaccount">
						<tr>
						<td> Bankaccount:</td>
						</tr>
						<tr>
						<td>Number:</td>
						<td><xsl:value-of select="@number"></xsl:value-of></td>
						</tr>
						<tr>
						<td>CV</td>
						<td><xsl:value-of select="@cv"></xsl:value-of></td>
						</tr>
						</xsl:for-each>
					</tbody>
			 	</table>
			 </div>
		</div>
	</xsl:template>
</xsl:stylesheet>