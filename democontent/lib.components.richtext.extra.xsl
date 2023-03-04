<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet SYSTEM "./dtd/entities.dtd">
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format">
<xsl:import href="./lib.styles.xsl"/>
	<xsl:template match="*[@style='richetxt']">
		<fo:block>
			<xsl:apply-templates select="text()|*"/>
		</fo:block>
	</xsl:template>
	<!--fonction de traitement lié a HTML-->
	<!--fonction de traitement lié a HTML-->
	<xsl:template name="htmlStyleProcessor">
		<!--que si presence d'@ttrib dans le contexte actuelle-->
		<xsl:if test="@style">
			<xsl:variable name="indexOf">
				<xsl:call-template name="indexOfChar">
					<xsl:with-param name="char">:</xsl:with-param>
					<xsl:with-param name="string" select="@style"/>
				</xsl:call-template>
			</xsl:variable>
			<xsl:variable name="propriete" select="substring(@style,1,$indexOf - 1)"/>
			<xsl:variable name="valueWithPonctuation" select="substring(@style,$indexOf + 1)"/>
			<xsl:variable name="value" select="substring($valueWithPonctuation,2,string-length($valueWithPonctuation)-2)"/>
			<xsl:attribute name="{$propriete}"><xsl:value-of select="$value"/></xsl:attribute>
		</xsl:if>
	</xsl:template>
	<xsl:template name="indexOfChar">
		<xsl:param name="string"/>
		<xsl:param name="char"/>
		<xsl:param name="i" select="1"/>
		<xsl:param name="strlen" select="string-length($string)"/>
		<xsl:choose>
			<xsl:when test="$i>$strlen">-1</xsl:when>
			<xsl:when test="substring($string,$i,1)=$char">
				<xsl:value-of select="$i"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="indexOfChar">
					<xsl:with-param name="i" select="$i+1"/>
					<xsl:with-param name="strlen" select="$strlen"/>
					<xsl:with-param name="string" select="$string"/>
					<xsl:with-param name="char" select="$char"/>
				</xsl:call-template>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!--auto merge style-->
	<xsl:template match="div" priority="2">
		<xsl:element name="fo:block">
			<xsl:call-template name="htmlStyleProcessor"/>
			<xsl:apply-templates select="*|text()"/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="span" priority="2">
		<xsl:element name="fo:inline">
			<xsl:call-template name="htmlStyleProcessor"/>
			<xsl:apply-templates select="*|text()"/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="em">
		<fo:inline xsl:use-attribute-sets="em">
			<xsl:apply-templates select="text()|*"/>
		</fo:inline>
	</xsl:template>
	<xsl:template match="br">
		<fo:block/>
	</xsl:template>
	<xsl:template match="hr">
		<fo:block border-top="0.3mm solid black"/>
	</xsl:template>
	<xsl:template match="strong">
		<fo:inline xsl:use-attribute-sets="strong">
			<xsl:apply-templates select="*|text()"/>
		</fo:inline>
	</xsl:template>
	<xsl:template match="u">
		<fo:inline xsl:use-attribute-sets="underline">
			<xsl:apply-templates select="*|text()"/>
		</fo:inline>
	</xsl:template>
	<xsl:template match="sup">
		<fo:inline xsl:use-attribute-sets="sup">
			<xsl:apply-templates select="*|text()"/>
		</fo:inline>
	</xsl:template>
	<xsl:template match="sub">
		<fo:inline xsl:use-attribute-sets="sub">
			<xsl:apply-templates select="*|text()"/>
		</fo:inline>
	</xsl:template>
	<xsl:template match="s">
		<fo:inline xsl:use-attribute-sets="s">
			<xsl:apply-templates select="*|text()"/>
		</fo:inline>
	</xsl:template>
	<xsl:template match="div[contains(@style,'margin')]" priority="2">
		<!--exception pour les div avec des style margin-->
		<xsl:variable name="colonPosition">
			<xsl:call-template name="indexOfChar">
				<xsl:with-param name="string" select="@style"/>
				<xsl:with-param name="char">:</xsl:with-param>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="margin">
			<xsl:value-of select="substring(@style,1,$colonPosition - 1 )"/>
		</xsl:variable>
		<!--<xsl:variable name="marginType">
			<xsl:value-of select="substring(@style,8,$colonPosition - 8)"/>
		</xsl:variable>-->
		<xsl:variable name="propertyValueWithSemicolon" select="substring(@style,$colonPosition+2)"/>
		<xsl:variable name="propertyValue" select="substring($propertyValueWithSemicolon,1,string-length($propertyValueWithSemicolon)-1)"/>
		<xsl:element name="fo:block">
			<xsl:attribute name="{$margin}"><xsl:value-of select="$propertyValue"/></xsl:attribute>
			<xsl:apply-templates select="*|text()"/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="table">
		<xsl:element name="fo:table">
			<xsl:call-template name="htmlStyleProcessor"/>
			<xsl:choose>
				<xsl:when test="tbody">
					<xsl:apply-templates select="tbody|thead|tfoot"/>
				</xsl:when>
				<xsl:otherwise>
					<fo:table-body>
						<xsl:apply-templates select="tr"/>
					</fo:table-body>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:element>
	</xsl:template>
	<xsl:template match="tbody">
		<fo:table-body>
			<xsl:apply-templates select="*"/>
		</fo:table-body>
	</xsl:template>
	<xsl:template match="thead">
		<fo:table-header>
			<xsl:apply-templates select="*"/>
		</fo:table-header>
	</xsl:template>
	<xsl:template match="tfoot">
		<fo:table-footer>
			<xsl:apply-templates select="*"/>
		</fo:table-footer>
	</xsl:template>
	<xsl:template match="tr">
		<xsl:element name="fo:table-row">
			<xsl:call-template name="htmlStyleProcessor"/>
			<xsl:apply-templates select="*"/>
		</xsl:element>
	</xsl:template>
