<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format">
	<xsl:import href="lib.common.data.access.xsl"/>
	<xsl:include href="lib.service-data.xsl"/>
	<xsl:template name="layouts-sets">
	<!--definition des formats de papiers standards avec entete et pieds-->
		<fo:simple-page-master master-name="A4PortraitBeforeAfterStart" page-height="297mm" page-width="21cm">
			<fo:region-body margin-left="7cm" margin-top="5cm" margin-bottom="12mm"/>
			<fo:region-before extent="5cm" background-color="skyblue"/>
			<fo:region-after extent="12mm"/>
			<fo:region-start extent="7cm"/>
		</fo:simple-page-master>
		<fo:simple-page-master master-name="A4PortraitBeforeAfter" page-height="297mm" page-width="21cm">
			<fo:region-body margin-top="5cm" margin-bottom="12mm"/>
			<fo:region-before extent="5cm" background-color="tomato" region-name="xsl-region-before-rest"/>
			<fo:region-after extent="12mm"/>
		</fo:simple-page-master>
		<fo:page-sequence-master master-name="A4FirstWithStartAndOthers">
			<fo:repeatable-page-master-alternatives>
				<fo:conditional-page-master-reference master-reference="A4PortraitBeforeAfterStart" page-position="first"/>
				<fo:conditional-page-master-reference master-reference="A4PortraitBeforeAfter" page-position="rest"/>
			</fo:repeatable-page-master-alternatives>
		</fo:page-sequence-master>
	</xsl:template>
	<xsl:template name="statics-contents">
	<!--definition des entete et pieds-->
		<xsl:param name="docPath" select="translate(concat('services/',/*/@site,'-',/*/@spec,'-service-datas.xml'),'éèàç','eeac')"/>
		<xsl:variable name="serviceDatas" select="document($docPath)"/>
		<fo:static-content flow-name="xsl-region-start">
			<fo:block>
				<fo:external-graphic src="file:///G:/partage/crpMaronnier/logos/logo1.png" scaling="uniform" content-height="5cm"/>
			</fo:block>
			<fo:block margin-top="3cm">
				<xsl:apply-templates select="$serviceDatas/service"/>
			</fo:block>
		</fo:static-content>
		<fo:static-content flow-name="xsl-region-before">
			<fo:block text-align="right">
				<fo:external-graphic src="file:///G:/partage/crpMaronnier/logos/teteINTENSIF.png" scaling="uniform" content-height="5cm"/>
			</fo:block>
		</fo:static-content>
		<fo:static-content flow-name="xsl-region-before-rest">
			<fo:block text-align="right">
				<fo:external-graphic src="file:///G:/partage/crpMaronnier/logos/logo1.png" scaling="uniform" content-height="5cm"/>
				<fo:external-graphic src="file:///G:/partage/crpMaronnier/logos/teteINTENSIF.png" scaling="uniform" content-height="5cm"/>
			</fo:block>
		</fo:static-content>
		<fo:static-content flow-name="xsl-region-after">
			<fo:block font-size="7pt">
				<fo:table>
					<fo:table-column column-width="50%"/>
					<fo:table-column/>
					<fo:table-body>
						<fo:table-row>
							<fo:table-cell>
								<fo:block>
									<xsl:call-template name="patient-full-identity"/>
									<fo:block>&#160;</fo:block>
									<fo:block>&#160;</fo:block>
									<xsl:value-of select="/*/@patBirthDate"/>
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block text-align="right" margin-right="5mm">
									<xsl:call-template name="formated-noteDate"/>
									<fo:block/>
									<xsl:call-template name="formated-noteHeure"/>
									<fo:block/>
									<fo:page-number/> / <fo:page-number-citation ref-id="endoc"/>
								</fo:block>
							</fo:table-cell>
						</fo:table-row>
					</fo:table-body>
				</fo:table>
			</fo:block>
		</fo:static-content>
	</xsl:template>
	<xsl:template name="enddoc">
	<!--definition du bloc de reference de calcul pour fin de pages-->
		<fo:block id="endoc"/>
	</xsl:template>
</xsl:stylesheet>
