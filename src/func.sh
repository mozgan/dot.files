#!/bin/sh
#
# $Id: src/func.sh,v 0.1 11.02.2018 22:20:36 mozgan Exp $
#

# === inquire() ============================================================= #
inquire()
{
    user "$1 $2 / $3 ? "
    read answer

    finish="-1"
    while [ $finish = '-1' ]; do
        finish="1"

        case $answer in
	    y | Y | yes | YES ) answer="y";;
	    n | N | no | NO ) answer="n";;
	    *) finish="-1"
	        warn "Invalid response -- please enter '$2' or '$3'!"
	        user "$1 $2 / $3? "
		read answer;;
        esac
    done
}

# === backup() ============================================================== #
BACKUP="false"
backup()
{
    inquire "Do you want to backup your old dot.files?" \
        "[${RED} Y ${DEFAULT}]es" "[${RED} N ${DEFAULT}]o"

    [ $answer = "y" ] || [ $answer = "Y" ] || [ $answer = "yes" ] || \
        [ $answer = "Yes" ] || [ $answer = "YES" ] && \
	        BACKUP=true && info "Backing up your old dot.files !"

    [ $BACKUP = "true" ] && [ -e $BACKUP_DIR/$TIMESTAMP ] && \
        warn "$BACKUP_DIR/$TIMESTAMP exists!"

    [ $BACKUP = "true" ] && [ ! -e $BACKUP_DIR/$TIMESTAMP ] && \
        mkdir -p $BACKUP_DIR/$TIMESTAMP && success "$BACKUP_DIR/$TIMESTAMP created!"
}

# === menu() ================================================================ #
menu()
{
    printf "\n"
    printf "\n"
    printf "\t${BHI_WHITE}*) Installation \n"
    printf "\t\t${RED}A${BHI_WHITE}ll dotfiles \n"
    printf "\t\t${RED}S${BHI_WHITE}h dotfiles \n"
    printf "\t\t${RED}B${BHI_WHITE}ash dotfiles \n"
    printf "\t\t${RED}Z${BHI_WHITE}sh dotfiles \n"
    printf "\t\t${RED}V${BHI_WHITE}im dotfiles \n"
    printf "\t*) ${RED}U${BHI_WHITE}pdate dotfiles from repo \n"
    printf "\t*) ${RED}I${BHI_WHITE}nstall personal files \n"
    printf "\t*) ${RED}R${BHI_WHITE}emove all files \n"
    printf "\t*) ${RED}Q${BHI_WHITE}uit \n"
    printf "\n"
    printf "\n"
}

# === choice() ============================================================== #
choice()
{
    user "Give your choice: "
    read ch

    case $ch in
        a | A | all | All | ALL)
        	# shell sources
           	make_link $PROFILE $PROFILE_INSTALL;
           	make_link $ENV $ENV_INSTALL;
           	make_link $BIN_DIR $BIN_DIR_INSTALL;

           	# shrc
           	make_link $SHRC $SHRC_INSTALL;

           	# Bash
            make_link $BASH_PROFILE $BASH_PROFILE_INSTALL;
            make_link $BASHRC $BASHRC_INSTALL;
            make_link $BASH_COLOR $BASH_COLOR_INSTALL;
            make_link $BASH_THEME $BASH_THEME_INSTALL;
            make_link $ALIASES $ALIASES_INSTALL;
            make_link $FUNCTIONS $FUNCTIONS_INSTALL;
            make_link $GIT_COMPLETION_BASH $GIT_COMPLETION_BASH_INSTALL;

            # Personal files
            install_personal;

            # Vi(m) files
            create_vimrc;
            make_link $VIM_DIR $VIM_DIR_INSTALL;
            ;;

        s | S | sh | Sh | SH)
            make_link $PROFILE $PROFILE_INSTALL;
            make_link $ENV $ENV_INSTALL;
            make_link $SHRC $SHRC_INSTALL;
            make_link $BIN_DIR $BIN_DIR_INSTALL;
            ;;

        b | B | bash | Bash | BASH)
            make_link $PROFILE $PROFILE_INSTALL;
            make_link $ENV $ENV_INSTALL;
            make_link $BASH_PROFILE $BASH_PROFILE_INSTALL;
            make_link $BASHRC $BASHRC_INSTALL;
            make_link $BASH_COLOR $BASH_COLOR_INSTALL;
            make_link $BASH_THEME $BASH_THEME_INSTALL;
            make_link $ALIASES $ALIASES_INSTALL;
            make_link $FUNCTIONS $FUNCTIONS_INSTALL;
            make_link $GIT_COMPLETION_BASH $GIT_COMPLETION_BASH_INSTALL;
            make_link $BIN_DIR $BIN_DIR_INSTALL;
            ;;

        z | Z | zsh | Zsh | ZSH)
            # :TODO:
            debug ":TODO: zsh"
            ;;

        v | V | vim | Vim | VIM)
            create_vimrc;
            make_link $VIM_DIR $VIM_DIR_INSTALL;
            ;;

        u | U | update | Update | UPDATE)
            update;
            ;;

        i | I | install | Install | INSTALL)
            install_personal;
            ;;

        r | R | remove | Remove | REMOVE)
            remove $INSTALLED;
            ;;

        q | Q | quit | Quit | QUIT)
            debug "quit"
            echo "Bye!"
            return
            ;;

        *)
            warn "Invalid response !! "
            choice
            ;;
    esac
}

