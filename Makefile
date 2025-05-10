.PHONY: test

GROUP=$(shell id -gn)
APPDIR=$(PWD)
UNAME_S=$(shell uname -s)

install:
	docker compose run --rm runner bundle install
	docker compose run --rm runner yarn install

start:
	docker compose up rails css js sidekiq

clear-jobs:
	docker compose run --rm runner bundle exec rails runner 'Sidekiq.redis { |conn| conn.flushdb }'

db-reset:
	docker compose run --rm runner bundle exec rails db:drop
	docker compose run --rm -e RAILS_ENV=test runner bundle exec rails db:drop

db-prepare: db-reset
	docker compose run --rm runner bundle exec rails db:create db:migrate db:seed
	docker compose run --rm -e RAILS_ENV=test runner bundle exec rails db:create db:migrate

db-migrate:
	docker compose run --rm runner bundle exec rails db:migrate
	docker compose run --rm -e RAILS_ENV=test runner bundle exec rails db:migrate

db-rollback:
	docker compose run --rm runner bundle exec rails db:rollback
	docker compose run --rm -e RAILS_ENV=test runner bundle exec rails db:migrate

db-open:
	docker compose run --rm runner bundle exec rails db -p

stop:
	docker compose down

test:
	docker compose up -d chrome
	docker compose run --rm -e RAILS_ENV=test runner bundle exec rspec $(filter-out $@,$(MAKECMDGOALS))

cons:
	docker compose run --rm runner bundle exec rails console

dive:
	docker compose run --rm runner bash

lint:
	docker compose run --rm runner bundle exec rake standard

lint-fix:
	docker compose run --rm runner bundle exec rake standard:fix

change-secrets:
	docker compose run --rm runner bundle exec rails credentials:edit --environment=$(filter-out $@,$(MAKECMDGOALS))
ifeq ($(UNAME_S),Linux)
	sudo chown -R $(USER):$(GROUP) .
endif

attach:
	docker compose attach $(filter-out $@,$(MAKECMDGOALS))

restart:
	docker compose restart $(filter-out $@,$(MAKECMDGOALS))

kamal:
	@env $$(cat .env | xargs) kamal $(filter-out $@,$(MAKECMDGOALS))

prod-cons:
	kamal app exec -i 'bin/rails console'

deploy:
	@env $$(cat .env | xargs) kamal deploy

infra-setup:
	ansible-playbook -i infra/inventory/hosts infra/setup.yml

g:
	docker compose run --rm runner bundle exec rails g $(filter-out $@,$(MAKECMDGOALS))
ifeq ($(UNAME_S),Linux)
	sudo chown -R $(USER):$(GROUP) .
endif

d:
	docker compose run --rm runner bundle exec rails d $(filter-out $@,$(MAKECMDGOALS))

%:
	@:
