#!/usr/bin/env bash
set -e

REPO_ORGANIZATION=$1
REPO_NAME=$2
CNAME=$3
GITHUB_USERNAME=$4
GITHUB_TOKEN=$5

if [[ ${REPO_NAME} != "" &&  CNAME != "" ]]; then

    echo "Going to set environment to maintenance mode, repo name: ${REPO_NAME}, CNAME: ${CNAME}"

    GIT_AUTH="${GITHUB_USERNAME}:${GITHUB_TOKEN}"

    curl --user "${GIT_AUTH}" \
     --request POST \
     --header "Content-Type: application/json" \
     --header "Accept: application/vnd.github.switcheroo-preview+json" \
     --url "https://api.github.com/repos/${REPO_ORGANIZATION}/${REPO_NAME}/pages" \
     --data "{ \"source\": { \"branch\": \"master\" } }"

     curl --user "${GIT_AUTH}" \
     --request PUT \
     --header "Content-Type: application/json" \
     --url "https://api.github.com/repos/${REPO_ORGANIZATION}/${REPO_NAME}/pages" \
     --data "{ \"cname\": \"${CNAME}\", \"source\": \"master\" }"
else
    echo "No need to set environment to maintenance mode"
fi
