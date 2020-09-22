#!/bin/bash

docker build -f Dockerfile --iidfile imageid.txt -t registry.heroku.com/memo2webtemplate/web .
docker login -u _ -p $HEROKU_TOKEN registry.heroku.com
docker push registry.heroku.com/memo2webtemplate/web
echo "Docker Image ID is $(cat imageid.txt)"
