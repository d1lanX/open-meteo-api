FROM ghcr.io/open-meteo/open-meteo:latest

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y wget gpg ca-certificates lsb-release \
    && wget -qO - https://patrick-zippenfenig.github.io/ecCodes-ubuntu/public.key | gpg --dearmor -o /etc/apt/trusted.gpg.d/ecCodes-ubuntu.gpg \
    && echo "deb https://patrick-zippenfenig.github.io/ecCodes-ubuntu/ jammy main" > /etc/apt/sources.list.d/ecCodes-ubuntu.list \
    && wget https://apache.jfrog.io/artifactory/arrow/ubuntu/apache-arrow-apt-source-latest-jammy.deb \
    && apt-get install -y -V ./apache-arrow-apt-source-latest-jammy.deb \
    && apt-get update \
    && GIR_PARQUET_PKG="$(apt-cache depends libparquet-glib-dev | awk '/Depends: gir1\.2-parquet-/{print $2; exit}')" \
    && if [ -z "$GIR_PARQUET_PKG" ]; then echo "Could not resolve gir1.2-parquet package" >&2; exit 1; fi \
    && apt-get install -y tzdata libnetcdf19 libeccodes0 bzip2 "$GIR_PARQUET_PKG" curl \
    && rm -rf /var/lib/apt/lists/* apache-arrow-apt-source-latest-jammy.deb
