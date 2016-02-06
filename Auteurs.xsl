<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:bib="http://www-ens.iro.umontreal.ca/hamelfre-dumontip/Bibliotheque"
	xmlns="http://www.w3.org/1999/xhtml"
	version="2.0">

	<xsl:param name="prenom" select="'J. K.'" />
	<xsl:param name="nom" select="'Rowling'" />

	<xsl:output method = "xml" 
		doctype-public = "-//W3C//DTD XHTML 1.0 Strict//EN"
		doctype-system = "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"
		indent = "yes" encoding = "UTF-8"/>

	<xsl:template match="/">
		<html>
			<head>
				<title>Auteur(s)</title>
			</head>
			<body>
				<xsl:apply-templates />
			</body>
		</html>
	</xsl:template>

	<xsl:template match="bib:bibliotheque">
		<h1>Bibliotheque (Auteur)</h1>
		<ul>
			<xsl:apply-templates select="bib:auteur[contains(bib:nom, $nom) and contains(bib:prenom, $prenom)]" />
		</ul>
	</xsl:template>

	<xsl:template match="bib:auteur">
		<li>
			<p><xsl:value-of select="bib:prenom" /><xsl:text> </xsl:text> <xsl:value-of select="bib:nom"/></p>
			<ul>
				<xsl:apply-templates select="bib:photo" />
				<xsl:apply-templates select="bib:commentaire" />
			</ul>
		</li>
	</xsl:template>

	<xsl:template match="bib:commentaire">
		<li><xsl:value-of select="."/></li>
	</xsl:template>

	<xsl:template match="bib:photo">
		<xsl:call-template name="image">
			<xsl:with-param name="titre" select="'Photo'" />
		</xsl:call-template>
	</xsl:template>

	<xsl:template name="image">
		<xsl:param name="titre"/>
		<li>
			<p><xsl:value-of select="$titre" /></p>
			<img>
				<xsl:attribute name="src">
					<xsl:value-of select="."/>
				</xsl:attribute>
				<xsl:attribute name="width">240</xsl:attribute>
				<xsl:attribute name="height">320</xsl:attribute>
			</img>
		</li>
	</xsl:template>
</xsl:stylesheet>
