# mygit
A lightweight educational clone of `git`, implemented in Python.  
Supports local version control of files, with core features of `git` such as `git commit`, `git branch`, and `git merge`.

---

## Features / Usage
- mygit-init
  - The `mygit-init` command creates an empty mygit repository.
  - Usage: `mygit-init`
- mygit-add
  - The `mygit-add` command adds the content of one or more files to the `index`.
  - Usage: `mygit-add filenames`
- mygit-commit
  - The `mygit-commit` command saves a copy of all files in the index to the repository.
  - Usage: `mygit-commit [-a] -m message`
- mygit-log
  - The `mygit-log` command prints a line for every commit made to the repository.
  - Usage: `mygit-log`
- mygit-show
  - The `mygit-show` command prints the contents of the specified filename as of the specified commit.
  - Usage: `mygit-show [commit]:filename`
- mygit-rm
  - The `mygit-rm` command removes a file from the index, or, from the current directory and the index.
  - Usage: `mygit-rm [--force] [--cached] filenames`
- mygit-status
  - The `mygit-status` command shows the status of files in the current directory, the index, and the repository.
  - Usage: `mygit-status`
- mygit-branch
  - The `mygit-branch` command either creates a branch, deletes a branch, or lists current branch names.
  - Usage: `mygit-branch [-d] [branch-name]`
- mygit-checkout
  - The `mygit-checkout` command switches branches.
  - Usage: `mygit-checkout branch-name`
- mygit-merge
  - The `mygit-merge` command adds the changes that have been made to the specified branch or commit to the index, and commits them.
  - Usage: `mygit-merge (branch-name|commit-number) -m message`

---

## Requirements
- Python 3.11+ (tested and developed on Python 3.11)
- Linux/WSL environment

---

## Installation
Clone this repo into your project directory:

```bash
git clone https://github.com/your-username/mygit.git
cd mygit