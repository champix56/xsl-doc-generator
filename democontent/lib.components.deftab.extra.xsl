<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format">
	<xsl:template name="makeSVGPointValue">
		<xsl:param name="nodesList"/>
		<xsl:param name="ratioX"/>
		<xsl:param name="ratioY"/>
		<xsl:for-each select="$nodesList/*">
			<xsl:value-of select="$ratioX * position()"/>,<xsl:value-of select="$ratioY * ."/>
			<xsl:if test="position() != last()">
				<xsl:text> </xsl:text>
			</xsl:if>
		</xsl:for-each>
	</xsl:template>
	<xsl:template match="*[@style='defTab']" mode="graph">
		<xsl:param name="width">5cm</xsl:param>
		<xsl:param name="height">5cm</xsl:param>
		<fo:instream-foreign-object scaling="uniform" content-height="{$height}" content-width="{$width}">
			<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" viewBox="-30 -20 1640 1030">
				<defs>
					<marker id="triangle" viewBox="0 0 10 10" refX="1" refY="5" markerUnits="strokeWidth" markerWidth="10" markerHeight="10" orient="auto">
						<path d="M 0 0 L 10 5 L 0 10 z" fill="#f00"/>
					</marker>
					<symbol id="Axes">
						<!--<polygon points="20,-1 25,5 15,5"/>
			<text x="112" y="115">X</text>
			<polygon points="121,100 115,95 115,105"/>
			<text x="5" y="10">Y</text>
			<rect x="40" y="97.5" width="1" height="5" style="fill:black"/>
			<text x="35" y="115">10</text>
			<rect x="70" y="97.5" width="1" height="5" style="fill:black"/>
			<text x="65" y="115">20</text>
			<rect x="100" y="97.5" width="1" height="5" style="fill:black"/>
			<text x="95" y="115">30</text>
			<rect x="18.5" y="20" width="5" height="1" style="fill:black"/>
			<text x="3" y="25">10</text>
			<rect x="18.5" y="50" width="5" height="1" style="fill:black"/>
			<text x="3" y="55">20</text>
			<rect x="18" y="80" width="5" height="1" style="fill:black"/>
			<text x="3" y="85">30</text>-->
						<line x1="20" y1="0" x2="20" y2="990" stroke="black" stroke-width="4" marker-start="url(#triangle)"/>
						<line x1="20" y1="990" x2="1520" y2="990" stroke="black" marker-end="url(#triangle)" stroke-width="4"/>
					</symbol>
					<linearGradient id="effetArrondiVertical" x1="0%" x2="100%" y1="20%" y2="0">
						<stop offset="0%" stop-color="#B7CA79"/>
						<stop offset="80%" stop-color="#677E52"/>
					</linearGradient>
				</defs>
				<!--<text x="0" y="0">Hellllllo</text>-->
				<xsl:variable name="values">
					<xsl:call-template name="makeSVGPointValue">
						<xsl:with-param name="nodesList">
							<xsl:for-each select="./row">
								<values>
									<xsl:value-of select="col[@name='Température']"/>
								</values>
							</xsl:for-each>
						</xsl:with-param>
						<xsl:with-param name="ratioX" select="1500 div (count(row)-1)"/>
						<xsl:with-param name="ratioY" select="1000 div 40"/>
					</xsl:call-template>
				</xsl:variable>
				<polyline points="{$values}" fill="none" stroke="black" stroke-width="7"/>
				<!--			<defs>
					<marker id="arrow" viewBox="0 0 10 10" refX="5" refY="5" markerWidth="6" markerHeight="6" orient="auto-start-reverse">
						<path d="M 0 0 L 10 5 L 0 10 z"/>
					</marker>
					<marker id="dot" viewBox="0 0 10 10" refX="5" refY="5" markerWidth="5" markerHeight="5">
						<circle cx="5" cy="5" r="5" fill="red"/>
					</marker>
				</defs>
				<g>
					<line y1="80" x1="0" x2="230" y2="80" class="_GraphCloudPoint-module__grid__3lSVD"/>
					<text alignment-baseline="middle" text-anchor="end" x="-2" y="80" class="_GraphCloudPoint-module__legendValue__3_LV5">8</text>
				</g>
				<g>
					<line y1="60" x1="0" x2="230" y2="60" class="_GraphCloudPoint-module__grid__3lSVD"/>
					<text alignment-baseline="middle" text-anchor="end" x="-2" y="60" class="_GraphCloudPoint-module__legendValue__3_LV5">16</text>
				</g>
				<g>
					<line y1="40" x1="0" x2="230" y2="40" class="_GraphCloudPoint-module__grid__3lSVD"/>
					<text alignment-baseline="middle" text-anchor="end" x="-2" y="40" class="_GraphCloudPoint-module__legendValue__3_LV5">24</text>
				</g>
				<g>
					<line y1="20" x1="0" x2="230" y2="20" class="_GraphCloudPoint-module__grid__3lSVD"/>
					<text alignment-baseline="middle" text-anchor="end" x="-2" y="20" class="_GraphCloudPoint-module__legendValue__3_LV5">32</text>
				</g>
				<g>
					<line y1="0" x1="0" x2="230" y2="0" class="_GraphCloudPoint-module__grid__3lSVD"/>
					<text alignment-baseline="middle" text-anchor="end" x="-2" y="0" class="_GraphCloudPoint-module__legendValue__3_LV5">40</text>
				</g>
				<polyline points="16.428571428571427,0 49.28571428571428,22.5 82.14285714285714,42.5 114.99999999999999,0 147.85714285714283,25 180.7142857142857,70 213.57142857142853,42.5" fill="none" stroke="black" marker-start="url(#dot)" marker-end="url(#dot)" marker-mid="url(#dot)"/>
				<polyline points="0,-5 0,100 230,100" fill="none" stroke="black" marker-start="url(#arrow)" marker-end="url(#arrow)"/>-->
				<use xlink:href="#Axes" x="-15" y="0"/>
			</svg>
		</fo:instream-foreign-object>
	<!--	<xsl:value-of select=".//*"/>-->
	<xsl:apply-templates select="." mode="#default"/>
	</xsl:template>
	<xsl:template match="*[@style='defTab']">
		<xsl:if test="./row/col">
			<fo:table>
				<fo:table-header>
					<fo:table-row>
						<xsl:for-each select="./row[1]/col/@name">
							<fo:table-cell>
								<fo:block xsl:use-attribute-sets="th">
									<xsl:value-of select="."/>
								</fo:block>
							</fo:table-cell>
						</xsl:for-each>
					</fo:table-row>
				</fo:table-header>
				<fo:table-body>
					<xsl:apply-templates select="row"/>
				</fo:table-body>
			</fo:table>
		</xsl:if>
	</xsl:template>
	<xsl:template match="*[@style='defTab']/row">
		<fo:table-row>
			<xsl:apply-templates select="col"/>
		</fo:table-row>
	</xsl:template>
	<xsl:template match="*[@style='defTab']/row/col">
		<fo:table-cell>
			<fo:block>
				<xsl:value-of select="."/>
			</fo:block>
		</fo:table-cell>
	</xsl:template>
</xsl:stylesheet>
