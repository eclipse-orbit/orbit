<xsl:stylesheet xmlns:xsl="https://www.w3.org/1999/XSL/Transform" version="1.0">

  <xsl:output omit-xml-declaration="yes" indent="yes"/>

  <!--
  Find the <unit> element whose id, version attributes match the ones passed
  in as parameters, and add the following elements under that unit's
  <properties> :

  <property name='iplog.bug_id' value='${bug_id}'>
  <property name='iplog.contact.name' value='${name}'>
  <property name='iplog.contact.email' value='${email}'>
  -->

  <xsl:param name="id"/>
  <xsl:param name="version"/>
  <xsl:param name="bug_id"/>
  <xsl:param name="name"/>
  <xsl:param name="email"/>

  <xsl:template match="@* | node()">
    <xsl:copy>
      <xsl:apply-templates select="@* | node()"/>
    </xsl:copy>
  </xsl:template>

<!-- Can't reference variables/parameters inside match pattern with XSLT 1.0.
     We split it up using template match and a conditional which does support
     variables/parameters -->

  <!-- Match against '<property name='maven-version>' so we can insert our
       our iplog metadata below it -->
  <xsl:template match="/repository/units/unit[properties/property/@name='maven-artifactId' and properties/property/@name='maven-version']/properties/property[@name='maven-version']">

  <xsl:copy-of select="."/>
    <!-- Confirm ancestor 'unit' for the 'properties' matches -->
    <xsl:if test="ancestor::unit[@id=$id and starts-with(@version,$version)]">
      <xsl:text>
</xsl:text>
      <xsl:text>	</xsl:text>
      <property name="iplog.bug_id" value="{$bug_id}"/>
      <xsl:text>
</xsl:text>
      <xsl:text>	</xsl:text>
      <property name="iplog.contact.name" value="{$name}"/>
      <xsl:text>
</xsl:text>
      <xsl:text>	</xsl:text>
      <property name="iplog.contact.email" value="{$email}"/>
    </xsl:if>
  </xsl:template>

</xsl:stylesheet>
