#!/bin/bash

ruby_version=3.2.2
node_version=14
yarn_version=1.22.15
postgres_version=13.0
redis_version=6.2
bundler_version=2.4.10

update_versions() {
  update_ruby_versions
  update_node_versions
  update_yarn_versions
  update_postgres_versions
  update_redis_versions
  update_bundler_versions
}

rebuild_images() {
  docker-compose down
  docker rmi $(docker images 'rapid-rails'  -a -q) -f
  docker-compose build runner
  make install
}

update_ruby_versions() {
  sed -i "s/ruby \".*\"/ruby \"$ruby_version\"/g" Gemfile
  sed -i "s/RUBY_VERSION: '.*'/RUBY_VERSION: '$ruby_version'/g" docker-compose.yml
  sed -i "s/ruby-version: '.*'/ruby-version: '$ruby_version'/g" .github/workflows/verify.yml
  sed -i "s/RUBY_VERSION: '.*'/RUBY_VERSION: '$ruby_version'/g" config/deploy.yml
}

update_node_versions() {
  sed -i "s/NODE_MAJOR: '.*'/NODE_MAJOR: '$node_version'/g" docker-compose.yml
  sed -i "s/node-version: '.*'/node-version: '$node_version'/g" .github/workflows/verify.yml
  sed -i "s/NODE_VERSION: '.*'/NODE_VERSION: '$node_version'/g" config/deploy.yml
}

update_yarn_versions() {
  sed -i "s/YARN_VERSION: '.*'/YARN_VERSION: '$yarn_version'/g" docker-compose.yml
  sed -i "s/YARN_VERSION: '.*'/YARN_VERSION: '$yarn_version'/g" config/deploy.yml
}

update_postgres_versions() {
  sed -i "s/POSTGRES_VERSION: '.*'/POSTGRES_VERSION: '$postgres_version'/g" docker-compose.yml
  sed -i "s/image: postgres:.*/image: postgres:$postgres_version/g" .github/workflows/verify.yml
  sed -i "s/image: postgres:.*/image: postgres:$postgres_version/g" config/deploy.yml
}

update_redis_versions() {
  sed -i "s/REDIS_VERSION: '.*'/REDIS_VERSION: '$redis_version'/g" docker-compose.yml
  sed -i "s/image: redis:.*/image: redis:$redis_version/g" .github/workflows/verify.yml
  sed -i "s/image: redis:.*/image: redis:$redis_version/g" config/deploy.yml
}

update_bundler_versions() {
  sed -i "s/BUNDLER_VERSION: '.*'/BUNDLER_VERSION: '$bundler_version'/g" docker-compose.yml
}

update_versions
rebuild_images
