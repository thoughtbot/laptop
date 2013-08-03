#!/usr/bin/env zsh

testSupportedDistrosInDistroCheck() {
  for RELEASE_FILE in files/os-release*; do
    RELEASE_FILE=$RELEASE_FILE zsh ../linux-components/distro-check
    assertEquals 0 $?
  done
}

testRejectedDistrosInDistroCheck(){
  RELEASE_FILE=files/bad-os-release zsh ../linux-components/distro-check
  assertEquals 1 $?
}

SHUNIT_PARENT=$0
setopt shwordsplit
. /usr/share/shunit2/shunit2
