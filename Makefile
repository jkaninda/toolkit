IMAGE_NAME=jkaninda/toolkit

build:
	 docker build -f src/Dockerfile -t ${IMAGE_NAME}:latest  .

run:
	docker compose up -d --force-recreate