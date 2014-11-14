<xsl:stylesheet
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:fo="http://www.w3.org/1999/XSL/Format"
		version="1.0">

<xsl:output method="xml" version="1.0" indent="yes"/>

<xsl:param name="prefix">html/</xsl:param>

<xsl:template match="/">
	<book title="Magento Documentation"
				name="magento"
				link="{$prefix}index.html"
				language="php">
		<chapters>
			<sub name="Classes" link="{$prefix}annotated.html">
				<xsl:apply-templates select="doxygenindex/compound[@kind='class']"/>
			</sub>
		</chapters>
		<functions>
			<xsl:apply-templates select="doxygenindex/compound/member[@kind='function']" mode="as-function"/>
		</functions>
	</book>
</xsl:template>

<xsl:template match="compound">
	<xsl:param name="name"><xsl:value-of select="name"/></xsl:param>
	<xsl:param name="link"><xsl:value-of select="@refid"/>.html</xsl:param>
	<sub name="{$name}" link="{$prefix}{$link}">
	<xsl:apply-templates select="member" mode="as-sub">
		<xsl:sort select="."/>
	</xsl:apply-templates>
	</sub>
</xsl:template>

<xsl:template match="member" mode="as-function">
	<xsl:param name="name"><xsl:value-of select="name"/></xsl:param>
	<xsl:param name="refid_parent"><xsl:value-of select="parent::node()/@refid"/></xsl:param>
	<xsl:param name="own_refid"><xsl:value-of select="@refid"/></xsl:param>
	<xsl:param name="before"><xsl:value-of select="substring-before($own_refid,'_1')"/></xsl:param>
	<xsl:param name="after"><xsl:value-of select="substring-after($own_refid,'_1')"/></xsl:param>
	<xsl:param name="link"><xsl:value-of select="$before"/>.html#<xsl:value-of select="$after"/></xsl:param>
	<function name="{$name}" link="{$prefix}{$link}"/>
</xsl:template>

<xsl:template match="member" mode="as-sub">
	<xsl:param name="name"><xsl:value-of select="name"/></xsl:param>
	<xsl:param name="refid_parent"><xsl:value-of select="parent::node()/@refid"/></xsl:param>
	<xsl:param name="own_refid"><xsl:value-of select="@refid"/></xsl:param>
	<xsl:param name="before"><xsl:value-of select="substring-before($own_refid,'_1')"/></xsl:param>
	<xsl:param name="after"><xsl:value-of select="substring-after($own_refid,'_1')"/></xsl:param>
	<xsl:param name="link"><xsl:value-of select="$before"/>.html#<xsl:value-of select="$after"/></xsl:param>
	<sub name="{$name}" link="{$prefix}{$link}"/>
</xsl:template>

</xsl:stylesheet>
