FROM python:3.7.0

ENV ANSIBLE_VERSION=2.7.4

RUN apt-get update -y \
  && apt-get install -y \
    openssh-client \
  && rm -rf /var/lib/apt/lists/*
RUN pip install ansible==$ANSIBLE_VERSION

CMD ['ansible']