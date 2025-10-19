#!/bin/bash

set -eu

usage="Usage: gtex <template_type>" 

# Checks
check_os(){
    if [ "$(uname -s)" == "Darwin" ]; then
        printf "Script running on MacOS...\r"
        sleep 1s

    elif [ "$(uname -s)" == "Linux" ]; then
        printf "Script running on Linux...\r"
        sleep 1s

    else
        echo "Unsupported OS"
        exit 1
    fi

}

check_curl (){
  if command -v curl > /dev/null; then
    echo "Launching gtex..."
  else
    echo "curl not found, please install it."
    exit 1
  fi
}

check_args(){
    if [[ $# == 0 ]]; then
        echo "No arguments provided."
        echo "$usage"
        exit 1
    elif [[ $# == 1 ]]; then
        PROJECT_NAME=$1
    elif [[ $# == 2 ]]; then
        PROJECT_NAME=$2
    else
        echo "Too many arguments provided."
        echo "$usage"
        exit 1
    fi

run_checks (){
    check_os
    check_curl
}

#
as (){
    curl -fsSOL "https://raw.githubusercontent.com/nishchalatattve/public-latex-templates/refs/heads/master/"
} 
execute(){

    if [ $1 == "as" ]; then
        simple_article 
    fi

}


main(){
    run_checks
    execute "$@"
}

main "$@"