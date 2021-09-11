#!/usr/bin/env bash

cat versions.missing.txt | xargs -I {} bash -c "source scripts/replace_version_function.sh && replace_version {}"
