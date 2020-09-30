#!/bin/sh
#

# get number of commits to squash
n=$1

# validate that n is an integer
regex="^[0-9]+$"
if ! [[ $n =~ $regex ]]; then
    echo "error: Squash count must be an integer."
    exit 0
fi

# get the nth commit message
skip=$(( $n - 1 ))
nthMessage=$(git log --skip=$skip --max-count=1 --pretty=%B)

# do the squash
git reset --soft HEAD~$n
git commit -m "$nthMessage"

exit 0
