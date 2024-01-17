# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

## Problems
1) Error in installing mysql2 gem
gem install mysql2 -v '0.5.5' -- --with-ldflags=-L/opt/homebrew/opt/openssl@1.1/lib --with-cppflags=-I/opt/homebrew/opt/openssl@1.1/include
gem install mysql2 -v '0.5.5' -- --with-opt-dir=$(brew --prefix openssl) --with-ldflags=-L/opt/homebrew/opt/zstd/lib
