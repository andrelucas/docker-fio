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

In the repo `config/` directory there are a few example config files configured for this image. You can run with:

```
$ docker run -e SIZE=1g -e RUNTIME=60s \
    -v $(pwd)/config:/config --volume-driver=storageos -v v1:/v \
    andrelucas/fio:latest vol_test.fio
```

That seems like a lot of command, but it's doing a lot: You're specifying runtime parameters (`SIZE`, `RUNTIME`) which are used by `vol_test.fio`, mounting the config file into the standard `/config` directory (otherwise fio wouldn't be able to read it), mounting the volume you're testing on the standard `/v` directory, and running the test.

If you stick to the standard config source directory (`/config`, set in the environment as `$CFG`), and the standard mount directiory (`/v`, set in the environment as `$VOL`), you'll have a slightly easier time.

Note that fio can use any environment variable in its config. In `vol_test_fio`, for example, `SIZE`, `RUNTIME`, and `VOL` are used. This means the configuration files don't need to be templatised for simple changes.

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
