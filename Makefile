.DEFAULT_GOAL: help
SHELL := /bin/bash

PROJECTNAME := "fury-kubernetes-monitoring"
VERSION := $(shell (git for-each-ref refs/tags --sort=-taggerdate --format='%(refname)' --count=1 | sed -Ee 's/^refs\/tags\/v|-.*//'))

.PHONY: help
all: help
help: Makefile
	@echo
	@echo " Choose a command to run in "$(PROJECTNAME)":"
	@echo
	@sed -n 's/^##//p' $< | column -t -s ':' |  sed -e 's/^/ /'
	@echo

.PHONY: version
## version: lists the latest version of tool
version:
	@echo v$(VERSION)

check-variable-%: # detection of undefined variables.
	@[[ "${${*}}" ]] || (echo '*** Please define variable `${*}` ***' && exit 1)

check-release-file-%: # checks if a release doc exists
	$(eval tag := `echo "${*}" | sed -e "s/-rc.//"`)
	$(eval release_file := "docs/releases/${tag}.md")
	@test -f ${release_file} || (echo "*** Please define file ${release_file} ***" && exit 1)

bumpversion-requirements: check-docker
	@docker build --no-cache --pull --target bumpversion-requirement -f build/builder/Dockerfile -t ${PROJECTNAME}:local-bumpversion-requirements .

SEMVER_TYPES := major minor patch
BUMP_TARGETS := $(addprefix bump-,$(SEMVER_TYPES))
.PHONY: $(BUMP_TARGETS)
## bump-major: Bumps the module up by a major version
## bump-minor: Bumps the module up by a minor version
## bump-patch: Bumps the module up by a patch version
$(BUMP_TARGETS): bumpversion-requirements
	$(eval bump_type := $(strip $(word 2,$(subst -, ,$@))))
	@echo "Making a ${bump_type} tag"
	@docker run --rm -v ~/.gitconfig:/etc/gitconfig -v ${PWD}:/src -w /src ${PROJECTNAME}:local-bumpversion-requirements --current-version $(VERSION) $(bump_type)
	@$(MAKE) clean-bumpversion-requirements

## bump-rc: Bumps the module up by a release candidate (this only adds a tag, and not bump the version in labels)
.PHONY:
bump-rc: check-variable-TAG check-release-file-$(TAG)
	@echo "Making ${TAG} tag"
	@git tag ${TAG}


check-%: # detection of required software.
	@which ${*} > /dev/null || (echo '*** Please install `${*}` ***' && exit 1)

license-requirements: check-docker
	@docker build --no-cache --pull --target add-license-requirement -f build/builder/Dockerfile -t ${PROJECTNAME}:local-license-requirements .

## add-license: Add license headers in all files in the project
add-license: license-requirements
	@docker run --rm -v ${PWD}:/src -w /src ${PROJECTNAME}:local-license-requirements addlicense -c "SIGHUP s.r.l" -v -l bsd .
	@$(MAKE) clean-license-requirements

## check-license: Check license headers are in-place in all files in the project
check-license: check-docker
	@docker build --no-cache --pull --target check-license -f build/builder/Dockerfile -t ${PROJECTNAME}:local-license .
	@$(MAKE) clean-license

## check-label: Check if labels are present in all kustomization files
check-label: check-docker
	@docker build --no-cache --pull --target checklabel -f build/builder/Dockerfile -t ${PROJECTNAME}:checklabel .

## lint: Run the policeman over the repository
lint: check-docker
	@docker build --no-cache --pull --target linter -f build/builder/Dockerfile -t ${PROJECTNAME}:local-lint .
	@$(MAKE) clean-lint

## clean-%: Clean the container image resulting from another target. make build clean-build
clean-%:
	@docker rmi -f ${PROJECTNAME}:local-${*}

jsonbuilder:
	@docker build --no-cache --pull --target jsonbuilder -f build/builder/Dockerfile -t ${PROJECTNAME}:jsonbuilder .

## build-canonical-json: Build a canonical JSON for any tag of module, only to be run inside a clean working directory
build-canonical-json: check-docker check-variable-TAG jsonbuilder
	@docker run -ti --rm -v $(PWD):/app -w /app ${PROJECTNAME}:jsonbuilder build-json -m=$(PROJECTNAME) -v=${TAG} .
