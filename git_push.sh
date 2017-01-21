#!/bin/sh

setup_git() {
  git config --global user.email "travis@travis-ci.org"
  git config --global user.name "Travis CI"
  git clone https://github.com/ScalecubePerf/ScalecubePerf.github.io.git
}

commit_website_files() {
  cp -rf ./target/gatling/ ./ScalecubePerf.github.io
  cd ScalecubePerf.github.io
  git add . 
  git commit --message "Travis build: $TRAVIS_BUILD_NUMBER"
}

upload_files() {
  # Get the deploy key by using Travis's stored variables to decrypt deploy_key.enc
  ENCRYPTED_KEY_VAR="encrypted_${ENCRYPTION_LABEL}_key"
  ENCRYPTED_IV_VAR="encrypted_${ENCRYPTION_LABEL}_iv"
  ENCRYPTED_KEY=${!ENCRYPTED_KEY_VAR}
  ENCRYPTED_IV=${!ENCRYPTED_IV_VAR}
  openssl aes-256-cbc -K $ENCRYPTED_KEY -iv $ENCRYPTED_IV -in deploy_key.enc -out deploy_key -d

  chmod 600 deploy_key
  eval `ssh-agent -s`
  ssh-add deploy_key

  # Now that we're all set up, we can push.
  git push $SSH_REPO $TARGET_BRANCH
 
}

setup_git
commit_website_files
upload_files
