ARTEMIS_VERSION=2.18.0
IMAGE_OWNER=saulocn

build:
	docker build -t ${IMAGE_OWNER}/artemismq:latest  -t ${IMAGE_OWNER}/artemismq:${ARTEMIS_VERSION} .

push: push-version push-latest

push-latest:
	docker push saulocn/artemismq:${ARTEMIS_VERSION}

push-version:
	docker push saulocn/artemismq:${ARTEMIS_VERSION}