TAG ?= clover/3proxy
PLATFORM ?= linux/amd64,linux/arm/v7,linux/arm64/v8

latest:
	docker buildx build --platform ${PLATFORM} --tag ${TAG}:$@ --push .

.PHONY: latest
