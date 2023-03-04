<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format">
	<xsl:include href="lib.components.richtext.extra.xsl"/>
	<xsl:include href="lib.components.deftab.extra.xsl"/>
	<xsl:template match="*[@toPrint=0]" priority="100"/>
	<xsl:template match="*">
		<fo:block page-break-inside="avoid" border="0.3mm solid red" padding="5mm" margin-bottom="5mm" background-color="tomato" color="white">
			<fo:block text-align="center" color="red" text-decoration="underline" font-style="italic" font-weight="900">
				DEBUG
			</fo:block>
			style:<xsl:value-of select="@style"/>
			name:<xsl:value-of select="name()"/>
			<fo:block margin-left="10mm" margin-right="10mm">
				<xsl:apply-templates select="*"/>
			</fo:block>
		</fo:block>
	</xsl:template>
	<xsl:template match="*[@style='lbl']">
		<xsl:apply-templates select="@label"/>
	</xsl:template>
	<xsl:template match="@label">
		<xsl:choose>
			<xsl:when test="string-length(../@unformattedLabel)>=1">
				<xsl:value-of select="../@unformattedLabel"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="."/>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:if test="(string-length(../@unformattedLabel)>=1 or string-length(.)>=1) and ../@style!='lbl' "> : </xsl:if>
	</xsl:template>
	<xsl:template match="*[@style='txt']|*[@style='txtArea']">
		<xsl:apply-templates select="@label"/>
		<xsl:value-of select="."/>
	</xsl:template>
	<xsl:template name="checkbox-svg">
		<xsl:param name="checked" select=" 'off' "/>
		<fo:instream-foreign-object content-height="7mm" content-width="8mm" scaling="uniform">
			<svg xmlns="http://www.w3.org/2000/svg" width="100%" height="100%" viewBox="-1 -1 14 12">
				<rect width="10" height="10" x="0" y="0" fill="none" stroke="black"/>
				<xsl:if test="$checked='on' ">
					<polyline points="1.5,5.5 4.5,8.7 12,2" stroke="green" stroke-width="3" fill="none" stroke-linecap="round"/>
				</xsl:if>
			</svg>
		</fo:instream-foreign-object>
	</xsl:template>
	<xsl:template name="radiobutton-svg">
		<xsl:param name="checked" select=" 'off' "/>
		<fo:instream-foreign-object content-height="7mm" content-width="8mm" scaling="uniform">
			<svg xmlns="http://www.w3.org/2000/svg" width="100%" height="100%" viewBox="-1 -1 12 12">
				<circle r="4.5" cx="5" cy="5" fill="white" stroke="black" stroke-width="0.5"/>
				<xsl:if test="$checked='on' ">
					<circle r="3.5" cx="5" cy="5" fill="black" stroke="black" stroke-width="0"/>
				</xsl:if>
			</svg>
		</fo:instream-foreign-object>
	</xsl:template>
	<xsl:template match="list/*[@style='rad'] | *[@style='rad' and name()!='list']">
		<xsl:message>traitement rad :<xsl:value-of select="name()"/>
		</xsl:message>
		<xsl:apply-templates select="@label"/>
		<xsl:call-template name="radiobutton-svg">
			<xsl:with-param name="checked" select="."/>
		</xsl:call-template>
	</xsl:template>
	
	<xsl:template match="list/*[@style='chk'] | *[@style='chk' and name()!='list']">
		<xsl:message>traitement chk :<xsl:value-of select="name()"/>
		</xsl:message>
		<xsl:apply-templates select="@label"/>
		<xsl:call-template name="checkbox-svg">
			<xsl:with-param name="checked" select="."/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template match="list">
		<fo:block page-break-inside="avoid">
			<xsl:apply-templates select="@label"/>
			<xsl:for-each select="*">
				<fo:block/>
				<xsl:apply-templates select="."/>
			</xsl:for-each>
		</fo:block>
	</xsl:template>
	<!--TODO : -->
	<xsl:template match="*[@style='ReportHealthCard']">
		<fo:block>ReportHealthCard</fo:block>
	</xsl:template>

	<!--<xsl:template match="*[@style='defTab']">
		<fo:block>defTab</fo:block>
	</xsl:template>-->
</xsl:stylesheet>
