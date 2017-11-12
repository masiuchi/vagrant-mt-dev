#!/bin/sh

set -u

rm -f package.box
vagrant destroy -f

set -e

export MT_DEV="build"
vagrant up

export MT_DEV="package"
vagrant reload
vagrant halt
vagrant package

