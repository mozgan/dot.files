#!/bin/sh
#
# $Id: src/msg.sh,v 0.3.2 11.02.2018 22:20:07 mozgan Exp $
#

# === info() ================================================================ #
info()
{
    printf "${HI_WHITE}[${HI_CYAN} INFO ${HI_WHITE}]${DEFAULT} ${1} \n"
}

# === user() ================================================================ #
user()
{
    printf "${HI_WHITE}[${HI_YELLOW}  =>  ${HI_WHITE}]${DEFAULT} ${1}"
}

# === warn() ================================================================ #
warn()
{
    printf "${HI_WHITE}[${HI_BLUE} WARN ${HI_WHITE}]${DEFAULT} ${1} \n"
}

# === success() ============================================================= #
success()
{
    printf "${HI_WHITE}[${HI_GREEN}  OK  ${HI_WHITE}]${DEFAULT} ${1} \n"
}

# === fail() ================================================================ #
fail()
{
    printf "${HI_WHITE}[${HI_RED} FAIL ${HI_WHITE}]${DEFAULT} ${1} \n"
}

# === finish() ============================================================== #
finish()
{
    printf "\n"
    printf "${HI_WHITE}[${HI_GREEN}  OK  ${HI_WHITE}] ${HI_WHITE}Gratulations! You have success installed the '${HI_RED}${1}${HI_WHITE}'.${DEFAULT}\n\n"
}

# === debug() =============================================================== #
debug()
{
    [ "$DEBUG" = "true" ] &&   \
        printf "${HI_WHITE}[${HI_VIOLET} DEBUG ${HI_WHITE}]\t${1}${DEFAULT}\n"
}
