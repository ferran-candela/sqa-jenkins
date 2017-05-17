#!/usr/bin/env bash
#
# Run unit tests of the project

# Exit the script when a command fails
set -e
# Exit the script when a variable is undeclared
set -u

mvn -f ../springAPI/pom.xml test
mvn -f ../uat/pom.xml test