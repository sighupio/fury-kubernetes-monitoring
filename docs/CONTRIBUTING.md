# Contribution

Read the following guide about how to contribute to this project and get
familiar with.

## Make

This project contains an easy-to-use interface with a `Makefile`. It allows you
to pass all the checks the pipeline will pass on certain events. So it worth get
familiar with all the targets. To know what targets are available in the project
just run:

```bash
$ make help

 Choose a command to run in fury-kubernetes-monitoring:

  version                       lists the latest version of tool
  bump-major                    Bumps the module up by a major version
  bump-minor                    Bumps the module up by a minor version
  bump-patch                    Bumps the module up by a patch version
  bump-rc                       Bumps the module up by a release candidate (this only adds a tag, and not bump the version in labels)
  check-label                   Check if labels are present in all kustomization files
  add-license                   Add license headers in all files in the project
  check-license                 Check license headers are in-place in all files in the project
  lint                          Run the policeman over the repository
  clean-%                       Clean the container image resulting from another target. make build clean-build
  build-canonical-json          Build a canonical JSON for any tag of module, only to be run inside a clean working directory
```

## bump-version (Release process)

`bump-%v` targets is the recommended way of creating a new release in this
module. This target internally uses
[`bump2version`](https://github.com/c4urself/bump2version/#installation) to bump
the versions of the module in the `examples` directory and the `kustomization`
labels. Then it creates the tag corresponding to the target chosen. We follow
semantic versioning and following is the criteria for versions:

- `bump-major`: Bumps up a major version, i.e. from 1.x.y -> 2.0.0
- `bump-major`: Bumps up a major version, i.e. from x.2.y -> x.2.0
- `bump-patch`: Bumps up a patch version, i.e. from x.y.2 -> x.y.3
- `bump-rc`: Creates an `rc(release candidate)` tag based on the env
  variable `TAG` to be given with the make call.

Before bumping the version, make sure you have a file in the directory
`docs/releases/` with the name of the new tag to be created. That is if you are
planning to make a patch release to version `v1.9.2`, create a file
`docs/releases/v1.9.2.md` with the release notes. You can see an example
[here](releases/v0.1.0.md). Commit all the change with appropriate commit messages.

Before a real release(major, minor or patch) is made, it is recommended
to create a patch release to make sure that the module is ready for the
real release. For this you can use the target `bump-rc`.

`bump-rc` works a bit differently in that it does not bump the versions in the
`kustomization` files or `Furyfiles` as configured in `.bumpversion.cfg`. The
assumption behind this being the considering that a pre-release is more like a
draft release. Another difference of this target is, it expects the rc tag name as
a variable `TAG` along with the `make` call. This is because it is otherwise
quite difficult to interpret which is the target version for which a `rc` is
being created. So the example usage is:

```bash
$ TAG=v1.9.2-rc1 make bump-rc
# This essentially creates a tag `v1.9.2-rc1` which we can  push to github to create a pre-release
```

Then, in order to release it(assuming from version `1.9.1` to `1.9.2` - so a
patch release):

```bash
$ make bump-patch
Making a patch tag
$ git push --tags origin master
# This should trigger the drone pipeline to publish the new release with the release notes from the file created.
```

## lint

To ensure the code-bases follow a standard, we have automated pipelines testing
for the linting rules. If one has to test if the rules are respected locally,
the following command can be run:

```bash
$ make lint
# This will use a dockerised super-linter library to run linting
```

## add-license and check-license

### check-license

This target ensures that a BSD license clause-3 copyrighted to `SIGHUP
s.r.l` is added to all the code files in the repository. To run the
check, run the command:

```bash
$ make check-license
# This will use a dockerised `addlicense` library to run check for labels
```

### add-license

We ensure all of our files are LICENSED respecting the community standards. The
automated drone pipelines fail, if some files are left without license. To add
our preferred license(BSD clause-3), one could locally run:

```bash
$ make add-license
# This will use a dockerised `addlicense` library to add license to the
# missing files
```

## clean-%v

The `clean-%v` target has been designed to remove the local built image
resulting from the different targets in the [`Makefile`](Makefile).

The main reason to implement this target is to save disk space. `clean-%v`
target is automatically called in the targets `lint` and `add-license`.

## Check-label

This targets verifies that required labels for KFD modules exist in each
kustomization file in the repo. The list of required labels and this
check can be found
[here](https://github.com/sighupio/ci-commons/blob/main/conftest/kustomization/kfd-labels.md).

## build-canonical-json

> Warning: run this command only inside a clean working directory.

These two targets can be used to create the canonical definition for the
module or an existing TAG. The following are the usages:

```bash
$ TAG=v1.9.1 make build-canonical-json
INFO[0000] Building JSON for: module fury-kubernetes-monitoring, version v1.9.1
```

The above command builds a canonical JSON parsing the version `v1.9.1`.

