#!/bin/bash

# ===============================================
# Global Git Setup Script
# ===============================================
# 
# Adds account info and some sensible defaults, 
# and also installs the global gitignore from the
# ~/.config/git/ directory.
#
# Usage:
#       config_git.sh NAME EMAIL
# 
# ===============================================
 
if [ -z "$2" ]; then
        echo "usage: config_git.sh NAME EMAIL"
        exit 1
fi

git config --global user.name $1
git config --global user.email $2

git config --global core.autocrlf input
git config --global core.editor subl
git config --global core.eol lf
git config --global core.excludesfile ~/.config/git/.ignore

git config --global branch.autosetuprebase always

git config --global alias.a "add ."
git config --global alias.cam "commit -am"

echo "Initial Git setup complete. Consider adding your github account details."
