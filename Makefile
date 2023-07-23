.PHONY: test

APPDIR=$(PWD)

install:
	docker-compose run --rm  runner bundle install

rm-rails-pid:
	yes | rm -f $(APPDIR)/tmp/pids/server.pid

backend: rm-rails-pid
	docker-compose up rails sidekiq anycable

start: rm-rails-pid
	docker-compose up server

jobs:
	docker-compose up sidekiq

clear-jobs:
	docker-compose run --rm runner bundle exec rails runner 'Sidekiq.redis { |conn| conn.flushdb }'

db-reset:
	docker-compose run --rm runner bundle exec rails db:drop

db-prepare: db-reset
	docker-compose run --rm runner bundle exec rails db:create db:migrate seeds
	docker-compose run --rm -e RAILS_ENV=test runner bundle exec rails db:create db:migrate

db-migrate:
	docker-compose run --rm runner bundle exec rails db:create db:migrate
	docker-compose run --rm -e RAILS_ENV=test runner bundle exec rails db:migrate

db-open:
	docker-compose run --rm runner bundle exec rails db -p

stop:
	docker-compose down

test:
	docker-compose run --rm -e RAILS_ENV=test runner bundle exec rspec $(filter-out $@,$(MAKECMDGOALS))

cons:
	docker-compose run --rm runner bundle exec rails console

dive:
	docker-compose run --rm runner bash

lint:
	docker-compose run --rm runner bundle exec rubocop

lint-fix:
	docker-compose run --rm runner bundle exec rubocop -A

g:
	docker-compose run --rm runner bundle exec rails g $(filter-out $@,$(MAKECMDGOALS))
	sudo chown -R $(USER):$(USER) .

d:
	docker-compose run --rm runner bundle exec rails d $(filter-out $@,$(MAKECMDGOALS))

%:
	@:
