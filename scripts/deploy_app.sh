#!/bin/sh

# first wait some seconds to ensure the image is registered bby heroku
sleep 30

echo "image id: $IMAGE_ID"

curl -X PATCH https://api.heroku.com/apps/$HEROKU_APP/formation --header "Content-Type: application/json" --header "Accept: application/vnd.heroku+json; version=3.docker-releases" --header "Authorization: Bearer ${HEROKU_TOKEN}" --data '{ "updates": [ { "type": "web", "docker_image": "$IMAGE_ID" } ] }' --fail