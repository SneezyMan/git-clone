#!/usr/bin/dash
# Test for mygit-branch
# Written by z5611273 on 9/8/2025

# clears any existing .mygit folders
rm -r .mygit 2>/dev/null

# create files
echo hello > a
echo hello > b

# check if mygit-branch outputs correct fail message when .mygit does not exist
output=$(./mygit-branch 2>&1)
expected="mygit-branch: error: mygit repository directory .mygit not found"
if [ "$output" != "$expected" ] >/dev/null;
then
  echo 'mygit-branch failed: incorrect output message'
  exit 1
fi

# create .mygit directory
./mygit-init >/dev/null

# check if mygit-branch outputs correct fail message when no commits have been made
output=$(./mygit-branch 2>&1)
expected="mygit-branch: error: this command can not be run until after the first commit"
if [ "$output" != "$expected" ] >/dev/null;
then
  echo 'mygit-branch failed: incorrect output message'
  exit 1
fi

# make commit
./mygit-add a b
./mygit-commit -m message >/dev/null

# check if mygit-branch outputs correct fail message when given invalid arguments
output=$(./mygit-branch ! 2>&1)
expected="mygit-branch: error: invalid branch name '!'"
if [ "$output" != "$expected" ] >/dev/null;
then
  echo "$output"
  echo 'mygit-branch failed: incorrect output message'
  exit 1
fi

output=$(./mygit-branch -d 2>&1)
expected="mygit-branch: error: branch name required"
if [ "$output" != "$expected" ] >/dev/null;
then
  echo 'mygit-branch failed: incorrect output message'
  exit 1
fi

output=$(./mygit-branch trunk 2>&1)
expected="mygit-branch: error: branch 'trunk' already exists"
if [ "$output" != "$expected" ] >/dev/null;
then
  echo 'mygit-branch failed: incorrect output message'
  exit 1
fi

output=$(./mygit-branch -d trunk 2>&1)
expected="mygit-branch: error: can not delete branch 'trunk': default branch"
if [ "$output" != "$expected" ] >/dev/null;
then
  echo 'mygit-branch failed: incorrect output message'
  exit 1
fi

# check if mygit-branch behaves correctly when given valid new branch name
output=$(./mygit-branch new 2>&1)
expected=""
if [ "$output" != "$expected" ] >/dev/null;
then
  echo 'mygit-branch failed: incorrect output message'
  exit 1
fi

# remove .mygit and files created for testing
rm -r .mygit a b

echo "All tests for mygit-branch successful!"
exit 0