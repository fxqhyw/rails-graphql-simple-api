#!/bin/sh

set -e

bundle exec rails db:setup

exec "$@"
