all: build

build:
	docker build -t meltwater/mesos-demo-webapp:latest demo-webapp/

.PHONY: build
