#!/usr/bin/dash
# Test for mygit-show
# Written by z5611273 on 7/8/2025

# clears any existing .mygit folders
rm -r .mygit 2>/dev/null

# creates sample files
echo Hello > a
echo Bye > b

# check if mygit-show outputs correct fail message when .mygit does not exist
output=$(./mygit-show :a 2>&1)
expected="mygit-show: error: mygit repository directory .mygit not found"
if [ "$output" != "$expected" ] >/dev/null;
then
  echo 'mygit-show failed: incorrect output message'
  exit 1
fi

# create .mygit directory
./mygit-init >/dev/null

# check if mygit-show outputs correct fail message when given no arguments
output=$(./mygit-show 2>&1)
expected="usage: mygit-show <commit>:<filename>"
if [ "$output" != "$expected" ] >/dev/null;
then
  echo 'mygit-show failed: incorrect output message'
  exit 1
fi

# check if mygit-show outputs correct fail message when invalid filename
output=$(./mygit-show :- 2>&1)
expected="mygit-show: error: invalid filename '-'"
if [ "$output" != "$expected" ] >/dev/null;
then
  echo 'mygit-show failed: incorrect output message'
  exit 1
fi

# check if mygit-show outputs correct fail message when file does not exist
output=$(./mygit-show :c 2>&1)
expected="mygit-show: error: 'c' not found in index"
if [ "$output" != "$expected" ] >/dev/null;
then
  echo 'mygit-show failed: incorrect output message'
  exit 1
fi

# check if mygit-show outputs correct fail message when commit does not exist
output=$(./mygit-show 0:a 2>&1)
expected="mygit-show: error: unknown commit '0'"
if [ "$output" != "$expected" ] >/dev/null;
then
  echo 'mygit-show failed: incorrect output message'
  exit 1
fi

# add and commit a and b
./mygit-add a b
./mygit-commit -m message1 >/dev/null

# check if mygit-show outputs correct fail message when file does not exist in commit
output=$(./mygit-show 0:c 2>&1)
expected="mygit-show: error: 'c' not found in commit 0"
if [ "$output" != "$expected" ] >/dev/null;
then
  echo 'mygit-show failed: incorrect output message'
  exit 1
fi

# check if mygit-show outputs correct success message
output=$(./mygit-show 0:a 2>&1)
expected="Hello"
if [ "$output" != "$expected" ] >/dev/null;
then
  echo 'mygit-show failed: incorrect output message'
  exit 1
fi

# remove .mygit and files created for testing
rm -r .mygit a b

echo "All tests for mygit-show successful!"
exit 0