<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:output method="html"/>

	<xsl:template match="/music_database">
		<html>
			<head>
				<title>Musik-Datenbanken</title>
			</head>
			<body>
				<h1>Meine Alben</h1>	
				<ul>
					<xsl:apply-templates select="album" mode="get_title"/>					
				</ul>
				
				<xsl:apply-templates select="album" mode="get_details"/>
				<ul>
					<xsl:apply-templates select="genre" mode="get_genres"></xsl:apply-templates>
				</ul>
			</body>
		</html>
	</xsl:template>
	
	
	<xsl:template match="album" mode="get_title">
		<a href="#{@album_id}">
			<li><xsl:value-of select="@album_name"/></li>
		</a>
	</xsl:template>
	
	<xsl:template match="album" mode="get_details">
		<h1 id="{@album_id}">
			<xsl:value-of select="@album_name"/>
		</h1>
			<xsl:variable name="m" select="id(@musician_id)"/>
		<p>
			<xsl:choose>
				<xsl:when test="$m/@artist_name != ''">
					<xsl:value-of select="$m/@artist_name"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="$m/@first_name"/>
					<xsl:text> </xsl:text>
					<xsl:value-of select="$m/@last_name"/>
				</xsl:otherwise>
			</xsl:choose>
		</p>
		<ol>
			<xsl:for-each select="contains">
				<li>
					<xsl:variable name="s" select="id(@song_id)"/>
					<xsl:value-of select="$s/@title"/>
					<ul>
						<li>
							<a>Vocalist: </a>
								<ul>
									<xsl:for-each select="$s/sings_song">
										<xsl:variable name="p" select="id(@person_id)"/>
										<xsl:choose>
											<xsl:when test="$p/@artist_name != ''">
												<xsl:value-of select="$p/@artist_name"/>
											</xsl:when>
											<xsl:otherwise>
												<xsl:value-of select="$p/@first_name"/>
												<xsl:text> </xsl:text>
												<xsl:value-of select="$p/@last_name"/>
											</xsl:otherwise>
										</xsl:choose>
										<br></br>
									</xsl:for-each>
								</ul>
							<a>Writer: </a>
								<ul>
									<xsl:for-each select="$s/writes_song">
											<xsl:variable name="p" select="id(@person_id)"/>
											<xsl:choose>
												<xsl:when test="$p/@artist_name != ''">
													<xsl:value-of select="$p/@artist_name"/>
												</xsl:when>
												<xsl:otherwise>
													<xsl:value-of select="$p/@first_name"/>
													<xsl:text> </xsl:text>
													<xsl:value-of select="$p/@last_name"/>
												</xsl:otherwise>
											</xsl:choose>
											<br></br>
										</xsl:for-each>
								</ul>
						</li>			
						<li>		
							<a>Dauer: </a>
							<xsl:value-of select="$s/@duration"/>
							<a> Sekunden </a>
						</li>	
						<li>	
							<a>Erscheinungsjahr: </a>
							<xsl:value-of select="$s/@release_date"/>
						</li>
					</ul>
					<br></br>
				</li>
			</xsl:for-each>
		</ol>
	</xsl:template>
	
	<xsl:template match="genre" mode="get_genres">
		<h2>
			<xsl:value-of select="@name"/>
		</h2>
		<ul>
			<xsl:for-each select="has">				
					<xsl:variable name="sid" select="@song_id"/>
					<xsl:variable name="s" select="id(@song_id)"/>
					<li>
						<xsl:value-of select="$s/@title"/>
					</li>
					<xsl:for-each select="//album[contains/@song_id = $sid]">
						<ul>
							<a>* </a>
							<a href="#{@album_id}">
								<xsl:value-of select="@album_name"/>
							</a>
							<br></br>
						</ul>	
					</xsl:for-each>										
			</xsl:for-each>
		</ul>		
	</xsl:template>
</xsl:stylesheet>