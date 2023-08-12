#!/bin/bash

project_name="mvp"
prod_ip="1.1.1.1"

rename_project () {
  echo "Renaming project"
  cd . || return
  new_dir=${PWD%/*}/$project_name
  mv -- "$PWD" "$new_dir" && cd -- "$new_dir"
  exec zsh
}

remove_git_origin () {
  git remote rm origin
}

rename_database_names () {
  echo "Renaming database.yml"
  sed -i "s/rapid_rails/$project_name/g" config/database.yml
}

rename_docker_compose () {
  sed -i "s/rapid_rails/$project_name/g" docker-compose.yml
}

rename_cable () {
  sed -i "s/rapid_rails/$project_name/g" config/cable.yml
}

prepare_for_deploy () {
  sed -i "s/<prod_ip>/$prod_ip/g" config/deploy.yml
}

#rename_project
rename_database_names
