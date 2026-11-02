<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:xhtml="http://www.w3.org/1999/xhtml"
                xmlns:m="http://example.com/ns/md-corpus"
                xmlns:fn="http://www.w3.org/2005/xpath-functions"
                exclude-result-prefixes="#all"
                version="3.0">

  <xsl:output 
    method="xhtml" 
    html-version="5.0" 
    encoding="UTF-8" 
    indent="yes" 
    omit-xml-declaration="yes"
    suppress-indentation="xhtml:pre" />

  <xsl:mode on-no-match="shallow-copy"/>

  <xsl:param name="do-snippets" as="xs:string" select="'no'"/>
  <xsl:param name="path" as="xs:string" select="''" />

  <xsl:import href="_layout.xsl"/>
  <xsl:import href="_frugal.xsl"/>

  <xsl:template match="/m:post" mode="head">
    <xsl:apply-templates select="m:head"/>
  </xsl:template>

  <xsl:template match="/m:post" mode="header">
    <xhtml:header>
      <xhtml:h1>Unusable</xhtml:h1>
    </xhtml:header>
  </xsl:template>

  <xsl:template match="/m:post">
    <xsl:apply-templates select="m:doc" />
  </xsl:template>

  <xsl:template name="add-pagefind-body">
    <xsl:attribute name="data-pagefind-body">
      <xsl:text>true</xsl:text>
    </xsl:attribute>
  </xsl:template>

  <xsl:template name="add-pagefind-meta">
    <xsl:param name="field" />
    <xsl:attribute name="data-pagefind-meta">
      <xsl:value-of select="$field" />
    </xsl:attribute>
  </xsl:template>

  <xsl:template name="add-pagefind-filter">
    <xsl:param name="field" />
    <xsl:attribute name="data-pagefind-filter">
      <xsl:value-of select="$field" />
    </xsl:attribute>
  </xsl:template>

</xsl:stylesheet>