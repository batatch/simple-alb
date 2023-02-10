Simple-alb
====

Simple ALB tool.

# Demo

```
$ cd simple-alb/
$ cp -p sample-alb.yml alb.yml

  -> Prepare alb setting using sample.

$ make build

  -> Generate nginx setting as conf.d/default.conf.

$ make up

  -> Start nginx.

$ make test

  -> Call test requests.

```

// EOF
