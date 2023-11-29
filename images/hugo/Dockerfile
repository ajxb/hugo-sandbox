# syntax=docker/dockerfile:1
ARG HUGO_VERSION=0.111.3
FROM floryn90/hugo:$HUGO_VERSION-ext-ubuntu

SHELL ["/usr/bin/env", "bash", "-c"] 

COPY ./files/etc/ /etc/
RUN chmod 0440 /etc/sudoers.d/hugo

ARG DART_SASS_VERSION=1.69.5
ARG GROUP_ID
ARG USER_ID

# Configure the system
RUN --mount=type=cache,target=/var/cache/apt,sharing=locked <<EOF
  set -ex

  apt update
  apt install --yes less sudo vim

  # Delete user - ubuntu
  deluser --remove-all ubuntu

  # Add user - hugo
  groupadd --gid ${GROUP_ID} hugo
  useradd --home /home/hugo --gid hugo --groups sudo --create-home --shell /bin/bash --uid ${USER_ID} hugo

  # Uninstall dart sass embedded
  unlink /usr/local/bin/dart-sass-embedded

  # Install dart sass
  wget https://github.com/sass/dart-sass/releases/download/${DART_SASS_VERSION}/dart-sass-${DART_SASS_VERSION}-linux-x64.tar.gz -O /tmp/sass.tar.gz
  tar -zxvf /tmp/sass.tar.gz -C /usr/local/lib
  ln -s /usr/local/lib/dart-sass/sass /usr/local/bin/sass
  rm -fr /tmp/sass.tar.gz
EOF

# Configure the hugo user
USER hugo
WORKDIR /home/hugo
ENV HOME=/home/hugo
ENV HUGO_CACHEDIR=/tmp/hugo
RUN <<EOF
  set -ex

  # Configure the comand history
  mkdir ~/history
  echo "export PROMPT_COMMAND='history -a'" >> .bashrc
  echo "export HISTFILE=~/history/.bash_history" >> .bashrc

  # Configure git
  git config --global init.defaultBranch main

  # Create tmp folder for hugo
  mkdir /tmp/hugo
EOF

WORKDIR /home/hugo/src
