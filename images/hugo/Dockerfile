# syntax=docker/dockerfile:1
ARG HUGO_VERSION=0.111.3
FROM floryn90/hugo:$HUGO_VERSION-ext-alpine

SHELL ["/usr/bin/env", "bash", "-c"] 

COPY ./files/etc/ /etc/
RUN chmod 0440 /etc/sudoers.d/hugo

ARG GROUP_ID
ARG USER_ID

RUN --mount=type=cache,target=/var/cache/apk,sharing=locked <<EOF
  set -ex

  apk add less sudo

  addgroup --gid ${GROUP_ID} hugo
  adduser --home /home/hugo --shell /bin/bash --ingroup hugo --disabled-password --uid ${USER_ID} hugo
  sudo -u hugo git config --global init.defaultBranch main
EOF

USER hugo
ENV HOME=/home/hugo
WORKDIR /home/hugo/src
