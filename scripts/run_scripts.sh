#!/bin/bash

for d in $(find /tmp/scripts -mindepth 1 -maxdepth 1 -type d | sort); do
  echo "Running $(basename $d) ..."
  ( cd $d && chown -R $VM_USERNAME * && su $VM_USERNAME setup.sh )
  rm -rf $d
  echo "Finished running $(basename $d)"
done
