# README

## Installation

### Prerequisite

You need [Oracle Instant Client Precompiler](https://www.oracle.com/database/technologies/instant-client/precompiler-downloads.html) before build docker image.

### Build

```shell
git clone https://github.com/pers0n4/delivery_proc

docker build -t oracle-proc ./oracle-proc
docker run --rm oracle-proc
```

## Usage

### Test Pro*C make

```shell
docker run -it --rm oracle-proc bash
make -f demo_proc_ic.mk
```

### Build Pro*C project

```shell
docker run -it --rm -v $(pwd)/src:/usr/src/app -w /usr/src/app oracle-proc make
```
