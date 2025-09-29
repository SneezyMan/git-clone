#!/usr/bin/dash
# Test for mygit-commit
# Written by z5611273 on 6/8/2025

# clears any existing .mygit folders
rm -r .mygit 2>/dev/null

# creates sample files
echo Hello > a
echo Bye > b

# check if mygit-commit outputs correct fail message when .mygit does not exist
output=$(./mygit-commit -m message 2>&1)
expected="mygit-commit: error: mygit repository directory .mygit not found"
if [ "$output" != "$expected" ] >/dev/null;
then
  echo 'mygit-commit failed: incorrect output message'
  exit 1
fi

# create .mygit directory
./mygit-init >/dev/null

# check if mygit-commit outputs correct fail message when no files are staged
output=$(./mygit-commit -m message 2>&1)
expected="nothing to commit"
if [ "$output" != "$expected" ] >/dev/null;
then
  echo 'mygit-commit failed: incorrect output message'
  exit 1
fi

# stage files to be commited
./mygit-add a b

# check if mygit-commit outputs correct fail message when give invalid arguments
output=$(./mygit-commit 2>&1)
expected="usage: mygit-commit [-a] -m commit-message"
if [ "$output" != "$expected" ] >/dev/null;
then
  echo "$output"
  echo 'mygit-commit failed: incorrect output message'
  exit 1
fi

# check if mygit-commit outputs correct success message
output=$(./mygit-commit -m message 2>&1)
expected="Committed as commit 0"
if [ "$output" != "$expected" ] >/dev/null;
then
  echo $output
  echo 'mygit-commit failed: incorrect output message'
  exit 1
fi

echo Gutentag > a

output=$(./mygit-commit -a -m message 2>&1)
expected="Committed as commit 1"
if [ "$output" != "$expected" ] >/dev/null;
then
  echo "$output"
  echo 'mygit-commit failed: incorrect output message'
  exit 1
fi

# remove .mygit and files created for testing
rm -r .mygit a b

echo "All tests for mygit-commit successful!"
exit 0