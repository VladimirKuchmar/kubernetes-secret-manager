# Makefile for the Docker image stevesloka/kubernetes-vault-manager
# MAINTAINER: Steve Sloka <steve@stevesloka.com>

.PHONY: all build container push clean test

TAG ?= 1.0.0
PREFIX ?= stevesloka

all: container

build: main.go
	GOOS=linux GOARCH=amd64 CGO_ENABLED=0 go build -a -installsuffix cgo -o kubernetes-secret-manager --ldflags '-w' ./main.go ./vault.go ./kubernetes.go ./processor.go ./db.go

container: build
	docker build -t $(PREFIX)/kubernetes-secret-manager:$(TAG) .

push:
	docker push $(PREFIX)/kubernetes-secret-manager:$(TAG)

clean:
	rm -f kubernetes-secret-manager

test: clean
	godep go test -v --vmodule=*=4
