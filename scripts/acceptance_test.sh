#/bin/bash

export BASE_URL=$1

echo "Running acceptance test on $BASE_URL"

bundle exec rake acceptance
