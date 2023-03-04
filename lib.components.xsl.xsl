<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format">
	<xsl:template match="xsl:attribute-set">
		<fo:block margin="5mm" border="0.3mm solid black" page-break-inside="avoid">
			<fo:block font-weight="900" text-align="center">
				<xsl:value-of select="@name"/>
			</fo:block>
			<fo:block font-style="italic" text-align="center">demo :</fo:block>
			<fo:block>
				<xsl:apply-templates select="xsl:attribute"/>
		Demonstration <xsl:value-of select="@name"/>
			</fo:block>
		</fo:block>
	</xsl:template>
	<xsl:template match="xsl:template[@match]">
		<fo:block margin="5mm" border="0.3mm solid black" page-break-inside="avoid">
			<fo:block font-weight="900" text-align="center">Template mach <xsl:value-of select="@match"/>
				<xsl:if test="@mode">mode="<xsl:value-of select="mode"/>"</xsl:if>
			</fo:block>
			<fo:block border-bottom="0.3mm solid black" margin="3mm" text-align="center">
				<xsl:value-of select="comment()"/>
			</fo:block>
			<fo:block>
				<xsl:apply-templates select="text()|fo:*|xsl:for-each|xsl:value-of|xsl:apply-templates"/>
			</fo:block>
		</fo:block>
	</xsl:template>
	<xsl:template match="xsl:template[@name]">
		<fo:block margin="5mm" border="0.3mm solid black" page-break-inside="avoid">
			<fo:block font-weight="900" text-align="center">Template name <xsl:value-of select="@name"/>
			</fo:block>
			<fo:block border-bottom="0.3mm solid black" margin="3mm" text-align="center">
				<xsl:value-of select="comment()"/>
			</fo:block>
			<fo:block>
				<xsl:apply-templates select="text()|fo:*|xsl:for-each|xsl:value-of|xsl:apply-templates"/>
			</fo:block>
		</fo:block>
	</xsl:template>
	<xsl:template match="xsl:attribute">
		<xsl:attribute name="{@name}"><xsl:value-of select="."/></xsl:attribute>
	</xsl:template>
	<xsl:template match="xsl:apply-templates">
		<fo:block margin-left="2mm">&lt;xsl:apply-templates select="<xsl:value-of select="@select"/>"&gt;</fo:block>
	</xsl:template>
	<xsl:template match="xsl:value-of">
		<fo:block margin-left="2mm">&lt;xsl:value-of select="<xsl:value-of select="@select"/>"&gt;</fo:block>
	</xsl:template>
	<xsl:template match="xsl:for-each">
		<fo:block margin-left="2mm">&lt;xsl:for-each select="<xsl:value-of select="@select"/>"&gt;
			<fo:block>
				<xsl:apply-templates select="text()|fo:*|xsl:for-each|xsl:value-of|xsl:apply-templates"/>
			</fo:block>
		</fo:block>
	</xsl:template>
	<xsl:template match="xsl:include">
		<fo:inline font-style="italic"><xsl:text> </xsl:text><xsl:value-of select=" @href "/></fo:inline>
	</xsl:template>
		<xsl:template match="fo:*">
		<fo:block margin-left="2mm">&lt;<xsl:value-of select="name()"/>
			<xsl:text> </xsl:text>
			<xsl:for-each select="@*">
				<xsl:value-of select="name()"/>="<xsl:value-of select="."/>"</xsl:for-each>&gt;
		<xsl:apply-templates select="text()|fo:*|xsl:for-each|xsl:value-of|xsl:apply-templates"/>
		&lt;/<xsl:value-of select="name()"/>&gt;</fo:block>
	</xsl:template>
</xsl:stylesheet>
