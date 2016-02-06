<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:bib="http://www-ens.iro.umontreal.ca/hamelfre-dumontip/Bibliotheque"
	xmlns="http://www.w3.org/1999/xhtml" version="2.0">

	<xsl:param name="titre" select="'Harry'"/>

	<xsl:output method="xml" doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"
		doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd" indent="yes"
		encoding="UTF-8"/>

	<xsl:template match="/">
		<html>
			<head>
				<title>Bibliotheque</title>
			</head>
			<body>
				<xsl:apply-templates/>
				<p>
					<a href="http://validator.w3.org/check?uri=referer"><img
						src="http://www.w3.org/Icons/valid-xhtml10" alt="Valid XHTML 1.0 Strict" height="31" width="88" /></a>
				</p>
			</body>
		</html>
	</xsl:template>

	<xsl:template match="bib:bibliotheque">
		<h1>Bibliotheque (Livre)</h1>
		<xsl:apply-templates select="bib:livre[contains(bib:titre, $titre)]"/>
	</xsl:template>

	<xsl:template match="bib:livre">
		<xsl:variable name="this" select="node()"/>
		<xsl:variable name="auteurs" select="@auteurs"/>
		<xsl:variable name="tokenized_auteurs" select="tokenize($auteurs, ' ')"/>
		<h2>
			<xsl:value-of select="bib:titre"/>
		</h2>
		<ul>
			<li>Annee: <xsl:value-of select="bib:annee"/></li>
			<li>
				<p>Prix: $<xsl:value-of select="bib:prix"/><xsl:apply-templates
						select="bib:prix/@monnaie"/></p>
				<ul>
					<xsl:apply-templates select="bib:couverture"/>
					<xsl:apply-templates select="bib:film"/>
				</ul>
			</li>
			<xsl:apply-templates select="bib:personnage"/>
			<xsl:apply-templates select="//bib:auteur[index-of($tokenized_auteurs, @ident) > 0]"/>
			<xsl:apply-templates select="bib:commentaire"/>
		</ul>
	</xsl:template>

	<xsl:template match="bib:auteur">
		<li>
			<p>Auteur: <xsl:value-of select="bib:prenom"/><xsl:text> </xsl:text><xsl:value-of
					select="bib:nom"/></p>
			<ul>
				<li>Pays: <xsl:value-of select="bib:pays"/></li>
			</ul>
		</li>
	</xsl:template>

	<xsl:template match="bib:prix/@monnaie">
		<xsl:text> </xsl:text>
		<xsl:value-of select="."/>
	</xsl:template>

	<xsl:template match="bib:couverture">
		<xsl:call-template name="image">
			<xsl:with-param name="titre" select="'Couverture'"/>
		</xsl:call-template>
	</xsl:template>

	<xsl:template match="bib:film">
		<xsl:call-template name="image">
			<xsl:with-param name="titre" select="'Film'"/>
		</xsl:call-template>
	</xsl:template>

	<xsl:template name="image">
		<xsl:param name="titre"/>
		<li>
			<p>
				<xsl:value-of select="$titre"/>
			</p>
			<img>
				<xsl:attribute name="src">
					<xsl:value-of select="."/>
				</xsl:attribute>
				<xsl:attribute name="width">240</xsl:attribute>
				<xsl:attribute name="height">320</xsl:attribute>
				<xsl:attribute name="alt"><xsl:value-of select="$titre" /></xsl:attribute>
			</img>
		</li>
	</xsl:template>

	<xsl:template match="bib:personnage">
		<li>
			<p>
				<xsl:value-of select="bib:prenom"/>
				<xsl:text> </xsl:text>
				<xsl:value-of select="bib:nom"/>
			</p>
		</li>
	</xsl:template>

	<xsl:template match="bib:commentaire">
		<li>
			<p>Commentaire: <xsl:value-of select="."/></p>
		</li>
	</xsl:template>
</xsl:stylesheet>
