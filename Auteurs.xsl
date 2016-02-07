<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:bib="http://www-ens.iro.umontreal.ca/hamelfre-dumontip/Bibliotheque"
	xmlns="http://www.w3.org/1999/xhtml"
	version="2.0">

	<xsl:param name="nom" select="''" />

	<xsl:output method = "xml" 
		doctype-public = "-//W3C//DTD XHTML 1.0 Strict//EN"
		doctype-system = "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"
		indent = "yes" encoding = "UTF-8"/>

	<xsl:template match="/">
		<html>
			<head>
				<title>Auteur(s)</title>
				<meta http-equiv="Content-Type" content="text/xhtml; charset=UTF-8" />
				<link rel="stylesheet" type="text/css" href="style.css"/>
			</head>
			<body>
				<xsl:apply-templates />
				<p>
					<a href="http://validator.w3.org/check?uri=referer"><img
						src="http://www.w3.org/Icons/valid-xhtml10" alt="Valid XHTML 1.0 Strict" height="31" width="88" /></a>
				</p>
			</body>
		</html>
	</xsl:template>

	<xsl:template match="bib:bibliotheque">
		<h1>Bibliotheque (Auteur)</h1>
		<ul>
			<xsl:choose>
				<xsl:when test="empty($nom)">
					<xsl:apply-templates select="bib:auteur" />
				</xsl:when>
				<xsl:otherwise>
					<xsl:apply-templates select="bib:auteur[contains(concat(bib:prenom, ' ', bib:nom), $nom)]" />
				</xsl:otherwise>
			</xsl:choose>
		</ul>
	</xsl:template>

	<xsl:template match="bib:auteur">
		<li>
			<p><xsl:value-of select="concat(bib:prenom, ' ', bib:nom)" /></p>
		</li>
		<xsl:apply-templates select="bib:pays" />
		<xsl:apply-templates select="bib:photo" />
		<xsl:apply-templates select="bib:commentaire" /><hr/>
	</xsl:template>

	<xsl:template match="bib:pays">
		<li><p>Pays: <xsl:value-of select="." /></p></li>
	</xsl:template>
	
	<xsl:template match="bib:commentaire">
		<li><p><xsl:value-of select="."/></p></li>
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
				<xsl:attribute name="alt">$titre</xsl:attribute>
			</img>
		</li>
	</xsl:template>
</xsl:stylesheet>
