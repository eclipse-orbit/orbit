<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:php="http://php.net/xsl" version="1.0">

  <xsl:output omit-xml-declaration="yes" indent="yes"/>

  <xsl:param name="repoPath"/>

  <xsl:template match="/">

      <xsl:for-each select="/repository/units/unit[provides/provided/@namespace = 'org.eclipse.equinox.p2.eclipse.type' and provides/provided/@name = 'bundle']">
      <xsl:sort select="@id"/>
      <xsl:variable name="id" select="@id"/>
      <!-- Get the version to the left of the 'v'
      Example: 1.2.3.v201611291555 gives 1.2.3. -->
      <xsl:variable name="vleft" select="substring-before(@version,'v')"/>
      <!-- Remove the last character -->
      <xsl:variable name="vfinal" select="substring($vleft,1,string-length($vleft)-1)"/>

<tr valign="top">
  <td width="20%" >
    <a href="{$repoPath}/plugins/{@id}_{@version}.jar">
    <xsl:value-of select="@id" />
    </a>
  </td>
  <td width="5%">
    <!-- Only show source link if source bundle exists -->
    <xsl:if test="../unit[@id=concat($id,'.source')]">
    <a href="{$repoPath}/plugins/{@id}.source_{@version}.jar">
    (source)
    </a>
    </xsl:if>
  </td>
  <td width="5%">
    <!-- Hack for conditional expression -->
    <!-- Use the fact that 1/0 = Infinity and substring($foo, Infinity)
         returnes the empty string -->
    <xsl:value-of select="concat(
        substring($vfinal, 1 div boolean(contains(@version,'v'))),
        substring(@version, 1 div not(contains(@version,'v'))))" />
  </td>
</tr>
      </xsl:for-each>

  </xsl:template>

</xsl:stylesheet>
