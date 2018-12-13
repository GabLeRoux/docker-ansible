FROM python:3.7-alpine

COPY requirements.txt ./

RUN apk add --update --no-cache \
    openssh-client \
    rsync \
    musl-dev \
    libffi-dev \
    openssl-dev 
RUN apk add --update --no-cache \
    --virtual .build-deps \
    make \
    gcc \
    python3-dev \
    && pip install --no-cache-dir -r requirements.txt \
    && apk del .build-deps

RUN addgroup -g 1000 -S gitlab-runner && \
    adduser -u 1000 -S gitlab-runner -G gitlab-runner
USER gitlab-runner

CMD ['ansible']
