# !/bin/bash

set -eu

usage="Usage: gtex <template_type> [PROJECT_NAME]" 

basic_test(){
    echo "Creating a basic test template ..."
    # Main files
    curl -fsSL -o  "${PROJECT_NAME}.tex" https://raw.githubusercontent.com/nishchalatattve/public-latex-templates/refs/heads/master/basic_test/test.tex
    echo "Done!"
}

plotter(){
    echo "Creating a plotter template ..."
    # Main files
    curl -fsSL -o  "${PROJECT_NAME}.tex" https://raw.githubusercontent.com/nishchalatattve/public-latex-templates/refs/heads/master/plotter/plotter.tex

    # Settings
    mkdir -p settings
    cd settings
    curl -fsSOL https://raw.githubusercontent.com/nishchalatattve/public-latex-templates/refs/heads/master/plotter/settings/colours.tex
    curl -fsSOL https://raw.githubusercontent.com/nishchalatattve/public-latex-templates/refs/heads/master/plotter/settings/fonts.tex
    curl -fsSOL https://raw.githubusercontent.com/nishchalatattve/public-latex-templates/refs/heads/master/plotter/settings/metadata.tex
    curl -fsSOL https://raw.githubusercontent.com/nishchalatattve/public-latex-templates/refs/heads/master/plotter/settings/settings.tex

    echo "Done!"

}

data_vis(){
    echo "Creating a data visualisation template ..."
    # Main files
    curl -fsSL -o  "${PROJECT_NAME}.tex" https://raw.githubusercontent.com/nishchalatattve/public-latex-templates/refs/heads/master/data-vis/plotter.tex

    # Settings
    mkdir -p settings
    cd settings
    curl -fsSOL https://raw.githubusercontent.com/nishchalatattve/public-latex-templates/refs/heads/master/data-vis/settings/colours.tex
    curl -fsSOL https://raw.githubusercontent.com/nishchalatattve/public-latex-templates/refs/heads/master/data-vis/settings/fonts.tex
    curl -fsSOL https://raw.githubusercontent.com/nishchalatattve/public-latex-templates/refs/heads/master/data-vis/settings/metadata.tex
    curl -fsSOL https://raw.githubusercontent.com/nishchalatattve/public-latex-templates/refs/heads/master/data-vis/settings/settings.tex

    echo "Done!"
}

simple_article(){
    echo "Creating a basic article template ..."
    # Main files
    curl -fsSL -o  "${PROJECT_NAME}.tex" https://raw.githubusercontent.com/nishchalatattve/public-latex-templates/refs/heads/master/article/article.tex

    # Settings
    mkdir -p settings
    cd settings
    curl -fsSOL https://raw.githubusercontent.com/nishchalatattve/public-latex-templates/refs/heads/master/article/settings/colours.tex
    curl -fsSOL https://raw.githubusercontent.com/nishchalatattve/public-latex-templates/refs/heads/master/article/settings/fonts.tex
    curl -fsSOL https://raw.githubusercontent.com/nishchalatattve/public-latex-templates/refs/heads/master/article/settings/metadata.tex
    curl -fsSOL https://raw.githubusercontent.com/nishchalatattve/public-latex-templates/refs/heads/master/article/settings/settings.tex
    curl -fsSOL https://raw.githubusercontent.com/nishchalatattve/public-latex-templates/refs/heads/master/article/settings/url.tex

    echo "Done!"
}
article_with_refs(){
    echo "Creating an article template with references ..."
    # Main files
    curl -fsSL -o  "${PROJECT_NAME}.tex" https://raw.githubusercontent.com/nishchalatattve/public-latex-templates/refs/heads/master/article_with_refs/article.tex
    curl -fsSOL https://raw.githubusercontent.com/nishchalatattve/public-latex-templates/refs/heads/master/article_with_refs/hdb.bib

    # Settings
    mkdir -p settings
    cd settings
    curl -fsSOL https://raw.githubusercontent.com/nishchalatattve/public-latex-templates/refs/heads/master/article_with_refs/settings/colours.tex
    curl -fsSOL https://raw.githubusercontent.com/nishchalatattve/public-latex-templates/refs/heads/master/article_with_refs/settings/fonts.tex
    curl -fsSOL https://raw.githubusercontent.com/nishchalatattve/public-latex-templates/refs/heads/master/article_with_refs/settings/metadata.tex
    curl -fsSOL https://raw.githubusercontent.com/nishchalatattve/public-latex-templates/refs/heads/master/article_with_refs/settings/settings.tex
    curl -fsSOL https://raw.githubusercontent.com/nishchalatattve/public-latex-templates/refs/heads/master/article_with_refs/settings/url.tex

    echo "Done!"
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
    
    mkdir -p ${PROJECT_NAME}
    cd ${PROJECT_NAME}
}

execute(){
    if [[ $1 == "article" || $1 == "a" ]]; then
        simple_article "$@"
    elif [[ $1 == "article_with_refs" || $1 == "ar" ]]; then
        article_with_refs "$@"
    elif [[ $1 == "basic_test" || $1 == "bt" ]]; then
        basic_test "$@"
    elif [[ $1 == "plotter" || $1 == "plt" ]]; then
        plotter "$@"
    elif [[ $1 == "data-vis" || $1 == "dv" ]]; then
        data_vis "$@"
    else
        echo "$1 is not a valid template type."
        exit 1
    fi
    
}
main(){
    check_args "$@"
    check_curl
    execute "$@"
}


main "$@"