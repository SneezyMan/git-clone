#!/usr/bin/dash
# Test for mygit-add
# Written by z5611273 on 6/8/2025

# clears any existing .mygit folders
rm -r .mygit 2>/dev/null

# creates sample files
echo Hello > a
echo Bye > b

# check if mygit-add outputs correct fail messages when .mygit does not exist
output=$(./mygit-add a b 2>&1)
expected="mygit-add: error: mygit repository directory .mygit not found"
if [ "$output" != "$expected" ] >/dev/null;
then
  echo 'mygit-add failed: incorrect output message'
  exit 1
fi

# create .mygit directory
./mygit-init >/dev/null

# check if mygit-add outputs correct fail messages when given invalid arguments
output=$(./mygit-add ! 2>&1)
expected="mygit-add: error: invalid filename '!'"
if [ "$output" != "$expected" ] >/dev/null;
then
  echo 'mygit-add failed: incorrect output message'
  exit 1
fi

output=$(./mygit-add a b c 2>&1)
expected="mygit-add: error: can not open 'c'"
if [ "$output" != "$expected" ] >/dev/null;
then
  echo 'mygit-add failed: incorrect output message'
  exit 1
fi

# check if mygit-add correctly outputs nothing if it was successful
output=$(./mygit-add a b)
expected=""
if [ "$output" != "$expected" ] >/dev/null;
then
  echo 'mygit-add failed: incorrect output message'
  exit 1
fi

# remove .mygit and files created for testing
rm -r .mygit a b

echo "All tests for mygit-add successful!"
exit 0