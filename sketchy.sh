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
    ["cpp"]='c++ cpp'
    ["rust"]='rust rs'
    ["haskell"]='haskell hs'
)

SKETCHY_LANG=$1
SKETCHY_PROJECT_NAME=$2

SKETCHY_PROJECT_DIR="$SKETCHY_ROOT_DIR$SKETCHY_PROJECT_NAME"

# Project Generation

for langName in ${SKETCHY_VALID_LANGS[*]}
do
    echo $langName
done

mkdir $SKETCHY_PROJECT_DIR
cd $SKETCHY_PROJECT_DIR
