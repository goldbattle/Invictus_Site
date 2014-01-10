#!/bin/bash
#### Install in /web_apps/invictus_deploy.sh
#### $ sudo chmod u+x invictus_deploy.sh
#### $ bash -x ./invictus_deploy.sh

###############################################
# Constants
###############################################
DIR_REPO='Invictus_Site_v2/'
URL_REPO='https://github.com/goldbattle/Invictus_Site_v2.git'

###############################################
# Pull from github
###############################################
if cd $DIR_REPO; then
  # If you can cd into the repo, then it is init
  echo "Repo made, FETCH repo"
  git fetch --all
  git reset --hard origin/master
  # cd back up
  cd ../
else
  # If not then clone and create folder
  echo "Repo not made, CLONE repo"
  git clone $URL_REPO $DIR_REPO
  # Done
fi
# Permissions
sudo chown -R $(whoami):$(whoami) $DIR_REPO
# Public folder permission
cd $DIR_REPO
sudo chmod -R 755 public/
cd ../

###############################################
# Run bundle command
###############################################
cd $DIR_REPO
# Run production command
bundle install --without test development
# cd back out
cd ../

###############################################
# Run rake command
###############################################
cd $DIR_REPO
# Rake the database if needed
RAILS_ENV=production rake db:migrate
# cd back out
cd ../

###############################################
# Compile assets
###############################################
cd $DIR_REPO
# Compile all needed assets
RAILS_ENV=production bundle exec rake assets:precompile
# cd back out
cd ../

###############################################
# Restart nginx
###############################################
sudo /etc/init.d/nginx restart