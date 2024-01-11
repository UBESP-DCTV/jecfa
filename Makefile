version := v0.1

all: update

update: build restart push

restart: stop remove run

# https://stackoverflow.com/questions/34228864/stop-and-delete-docker-container-if-its-running
stop:
	docker stop jecfa || true

run:
	docker run -d --rm --name jecfa -e PASSWORD=jecfa -p 18787:8787 jecfa:$(version)

remove:
	docker rm jecfa || true

build:
	docker build -t jecfa:$(version) .

tag:
	docker tag jecfa:$(version) jecfa:$(version)
	docker tag jecfa:$(version) corradolanera/jecfa:$(version)
	docker tag jecfa:$(version) jecfa:latest
	docker tag jecfa:$(version) corradolanera/jecfa:latest

push: tag
	docker push -a corradolanera/jecfa
