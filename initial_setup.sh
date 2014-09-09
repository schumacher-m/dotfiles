#!/bin/bash

\curl -sSL https://get.rvm.io | bash -s stable --ruby
ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
curl https://raw.githubusercontent.com/creationix/nvm/v0.15.0/install.sh | bash
cat brewlist | xargs brew install
