#!/bin/sh

setup_git() {
  git config --global user.email "travis@travis-ci.org"
  git config --global user.name "Travis CI"

  git clone git@github.com:ScalecubePerf/ScalecubePerf.github.io.git
  cp -rf ./target/gatling/ ./ScalecubePerf.github.io
  cd ScalecubePerf.github.io
}

commit_website_files() {
  
  git add . 
  git commit --message "Travis build: $TRAVIS_BUILD_NUMBER"
}

upload_files() {
  

  # Now that we're all set up, we can push.
  git push
 
}

setup_git
commit_website_files
upload_files
