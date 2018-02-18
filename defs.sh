#!/bin/sh
#
# $Id: defs.sh,v 0.1 11.02.2018 22:17:00 mozgan Exp $
#

# === definitions =========================================================== #
OS=`uname -s`
TODAY=`date +"%d.%m.%Y %T"`
TIMESTAMP=`date +%Y%m%d_%H%M%S`

# === source files ========================================================== #
SRC_DIR="$DOT_DIR/src"

# source files
SRC_FILES=" $SRC_DIR/color.sh   \
            $SRC_DIR/msg.sh     \
            $SRC_DIR/func.sh    "

# === backup ================================================================ #
BACKUP_DIR="$HOME/backup"
BACKUP=false

# === bin =================================================================== #
BIN_DIR="$DOT_DIR/bin"
BIN_DIR_INSTALL="$HOME/bin"

# === shell files =========================================================== #
SHELL_DIR="$DOT_DIR/dot.shell"
SH_DIR="$SHELL_DIR/sh"
BASH_DIR="$SHELL_DIR/bash"
COMPLETIONS="$SHELL_DIR/completions"

# profile
PROFILE="$SHELL_DIR/profile"
PROFILE_INSTALL="$HOME/.profile"

# environment
ENV="$SHELL_DIR/env"
ENV_INSTALL="$HOME/.env"

# shrc
SHRC="$SH_DIR/shrc"
SHRC_INSTALL="$HOME/.shrc"

# bash sources
BASH_PROFILE="$BASH_DIR/bash_profile"
BASH_PROFILE_INSTALL="$HOME/.bash_profile"

BASHRC="$BASH_DIR/bashrc"
BASHRC_INSTALL="$HOME/.bashrc"

BASH_COLOR="$BASH_DIR/bash_color"
BASH_COLOR_INSTALL="$HOME/.bash_color"

BASH_THEME="$BASH_DIR/bash_theme"
BASH_THEME_INSTALL="$HOME/.bash_theme"

# shell aliases
ALIASES="$SHELL_DIR/aliases"
ALIASES_INSTALL="$HOME/.aliases"

# shell functions
FUNCTIONS="$SHELL_DIR/functions"
FUNCTIONS_INSTALL="$HOME/.functions"

# git completio for bash
GIT_COMPLETION_BASH="$COMPLETIONS/git-completion.bash"
GIT_COMPLETION_BASH_INSTALL="$HOME/.git-completion.bash"

# === personal files ======================================================== #
PERSONAL_DIR="$DOT_DIR/personal"

GITCONFIG="$PERSONAL_DIR/gitconfig"
GITCONFIG_INSTALL="$HOME/.gitconfig"

GITIGNORE="$PERSONAL_DIR/gitignore_global"
GITIGNORE_INSTALL="$HOME/.gitignore_global"

# === vim =================================================================== #
VIM_DIR="$DOT_DIR/dot.vim"
VIM_PERSONAL="$VIM_DIR/templates/personal"

# === vim install =========================================================== #
VIM_DIR_INSTALL="$HOME/.vim"

# === installed ============================================================= #
INSTALLED=" $BIN_DIR_INSTALL				\
			$SHRC_INSTALL					\
			$PROFILE_INSTALL 				\
			$ENV_INSTALL 					\
			$BASH_PROFILE_INSTALL			\
			$BASHRC_INSTALL 				\
			$BASH_COLOR_INSTALL 			\
			$BASH_THEME_INSTALL 			\
			$ALIASES_INSTALL 				\
			$FUNCTIONS_INSTALL 				\
			$GIT_COMPLETION_BASH_INSTALL	\
			$GITCONFIG_INSTALL				\
			$GITIGNORE_INSTALL				\
			$VIM_DIR_INSTALL"


