lock "3.4.0"

set :application, "Exchange"
set :repo_url, "git@github.com:bzurkowski/Exchange.git"
set :branch, ENV["BRANCH"] || :master

set :linked_files, fetch(:linked_files, []).push("config/database.yml", "config/secrets.yml", "puma.rb")
set :linked_dirs, fetch(:linked_dirs, []).push("log", "tmp/pids", "tmp/cache", "tmp/sockets")

set :rbenv_type, :user
set :rbenv_ruby, "2.2.1"
