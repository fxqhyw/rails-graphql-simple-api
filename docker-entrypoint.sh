#!/bin/sh

set -e

bundle exec rails db:setup
bundle exec rake books:reindex

exec "$@"
