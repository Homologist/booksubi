# README

This app  help you to store your csv about books to your S3 account

* This project use ruby 2.5.7 but works for versions >= 2.0

* 

* The docker-compose should be place in the parent folder and the parent foler should have a folder called tmp for the postgres database.

* You have to create a database! Any sql database probably works but I used posgres(You just need to make the changes in the Gemfile).

* The project is ship with redis/sidekiq but doesn t use it

* We store the csv on aws so you have to provide set `AWS_SECRET_ACCESS_KEY`, `AWS_ACCESS_KEY_ID` and `S3_BUCKET` in your enviroment

* We use dot-env but you can just export. 

* But you can just `bundle install` the project from the main directory.

* To start puma we use `rails s`.

* We use rspec and cucumber. Use `cucumber` and `rspec` to run them

* For a deploy you have to compile the asstes with `bundle exec rails assets:precompile` and `bundle exec rails webpacker:compile`.


# booksubi

