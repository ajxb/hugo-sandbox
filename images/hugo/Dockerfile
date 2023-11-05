# syntax=docker/dockerfile:1
ARG HUGO_VERSION=0.111.3
FROM floryn90/hugo:$HUGO_VERSION-ext-ubuntu

SHELL ["/usr/bin/env", "bash", "-c"] 

COPY ./files/etc/ /etc/
RUN chmod 0440 /etc/sudoers.d/hugo

ARG GROUP_ID
ARG USER_ID

RUN --mount=type=cache,target=/var/cache/apt,sharing=locked <<EOF
  set -ex

  apt update
  apt install --yes less sudo

  # Delete user - ubuntu
  deluser --remove-all ubuntu

  # Add user - hugo
  groupadd --gid ${GROUP_ID} hugo
  useradd --home /home/hugo --gid hugo --groups sudo --create-home --shell /bin/bash --uid ${USER_ID} hugo

  # Configure the hugo user
  sudo -u hugo git config --global init.defaultBranch main
EOF

USER hugo
ENV HOME=/home/hugo
WORKDIR /home/hugo/src
