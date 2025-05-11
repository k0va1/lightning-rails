# Template for building Rails Turbo Apps from scratch

![Lightning Rails](images/logo.webp)

### Key features

* Postgres, Redis, Sidekiq, Puma
* Tailwind + Hotwire + Stimulus
* Kamal deployment
* RSpec for testing

### How to use

1. Clone the repo

There are two options how to do it:

* Use classic

```
git clone https://github.com/k0va1/lightning-rails.git
```

* Click on [Use this template](https://github.com/new?template_name=lightning-rails&template_owner=k0va1) on Github and clone it afterwards

2. Rename and prepare the project

Go to `setup.sh` and rename variables according to your values

```
project_name="mvp" <- your project name
dockerhub_username="k0va1" <- your username on dockerhub
prod_ip="1.1.1.1" <- your future production server's IP. In case you don't have yet leave it as is
```

Run `setup.sh`

```
./setup.sh
```

3. Install dependencies

```
make install
```

4. Setup database

```
make db-prepare
```

5. Start the project

```
make start
```

### How to add ActiveAdmin

```
make dive
be rails g active_admin_setup
```
