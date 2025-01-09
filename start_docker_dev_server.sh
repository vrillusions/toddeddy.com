#!/bin/bash
readonly script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

cd "${script_dir}"

extra_args=''
if [[ $# -ge 1 ]] && [[ $1 == 'buildDrafts' ]]; then
    echo "Building draft pages"
    extra_args="--buildDrafts"
fi

# basic check for docker command and to use podman if it doesn't exist
cmd=docker
if ! command -v "${cmd}" 1>/dev/null 2>&1; then
    cmd=podman
fi

${cmd} run --rm -it -d -v $(pwd):/project -p 1313:1313 --name hugo ghcr.io/gohugoio/hugo:0.140.2 server $extra_args
