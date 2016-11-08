#!/bin/bash

echo "Releasing! Now!"

git add .
git status
git commit -m '$1'
git push origin gh-pages
