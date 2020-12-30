# Tracking APP

### Tech

Dillinger uses a number of open source projects to work properly:

* [Ruby On Rail 6] - BackEnd Server
* [Rail Engine] - First step will be ready to move microservice
* [Postgres] - Database

### Installation

## Ruby On Rails

```sh
$ bundle install
$ bundle exec rake db:setup
$ bundle exec rake db:seed
$ rails s
```
## Run UNIT test for domain (Identity/Clock Operation)
```sh
$ cd engines/identity/
$ bundle exec rspec
$ cd engines/clock_operation
$ bundle exec rspec
```

## API Document
https://www.getpostman.com/collections/088f7f441d90b20a3cf4

### Need improvement

* Change authentication method use shortlive & refresh token instead of longlive token
* Isolating Rails Engines with access data modeling for prevent circular dependency
* Manage dependency between of engines
* Communicate interface between of engines (Evenbus/Grpc protocol)
* Unit testing
