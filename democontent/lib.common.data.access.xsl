<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format">
	<xsl:template name="patient-full-dateBirth"><!--Date complete du patient<fo:block/>demo : né(e) le 2023/12/12-->né<xsl:if test="/*/@patSex!='m'">e</xsl:if> le <xsl:call-template name="formated-noteDate">
			<xsl:with-param name="dateToDecode" select="/*/@patBirthDate"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template name="patient-full-identity">
		<xsl:value-of select="translate(/*/@patLastName,'abcdefghijklmnopqrstuvwxyz','ABCDEFGHIJKLMNOPQRSTUVWXYZ')"/>
		<xsl:text> </xsl:text>
		<xsl:value-of select="/*/@patFirstName"/>
	</xsl:template>
	<xsl:template name="doctor-full-identity">
		<xsl:value-of select="translate(/*/@doctorLastName,'abcdefghijklmnopqrstuvwxyz','ABCDEFGHIJKLMNOPQRSTUVWXYZ')"/>
		<xsl:text> </xsl:text>
		<xsl:value-of select="/*/@doctorFirstName"/>
	</xsl:template>
	<xsl:template name="formated-noteDate">
		<xsl:param name="dateToDecode" select="/*/@noteDate"/>
		<xsl:value-of select="substring(/*/@noteDate,1,4)"/>-<xsl:value-of select="substring(/*/@noteDate,5,2)"/>-<xsl:value-of select="substring(/*/@noteDate,7)"/>
	</xsl:template>
	<xsl:template name="formated-noteHeure">
		<xsl:value-of select="substring(/*/@noteHeure,1,2)"/>:<xsl:value-of select="substring(/*/@noteHeure,3,2)"/>
	</xsl:template>
</xsl:stylesheet>
