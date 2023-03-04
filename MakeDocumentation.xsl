<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format">
<xsl:param name="xslDoc">
		<docs>
			<doc title="layout" path="../lib.layout.xsl"/>
			<doc title="raccourcis d'acces" path="../lib.common.data.access.xsl"/>
			<doc title="components global" path="../lib.components.xsl"/>
			<doc title="components " titleCmplement="richeText" path="../lib.components.richtext.extra.xsl"/>
			<doc title="components " titleCmplement="defTab" path="../lib.components.deftab.extra.xsl"/>
		</docs>
	</xsl:param>
	<xsl:template name="makeALibDoc">
		<xsl:param name="title"/>
		<xsl:param name="titleComplement" select="''"/>
		<xsl:param name="fileName"/>
		<xsl:variable name="doc" select="document($fileName)"/>
		<fo:block font-weight="900" text-align="center" break-before="page">Liste des template de <xsl:value-of select="$title"/>
			<fo:block/>
			<xsl:value-of select="$titleComplement"/>
			<fo:block/>&lt;include href="<xsl:value-of select="$fileName"/>"/&gt;</fo:block>
		<xsl:apply-templates select="$doc//xsl:template"/>
		<fo:block>Liste des styles du fichiers</fo:block>
		<xsl:apply-templates select="$doc//xsl:attribute-set"/>
	</xsl:template>
	<xsl:template match="/">
		<fo:root>
			<fo:layout-master-set>
				<fo:simple-page-master master-name="A4" page-height="297mm" page-width="210mm">
					<fo:region-body/>
				</fo:simple-page-master>
			</fo:layout-master-set>
			<fo:page-sequence master-reference="A4">
				<fo:flow flow-name="xsl-region-body">
					<fo:block>
						<fo:block font-weight="900" text-align="center">Liste des styles</fo:block>
						<xsl:apply-templates select="//xsl:attribute-set"/>
						<!--<xsl:call-template name="makeALibDoc">
							<xsl:with-param name="title">layout</xsl:with-param>
							<xsl:with-param name="fileName">lib.layout.xsl</xsl:with-param>
						</xsl:call-template>-->
						<!--<xsl:call-template name="makeALibDoc">
							<xsl:with-param name="title">raccourcis d'acces</xsl:with-param>
							<xsl:with-param name="fileName">lib.common.data.access.xsl</xsl:with-param>
						</xsl:call-template>-->
						<!--<xsl:call-template name="makeALibDoc">
							<xsl:with-param name="title">components global</xsl:with-param>
							<xsl:with-param name="fileName">lib.components.xsl</xsl:with-param>
						</xsl:call-template>-->
						<!--<xsl:call-template name="makeALibDoc">
							<xsl:with-param name="title">components</xsl:with-param>
							<xsl:with-param name="titleComplement">RicheText</xsl:with-param>
							<xsl:with-param name="fileName">lib.components.richtext.extra.xsl</xsl:with-param>
						</xsl:call-template>-->
						<xsl:call-template name="makeALibDoc">
							<xsl:with-param name="title">components</xsl:with-param>
							<xsl:with-param name="titleComplement">defTab</xsl:with-param>
							<xsl:with-param name="fileName">lib.components.deftab.extra.xsl</xsl:with-param>
						</xsl:call-template>
					</fo:block>
				</fo:flow>
			</fo:page-sequence>
		</fo:root>
	</xsl:template>
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
	<xsl:template match="fo:*">
		<fo:block margin-left="2mm">&lt;<xsl:value-of select="name()"/>
			<xsl:text> </xsl:text>
			<xsl:for-each select="@*">
				<xsl:value-of select="name()"/>="<xsl:value-of select="."/>"</xsl:for-each>&gt;
		<xsl:apply-templates select="text()|fo:*|xsl:for-each|xsl:value-of|xsl:apply-templates"/>
		&lt;/<xsl:value-of select="name()"/>&gt;</fo:block>
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
</xsl:stylesheet>
