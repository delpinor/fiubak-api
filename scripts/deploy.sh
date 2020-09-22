#!/bin/bash

curl -X PATCH https://api.heroku.com/apps/memo2webtemplate/formation --header "Content-Type: application/json" --header "Accept: application/vnd.heroku+json; version=3.docker-releases" --header "Authorization: Bearer ${HEROKU_TOKEN}" --data '{ "updates": [ { "type": "web", "docker_image": "'$(cat imageid.txt)'" } ] }'