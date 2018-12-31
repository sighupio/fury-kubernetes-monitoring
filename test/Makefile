
targets:
	kustomize build | yq -rc '[.metadata.namespace,.kind,.metadata.name]|@csv' > targets.csv
