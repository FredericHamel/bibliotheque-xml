<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:bib="http://www-ens.iro.umontreal.ca/hamelfre-dumontip/Bibliotheque"
    xmlns="http://www.w3.org/1999/xhtml"
    version="2.0">    
    <xsl:param name="titre" select="Let It Snow"/>
    
    <xsl:output method = "xml" 
        doctype-public = "-//W3C//DTD XHTML 1.0 Strict//EN"
        doctype-system = "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"
        indent = "yes" encoding = "UTF-8"/>
    
    <xsl:template match="/">
        <html>
            <head>
                <title>Bibliotheque</title>
            </head>
            <body>
                <xsl:apply-templates />
            </body>
        </html>
    </xsl:template>
    <xsl:template match="bib:bibliotheque">
        <h1>Bibliotheque (Livre)</h1>
        <xsl:apply-templates select="bib:livre" />
    </xsl:template>
		<xsl:template match="bib:livre">
				<xsl:variable name="auteurs" select="@auteurs" />
        <h2><xsl:value-of select="bib:titre"/></h2>
        <ul>
            <li>Annee: <xsl:value-of select="bib:annee"/></li>
						<li>
							<p>Prix: $<xsl:value-of select="bib:prix" /><xsl:apply-templates select="bib:prix/@monnaie"/></p>
							<xsl:apply-templates select="bib:couverture"/>
							<xsl:apply-templates select="bib:film"/>
						</li>
						<xsl:apply-templates select="//bib:auteur[contains($auteurs, @ident)]" />
        </ul>
    </xsl:template>

		<xsl:template match="//bib:auteur">
			<li><p>Auteur: <xsl:value-of select="bib:prenom" /><xsl:text> </xsl:text><xsl:value-of select="bib:nom" /></p></li>
		</xsl:template>

    <xsl:template match="//bib:prix/@monnaie">
        <xsl:text> </xsl:text><xsl:value-of select="." />
		</xsl:template>
    
    <xsl:template match="//bib:couverture|//bib:film">
            <img>
                <xsl:attribute name="src">
                    <xsl:value-of select="."/>
                </xsl:attribute>
                <xsl:attribute name="width">240</xsl:attribute>
                <xsl:attribute name="height">320</xsl:attribute>
            </img>
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
</xsl:stylesheet>
