#!/bin/bash

echo "Releasing! Now!"

git add .
git status
git commit -m 'Update Practice'
git push origin gh-pages
