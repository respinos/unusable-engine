<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:m="http://example.com/ns/md-corpus"
                xmlns:xhtml="http://www.w3.org/1999/xhtml"
                exclude-result-prefixes="#all"
                version="3.0">

  <!-- ==================================================================
       Turns the m:entry sequence aggregated off build-site.xpl's loop
       into a sitemaps.org urlset.

       Input:  <m:sitemap>
                 <m:entry path="intro.html" date="2026-03-01"
                          source="file:/.../intro.md"
                          stored="file:/.../build/intro.html">Intro</m:entry>
                 ...
               </m:sitemap>
       ================================================================== -->

  <xsl:param name="base-url" as="xs:string" select="'https://example.com/'"/>

  <xsl:output 
    method="xhtml" 
    html-version="5.0" 
    encoding="UTF-8" 
    indent="yes" 
    omit-xml-declaration="yes"
    suppress-indentation="xhtml:pre" />

  <xsl:import href="_layout.xsl"/>

  <!-- on-no-match="fail" (below) switches off the built-in rules, which
       includes the one that would otherwise walk from the document node
       into its element child - so that step has to be explicit. -->
  <!-- <xsl:template match="document-node()">
     <xsl:apply-templates select="m:snippets" />
  </xsl:template> -->

  <xsl:template match="/m:snippets" mode="head">
    <xhtml:title>Archives - Unusable Notes</xhtml:title>
  </xsl:template>

  <xsl:template name="add-body-class">
    <xsl:attribute name="data-page">home</xsl:attribute>
  </xsl:template>

  <xsl:template match="/m:snippets" mode="header">
    <xhtml:header>
      <xhtml:h1 class="flicker">Unusable</xhtml:h1>
      <xhtml:span class="flickr" aria-hidden="true">u</xhtml:span>
      <!-- <xhtml:span class="flickr l2" aria-hidden="true">t</xhtml:span> -->
    </xhtml:header>
  </xsl:template>

  <xsl:template match="/m:snippets">
    <xhtml:h2>Search</xhtml:h2>
    <xhtml:div class="search-wrapper">
      <xsl:comment>search goes here</xsl:comment>
    </xhtml:div>
    <xhtml:h2>Archives</xhtml:h2>
    <xsl:for-each-group select="xhtml:section"
      group-adjacent="format-dateTime(xs:dateTime(replace(@data-created-at, '\+0000', '')), '[Y]')">
      <xhtml:div class="archive-group">          
        <xhtml:h3><xsl:value-of select="current-grouping-key()" /></xhtml:h3>
        <xsl:for-each select="current-group()">
          <xhtml:div>
            <xhtml:time datetime="{@data-created-at}">
              <xsl:value-of select="format-dateTime(xs:dateTime(replace(@data-created-at, '\+0000', '')), '[Y]-[M01]')" />
            </xhtml:time>
            <xsl:copy-of select=".//xhtml:a[@rel='bookmark']" />
          </xhtml:div>
        </xsl:for-each>
      </xhtml:div>
    </xsl:for-each-group>
  </xsl:template>

  <!-- Nothing else should reach the output. -->
  <xsl:mode on-no-match="shallow-copy"/>

</xsl:stylesheet>
