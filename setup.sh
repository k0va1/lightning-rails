#!/bin/bash

project_name="mvp"
dockerhub_username="hetsketch"
prod_ip="1.1.1.1"

main () {
  rename_project
  rename_database_names
  rename_docker_compose
  rename_cable
  prepare_for_deploy
  rename_dependencies
  exec $SHELL
}

rename_project () {
  echo "Renaming project"
  cd . || return
  new_dir=${PWD%/*}/$project_name
  mv -- "$PWD" "$new_dir" && cd -- "$new_dir"
}

remove_git_origin () {
  git remote rm origin
}

rename_database_names () {
  echo "Renaming database.yml"
  sed -i '' "s/lightning_rails/$project_name/g" config/database.yml
}

rename_docker_compose () {
  echo "Renaming docker-compose.yml"
  sed -i '' "s/lightning_rails/$project_name/g" docker-compose.yml
}

rename_cable () {
  echo "Renaming cable.yml"
  sed -i '' "s/lightning_rails/$project_name/g" config/cable.yml
}

prepare_for_deploy () {
  echo "Renaming deploy.yml"
  sed -i '' "s/<prod_ip>/$prod_ip/g" config/deploy.yml
  sed -i '' "s/hetsketch/$dockerhub_username/g" config/deploy.yml
  sed -i '' "s/lightning_rails/$project_name/g" config/deploy.yml
  echo "Copying templates/ci.yml"
  mv templates/ci.yml .github/workflows/ci.yml
}

rename_dependencies () {
  echo "Renaming dependencies.sh"
  sed -i '' "s/lightning-rails/$project_name/g" dependencies.sh
}

main
