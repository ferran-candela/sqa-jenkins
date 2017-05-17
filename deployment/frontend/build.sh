#!/usr/bin/env bash
#
# Build com.upc.sqa/simple-frontend image

# Exit the script when a command fails
set -e
# Exit the script when a variable is undeclared
set -u

readonly CURRENT_DIRECTORY="$(cd "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

readonly DOCKER_IMAGE_NAME="com.upc.sqa/simple-frontend"
readonly DOCKER_IMAGE_TAG="v0.1"

readonly FRONTEND_DIRECTORY="$(cd "$CURRENT_DIRECTORY" && cd ../../simpleFrontend/ && pwd)"

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
    local sourceDir="${FRONTEND_DIRECTORY}"
    local destinationDir="${CURRENT_DIRECTORY}/docker"

    cp -r "${sourceDir}" "${destinationDir}"
}

rm_tmp_folder() {
    rm -rf "${CURRENT_DIRECTORY}/docker/simpleFrontend"
}

main() {
    copy_source_to_docker_context_folder
    build_image
    rm_tmp_folder
}

if [[ "$0" == "${BASH_SOURCE[0]}" ]]; then
    main "$@"
fi