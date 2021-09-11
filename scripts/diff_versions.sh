#!/usr/bin/env bash

set -ex

app=ansible

existing_tags=$(skopeo --override-os linux inspect docker://gableroux/$app | jq '.RepoTags[]' -r  | sort -V)
echo "$existing_tags" > versions.existing.txt

PACKAGE_JSON_URL="https://pypi.org/pypi/${app}/json"
all_tags=$(curl -L -s "$PACKAGE_JSON_URL" | jq  -r '.releases | keys | .[]' | sort -V)
echo "$all_tags" > versions.all.txt

missing_tags=$(comm -23 <(cat ./versions.all.txt) <(cat ./versions.existing.txt))
echo "$missing_tags" > versions.missing.txt

cat versions.missing.txt
