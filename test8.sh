#!/usr/bin/dash
# Test for mygit-checkout
# Written by z5611273 on 10/8/2025

# clears any existing .mygit folders
rm -r .mygit 2>/dev/null

# create files
echo hello > a
echo hello > b

# check if mygit-checkout outputs correct fail message when .mygit does not exist
output=$(./mygit-checkout 2>&1)
expected="mygit-checkout: error: mygit repository directory .mygit not found"
if [ "$output" != "$expected" ] >/dev/null;
then
  echo 'mygit-checkout failed: incorrect output message'
  exit 1
fi

# create .mygit directory
./mygit-init >/dev/null

# check if mygit-checkout outputs correct fail message when no commits have been made
output=$(./mygit-checkout 2>&1)
expected="mygit-checkout: error: this command can not be run until after the first commit"
if [ "$output" != "$expected" ] >/dev/null;
then
  echo 'mygit-checkout failed: incorrect output message'
  exit 1
fi

# make commit and branch
./mygit-add a b
./mygit-commit -m message >/dev/null
./mygit-branch new

# check if mygit-checkout outputs correct fail message when given invalid arguments
output=$(./mygit-checkout 2>&1)
expected="usage: mygit-checkout <branch>"
if [ "$output" != "$expected" ] >/dev/null;
then
  echo 'mygit-checkout failed: incorrect output message'
  exit 1
fi

output=$(./mygit-checkout old 2>&1)
expected="mygit-checkout: error: unknown branch 'old'"
if [ "$output" != "$expected" ] >/dev/null;
then
  echo 'mygit-checkout failed: incorrect output message'
  exit 1
fi

# check if mygit-checkout outputs correct fail message when already on branch
output=$(./mygit-checkout trunk 2>&1)
expected="Already on 'trunk'"
if [ "$output" != "$expected" ] >/dev/null;
then
  echo 'mygit-checkout failed: incorrect output message'
  exit 1
fi

# check if mygit-checkout outputs correct fail message when successful switch
output=$(./mygit-checkout new 2>&1)
expected="Switched to branch 'new'"
if [ "$output" != "$expected" ] >/dev/null;
then
  echo 'mygit-checkout failed: incorrect output message'
  exit 1
fi

# remove .mygit and files created for testing
rm -r .mygit a b

echo "All tests for mygit-checkout successful!"
exit 0