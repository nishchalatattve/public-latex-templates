#!/bin/bash

set -eu

usage="Usage: gtex <TEMPLATE_TYPE> <PROJECT_NAME>" 

# Checks
check_os(){
    if [ "$(uname -s)" == "Darwin" ]; then
        printf "\r"

    elif [ "$(uname -s)" == "Linux" ]; then
        printf "\r"
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
    if [[ $# != 2 ]]; then
        echo "Invalid arguments."
        echo "$usage"
        exit 1
    fi
}
run_checks (){
    # check_os
    check_args "$@"
    # check_curl
}

#
as (){
    echo "Creating a simple article template ..."

    curl -fsSL "https://raw.githubusercontent.com/nishchalatattve/public-latex-templates/refs/heads/master/Simple%20article.tex" -o "$2.tex"

    echo "Done!"
} 
execute(){

    if [[ $1 == "as" ]]; then
        as "$@"
    else
        echo "$1 is not a valid template type."
        exit 1
    fi

}


main(){
    run_checks "$@"
    execute "$@"
}

main "$@"
