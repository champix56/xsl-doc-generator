<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format">
	<xsl:include href="lib.components.xsl.xsl"/>
	<xsl:include href="lib.components.html.xsl"/>
	<xsl:param name="baseUrl">democontent/</xsl:param>
	<xsl:param name="xslDoc">
		<docs>
			<!--force an include file non auto with :<doc title="components " titleCmplement="defTab" path="../lib.components.deftab.extra.xsl"/>-->
			<xsl:call-template name="process-auto-recurs-include"/>
		</docs>
	</xsl:param>
	<xsl:variable name="contentList">
		<contents>
			<xsl:call-template name="process-auto-list-content"/>
		</contents>
	</xsl:variable>
	<xsl:template name="process-auto-list-content">
		<xsl:apply-templates select="$xslDoc//doc" mode="auto-list-content"/>
	</xsl:template>
	<xsl:template match="docs/doc" mode="auto-list-content">
		<xsl:variable name="docToList" select="document(@path)"/>
		<doc path="{@path}">
			<xsl:apply-templates select="$docToList//xsl:template|$docToList//xsl:attribute-set" mode="auto-list-content"/>
		</doc>
	</xsl:template>
	<xsl:template match="xsl:attribute-set" mode="auto-list-content">
		<xsl:variable name="nodeid">
			<xsl:call-template name="getIdName"/>
		</xsl:variable>
		<style name="{@name}" id="{$nodeid}"/>
	</xsl:template>
	<xsl:template match="xsl:template" mode="auto-list-content">
		<xsl:variable name="nodeid">
			<xsl:call-template name="getIdName"/>
		</xsl:variable>
		<template id="{$nodeid}">
			<xsl:choose>
				<xsl:when test="@name">
					<xsl:attribute name="name"><xsl:value-of select="@name"/></xsl:attribute>
				</xsl:when>
				<xsl:when test="@match">
					<xsl:attribute name="match"><xsl:value-of select="@match"/></xsl:attribute>
				</xsl:when>
			</xsl:choose>
		</template>
	</xsl:template>
	<xsl:template name="sommaire">
		<fo:block break-before="page">
			<fo:block text-align="center" font-size="16pt" font-weight="900">Sommaire</fo:block>
			<fo:block text-align="left" font-size="12pt" font-weight="500">
				<xsl:for-each select="$contentList/contents/doc/*">
					<xsl:sort select="name()"/>
					<xsl:sort select="@match"/>
					<xsl:sort select="@name"/>
					<fo:block margin-left="5mm">
						<fo:basic-link internal-destination="{@id}">
							<xsl:value-of select="name()"/>
							<xsl:text> </xsl:text>
							<xsl:choose>
								<xsl:when test="self::style">
									<xsl:text> </xsl:text><xsl:value-of select="@name"/>
								</xsl:when>
								<xsl:when test="self::template and @name"> name : <xsl:value-of select="@name"/>
								</xsl:when>
								<xsl:when test="self::template and @match">match : <xsl:value-of select="@match"/>
								</xsl:when>
							</xsl:choose> ... p<fo:page-number-citation ref-id="{@id}"/>
						</fo:basic-link>
					</fo:block>
				</xsl:for-each>
			</fo:block>
		</fo:block>
	</xsl:template>
	<xsl:template name="process-auto-recurs-include">
		<xsl:param name="doc" select="/*"/>
		<xsl:for-each select="$doc//xsl:include">
			<!--			<xsl:if test="not(contains($xslDoc//doc/@path,@href))">
-->
			<doc title="{@href} " path="{$baseUrl}{@href}"/>
			<xsl:call-template name="process-auto-recurs-include">
				<xsl:with-param name="doc" select="document(concat($baseUrl,@href))"/>
			</xsl:call-template>
			<!--			</xsl:if>
-->
		</xsl:for-each>
	</xsl:template>
	<xsl:template name="makeALibDoc">
		<xsl:param name="title"/>
		<xsl:param name="titleComplement" select="''"/>
		<xsl:param name="fileName"/>
		<xsl:variable name="doc" select="document($fileName)"/>
		<xsl:variable name="includeInDoc" select="$doc//xsl:include"/>
		<fo:block font-weight="900" text-align="center" break-before="page">Liste des contenus de <xsl:value-of select="$title"/>
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
		<xsl:if test="$doc//xsl:attribute-set">
			<fo:block font-weight="700" text-align="center">Liste des styles du fichiers</fo:block>
			<xsl:apply-templates select="$doc//xsl:attribute-set"/>
		</xsl:if>
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
						<fo:block font-size="18pt" text-align="center" margin-top="40%">
							Documentation XSL
						</fo:block>
						<xsl:call-template name="sommaire"/>
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
						<!--<xsl:call-template name="annexe"/>-->
					</fo:block>
				</fo:flow>
			</fo:page-sequence>
		</fo:root>
	</xsl:template>
</xsl:stylesheet>
