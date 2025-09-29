#!/usr/bin/dash
# Test for mygit-merge
# Written by z5611273 on 11/8/2025

# clears any existing .mygit folders
rm -r .mygit 2>/dev/null

# create files
echo hello > a
echo hello > b

# check if mygit-merge outputs correct fail message when .mygit does not exist
output=$(./mygit-merge 2>&1)
expected="mygit-merge: error: mygit repository directory .mygit not found"
if [ "$output" != "$expected" ] >/dev/null;
then
  echo 'mygit-merge failed: incorrect output message'
  exit 1
fi

# create .mygit directory
./mygit-init >/dev/null

# check if mygit-merge outputs correct fail message when no commits have been made
output=$(./mygit-merge 2>&1)
expected="mygit-merge: error: this command can not be run until after the first commit"
if [ "$output" != "$expected" ] >/dev/null;
then
  echo 'mygit-merge failed: incorrect output message'
  exit 1
fi

# make commit and branch
./mygit-add a b
./mygit-commit -m message >/dev/null
./mygit-branch new

# check if mygit-merge outputs correct fail message when given invalid arguments
output=$(./mygit-merge 2>&1)
expected="usage: mygit-merge <branch|commit> -m message"
if [ "$output" != "$expected" ] >/dev/null;
then
  echo "$output"
  echo 'mygit-merge failed: incorrect output message'
  exit 1
fi

output=$(./mygit-merge new 2>&1)
expected="mygit-merge: error: empty commit message"
if [ "$output" != "$expected" ] >/dev/null;
then
  echo 'mygit-merge failed: incorrect output message'
  exit 1
fi

./mygit-checkout new >/dev/null
echo gutentag > c
./mygit-add c
./mygit-commit -m message >/dev/null

# check if mygit-merge outputs correct error message when fail
output=$(./mygit-merge new -m message 2>&1)
expected="Already up to date"
if [ "$output" != "$expected" ] >/dev/null;
then
  echo 'mygit-merge failed: incorrect output message'
  exit 1
fi

./mygit-checkout trunk >/dev/null

# check if mygit-merge outputs correct message when successful
output=$(./mygit-merge new -m message 2>&1)
expected="Fast-forward: no commit created"
if [ "$output" != "$expected" ] >/dev/null;
then
  echo 'mygit-merge failed: incorrect output message'
  exit 1
fi


# check if repository history is updated
output=$(./mygit-log 2>&1)
expected="1 message
0 message"
if [ "$output" != "$expected" ] >/dev/null;
then
  echo 'mygit-merge failed: incorrect output message'
  exit 1
fi

# remove .mygit and files created for testing
rm -r .mygit a b c

echo "All tests for mygit-merge successful!"
exit 0