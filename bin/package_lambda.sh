#!/bin/bash

code=${1:?No code specified}

REPO_ROOT_DIR="$(dirname $( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd ))"

cd ${REPO_ROOT_DIR}

mkdir -p tmp/lambda

zip -r tmp/lambda/${code}.zip src/${code}
