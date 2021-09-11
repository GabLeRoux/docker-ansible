#!/usr/bin/env bash

set -e

git config user.name "GitHub Actions Bot"
git config user.email "<>"

requirements_version=$(cat requirements.txt | grep ansible | sed 's#ansible==##g')

set +e
echo git tag -d $requirements_version
echo git push origin :refs/tags/$requirements_version

set -e
echo git tag $requirements_version
echo git push --tags
