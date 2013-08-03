#!/usr/bin/env zsh

for testFile in `find ./ -type f -name '*_test.sh'`; do
  . $testFile
done
