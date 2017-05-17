#!/usr/bin/env bash
#
# Run com.upc.sqa/simple-frontend container

# Exit the script when a command fails
set -e
# Exit the script when a variable is undeclared
set -u


run() {
    local image_name="com.upc.sqa/spring-api"
    local name="$1"
    local port="$2"
    local tag="$3"

    if [[ -n "${tag}" ]]; then
        image_name="${image_name}:${tag}"
    fi

    docker run --name "${name}" -d \
                -p "${port}:8091" \
                "${image_name}"
}

# usage: main [-s frontend source directory]
main() {
    local name="spring-api"
    local port="8091"
    local tag="v0.1"

    while getopts ':n:p:t:' OPT; do
        case "${OPT}" in
            n)
                name="${OPTARG}"
                ;;
            p)
                port="${OPTARG}"
                ;;
            t)
                tag="${OPTARG}"
                ;;
            ?)
                echo "invalid argument: ${OPTARG}"
                exit 1
                ;;
        esac
    done

    run "${name}" "${port}" "${tag}"
}

if [[ "$0" == "${BASH_SOURCE[0]}" ]]; then
    main "$@"
fi