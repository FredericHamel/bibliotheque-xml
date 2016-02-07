<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:bib="http://www-ens.iro.umontreal.ca/hamelfre-dumontip/Bibliotheque"
	xmlns="http://www.w3.org/1999/xhtml" version="2.0">

	<xsl:param name="titre" select="''"/>

	<xsl:output method="xml" doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"
		doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd" indent="yes"
		encoding="UTF-8"/>

	<xsl:template match="/">
		<html>
			<head>
				<title>Bibliotheque</title>
				<meta http-equiv="Content-Type" content="text/xhtml; charset=UTF-8" />
				<link rel="stylesheet" type="text/css" href="style.css"/>
			</head>
			<body>
				<xsl:apply-templates/>
				<p>
					<a href="http://validator.w3.org/check?uri=referer">
						<img src="http://www.w3.org/Icons/valid-xhtml10" alt="Valid XHTML 1.0 Strict" height="31" width="88" /></a>
					<a href="http://jigsaw.w3.org/css-validator/check/referer">
						<img style="border:0;width:88px;height:31px"
							src="http://jigsaw.w3.org/css-validator/images/vcss"
							alt="Valid CSS!" /></a>
				</p>
			</body>
		</html>
	</xsl:template>

	<xsl:template match="bib:bibliotheque">
		<h1>Bibliotheque (Livre)</h1>
		<xsl:choose>
			<xsl:when test="empty($titre)">
				<xsl:apply-templates select="bib:livre"/>		
			</xsl:when>
			<xsl:otherwise>
				<xsl:apply-templates select="bib:livre[contains(bib:titre, $titre)]"/>
			</xsl:otherwise>
		</xsl:choose>
		
	</xsl:template>

	<xsl:template match="bib:livre">
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
			</li>
			<xsl:apply-templates select="bib:couverture"/>
			<xsl:apply-templates select="bib:film"/>
			<xsl:apply-templates select="bib:personnage"/>
			<xsl:apply-templates select="//bib:auteur[index-of($tokenized_auteurs, @ident) > 0]"/>
			<xsl:apply-templates select="bib:commentaire"/>
		</ul><hr />
	</xsl:template>

	<xsl:template match="bib:auteur">
		<xsl:call-template name="personne">
			<xsl:with-param name="header">Auteur</xsl:with-param>
		</xsl:call-template>
	</xsl:template>

	<xsl:template match="bib:personnage">
		<xsl:call-template name="personne">
			<xsl:with-param name="header">Personnage</xsl:with-param>
		</xsl:call-template>
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
	
	<xsl:template name="personne">
		<xsl:param name="header" />
		<li>
			<p>
				<xsl:value-of select="concat($header, ': ', bib:prenom, ' ', bib:nom)" />
			</p>
			<xsl:if test="string-length(concat(bib:pays, bib:photo)) > 0">
				<ul>
					<xsl:apply-templates select="bib:pays" />
					<xsl:apply-templates select="bib:photo" />
				</ul>
			</xsl:if>
		</li>
	</xsl:template>
	<xsl:template match="bib:pays">
		<li><p>Pays: <xsl:value-of select="."/></p></li>
	</xsl:template>
	<xsl:template match="bib:photo">
		<xsl:call-template name="image">
			<xsl:with-param name="titre">Photo</xsl:with-param>
			<xsl:with-param name="width">120</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	
	<xsl:template name="image">
		<xsl:param name="titre"/>
		<xsl:param name="width">240</xsl:param>
		<li>
			<p>
				<xsl:value-of select="$titre"/>
			</p>
			<img>
				<xsl:attribute name="src">
					<xsl:value-of select="."/>
				</xsl:attribute>
				<xsl:attribute name="width" select="$width" />
				<xsl:attribute name="alt"><xsl:value-of select="$titre" /></xsl:attribute>
			</img>
		</li>
	</xsl:template>
	
	<xsl:template match="bib:commentaire">
		<li>
			<p>Commentaire: <xsl:value-of select="."/></p>
		</li>
	</xsl:template>
</xsl:stylesheet>
