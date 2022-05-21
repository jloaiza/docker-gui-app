#/usr/bin/env bash

set -o errexit

# Get xauth cookie
export X_COOKIE=$(xauth list | grep $(uname -n) | grep -oP '[0-9a-zA-Z]{32}')

if [ -z ${X_COOKIE} ]; then
    echo "Unable to get xauth cookie for $(uname -n)"
fi

docker-compose -f docker-compose.yaml build gui-app
docker-compose -f docker-compose.yaml run gui-app $@
