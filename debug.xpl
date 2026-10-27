<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc"
                xmlns:c="http://www.w3.org/ns/xproc-step"
                xmlns:cx="http://xmlcalabash.com/ns/extensions"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:m="http://example.com/ns/md-corpus"
                xmlns:xhtml="http://www.w3.org/1999/xhtml"
                version="3.1"
                name="markdown-corpus">


  <p:output port="result" serialization="map{'indent': true()}" sequence="true" />

  <p:option name="source-dir" as="xs:string" required="true"/>
  <p:option name="output-dir"      as="xs:anyURI" required="true"/>
  <p:option name="parent-id" as="xs:string" required="true"/>
  <p:option name="recursive" as="xs:boolean" select="true()"/>
  <p:option name="base-url"        as="xs:string" select="'https://notes.unusable.lol/'"/>
  <p:option name="page-stylesheet" as="xs:string" select="'identity.xsl'"/>
  <p:option name="sitemap-name"    as="xs:string" select="'sitemap.xml'"/>  

  <p:option name="debug-messages-on" as="xs:boolean" select="true()"/>


  <!-- 1. Enumerate the directory. Produces one c:directory document. -->
  <p:directory-list name="listing"
                    path="{$source-dir}"
                    include-filter="\.(json)$"
                    max-depth="{if ($recursive) then 'unbounded' else '1'}"/>

  <!-- <p:xslt>
    <p:with-input port="stylesheet">
        <xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="3.0">
            <xsl:template match="c:directory">
                <xsl:copy>
                    <xsl:apply-templates select="@*"/>
                    <xsl:apply-templates select="*">
                        <xsl:sort select="@name" order="ascending"/>
                    </xsl:apply-templates>
                </xsl:copy>
            </xsl:template>
            
            <xsl:mode on-no-match="shallow-copy"/>
        </xsl:stylesheet>
    </p:with-input>
  </p:xslt>                     -->

  <p:for-each>
    <!-- <p:with-input select="reverse(//c:file[position() ge 1])"/> -->
    <p:with-input select="reverse(sort(//c:directory[c:file], (), function($emp) { xs:string($emp/@name) }))"/>
    <!-- <p:variable name="href" as="xs:anyURI"
      select="resolve-uri(concat(/c:directory/@name, '/', /c:directory/c:file/@name), base-uri(/c:directory))" /> -->
    <p:variable name="href" as="xs:anyURI"
      select="resolve-uri('meta.json', base-uri(/c:directory))" />

    <p:message test="{$debug-messages-on}" select="href = {$href}" />

    <p:identity />
  </p:for-each>

</p:declare-step>