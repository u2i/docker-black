FROM alpine
ARG BLACK_VERSION=20.8b1
RUN set -eux \
    && apk add --no-cache python3 \
    && apk add --no-cache --virtual=deps \
        gcc \
        musl-dev \
        python3-dev \
        py3-pip \
    && pip3 install --no-cache-dir --no-compile "black==${BLACK_VERSION}" \
    && find /usr/lib/ -name '__pycache__' -print0 | xargs -0 -n1 rm -rf \
    && find /usr/lib/ -name '*.pyc' -print0 | xargs -0 -n1 rm -rf \
    && apk del deps

VOLUME /code
WORKDIR /code

ENTRYPOINT ["/usr/bin/black"]
CMD ["--check", "."]
