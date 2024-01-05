#!/bin/bash

echo -e "\033 [0;33mDeploying updates to GitHub...\033 [0m"

# Build the project.
echo "###### hugo ####"
hugo

# Go to public folder
cd public

# Add changes to git.
echo "###### git add -A ####"
git add -A

# Commit changes.
msg="rebuilding site `date`"
if [ $# -eq 1 ]
  then msg="$1"
fi
echo "###### git commit ####"
git commit -m "$msg"

# Push source and build repos.
echo "###### git push origin master ####"
git push origin master

# Come back
cd ..

# Add changes to git.
echo "###### git push origin master ####"
git add -A

# Commit changes.
msg="rebuilding site `date`"
if [ $# -eq 1 ]
  then msg="$1"
fi
echo "###### git commit -m ####"
git commit -m "$msg"

# Push source and build repos.
echo "###### git push origin master ####"
git push origin master
