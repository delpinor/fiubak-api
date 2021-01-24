#!/bin/sh

docker-compose run --rm webapp bundle exec rake db:migrate
docker-compose up -d
docker-compose exec webapp /bin/bash
