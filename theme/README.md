# Quarkiverse Roq theme


It provides:

- the `default` layout (`templates/theme-layouts/quarkiverse/default.html`), based on the Roq base theme, with a
  `footer` section that sites can override,
- the footer partial (`templates/partials/quarkiverse/footer.html`), for sites that have their own layouts,
- the footer styles (`web/app/_quarkiverse-footer.css`), imported by the theme's `web/app/main.js`,

## Using the theme in a site

The jar is published in a Maven repository at https://quarkiverse.io/maven/ on every deploy of quarkiverse.io:

```xml
<repositories>
    <repository>
        <id>quarkiverse-website</id>
        <url>https://quarkiverse.io/maven/</url>
        <snapshots><enabled>true</enabled></snapshots>
    </repository>
</repositories>

<dependency>
    <groupId>io.quarkiverse</groupId>
    <artifactId>quarkiverse-website-theme</artifactId>
    <version>1.0.0-SNAPSHOT</version>
</dependency>
```

The theme's web dependencies (fonts, icons) come in transitively, and the jar configures the Web Bundler to accept
them, so there is nothing else to declare.

Then, in the site:

- use `layout: default` for pages; the jar sets `site.theme=quarkiverse`,
- or, if the site has its own layouts, add `{#include partials/quarkiverse/footer.html /}` where the footer belongs.
  The partial uses the alternative expression syntax, so the site needs `quarkus.qute.alt-expr-syntax=true` in
  `config/application.properties` if it includes the partial from its own templates.

To override the footer in a layout that extends the theme layout:

```html
---
theme-layout: default
---
{#insert /}

{#footer}
{#include partials/quarkiverse/footer.html /}
<p>Something extra</p>
{/footer}
```

### Configuration

Both are optional, in `config/application.properties`:

| Property | Default |
| --- | --- |
| `quarkiverse-website-theme.contribute-url` | `https://github.com/quarkiverse/quarkiverse` |
| `quarkiverse-website-theme.copyright-holder` | `Quarkiverse` |

`example-minimal-site/` is a complete minimal site.

## How quarkiverse.io uses it

quarkiverse.io adds `theme/src/main/resources` to its resources (see the root `pom.xml`), so `roq start` needs no
pre-build and theme changes hot-reload like any site file.

`theme/pom.xml` packages the same sources as a jar. Since quarkiverse.io never uses that jar, `example-minimal-site/` is
built against it on every pull request (see the `theme` job in `.github/workflows/build.yml`).

On every deploy from `main`, the workflow publishes the jar to the `maven/` directory of the site, which makes the site
a Maven repository. A release to Maven Central every time the footer changes would be expensive and easy to forget.

## Developing the theme

Run `quarkus dev` at the repository root and edit the files in `theme/src/main/resources`.

To check the packaged jar like CI does:

```sh
./mvnw -f theme/pom.xml install
cd theme/example-minimal-site && QUARKUS_ROQ_GENERATOR_BATCH=true ../../mvnw package quarkus:run
./verify.sh target/roq
```

Keep in mind that a site using the jar differs from quarkiverse.io:

- the jar needs `META-INF/beans.xml`, otherwise its templates and web assets are ignored,
- templates use the alternative expression syntax (`{=expr}`), which `templates/.qute` enables for the jar.
