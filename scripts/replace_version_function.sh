#!/usr/bin/env bash

replace_version() {
    new_version=$1

    sed -i '' "s#ansible==.*#ansible==${new_version}#g" requirements.txt
    sed -i '' "s#gableroux/ansible:.*#gableroux/ansible:${new_version}#g" ReadMe.md

    cat requirements.txt

    git add requirements.txt
    git add ReadMe.md

    git commit -m "Set version to ${new_version}"
    git tag "${new_version}"
    git push
    git push --tags
}
