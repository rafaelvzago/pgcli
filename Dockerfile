FROM alpine

MAINTAINER Maciej Lisiewski <maciej.lisiewski@gmail.com>

RUN apk add --no-cache \
        python3 \
        libevent \
        tini \
        libpq && \
    apk add --no-cache --virtual .build-deps \
        python3-dev \
        postgresql-dev \
        libevent-dev \
        musl-dev \
        gcc && \
    python3 -m ensurepip && \
    pip3 install --upgrade pip && \
    pip3 install pgcli && \
    apk del .build-deps

COPY entrypoint.sh /entrypoint.sh
RUN chmod 777 /entrypoint.sh

ENTRYPOINT ["/sbin/tini", "--", "/entrypoint.sh"]