<!--	<xsl:template match="tr">
		<xsl:element name="fo:table-row">
			<xsl:call-template name="htmlStyleProcessor"/>
			<xsl:apply-templates select="*"/>
		</xsl:element>
	</xsl:template>-->
	<xsl:template match="td">
		<xsl:element name="fo:table-cell">
			<!--<xsl:call-template name="htmlStyleProcessor"/>-->
			<fo:block>
				<xsl:apply-templates select="*|text()"/>
			</fo:block>
		</xsl:element>
	</xsl:template>
	<xsl:template match="th">
		<xsl:element name="fo:table-cell">
			<!--<xsl:call-template name="htmlStyleProcessor"/>-->
			<fo:block xsl:use-attribute-sets="th">
				<xsl:apply-templates select="*|text()"/>
			</fo:block>
		</xsl:element>
	</xsl:template>
	<xsl:template match="ul">
		<fo:list-block>
			<xsl:apply-templates select="*"/>
		</fo:list-block>
	</xsl:template>
	<xsl:template match="li">
		<fo:list-item>
			<fo:list-item-label end-indent="label-end()">
				<fo:block>
					<xsl:variable name="countUL" select="count(ancestor-or-self::ul)"/>
					<xsl:choose>
						<xsl:when test="1">&circle;</xsl:when>
						<xsl:when test="2">&cir;</xsl:when>
						<xsl:otherwise>-</xsl:otherwise>
					</xsl:choose>
				</fo:block>
			</fo:list-item-label>
			<fo:list-item-body start-indent="body-start()">
				<fo:block>
					<xsl:apply-templates select="*|text()"/>
				</fo:block>
			</fo:list-item-body>
		</fo:list-item>
	</xsl:template>
	<!--<fo:table>								<table>
		<fo:table-body>							<tbody>
			<fo:table-row>								<tr>
				<fo:table-cell>								<td>/<th>
					<fo:block></fo:block>
				</fo:table-cell>
			</fo:table-row>
		</fo:table-body>
	</fo:table>-->
	<!--	

		deprecié et remplacé par div[@style]

-->
	<!--<xsl:template match="div[contains(@style,'text-align: ')]">
		<xsl:variable name="alignTypeWithPonctuation" select="substring(@style,13)"/>
		<xsl:variable name="alignType" select="substring($alignTypeWithPonctuation,1,string-length($alignTypeWithPonctuation)-1)"/>
		<fo:block text-align="{$alignType}">
			<xsl:apply-templates select="*|text()"/>
		</fo:block>
	</xsl:template>-->
</xsl:stylesheet>
