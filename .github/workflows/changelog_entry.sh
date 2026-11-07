#!/usr/bin/env bash

# Print only the requested release's entry, if present. Release Please uses
# either linked headings (## [1.2.3](...)) or plain headings (## 1.2.3).
set -o errexit -o nounset -o pipefail

if [[ -f CHANGELOG.md ]]; then
    awk -v version="${1#v}" '
        /^##? / {
            heading = $2
            sub(/^\[/, "", heading)
            sub(/\].*$/, "", heading)
            sub(/^v/, "", heading)
            if (found) exit
            found = (heading == version)
        }
        found { print }
    ' CHANGELOG.md
fi
