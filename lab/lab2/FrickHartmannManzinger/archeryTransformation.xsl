<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="html"/>
    <xsl:template match="/archery_tournament">
        <html lang="en">
            <head>
                <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bulma@0.9.3/css/bulma.min.css"/>
                <link href="https://fonts.googleapis.com/css2?family=Atkinson+Hyperlegible:wght@400;700&amp;display=swap" rel="stylesheet"/>
                <link rel="icon" href="data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZlcnNpb249IjEuMSIgeG1sbnM6eGxpbms9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkveGxpbmsiIHhtbG5zOnN2Z2pzPSJodHRwOi8vc3ZnanMuY29tL3N2Z2pzIiB3aWR0aD0iMjQiIGhlaWdodD0iMjQiPjxzdmcgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiB3aWR0aD0iMjQiIGhlaWdodD0iMjQiIHZpZXdCb3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTYgMTJjMCAyLjIwNiAxLjc5NCA0IDQgNCAxLjc2MSAwIDMuMjQyLTEuMTUxIDMuNzc1LTIuNzM0bDIuMjI0LTEuMjkxLjAwMS4wMjVjMCAzLjMxNC0yLjY4NiA2LTYgNnMtNi0yLjY4Ni02LTYgMi42ODYtNiA2LTZjMS4wODQgMCAyLjA5OC4yOTIgMi45NzUuNzk0bC0yLjIxIDEuMjgzYy0uMjQ4LS4wNDgtLjUwMy0uMDc3LS43NjUtLjA3Ny0yLjIwNiAwLTQgMS43OTQtNCA0em00LTJjLTEuMTA1IDAtMiAuODk2LTIgMnMuODk1IDIgMiAyIDItLjg5NiAyLTJsLS4wMDItLjAxNSAzLjM2LTEuOTVjLjk3Ni0uNTY1IDIuNzA0LS4zMzYgMy43MTEuMTU5bDQuOTMxLTIuODYzLTMuMTU4LTEuNTY5LjE2OS0zLjYzMi00Ljk0NSAyLjg3Yy0uMDcgMS4xMjEtLjczNCAyLjczNi0xLjcwNSAzLjMwMWwtMy4zODMgMS45NjRjLS4yOS0uMTYzLS42MjEtLjI2NS0uOTc4LS4yNjV6bTcuOTk1IDEuOTExbC4wMDUuMDg5YzAgNC40MTEtMy41ODkgOC04IDhzLTgtMy41ODktOC04IDMuNTg5LTggOC04YzEuNDc1IDAgMi44NTMuNDA4IDQuMDQxIDEuMTA3LjMzNC0uNTg2LjQyOC0xLjU0NC4xNDYtMi4xOC0xLjI3NS0uNTg5LTIuNjktLjkyNy00LjE4Ny0uOTI3LTUuNTIzIDAtMTAgNC40NzctMTAgMTBzNC40NzcgMTAgMTAgMTBjNS4yMzMgMCA5LjUyMS00LjAyMSA5Ljk1Ny05LjE0Mi0uMzAxLS40ODMtMS4wNjYtMS4wNjEtMS45NjItLjk0N3oiPjwvcGF0aD48L3N2Zz48c3R5bGU+QG1lZGlhIChwcmVmZXJzLWNvbG9yLXNjaGVtZTogbGlnaHQpIHsgOnJvb3QgeyBmaWx0ZXI6IG5vbmU7IH0gfQpAbWVkaWEgKHByZWZlcnMtY29sb3Itc2NoZW1lOiBkYXJrKSB7IDpyb290IHsgZmlsdGVyOiBpbnZlcnQoMTAwJSk7IH0gfQo8L3N0eWxlPjwvc3ZnPg==" type="image/svg+xml" />
                <meta name="viewport" content="width=device-width, initial-scale=1"/>
                <style>
                    * {font-family: "Atkinson Hyperlegible", "Segoe UI", sans-serif;}
                    table .dropdown.is-hoverable.disappearing .dropdown-menu:hover {
                    display: none; /*to break the hover dropdown on purpose and use it as a tooltip*/
                    }
                    .dropdown-menu {
                    display: none; /*to hide bulma stuff when bulma is unavailable*/
                    }
                </style>
                <title>
                    <xsl:value-of select="@name"/>
                </title>
            </head>
            <body class="has-background-white-bis">
                <!-- Heading and group navigation -->
                <section class="section">
                    <div class="container is-max-desktop">
                        <h1 class="title">
                            <xsl:value-of select="@name"/>
                        </h1>
                        <div class="menu box">
                            <p class="menu-label">Quick Links</p>
                            <ul class="menu-list">
                                <xsl:apply-templates select="discipline" mode="menu"/>
                            </ul>
                        </div>
                    </div>
                </section>
                <hr class="has-background-grey-light"/>

                <!-- Disciplines and their groups -->
                <section class="section">
                    <div class="container is-max-desktop">
                        <h2 class="title is-3">Disciplines</h2>
                        <xsl:apply-templates select="discipline" mode="content"/>
                    </div>
                </section>
                <hr class="has-background-grey-light"/>

                <!-- All score cards -->
                <section class="section">
                    <div class="container is-max-desktop">
                        <h2 class="title is-3">Score Cards</h2>
                        <!-- for each needed so that sorting doesn't break groups appart-->
                        <xsl:for-each select="//group">
                            <xsl:apply-templates select="./member" mode="score-card">
                                <xsl:sort select="id(@athlete-id)/lastname" order="ascending"/>
                            </xsl:apply-templates>
                        </xsl:for-each>

                    </div>
                </section>

                <!-- Spacer for the target dropdowns to not clip -->
                <section class="section"/>
            </body>
        </html>
    </xsl:template>

    <xsl:template match="discipline" mode="content">
        <xsl:variable name="dsc" select="."/>
        <xsl:variable name="grp" select="//group[@discipline-id=$dsc/@id]"/>
        <xsl:if test="$grp">
            <hr class="has-background-grey-light"/>
            <h2 class="title is-4" id="{generate-id($dsc)}">
                <xsl:value-of select="$dsc"/>
            </h2>
            <xsl:apply-templates select="$grp"/>
        </xsl:if>
    </xsl:template>

    <xsl:template match="discipline" mode="menu">
        <xsl:variable name="dsc" select="."/>
        <xsl:variable name="grp" select="//group[@discipline-id=$dsc/@id]"/>
        <xsl:if test="$grp">
            <li>
                <a href="#{generate-id($dsc)}">
                    <xsl:value-of select="$dsc"/>
                </a>
                <ul>
                    <xsl:for-each select="$grp">
                        <li>
                            <a href="#{generate-id()}" xml:space="preserve">
                                <xsl:value-of select="id(@division-id)"/> -
                                <abbr  title="{id(@class-id)}">
                                    <xsl:value-of select="@class-id"/>
                                </abbr>
                            </a>
                        </li>
                    </xsl:for-each>
                </ul>
            </li>
        </xsl:if>
    </xsl:template>

    <!-- Card of all members in a group -->
    <xsl:template match="group">
        <xsl:variable name="g" select="."/>
        <div class="box">
            <h3 class="title is-5" id="{generate-id()}">
                <xsl:value-of select="@name"/>
            </h3>
            <p class="subtitle">
                <xsl:value-of select="id(@division-id)"/><br/>
                <xsl:value-of select="id(@class-id)"/>
            </p>

            <table class="table">
                <xsl:for-each select="member">
                    <xsl:sort select="id(@athlete-id)/lastname" order="ascending"/>
                    <xsl:variable name="a" select="id(@athlete-id)"/>
                    <xsl:variable name="score-set" select="//score[@group-name=$g/@name and @athlete-id=$a/@id]"/>

                    <xsl:variable name="total-score">
                        <xsl:choose>
                            <xsl:when test="sum($score-set/*)">
                                <xsl:value-of select="sum($score-set/*)"/>
                            </xsl:when>
                            <xsl:otherwise>n.a.</xsl:otherwise>
                        </xsl:choose>
                    </xsl:variable>


                    <tr>
                        <!-- athlete name   |   link to score card -->
                        <td>
                            <xsl:apply-templates select="$a" mode="name"/>
                        </td>
                        <td>(<a href="#{generate-id(.)}"><xsl:value-of select="($total-score)"/></a>)
                        </td>
                    </tr>
                </xsl:for-each>
            </table>
        </div>
    </xsl:template>

    <!-- Full name of an athlete in a span -->
    <xsl:template match="athlete" mode="name">
        <span xml:space="preserve"><xsl:value-of select="firstname"/>
            <xsl:value-of select="lastname"/></span>
    </xsl:template>

    <!-- Score card of a person in a group -->
    <xsl:template match="member" mode="score-card">
        <xsl:variable name="m" select="."/>
        <xsl:variable name="a" select="id(@athlete-id)"/>
        <xsl:variable name="g" select="$m/.."/>

        <xsl:variable name="score-set" select="//score[@group-name=$g/@name and @athlete-id=$a/@id]"/>

        <!-- only print a score card if actual scores exist -->
        <xsl:if test="$score-set">
            <div class="box">

                <!-- AthleteName - GroupName -->
                <h3 class="title is-5" xml:space="preserve" id="{generate-id($m)}">
                    <xsl:apply-templates select="$a" mode="name"/>
                    -
                    <xsl:value-of select="$g/@name"/></h3>
                <table class="table is-bordered is-hoverable has-text-right">
                    <thead>
                        <tr>
                            <th class="pl-4">Target</th>
                            <th class="pl-6">1.</th>
                            <th class="pl-6">2.</th>
                            <th class="pl-6">3.</th>
                        </tr>
                    </thead>
                    <tbody>
                        <xsl:apply-templates select="$score-set" mode="row">
                            <xsl:sort select="@target-id"/>
                        </xsl:apply-templates>
                    </tbody>
                </table>
            </div>
        </xsl:if>
    </xsl:template>

    <xsl:template match="score" mode="row">
        <xsl:variable name="s" select="."/>
        <tr>
            <xsl:apply-templates select="id(@target-id)" mode="table-heading"/>
            <td>
                <xsl:value-of select="$s/first"/>
            </td>
            <td>
                <xsl:value-of select="$s/second"/>
            </td>
            <td>
                <xsl:value-of select="$s/third"/>
            </td>
        </tr>
    </xsl:template>

    <!-- Target Number th with target information in rich tooltip -->
    <xsl:template match="target" mode="table-heading">
        <th style="display: table-cell;" class="dropdown is-hoverable disappearing">
            <div class="dropdown-trigger">
                <xsl:value-of select="substring(@id,2,1)"/>
            </div>
            <div class="dropdown-menu">
                <div class="dropdown-content has-text-weight-normal">
                    <div class="dropdown-item level is-mobile mb-0">
                        <p class="level-left">
                            <strong>Type:</strong>
                        </p>
                        <p class="level-right">
                            <xsl:value-of select="type"/>
                        </p>
                    </div>
                    <hr class="dropdown-divider"/>
                    <div class="dropdown-item level is-mobile mb-0">
                        <p class="level-left">
                            <strong>Distance:</strong>
                        </p>
                        <p class="level-right"><xsl:value-of select="distance"/>m
                        </p>
                    </div>
                </div>
            </div>
        </th>
    </xsl:template>
</xsl:stylesheet>