#! /bin/sh

BASE=$(dirname $0)

mkdir -p $BASE/results $BASE/srpm

mock --resultdir=./srpm --configdir=./mock -r metal \
  --buildsrpm --spec foreman-metal.spec --sources ${BASE}

mock --resultdir=./results --configdir=./mock -r metal \
  --rebuild srpm/*.src.rpm $*
