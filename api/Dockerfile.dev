FROM eclipse-temurin:21

RUN apt-get update && apt-get install -y --no-install-recommends \
    inotify-tools \
    dos2unix \
 && rm -rf /var/lib/apt/lists/*

ENV HOME=/app

RUN mkdir -p $HOME

WORKDIR $HOME
