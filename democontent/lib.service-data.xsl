<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format">
<xsl:import href="lib.styles.xsl"/>
	<xsl:template match="/service">
		<fo:block>
			<fo:block xsl:use-attribute-sets="h3 defaultColor" margin-bottom="3mm">
				<xsl:value-of select="nom"/>
			</fo:block>
			<fo:block font-style="italic" font-size="9pt" text-align="center">
				<xsl:value-of select="tel"/>
			</fo:block>
			<xsl:apply-templates select="section"/>
		</fo:block>
	</xsl:template>
	<xsl:template match="/service/section">
		<fo:block xsl:use-attribute-sets="h4" margin-top="5mm">
				<xsl:value-of select="@type"/>
			</fo:block>
			<xsl:apply-templates select="employe"/>
	</xsl:template>
	<xsl:template match="/service/section/employe">
		<fo:block text-align="center"><xsl:value-of select="concat(@civ,' ',nom)"/></fo:block>
	</xsl:template>
</xsl:stylesheet>
