<?xml version="1.0"?>
<!--
 * Copyright (c) 2012, s3auth.com
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met: 1) Redistributions of source code must retain the above
 * copyright notice, this list of conditions and the following
 * disclaimer. 2) Redistributions in binary form must reproduce the above
 * copyright notice, this list of conditions and the following
 * disclaimer in the documentation and/or other materials provided
 * with the distribution. 3) Neither the name of the s3auth.com nor
 * the names of its contributors may be used to endorse or promote
 * products derived from this software without specific prior written
 * permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT
 * NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND
 * FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL
 * THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
 * INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
 * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
 * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
 * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED
 * OF THE POSSIBILITY OF SUCH DAMAGE.
 -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns="http://www.w3.org/1999/xhtml"
    version="2.0" exclude-result-prefixes="xs">

    <xsl:output method="xml" omit-xml-declaration="yes"/>

    <xsl:include href="/xsl/layout.xsl" />

    <xsl:template name="head">
        <title>
            <xsl:text>s3auth</xsl:text>
        </title>
    </xsl:template>

    <xsl:template name="content">
        <h1>
            <xsl:text>Domains Under Management</xsl:text>
        </h1>
        <xsl:choose>
            <xsl:when test="/page/domains/domain">
                <p>
                    <xsl:text>Your registered domains:</xsl:text>
                </p>
                <ul>
                    <xsl:apply-templates select="/page/domains/domain"/>
                </ul>
            </xsl:when>
            <xsl:otherwise>
                <p>
                    <xsl:text>You haven't registered any domains yet.</xsl:text>
                </p>
            </xsl:otherwise>
        </xsl:choose>
        <p>
            <xsl:text>Register new domain using the form (all fields are mandatory):</xsl:text>
        </p>
        <form method="post">
            <xsl:attribute name="action">
                <xsl:value-of select="/page/links/link[@rel='add']/@href" />
            </xsl:attribute>
            <p>
                <label><xsl:text>Host name (the same as S3 bucket name):</xsl:text></label>
                <input name="host" />
                <label><xsl:text>AWS key:</xsl:text></label>
                <input name="key" size="30" maxlength="20" />
                <label><xsl:text>AWS secret key:</xsl:text></label>
                <input name="secret" size="40" maxlength="40" />
                <input class="submit" type="submit" value="" />
            </p>
        </form>
        <p>
            <xsl:text>To access the bucket you can use your S3 credentials (key and secret key). Also you can create a </xsl:text>
            <span class="tt">.htpasswd</span>
            <xsl:text> file in the root of the bucket according to </xsl:text>
            </xsl:text>
            <a href="http://httpd.apache.org/docs/2.2/misc/password_encryptions.html">
                <xsl:text>Apache HTTP Server format</xsl:text>
            </a>
            <xsl:text> (we support only SHA1 and PLAIN TEXT algorithms at the moment).</xsl:text>
        </p>
    </xsl:template>

    <xsl:template match="domain">
        <li>
            <a>
                <xsl:attribute name="href">
                    <xsl:text>http://</xsl:text>
                    <xsl:value-of select="name"/>
                    <xsl:text>/</xsl:text>
                </xsl:attribute>
                <xsl:value-of select="name"/>
            </a>
            <xsl:text> (key: </xsl:text>
            <span class="tt"><xsl:value-of select="key"/></span>
            <xsl:text>, secret: </xsl:text>
            <span class="tt"><xsl:value-of select="secret"/></span>
            <xsl:text>) </xsl:text>
            <a>
                <xsl:attribute name="href">
                    <xsl:value-of select="links/link[@rel='remove']/@href" />
                </xsl:attribute>
                <xsl:text>delete</xsl:text>
            </a>
        </li>
    </xsl:template>

</xsl:stylesheet>
