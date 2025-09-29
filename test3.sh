#!/usr/bin/dash
# Test for mygit-log
# Written by z5611273 on 7/8/2025

# clears any existing .mygit folders
rm -r .mygit 2>/dev/null

# creates sample files
echo Hello > a
echo Bye > b

# check if mygit-log outputs correct fail message when .mygit does not exist
output=$(./mygit-log 2>&1)
expected="mygit-log: error: mygit repository directory .mygit not found"
if [ "$output" != "$expected" ] >/dev/null;
then
  echo 'mygit-log failed: incorrect output message'
  exit 1
fi

# create .mygit directory
./mygit-init >/dev/null

# check if mygit-log outputs correct fail message when given invalid arguments
output=$(./mygit-log a 2>&1)
expected="usage: mygit-log"
if [ "$output" != "$expected" ] >/dev/null;
then
  echo 'mygit-log failed: incorrect output message'
  exit 1
fi

# make 2 commits
./mygit-add a
./mygit-commit -m message1 >/dev/null
./mygit-add b
./mygit-commit -m message2 >/dev/null

# check if mygit-log outputs correct success message
output=$(./mygit-log 2>&1)
expected="1 message2
0 message1"
if [ "$output" != "$expected" ] >/dev/null;
then
  echo "$output"
  echo 'mygit-log failed: incorrect output message'
  exit 1
fi

# remove .mygit and files created for testing
rm -r .mygit a b

echo "All tests for mygit-log successful!"
exit 0