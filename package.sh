#!/bin/sh
set -eu

rm -f package.box
vagrant destroy -f

MT_DEV=build vagrant up
MT_DEV=package vagrant reload
vagrant halt

MT_DEV=package vagrant package

