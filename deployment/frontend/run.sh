#!/usr/bin/env bash
#
# Run com.upc.sqa/simple-frontend container

# Exit the script when a command fails
set -e
# Exit the script when a variable is undeclared
set -u


readonly CURRENT_DIRECTORY="$(cd "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
readonly CONF_DIRECTORY="$(cd "$CURRENT_DIRECTORY" && cd ./docker/ && pwd)"

run() {
    local imageName="com.upc.sqa/simple-frontend"
    local name="$1"
    local port="$2"
    local tag="$3"
    local apiContainerName="$4"

    if [[ -n "${tag}" ]]; then
        imageName="${imageName}:${tag}"
    fi

    docker run --name "${name}" \
                -p "${port}:8080" \
                --link "${apiContainerName}" \
                "${imageName}"
}

# usage: main [-s frontend source directory]
main() {
    local name="simple-frontend"
    local port="8090"
    local tag="v0.1"
    local apiContainerName="spring-api"

    while getopts ':n:p:t:c:' OPT; do
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
            c)
                apiContainerName="${OPTARG}"
                ;;
            ?)
                echo "invalid argument: ${OPTARG}"
                exit 1
                ;;
        esac
    done

    run "${name}" "${port}" "${tag}" "${apiContainerName}"
}

if [[ "$0" == "${BASH_SOURCE[0]}" ]]; then
    main "$@"
fi