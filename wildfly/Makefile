IMAGE_OWNER=saulocn
build-image: remove
	docker build -t ${IMAGE_OWNER}/wildfly:latest .

remove:
	docker rmi ${IMAGE_OWNER}/wildfly:latest || true

push-latest:
	docker push ${IMAGE_OWNER}/wildfly:latest
