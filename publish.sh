#!/usr/bin/env bash

set -x
set -e
set -u
set -o pipefail

if [ $# -ne 1 ]; then
  echo "$(basename $0) <private-repo>" 1>&2
  exit 1
fi

function heredoc () {
cat <<EOF
**Note**: This public repo contains the documentation for the private GitHub repo <https://github.com/sighup-io/${REPONAME}>.
We publish the documentation publicly so it turns up in online searches, but to see the source code, you must be a SIGHUP customer.
If you're already a SIGHUP customer, the original source for this file is at: <https://github.com/sighup-io/${REPONAME}-public/blob/master/${1#./}>.
If you're not a customer, contact us at <info@sighup.io> or <https://sighup.io> for info on how to get access!
EOF
}

export -f heredoc

REPONAME="$1"

export REPONAME

TMP_PRIVATE="$(readlink -e $(mktemp -d ${REPONAME}.XXXXXXXXXX))"
TMP_PUBLIC="$(readlink -e $(mktemp -d ${REPONAME}-public.XXXXXXXXXX))"

trap 'rm -rf "${TMP_PRIVATE}" "${TMP_PUBLIC}"' ERR EXIT

git clone "git@github.com:sighup-io/${REPONAME}.git" "${TMP_PRIVATE}"
git clone "git@github.com:sighup-io/${REPONAME}-public.git" "${TMP_PUBLIC}"

pushd "${TMP_PRIVATE}"
REPO_PRIVATE_HEAD="$(git rev-parse HEAD)"
find . -type f -not -path './.git/*' -a -not -name '.gitignore' -a -not -name '*.md' -exec bash -c 'heredoc {} | sed "s/^/# /" > {}' \;
find . -type f -not -path './.git/*' -a -not -name '.gitignore' -a -name '*.md' -exec bash -c 'echo -e "$(heredoc {})\n\n$(cat {})" > {}' \;
popd

rm -rf "${TMP_PUBLIC}"/*
cp -a "${TMP_PRIVATE}"/* "${TMP_PUBLIC}"

pushd "${TMP_PUBLIC}"
git add .
git commit -m "Auto-generate docs for commit ${REPO_PRIVATE_HEAD}"
git remote add target "git@github.com:sighup-io/${REPONAME}-public.git"
git push target master
popd

exit 0
