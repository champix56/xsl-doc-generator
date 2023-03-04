<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format">
	<xsl:include href="lib.components.xsl.xsl"/>
	<xsl:include href="lib.components.html.xsl"/>
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
		<xsl:variable name="includeInDoc" select="$doc//xsl:include"/>
		<fo:block font-weight="900" text-align="center" break-before="page">Liste des template de <xsl:value-of select="$title"/>
			<fo:block font-style="italic">
				<xsl:value-of select="$titleComplement"/>
			</fo:block>
			<fo:block/>&lt;include href="<xsl:value-of select="$fileName"/>"/&gt;</fo:block>
			<xsl:if test="count($includeInDoc)&gt;0">
			<fo:block margin="5mm" border="0.3mm solid black" text-align="center">
				<fo:block font-weight="700">liste des dépendances inclues</fo:block>
				<xsl:apply-templates select="$includeInDoc"/>
			</fo:block>
		</xsl:if>
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
						<xsl:for-each select="$xslDoc//doc">
							<xsl:call-template name="makeALibDoc">
								<xsl:with-param name="title">
									<xsl:value-of select="@title"/>
								</xsl:with-param>
								<xsl:with-param name="titleComplement">
									<xsl:value-of select="@titleCmplement"/>
								</xsl:with-param>
								<xsl:with-param name="fileName">
									<xsl:value-of select="@path"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:for-each>
					</fo:block>
				</fo:flow>
			</fo:page-sequence>
		</fo:root>
	</xsl:template>
</xsl:stylesheet>
