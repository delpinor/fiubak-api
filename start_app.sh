#!/bin/sh
bundle exec rake db:migrate
bundle exec padrino start -p $PORT -h 0.0.0.0
