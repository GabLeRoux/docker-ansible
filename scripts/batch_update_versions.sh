#!/usr/bin/env bash
cat versions.txt | \
xargs -I _ bash -c "echo 'ansible==_' > requirements.txt \
    && git add requirements.txt \
    && git commit -m 'Set version to _' \
    && git tag _ \
    && git push \
    && git push --tags"
