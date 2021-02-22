#/bin/bash

export BASE_URL=$1

echo "Running acceptance test on $BASE_URL"
mkdir -p reports
bundle exec rake acceptance
