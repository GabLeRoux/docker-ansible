#!/usr/bin/env bash

set -ex

LC_COLLATE=C
app=ansible
existing_tags=$(docker run --rm quay.io/skopeo/stable --override-os linux inspect docker://gableroux/$app | jq '.RepoTags[]' -r  | sort)
echo "$existing_tags" > versions.existing.txt

PACKAGE_JSON_URL="https://pypi.org/pypi/$app}/json"
all_tags=$(curl -L -s "$PACKAGE_JSON_URL" | jq  -r '.releases | keys | .[]' | sort)
echo "$all_tags" > versions.all.txt

missing_versions=$(comm -13 versions.existing.txt versions.all.txt)
echo "$missing_versions" > versions.missing.txt

cat versions.missing.txt
