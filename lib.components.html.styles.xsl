<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:attribute-set name="em">
		<xsl:attribute name="font-style">italic</xsl:attribute>
	</xsl:attribute-set>
	<xsl:attribute-set name="h1">
		<xsl:attribute name="font-size">2em</xsl:attribute>
		<xsl:attribute name="margin-block-start">0.67em</xsl:attribute>
		<xsl:attribute name="margin-block-end">0.67em</xsl:attribute>
		<xsl:attribute name="margin-inline-start">0</xsl:attribute>
		<xsl:attribute name="margin-inline-end">0</xsl:attribute>
		<xsl:attribute name="font-weight">bold</xsl:attribute>
	</xsl:attribute-set>
	<xsl:attribute-set name="h2">
		<xsl:attribute name="font-size">1.5em</xsl:attribute>
		<xsl:attribute name="margin-block-start">0.83em</xsl:attribute>
		<xsl:attribute name="margin-block-end">0.83em</xsl:attribute>
		<xsl:attribute name="margin-inline-start">0</xsl:attribute>
		<xsl:attribute name="margin-inline-end">0</xsl:attribute>
		<xsl:attribute name="font-weight">bold</xsl:attribute>
	</xsl:attribute-set>
	<xsl:attribute-set name="h3">
		<xsl:attribute name="font-size">1.17em</xsl:attribute>
		<xsl:attribute name="margin-block-start">1em</xsl:attribute>
		<xsl:attribute name="margin-block-end">1em</xsl:attribute>
		<xsl:attribute name="margin-inline-start">0</xsl:attribute>
		<xsl:attribute name="margin-inline-end">0</xsl:attribute>
		<xsl:attribute name="font-weight">bold</xsl:attribute>
	</xsl:attribute-set>
	<xsl:attribute-set name="h4">
		<xsl:attribute name="margin-block-start">1.33em</xsl:attribute>
		<xsl:attribute name="margin-block-end">1.33em</xsl:attribute>
		<xsl:attribute name="margin-inline-start">0</xsl:attribute>
		<xsl:attribute name="margin-inline-end">0</xsl:attribute>
		<xsl:attribute name="font-weight">bold</xsl:attribute>
	</xsl:attribute-set>
	<xsl:attribute-set name="h5">
		<xsl:attribute name="font-size">0.83em</xsl:attribute>
		<xsl:attribute name="margin-block-start">1.67em</xsl:attribute>
		<xsl:attribute name="margin-block-end">1.67em</xsl:attribute>
		<xsl:attribute name="margin-inline-start">0</xsl:attribute>
		<xsl:attribute name="margin-inline-end">0</xsl:attribute>
		<xsl:attribute name="font-weight">bold</xsl:attribute>
	</xsl:attribute-set>
	<xsl:attribute-set name="h6">
		<xsl:attribute name="font-size">0.67em</xsl:attribute>
		<xsl:attribute name="margin-block-start">2.33em</xsl:attribute>
		<xsl:attribute name="margin-block-end">2.33em</xsl:attribute>
		<xsl:attribute name="margin-inline-start">0</xsl:attribute>
		<xsl:attribute name="margin-inline-end">0</xsl:attribute>
		<xsl:attribute name="font-weight">bold</xsl:attribute>
	</xsl:attribute-set>
	<xsl:attribute-set name="p">
		<xsl:attribute name="margin-block-start">1em</xsl:attribute>
		<xsl:attribute name="margin-block-end">1em</xsl:attribute>
		<xsl:attribute name="margin-inline-start">0</xsl:attribute>
		<xsl:attribute name="margin-inline-end">0</xsl:attribute>
	</xsl:attribute-set>
	<xsl:attribute-set name="hr">
		<xsl:attribute name="border-top">0.3mm solid black</xsl:attribute>
	</xsl:attribute-set>
	<xsl:attribute-set name="underline">
		<xsl:attribute name="text-decoration">underline</xsl:attribute>
	</xsl:attribute-set>
	<xsl:attribute-set name="strong">
		<xsl:attribute name="font-weight">900</xsl:attribute>
	</xsl:attribute-set>
	<xsl:attribute-set name="sup">
		<xsl:attribute name="vertical-align">super</xsl:attribute>
		<xsl:attribute name="font-size">smaller</xsl:attribute>
	</xsl:attribute-set>
	<xsl:attribute-set name="sub">
		<xsl:attribute name="vertical-align">sub</xsl:attribute>
		<xsl:attribute name="font-size">smaller</xsl:attribute>
	</xsl:attribute-set>
	<xsl:attribute-set name="s">
		<xsl:attribute name="text-decoration">line-through</xsl:attribute>
	</xsl:attribute-set>
	<xsl:attribute-set name="td">
	</xsl:attribute-set>
	<xsl:attribute-set name="th">
		<xsl:attribute name="text-align">center</xsl:attribute>
		<xsl:attribute name="font-weight">900</xsl:attribute>
	</xsl:attribute-set>
	<xsl:attribute-set name="bold">
		<xsl:attribute name="font-weight">900</xsl:attribute>
	</xsl:attribute-set>
</xsl:stylesheet>
