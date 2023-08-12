.PHONY: test

APPDIR=$(PWD)

install:
	docker-compose run --rm runner bundle install && yarn install

rm-rails-pid:
	yes | rm -f $(APPDIR)/tmp/pids/server.pid

start: rm-rails-pid
	docker-compose up rails css js sidekiq

clear-jobs:
	docker-compose run --rm runner bundle exec rails runner 'Sidekiq.redis { |conn| conn.flushdb }'

db-reset:
	docker-compose run --rm runner bundle exec rails db:drop

db-prepare: db-reset
	docker-compose run --rm runner bundle exec rails db:create db:migrate db:seed
	docker-compose run --rm -e RAILS_ENV=test runner bundle exec rails db:create db:migrate

db-migrate:
	docker-compose run --rm runner bundle exec rails db:create db:migrate
	docker-compose run --rm -e RAILS_ENV=test runner bundle exec rails db:migrate

db-open:
	docker-compose run --rm runner bundle exec rails db -p

stop:
	docker-compose down

test:
	docker-compose up -d chrome-server
	docker-compose run --rm -e RAILS_ENV=test runner bundle exec rspec $(filter-out $@,$(MAKECMDGOALS))

cons:
	docker-compose run --rm runner bundle exec rails console

dive:
	docker-compose run --rm runner bash

lint:
	docker-compose run --rm runner bundle exec rake rails_lint

lint-fix:
	docker-compose run --rm runner bundle exec rake rails_lint -A

change-secrets:
	docker-compose run --rm runner bundle exec rails credentials:edit --environment=$(filter-out $@,$(MAKECMDGOALS))
	sudo chown -R $(USER):$(USER) .

g:
	docker-compose run --rm runner bundle exec rails g $(filter-out $@,$(MAKECMDGOALS))
	sudo chown -R $(USER):$(USER) .

d:
	docker-compose run --rm runner bundle exec rails d $(filter-out $@,$(MAKECMDGOALS))

%:
	@:
