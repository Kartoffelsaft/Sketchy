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
        # I know the touching is redundant, but it's more clear
        touch main.cpp 
        touch run.sh

        echo '#include <cstdio>' >> main.cpp
        echo -e "\nint main(int argc, char ** argv) {" >> main.cpp
        echo -e "\tprintf(\"Hello\\\n\");" >> main.cpp
        echo -e "\treturn 0;\n}" >> main.cpp

        echo '#!/bin/sh' >> run.sh
        echo 'g++ -Og -g -Wall -Wextra main.cpp -o a.out' >> run.sh
        echo './a.out' >> run.sh

        chmod +x ./run.sh

        ${SKETCHY_DEFAULT_EDITOR} ./main.cpp
        ;;

    rust)
        cargo init --vcs none
        ${SKETCHY_DEFAULT_EDITOR} ./src/main.rs
        ;;

    haskell)
        touch main.hs

        echo "square x = x * x" >> main.hs

        if [ ${SKETCHY_DEFAULT_EDITOR} = nvim ]
        then
            SKETCHY_EDITOR_ARGS="+tabnew -c \"terminal ghci ./main.hs\" +tabfirst"
        fi

        echo $SKETCHY_EDITOR_ARGS

        /bin/sh -c "${SKETCHY_DEFAULT_EDITOR} ./main.hs ${SKETCHY_EDITOR_ARGS}"
        ;;

    *)
        echo "${SKETCHY_LANG} was detected as a valid language, but has no configuration"
        ;;
esac
