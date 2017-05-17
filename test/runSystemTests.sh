#!/usr/bin/env bash
#
# Run system tests of the project

# Exit the script when a command fails
set -e
# Exit the script when a variable is undeclared
set -u

docker-compose -f ../deployment/docker-compose.yml up -d
java -jar ../uat/target/uat-0.1-spring-boot.jar
docker-compose -f ../deployment/docker-compose.yml down