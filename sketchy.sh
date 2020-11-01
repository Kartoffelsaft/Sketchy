#!/usr/bin/env bash

# Note: Sketchy is designed with the assumtion that it is sourced; i.e.
# ". ./sketchy.sh" instead of "./sketchy.sh"

###
# User Config
###

SKETCHY_ROOT_DIR=/tmp/
SKETCHY_DEFAULT_EDITOR=nvim

###
# Dev Config
###

# Aliases

declare -A SKETCHY_VALID_LANGS=(
    [cpp]='c++ cpp'
    [rust]='rust rs'
    [haskell]='haskell hs'
)

SKETCHY_LANG=$1
SKETCHY_PROJECT_NAME=$2

SKETCHY_PROJECT_DIR="$SKETCHY_ROOT_DIR$SKETCHY_PROJECT_NAME"

# Project Generation

for langName in ${!SKETCHY_VALID_LANGS[*]}
do
    if [[ ${SKETCHY_VALID_LANGS[${langName}]} =~ ${SKETCHY_LANG} ]]
    then
        SKETCHY_VALID_LANG=$langName
    fi
done

if [ -z ${SKETCHY_VALID_LANG+x} ]
then
    echo "${SKETCHY_LANG} is not a valid language"
    exit 1
fi

mkdir $SKETCHY_PROJECT_DIR
cd $SKETCHY_PROJECT_DIR

case $SKETCHY_VALID_LANG in
    cpp)
        echo "C Plus Plus"
        ;;

    rust)
        cargo init --vcs none
        ${SKETCHY_DEFAULT_EDITOR} ./src/main.rs
        ;;

    haskell)
        echo "Haskell"
        ;;

    *)
        echo "${SKETCHY_LANG} was detected as a valid language, but has no configuration"
        ;;
esac
