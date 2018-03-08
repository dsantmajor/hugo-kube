DOCKER_REGISTRY_LOCAL = registry.dontechlabs.com:5005
DOCKER_REGISTRY_GC = asia.gcr.io
GCP_JSON_LOCATION = /vagrant/.gcp/don-kube-c6bdb7737cb1.json
IMAGE_NAME = hugokube
IMAGE_VERSION = 0.1
IMAGE_PROJECT = don-kube
IMAGE_TAG_LOCAL = $(DOCKER_REGISTRY_LOCAL)/$(IMAGE_NAME):$(IMAGE_VERSION)
IMAGE_TAG_GC = $(DOCKER_REGISTRY_GC)/$(IMAGE_PROJECT)/$(IMAGE_NAME):$(IMAGE_VERSION)

WORKING_DIR := $(shell pwd)
# The $(shell) function calls out to the shell to execute a command.
# The command being executed in this case is pwd, like if you ran
# pwd at the bash shell prompt.

JSON_KEY := @cat $(GCP_JSON_LOCATION)

.DEFAULT_GOAL := build

.PHONY: build push

release:: build push ## Builds and pushes the docker image to the registry

releasegc:: buildgc pushgc ## Builds and pushes the docker image to the registry

push:: ## Pushes the docker image to the registry
	    @docker push $(IMAGE_TAG_LOCAL)

pushgc:: ## Pushes the docker image to Google Cloud the registry
	    @gcloud docker -- push $(IMAGE_TAG_GC)

docker-start:: ## start the container in daemon mode
	    @docker-compose up -d

docker-stop:: ## start the container in daemon mode
	    @docker stop `docker ps |  grep hugokube_website_1 | awk '{print $1}'`

build:: ## Builds the docker image locally
	    @echo $(IMAGE_TAG_LOCAL)
			@docker build --pull \
        -t $(IMAGE_TAG_LOCAL) $(WORKING_DIR)

buildgc:: ## Builds the docker image locally
	    @echo $(IMAGE_TAG_GC)
			@docker build --pull \
        -t $(IMAGE_TAG_GC) $(WORKING_DIR)

# buildgc:: ## Builds the docker image locally
# 	    @echo $(IMAGE_TAG_GC)
#       @docker build --pull \
# 				-t $(IMAGE_TAG_GC) $(WORKING_DIR)

# A help target including self-documenting targets (see the awk statement)
# define HELP_TEXT
# Usage: make [TARGET]... [MAKEVAR1=SOMETHING]...
#
# Available targets:
# endef
# export HELP_TEXT
# help: ## This help target
#     @cat .banner
#     @echo
#     @echo "$$HELP_TEXT"
#     @awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / \
#         {printf "\033[36m%-30s\033[0m  %s\n", $$1, $$2}' $(MAKEFILE_LIST)
