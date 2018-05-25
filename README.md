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

# NOTES

## DB
- To start postgres run command:
```
brew services start postgresql
```

## GIT
- Revert changes to modified files.
```
git reset --hard
```

- Remove all untracked files and directories. (`-f` is `force`, `-d` is `remove directories`)
```
git clean -fd
```
## TODO
- Input validation in chats_controller.rb