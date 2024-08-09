IMAGE_NAME=jkaninda/toolkit

build:
	 docker buildx build --platform=linux/amd64 -f src/Dockerfile -t ${IMAGE_NAME}:latest  .

run:
	docker compose up -d --force-recreate