#!/usr/bin/dash
# Test for mygit-rm
# Written by z5611273 on 7/8/2025

# clears any existing .mygit folders
rm -r .mygit 2>/dev/null

# creates sample files
echo Hello > a
echo Bye > b

# check if mygit-rm outputs correct fail message when .mygit does not exist
output=$(./mygit-rm 2>&1)
expected="mygit-rm: error: mygit repository directory .mygit not found"
if [ "$output" != "$expected" ] >/dev/null;
then
  echo 'mygit-rm failed: incorrect output message'
  exit 1
fi

# create .mygit directory
./mygit-init >/dev/null

# check if mygit-rm outputs correct fail message when given invlaid arguments
output=$(./mygit-rm 2>&1)
expected="usage: usage: mygit-rm [--force] [--cached] <filenames>"
if [ "$output" != "$expected" ] >/dev/null;
then
  echo 'mygit-rm failed: incorrect output message'
  exit 1
fi

output=$(./mygit-rm - 2>&1)
expected="mygit-rm: error: invalid filename '-'"
if [ "$output" != "$expected" ] >/dev/null;
then
  echo 'mygit-rm failed: incorrect output message'
  exit 1
fi

# make a commit with a
./mygit-add a
./mygit-commit -m message >/dev/null

# check if mygit-rm correctly outputs nothing when successful
output=$(./mygit-rm a 2>&1)
expected=""
if [ "$output" != "$expected" ] >/dev/null;
then
  echo 'mygit-rm failed: incorrect output message'
  exit 1
fi

# put b in repository
./mygit-add b
./mygit-commit -m message >/dev/null
echo gutentag > b

# check if mygit-rm outputs correct fail message
output=$(./mygit-rm b 2>&1)
expected="mygit-rm: error: 'b' in the repository is different to the working file"
if [ "$output" != "$expected" ] >/dev/null;
then
  echo 'mygit-rm failed: incorrect output message'
  exit 1
fi

./mygit-add b
echo priviet > b

# check if mygit-rm outputs correct fail message
output=$(./mygit-rm b 2>&1)
expected="mygit-rm: error: 'b' in index is different to both the working file and the repository"
if [ "$output" != "$expected" ] >/dev/null;
then
  echo 'mygit-rm failed: incorrect output message'
  exit 1
fi

# check if mygit-rm outputs correct fail message
output=$(./mygit-rm --force b 2>&1)
expected=""
if [ "$output" != "$expected" ] >/dev/null;
then
  echo 'mygit-rm failed: incorrect output message'
  exit 1
fi

# remove .mygit and files created for testing
rm -r .mygit

echo "All tests for mygit-rm successful!"
exit 0