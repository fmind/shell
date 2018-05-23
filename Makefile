TAG=fmind/shell

all: build push;

push:
	docker push ${TAG}

build:
	docker build -t ${TAG} .
