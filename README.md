# Template for building Rails Turbo Apps from scratch

### TODO

* Add docs
* Add Makefile
* Add gems & libs
* Add tests
* Add script for renaming project

### How to use

* Clone the repo

There are two options how to do it

1. Use classic `git clone https://github.com/k0va1/lightning-rails.git`
2. Click on [Use this template](https://github.com/new?template_name=lightning-rails&template_owner=k0va1)` on Github and clone it afterwards

* Rename and prepare the project

Go to `setup.sh` and rename these variables according to your values

```
project_name="mvp" <- your project name
dockerhub_username="hetsketch" <- your username on dockerhub
prod_ip="1.1.1.1" <- your future production server's IP. In case you don't have yet leave it as is
```

Run `setup.sh`

```
./setup.sh
```

* Install dependencies

```
make install
```

* Setup database

```
make db-prepare
```

* Start the project

```
make start
``

### How to add ActiveAdmin

```
make dive
be rails g active_admin_setup
```

### What's inside?

* https://github.com/kirillplatonov/hotwire-livereload for live reload
* https://github.com/rails/tailwindcss-rails
