#!/usr/bin/env sh
set -e

echo "{}" > config.production.json

/usr/local/lib/node_modules/ghost-cli/node_modules/.bin/knex-migrator-migrate --init --mgpath=/app/current

node current/index.js
