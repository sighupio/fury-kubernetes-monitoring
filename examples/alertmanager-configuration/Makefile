.PHONY: build deploy

build:
	kustomize build .

deploy:
	kustomize build . | kubectl apply -f -
