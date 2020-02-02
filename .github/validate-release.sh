#!/usr/bin/env bash

BRANCH=$(git rev-parse --abbrev-ref HEAD)
MASTER=$(git rev-parse origin/master)
CURRENT=$(git rev-parse ${BRANCH})

if [[ ${MASTER} != ${CURRENT} ]];then
  echo "ERROR - The release branch is not up to date with master" 1>&2
  exit 1
fi

VERSION=$(echo ${BRANCH} | awk -F / '{print $2}')

if [[ ${VERSION} =~ ^[0-9]+.[0-9]+.[0-9]+$ ]];then
    sleep 0
else
    echo "ERROR - Version: ${VERSION}, didn't match the version pattern \d+.\d+.\d+" 1>&2
    exit 2
fi

echo "::set-output name=branch::${BRANCH}"
echo "::set-output name=version::${VERSION}"