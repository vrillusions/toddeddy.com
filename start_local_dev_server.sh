#!/bin/bash
readonly script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

cd "${script_dir}"

extra_args=''
if [[ $# -ge 1 ]] && [[ $1 == 'buildDrafts' ]]; then
    echo "Building draft pages"
    extra_args="--buildDrafts"
fi

# Add extra debugging if stuff is broken
extra_args="${extra_args} --log --verbose --debug"

# Other options I've used but not sure if needed when in dev mode
#--cleanDestinationDir --gc

#hugo server --cleanDestinationDir --gc --ignoreCache --noHTTPCache \
#    --log --verbose --debug $extra_args
hugo server $extra_args
