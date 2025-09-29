#!/usr/bin/dash
# Test for mygit-status
# Written by z5611273 on 8/8/2025

# clears any existing .mygit folders
rm -r .mygit 2>/dev/null

# creates sample files
touch a b c d e f g h i j k l

# check if mygit-status outputs correct fail message when .mygit does not exist
output=$(./mygit-status 2>&1)
expected="mygit-status: error: mygit repository directory .mygit not found"
if [ "$output" != "$expected" ] >/dev/null;
then
  echo 'mygit-status failed: incorrect output message'
  exit 1
fi

# create .mygit directory
./mygit-init >/dev/null

# check if mygit-status outputs correct fail message when given invlaid arguments
output=$(./mygit-status a b c 2>&1)
expected="usage: mygit-status"
if [ "$output" != "$expected" ] >/dev/null;
then
  echo 'mygit-status failed: incorrect output message'
  exit 1
fi

./mygit-add a b c d i j k l
./mygit-commit -m message >/dev/null
./mygit-rm --cached b
./mygit-rm c
./mygit-add f g
rm d g
echo hello > h
echo hello > i
echo hello > j
echo hello > k
echo hello > l
./mygit-add h j k l
rm j
echo world > l
echo world > h


# check if mygit-status gives correct outputs
output=$(./mygit-status 2>&1)
expected="a - same as repo
b - deleted from index
c - file deleted, deleted from index
d - file deleted
e - untracked
f - added to index
g - added to index, file deleted
h - added to index, file changed
i - file changed, changes not staged for commit
j - file deleted, changes staged for commit
k - file changed, changes staged for commit
l - file changed, different changes staged for commit"
if [ "$output" != "$expected" ] >/dev/null;
then
  echo 'mygit-status failed: incorrect output message'
  exit 1
fi

# remove .mygit and files created for testing
rm -r .mygit a b c d e f g h i j k l

echo "All tests for mygit-rm successful!"
exit 0
