#!/bin/bash
readonly script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

cd "${script_dir}"

extra_args=''
if [[ $# -ge 1 ]] && [[ $1 == 'buildDrafts' ]]; then
    echo "Building draft pages"
    extra_args="--buildDrafts"
fi
docker run --rm -it -d -v $(pwd):/src -p 1313:1313 --name hugo klakegg/hugo:latest server $extra_args
