DOMAIN ?= ultroneous.org
DOCROOT ?= www/ultroneous.org

default: build

build: source
	jekyll build --source source --destination build

docker-build: source
	docker build -t ultroneous.org .
	docker run --rm -v $$PWD/source:/root/ultroneous.org/source -v $$PWD/build:/root/ultroneous.org/build ultroneous.org jekyll build --source source --destination build

deploy: build
	rsync -rv --delete --exclude=share --exclude=grace-foundation build/ $(DOMAIN):$(DOCROOT)/

test: source
	jekyll serve --incremental --source source --destination build
