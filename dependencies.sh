#!/bin/bash

ruby_version=3.3.6
node_version=22
yarn_version=1.22.22
postgres_major=17
postgres_version=17.0
redis_version=7.0
bundler_version=2.5.0

platform=''
case "$OSTYPE" in
  darwin*)  platform="OSX" ;;
  linux*)   platform="LINUX" ;;
  bsd*)     platform="BSD" ;;
  *)        platform="unsupported" ;;
esac

if [ "$platform" == "unsupported" ]; then
  echo "Unsupported platform"
  exit 1
fi

replace_occurrences() {
  if [ "$platform" == "OSX" ]; then
    sed -i "" "$1" "$2"
  else
    sed -i "$1" "$2"
  fi
}

update_versions() {
  update_ruby_versions
  update_node_versions
  update_yarn_versions
  update_postgres_versions
  update_redis_versions
  update_bundler_versions
}

rebuild_images() {
  docker compose down
  docker rmi $(docker images 'lightning-rails' -a -q) -f
  docker compose build runner
  make install
}

update_ruby_versions() {
  replace_occurrences "s/ruby \".*\"/ruby \"$ruby_version\"/g" Gemfile
  replace_occurrences "s/RUBY_VERSION: '.*'/RUBY_VERSION: '$ruby_version'/g" docker-compose.yml
  replace_occurrences "s/ruby:.*/ruby:$ruby_version/g" .github/workflows/ci.yml
  replace_occurrences "s/ruby-version: .*/ruby-version: $ruby_version/g" .github/workflows/ci.yml
  replace_occurrences "s/RUBY_VERSION: '.*'/RUBY_VERSION: '$ruby_version'/g" config/deploy.yml
}

update_node_versions() {
  replace_occurrences "s/NODE_MAJOR: '.*'/NODE_MAJOR: $node_version/g" docker-compose.yml
  replace_occurrences "s/node-version: .*/node-version: $node_version/g" .github/workflows/ci.yml
  replace_occurrences "s/NODE_VERSION: .*/NODE_VERSION: $node_version/g" config/deploy.yml
}

update_yarn_versions() {
  replace_occurrences "s/YARN_VERSION: '.*'/YARN_VERSION: '$yarn_version'/g" docker-compose.yml
  replace_occurrences "s/YARN_VERSION: '.*'/YARN_VERSION: '$yarn_version'/g" config/deploy.yml
}

update_postgres_versions() {
  replace_occurrences "s/image: postgres:.*/image: postgres:$postgres_version/g" docker-compose.yml
  replace_occurrences "s/image: postgres:.*/image: postgres:$postgres_version/g" .github/workflows/ci.yml
  replace_occurrences "s/image: postgres:.*/image: postgres:$postgres_version/g" config/deploy.yml
  replace_occurrences "s/PG_MAJOR: '.*'/PG_MAJOR: $postgres_major/g" docker-compose.yml
}

update_redis_versions() {
  replace_occurrences "s/REDIS_VERSION: '.*'/REDIS_VERSION: '$redis_version'/g" docker-compose.yml
  replace_occurrences "s/image: redis:.*/image: redis:$redis_version-alpine/g" docker-compose.yml
  replace_occurrences "s/image: redis:.*/image: redis:$redis_version/g" .github/workflows/ci.yml
  replace_occurrences "s/image: redis:.*/image: redis:$redis_version/g" config/deploy.yml
}

update_bundler_versions() {
  replace_occurrences "s/BUNDLER_VERSION: '.*'/BUNDLER_VERSION: '$bundler_version'/g" docker-compose.yml
}

update_versions
rebuild_images
