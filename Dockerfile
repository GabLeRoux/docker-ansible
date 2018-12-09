FROM python:3.7-alpine

COPY requirements.txt ./

RUN apk add --update --no-cache \
    openssh-client \
    --virtual .build-deps \
      make \
      gcc \
      python3-dev \
      musl-dev \
      libffi-dev \
      openssl-dev \
    && pip install --no-cache-dir -r requirements.txt \
    && apk del .build-deps

CMD ['ansible']
