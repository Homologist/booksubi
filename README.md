# README

This app  help you to store your csv about books to your S3 account

* This project use ruby 2.5.7 but works for versions >= 2.0

* We use rails 6 but we don t really use new feature directly, it should be possible to use rails 5 with few changes. 

* The project use node v10.14.2 and yarn 1.12.3 like for the frontend part

* The docker-compose should be place in the parent folder and the parent foler should have a tmp/db folder for the postgres database.

* You have to create a database! Any sql database probably works but I used posgres(You just need to make the changes in the Gemfile).

* The project is ship with redis/sidekiq but doesn t use it

* We store the csv on aws so you have to provide set `AWS_SECRET_ACCESS_KEY`, `AWS_ACCESS_KEY_ID` and `S3_BUCKET` in your enviroment

* We use dot-env but you can just export. 

* But you can just `bundle install` the project from the main directory.

* To start puma we use `rails s`.

* We use rspec and cucumber. Use `cucumber` and `rspec` to run them

* For a deploy you have to compile the asstes with `bundle exec rails assets:precompile` and `bundle exec rails webpacker:compile`.


# booksubi

