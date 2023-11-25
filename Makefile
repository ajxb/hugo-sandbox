SHELL=/usr/bin/env bash

include .env
export

export GROUP_ID?=$(shell id -g)
export USER_ID?=$(shell id -u)
export HUGO_PARAMS
export NGROK_URL?=

.PHONY: all build clean cli down expose hide init restart up
.PHONY: confirm

all: build up

# Build Docker images required by Docker Compose
build:
	docker compose build cli hugo

# Clean the system - removes built images and volumes
clean: down
	-docker rmi $$(docker compose --profile cli --profile server config --images)
	-docker volume rm $$(docker compose --profile cli --profile server config | yq '.volumes.*.name')

# Run a cli instance of Hugo
cli: init
	docker compose run --rm cli

# Remove the running instance of Hugo
down:
	docker compose --profile expose --profile server down

# Expose the Hugo instance to the internet using ngrok
expose: init
	HUGO_PARAMS="--appendPort=false --baseURL=$(NGROK_URL)" docker compose --profile expose --profile server up --detach
	@echo "Hugo instance exposed at https://$(NGROK_URL)"

# Hide the Hugo instance from the internet
hide:
	docker compose stop ngrok
	docker compose --profile server up --detach

# Initialise the system
init:
	mkdir -p src

# Restart the Hugo instance
restart: down up

# Start the Hugo instance
up: init
	docker compose --profile server up --detach
	@echo "Hugo instance started at http://localhost:$(HUGO_PORT)"
