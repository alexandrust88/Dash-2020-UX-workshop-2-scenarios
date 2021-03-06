#!/bin/bash

echo "Setup..."

# TODO this script should move to setup. It's handy to have it in foreground while debugging

git init --bare remote # Prepare a fake remote to push to

git clone https://github.com/etnbrd/ecommerce-workshop.git ~/ecommerce-observability
cd ~/ecommerce-observability
yarn
docker-compose pull agent frontend advertisements db # pull images now to avoid wasting time later
docker pull etnbrddd/ecommerce-frontend:canary # pull images now to avoid wasting time later
docker build -t discounts-service discounts-service # build image now to avoid wasting time later
docker build -t discounts-service:canary discounts-service # build image now to avoid wasting time later
git remote add deploy ~/remote # Add the fake remote
cp scripts/pre-push .git/hooks/ # Setup the fake CI/CD

git config --global user.email "relevant-titmouse@dash2020.datadoghq.com"
git config --global user.name "relevant titmouse"

echo "Done"