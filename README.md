# README for docker-fio

Minimal Docker image for running [fio](https://github.com/axboe/fio) tests.

Our thanks to [Jens Axboe](https://github.com/axboe) for writing this excellent utility and making it available for all.

## Use

fio doesn't do anything without a configuration, but it will at least give you the help:

```
$ docker run andrelucas/fio:latest
No job(s) defined

fio-2.19
/fio [options] [job options] <job file(s)>
  --debug=options	Enable debug logging. May be one/more of:
			process,file,io,mem,blktrace,verify,random,parse,
			diskutil,job,mutex,profile,time,net,rate,compress,
			steadystate,helperthread
  --parse-only		Parse options only, don't start any IO

... etc ...

Fio was written by Jens Axboe <jens.axboe@oracle.com>
                   Jens Axboe <jaxboe@fusionio.com>
                   Jens Axboe <axboe@fb.com>
```

There are a ton of example config files in the fio repo under `examples/`.


## Building

The binary is built using Rancher's excellent [dapper](https://github.com/rancher/dapper) tool. I install it using ```go get github.com/rancher/dapper```, which needs a working Go installation and a properly-set `GOPATH`.

```
# Just do it. You'll need to change the value of IMAGE at the top of the Makefile.
$ make

# Build fio binary - needs a working GOPATH.
$ dapper

# Build scratch image.
$ docker build --rm -t my-hub-name/fio:latest .
# docker push my-hub-name/fio:latest

```