# === make_backup() ========================================================= #
make_backup()
{
    [ $# -eq 0 ] && return;

    i=0
    j=$#
    while [ $i -lt $j ]; do
        local f=${1}
        i=$((i+1))

        [ -e ${f} ] && $(SHELL=/bin/sh mv ${f} $BACKUP_DIR/$TIMESTAMP) && \
            success "BACKUP: ${f} to $BACKUP_DIR/$TIMESTAMP moved."

        shift
    done
}

# === make_link() =========================================================== #
make_link()
{
    [ $# -eq 0 ] && fail "No source given!" && return;
    [ $# -eq 1 ] && fail "No destination given!" && return;

    local src=$1;
    local dest=$2;

    [ ! -e $src ] && fail "$src not exists!" && return;

    if [ -e $dest ];
    then
        if [ -L $dest ];
        then
            info "$dest exists." && \
                $(SHELL=/bin/sh unlink $dest) && success "$dest removed."
        else
            [ $BACKUP = "true" ] && info "$dest exists." && \
                make_backup $dest

            $(SHELL=/bin/sh rm -rf $dest) && success "$dest deleted."
        fi
    fi

    $(SHELL=/bin/sh ln -s $src $dest) && success "$dest linked."
}

# === create_vimrc() ======================================================== #
create_vimrc()
{
    [ -e $HOME/.vimrc ] && [ $BACKUP = "true" ] && \
        info "$HOME/.vimrc exists." && make_backup `ls $HOME/.vimrc`

echo '
"
" $HOME/.vimrc preamble
"
" $Id: $HOME/.vimrc,v 0.1' $TODAY 'mozgan Exp $
"
if isdirectory(expand("$HOME/.vim"))
    set runtimepath+='$HOME'/.vim

    " load plugins
    if filereadable(expand("$HOME/.vim/vimrcs/plugins.vim"))
        source $HOME/.vim/vimrcs/plugins.vim
    endif

    " load default vimrc
    if filereadable(expand("$HOME/.vim/vimrcs/vimrc.vim"))
        source $HOME/.vim/vimrcs/vimrc.vim
    endif

	" load specific configurations for programming
    if filereadable(expand("$HOME/.vim/vimrcs/programming.vim"))
        source $HOME/.vim/vimrcs/programming.vim
    endif

	" load default vimrc
    if filereadable(expand("$HOME/.vim/vimrcs/style.vim"))
        source $HOME/.vim/vimrcs/style.vim
    endif
endif
' > $HOME/.vimrc
}

# === update() ============================================================== #
update()
{
    if [ `command -v git` ];
    then
        $(SHELL=/bin/sh git fetch origin)
        $(SHELL=/bin/sh git rebase -p origin/master)
        $(SHELL=/bin/sh git submodule update --init --recursive)
    else
        fail "git has not installed !!"
    fi
}

# === remove() ============================================================== #
remove()
{
    [ $# -eq 0 ] && printf "There is nothing to remove!\n" && return;

    inquire "Do you want to remove the dot.files?" \
        "[${RED} Y ${DEFAULT}]es" "[${RED} N ${DEFAULT}]o"

    [ $answer = "n" ] || [ $answer = "N" ] || [ $answer = "no" ] || \
        [ $answer = "No" ] || [ $answer = "NO" ] && \
            info "Nothing removed!" && return;

    i=0
    j=$#
    while [ $i -lt $j ];
    do
        f=${1}
        i=$((i+1))

        [ `command -v unlink` ] && [ -L $f ] && \
            $(SHELL=/bin/sh unlink $f) && success "$f removed."

        # OpenBSD has no command `unlink'. Use `rm'!
        [ -f $f ] && \
            $(SHELL=/bin/sh rm -f $f) && success "$f removed."

        shift
    done

    [ -e $HOME/.vimrc ] && $(SHELL=/bin/sh rm -f $HOME/.vimrc) && \
        success "$HOME/.vimrc removed."
}

# === install_personal() ==================================================== #
install_personal()
{
    local _NAME="USER"
    local _NICK="NICK"
    local _EMAIL="MAIL"
    local _COMPANY="COMPANY"

    user "Give your name: "
    read _NAME

    user "Give your nickname: "
    read _NICK

    user "Give your email: "
    read _EMAIL

    user "Give your company: "
    read _COMPANY

    echo "NAME=$_NAME" > $PERSONAL_DIR/PERSONAL
    echo "NICK=$_NICK" >> $PERSONAL_DIR/PERSONAL
    echo "EMAIL=$_EMAIL" >> $PERSONAL_DIR/PERSONAL
    echo "COMPANY=$_COMPANY" >> $PERSONAL_DIR/PERSONAL

    # make a hard copy and don't change original config file(s)
    $(SHELL=/bin/sh cp $GITCONFIG $GITCONFIG_INSTALL)
    $(SHELL=/bin/sh cp $GITIGNORE $GITIGNORE_INSTALL)

    sed -e "s/_NAME/$_NAME/g" $GITCONFIG_INSTALL > $GITCONFIG_INSTALL.tmp
    mv $GITCONFIG_INSTALL.tmp $GITCONFIG_INSTALL
    sed -e "s/_EMAIL/$_EMAIL/g" $GITCONFIG_INSTALL > $GITCONFIG_INSTALL.tmp
    mv $GITCONFIG_INSTALL.tmp $GITCONFIG_INSTALL
    sed -e "s/_SIGNATURE/$_NAME <$_EMAIL>/g" $GITCONFIG_INSTALL > $GITCONFIG_INSTALL.tmp
    mv $GITCONFIG_INSTALL.tmp $GITCONFIG_INSTALL
    sed -e "s/EXCLUDESFILE/~\/.gitignore_global/g" $GITCONFIG_INSTALL > $GITCONFIG_INSTALL.tmp
    mv $GITCONFIG_INSTALL.tmp $GITCONFIG_INSTALL

    #sed -e "s/NAME/$NAME/g" $GITCONFIG > $GITCONFIG.tmp
    #mv $GITCONFIG.tmp $GITCONFIG
    #sed -e "s/EMAIL/$EMAIL/g" $GITCONFIG > $GITCONFIG.tmp
    #mv $GITCONFIG.tmp $GITCONFIG
    #sed -e "s/SIGNATURE/$NAME <$EMAIL>/g" $GITCONFIG > $GITCONFIG.tmp
    #mv $GITCONFIG.tmp $GITCONFIG
    #sed -e "s/EXCLUDESFILE/~\/.gitignore_global/g" $GITCONFIG > $GITCONFIG.tmp
    #mv $GITCONFIG.tmp $GITCONFIG

    #make_link $GITCONFIG $GITCONFIG_INSTALL
    #make_link $GIT_COMPLETION $GIT_COMPLETION_INSTALL
    #make_link $GITIGNORE $GITIGNORE_INSTALL

    sed -e "s/_NAME/$_NAME/g" $VIM_PERSONAL > $VIM_PERSONAL.tmp
    mv $VIM_PERSONAL.tmp $VIM_PERSONAL
    sed -e "s/_NICK/$_NICK/g" $VIM_PERSONAL > $VIM_PERSONAL.tmp
    mv $VIM_PERSONAL.tmp $VIM_PERSONAL
    sed -e "s/_EMAIL/$_EMAIL/g" $VIM_PERSONAL > $VIM_PERSONAL.tmp
    mv $VIM_PERSONAL.tmp $VIM_PERSONAL
    sed -e "s/_COMPANY/$_COMPANY/g" $VIM_PERSONAL > $VIM_PERSONAL.tmp
    cp $VIM_PERSONAL.tmp $VIM_PERSONAL
    cp $VIM_PERSONAL $VIM_PERSONAL.templates
}

