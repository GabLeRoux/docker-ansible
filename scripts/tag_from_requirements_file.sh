#!/usr/bin/env bash

set -e

git config user.name "GitHub Actions Bot"
git config user.email "<>"

requirements_version=$(cat requirements.txt | grep ansible | sed 's#ansible==##g')

set +e
#git tag -d $requirements_version
#git push origin :refs/tags/$requirements_version

set -e
git tag $requirements_version
git push --tags
