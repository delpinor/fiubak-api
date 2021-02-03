#!/bin/bash
# IMPORTANT: before running this script ensure to run heroku login!!!!

set -e

heroku container:login
heroku apps:create webapi-example
heroku addons:create heroku-postgresql:hobby-dev --app webapi-example
#heroku addons:create sumologic:free --app webapi-example
heroku config:set RACK_ENV=production --app webapi-example

heroku drains:add <SUMOLOGIC_SOURCE> --app webapi-example
