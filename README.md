# quarkiverse.github.io
Website for quarkiverse.io, built with [Roq](https://iamroq.dev).

* `roq start` (or `./mvnw quarkus:dev`) to run in dev mode
* `roq generate` (or `QUARKUS_ROQ_GENERATOR_BATCH=true ./mvnw package quarkus:run`) to generate the site in `target/roq`

## The Quarkiverse theme

Important site elements are packaged as a Roq theme in [`theme/`](theme/), published in a Maven
repository at https://quarkiverse.io/maven/ so other Quarkiverse sites can use it. See [`theme/README.md`](theme/README.md).
