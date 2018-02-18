#!/bin/sh
#
# $Id: src/color.sh,v 0.2 11.02.2018 22:19:44 mozgan Exp $
#

# === Regular, Bold, Underline ============================================== #
REGULAR=0
BOLD=1
UNDERLINE=4

# === Foreground ============================================================ #
F_NULL=00
F_BLACK=30
F_RED=31
F_GREEN=32
F_YELLOW=33
F_BLUE=34
F_VIOLET=35
F_CYAN=36
F_WHITE=37

# === Background ============================================================ #
B_NULL=00
B_BLACK=40
B_RED=41
B_GREEN=42
B_YELLOW=43
B_BLUE=44
B_VIOLET=45
B_CYAN=46
B_WHITE=47

# === High Intensity ======================================================== #
H_NULL=00
H_BLACK=90
H_RED=91
H_GREEN=92
H_YELLOW=93
H_BLUE=94
H_VIOLET=95
H_CYAN=96
H_WHITE=97

# === Background High Intensity  ============================================ #
BH_NULL=00
BH_BLACK=100
BH_RED=101
BH_GREEN=102
BH_YELLOW=103
BH_BLUE=104
BH_VIOLET=105
BH_CYAN=106
BH_WHITE=107

# === ESC =================================================================== #
#ESC="\e"
ESC="\033"

# === Default =============================================================== #
DEFAULT="$ESC[0m"

# === Reset ================================================================= #
RESET="$ESC[${REGULAR};${F_WHITE};${B_NULL}m"

# === Regular Text ========================================================== #
BLACK="$ESC[${REGULAR};${F_BLACK}m"
RED="$ESC[${REGULAR};${F_RED}m"
GREEN="$ESC[${REGULAR};${F_GREEN}m"
YELLOW="$ESC[${REGULAR};${F_YELLOW}m"
BLUE="$ESC[${REGULAR};${F_BLUE}m"
VIOLET="$ESC[${REGULAR};${F_VIOLET}m"
CYAN="$ESC[${REGULAR};${F_CYAN}m"
WHITE="$ESC[${REGULAR};${F_WHITE}m"

# === Bold Text ============================================================= #
BOLD_BLACK="$ESC[${BOLD};${F_BLACK}m"
BOLD_RED="$ESC[${BOLD};${F_RED}m"
BOLD_GREEN="$ESC[${BOLD};${F_GREEN}m"
BOLD_YELLOW="$ESC[${BOLD};${F_YELLOW}m"
BOLD_BLUE="$ESC[${BOLD};${F_BLUE}m"
BOLD_VIOLET="$ESC[${BOLD};${F_VIOLET}m"
BOLD_CYAN="$ESC[${BOLD};${F_CYAN}m"
BOLD_WHITE="$ESC[${BOLD};${F_WHITE}m"

# === Underline ============================================================= #
UNDERLINE_BLACK="$ESC[${UNDERLINE};${F_BLACK}m"
UNDERLINE_RED="$ESC[${UNDERLINE};${F_RED}m"
UNDERLINE_GREEN="$ESC[${UNDERLINE};${F_GREEN}m"
UNDERLINE_YELLOW="$ESC[${UNDERLINE};${F_YELLOW}m"
UNDERLINE_BLUE="$ESC[${UNDERLINE};${F_BLUE}m"
UNDERLINE_VIOLET="$ESC[${UNDERLINE};${F_VIOLET}m"
UNDERLINE_CYAN="$ESC[${UNDERLINE};${F_CYAN}m"
UNDERLINE_WHITE="$ESC[${UNDERLINE};${F_WHITE}m"

# === Background ============================================================ #
BG_BLACK="$ESC[${B_BLACK}m"
BG_RED="$ESC[${B_RED}m"
BG_GREEN="$ESC[${B_GREEN}m"
BG_YELLOW="$ESC[${B_YELLOW}m"
BG_BLUE="$ESC[${B_BLUE}m"
BG_VIOLET="$ESC[${B_VIOLET}m"
BG_CYAN="$ESC[${B_CYAN}m"
BG_WHITE="$ESC[${B_WHITE}m"

# === High Intensity ======================================================== #
HI_BLACK="$ESC[${REGULAR};${H_BLACK}m"
HI_RED="$ESC[${REGULAR};${H_RED}m"
HI_GREEN="$ESC[${REGULAR};${H_GREEN}m"
HI_YELLOW="$ESC[${REGULAR};${H_YELLOW}m"
HI_BLUE="$ESC[${REGULAR};${H_BLUE}m"
HI_VIOLET="$ESC[${REGULAR};${H_VIOLET}m"
HI_CYAN="$ESC[${REGULAR};${H_CYAN}m"
HI_WHITE="$ESC[${REGULAR};${H_WHITE}m"

# === Bold High Intensity =================================================== #
BHI_BLACK="$ESC[${BOLD};${H_BLACK}m"
BHI_RED="$ESC[${BOLD};${H_RED}m"
BHI_GREEN="$ESC[${BOLD};${H_GREEN}m"
BHI_YELLOW="$ESC[${BOLD};${H_YELLOW}m"
BHI_BLUE="$ESC[${BOLD};${H_BLUE}m"
BHI_VIOLET="$ESC[${BOLD};${H_VIOLET}m"
BHI_CYAN="$ESC[${BOLD};${H_CYAN}m"
BHI_WHITE="$ESC[${BOLD};${H_WHITE}m"

# === High Intensity backgrounds ============================================ #
BG_HI_BLACK="$ESC[${REGULAR};${BH_BLACK}m"
BG_HI_RED="$ESC[${REGULAR};${BH_RED}m"
BG_HI_GREEN="$ESC[${REGULAR};${BH_GREEN}m"
BG_HI_YELLOW="$ESC[${REGULAR};${BH_YELLOW}m"
BG_HI_BLUE="$ESC[${REGULAR};${BH_BLUE}m"
BG_HI_VIOLET="$ESC[${REGULAR};${BH_VIOLET}m"
BG_HI_CYAN="$ESC[${REGULAR};${BH_CYAN}m"
BG_HI_WHITE="$ESC[${REGULAR};${BH_WHITE}m"

# === References ============================================================ #
#	*) http://misc.flogisoft.com/bash/tip_colors_and_formatting
#	*) https://wiki.archlinux.org/index.php/Color_Bash_Prompt
#	*) http://tldp.org/LDP/abs/html/sample-bashrc.html
