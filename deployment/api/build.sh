#!/usr/bin/env bash
#
# Build com.upc.sqa/spring-api image

# Exit the script when a command fails
set -e
# Exit the script when a variable is undeclared
set -u

readonly CURRENT_DIRECTORY="$(cd "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

readonly DOCKER_IMAGE_NAME="com.upc.sqa/spring-api"
readonly DOCKER_IMAGE_TAG="v0.1"

readonly API_BUILD_DIRECTORY="$(cd "$CURRENT_DIRECTORY" && cd ../../springAPI/target/ && pwd)"

# usage: build_image [tag]
build_image() {
    # Generate image name
    local name="${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG}"

    echo "Building image ${name}"

    # Run docker with the provided arguments
    docker build -t "${name}" \
                  "${CURRENT_DIRECTORY}/docker"
}

copy_source_to_docker_context_folder() {
    local sourceFile="${API_BUILD_DIRECTORY}/springAPI-0.1.jar"
    local destinationDir="${CURRENT_DIRECTORY}/docker"

    cp "${sourceFile}" "${destinationDir}"
}

rm_tmp_file() {
    rm -rf "${CURRENT_DIRECTORY}/docker/springAPI-0.1.jar"
}

main() {
    copy_source_to_docker_context_folder
    build_image
    rm_tmp_file
}

if [[ "$0" == "${BASH_SOURCE[0]}" ]]; then
    main "$@"
fi