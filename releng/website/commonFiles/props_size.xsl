<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

  <xsl:output omit-xml-declaration="yes" indent="yes"/>

  <!-- Increment the size attribute (under <properties> ) by 3 for any
       <unit> containing a property named 'iplog.bug_id' -->

  <xsl:template match="@* | node()">
    <xsl:copy>
      <xsl:apply-templates select="@* | node()"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="/repository/units/unit/properties/@size">
    <xsl:choose>
      <xsl:when test="../property[@name='iplog.bug_id']">
        <xsl:attribute name="size">
          <xsl:value-of select="../@size+3"/>
        </xsl:attribute>
      </xsl:when>
      <xsl:otherwise>
        <xsl:attribute name="size">
          <xsl:value-of select="../@size"/>
        </xsl:attribute>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

</xsl:stylesheet>
