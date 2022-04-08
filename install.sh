#!/bin/sh
#
# $Id: install.sh,v 0.5 10.07.2021 22:05:57 mozgan Exp $
#

# =========================================================================== #
# === === ===                      LET's GO!                      === === === #
# =========================================================================== #

DEBUG=true

# === include() ============================================================= #
include()
{
    [ $# -eq 0 ] && printf "There is nothing to include!\n" && exit 1;

    i=0
    j=$#
    while [ $i -lt $j ];
    do
        f=${1}
        i=$((i+1))

        [ ! -e ${f} ] && printf "'${f}' not found!\n" && exit 1;

        . ${f}
        shift
    done
}

# === main ================================================================== #

# clear screen
clear

# set dot directory
DOT_DIR="$HOME/.dot.files" && [ ! -e $DOT_DIR ] &&   \
    printf ".dot.files should be in $HOME directory!\n" && exit 1;

# include the definitions
[ ! -e $DOT_DIR/defs.sh ] && printf "$DOT_DIR/defs.sh not found! \n" && exit 1;
include $DOT_DIR/defs.sh

# include source files
include ${SRC_FILES}

[ ! `command -v git` ] && fail "Please install git!" && return;

backup  # ask whether the backup should be done
menu    # show menu
choice  # choice from menu

git stash

