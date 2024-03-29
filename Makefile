# VARS
IMAGE:=fmind/shell
# TASKS
push: rebuild
	docker push ${IMAGE}

build:
	docker build -t ${IMAGE} .

rebuild:
	docker build --no-cache -t ${IMAGE} .
