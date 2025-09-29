#!/usr/bin/dash
# Test for mygit-init
# Written by z5611273 on 5/8/2025

# clears any existing .mygit folders
rm -r .mygit 2>/dev/null

# check if mygit-init outputs correct success messages when no .mygit exists
output=$(./mygit-init)
expected="Initialized empty mygit repository in .mygit"
if [ "$output" != "$expected" ] >/dev/null;
then
  echo 'mygit-init failed: incorrect output message'
  exit 1
fi

# check if mygit-init outputs correct fail messages when .mygit already exists
output=$(./mygit-init 2>&1)
expected="mygit-init: error: .mygit already exists"
if [ "$output" != "$expected" ] >/dev/null;
then
  echo 'mygit-init failed: incorrect output message'
  exit 1
fi

# remove .mygit created for testing
rm -r .mygit

echo "All tests for mygit-init successful!"
exit 0
