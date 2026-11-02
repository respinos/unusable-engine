<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:m="http://example.com/ns/md-corpus"
                xmlns:xhtml="http://www.w3.org/1999/xhtml"
                xmlns:fn="http://www.w3.org/2005/xpath-functions"
                exclude-result-prefixes="#all"
                version="3.0">

  <xsl:template match="document-node()">
    <xhtml:html lang="en">
      <xhtml:head>
        <xhtml:meta charset="UTF-8" />
        <xhtml:meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <xsl:apply-templates mode="head" />
        <xhtml:link rel="stylesheet" href="/static/css/styles.css" />
      </xhtml:head>
      <xhtml:body>
        <xsl:call-template name="add-body-class" />
        <xsl:call-template name="add-pagefind-body" />
        <xhtml:div class="container">
          <xsl:apply-templates mode="header" />
          <xhtml:main class="main">
            <xsl:apply-templates />
          </xhtml:main>
          <xsl:call-template name="build-footer" />
        </xhtml:div>
      </xhtml:body>
    </xhtml:html>
  </xsl:template>

  <xsl:template name="build-footer">
    <xhtml:footer>
      <xhtml:div>        
        <nav>
          <ol>
            <li><a href="/">Home</a></li>
            <li><a href="/about/">About</a></li>
            <li><a href="/archives/">Archives</a></li>
            <li><a href="/search/">Search</a></li>
          </ol>
        </nav>
      </xhtml:div>
      <xhtml:div class="copyright">
        <xsl:variable name="currentYear" select="fn:format-date(fn:current-date(), '[Y]')" />
        <xsl:text>© </xsl:text>
        <xsl:value-of select="$currentYear" />
        <xsl:text> by your humble narrator</xsl:text>
      </xhtml:div>
    </xhtml:footer>
  </xsl:template>

  <xsl:template name="add-body-class" />
  <xsl:template name="add-pagefind-body" />

</xsl:stylesheet>