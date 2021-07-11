"------------------------------------------------------------------------------
"                           Vim Configuration
"
"
" $Id: dot.vim/vimrcs/vimrc.vim,v 1.5 17.02.2018 10:13:36 mozgan Exp $
"------------------------------------------------------------------------------

"------------------------------------------------------------------------------
" {{{   Index
"
" 1) Vi/Ex compatibility
" 2) Local configuration
" 3) Display configuration
" 4) Depiction of long lines
" 5) Wrapping for too long lines
" 6) Movement for cursor
" 7) Text input
" 8) File format and backups
" 9) Search and Replace
" 10) Tabs (<TAB>, <CTRL-i>)
" 11) Programming (General)
" 12) Syntax and Colors
" 13) Personal rules for syntax
" 14) Folding
" 15) Mouse
" 16) Printing (:hardcopy or :hardcopy!)
" 17) Authorization
" 18) Shell
" 19) Tags
" 20) Swapping
" 21) GUI
" 22) Keywords
" 23) Pages
" 24) Completion and Wildcard
" 25) Limitation
" 26) Terminal
" 27) Mapping
" 28) Viminfo, Sessions and Views
" 29) Movement of mouse
" 30) Definitions of menu
" 31) Definitions of input mod
" 32) Debugging
"
" }}}

"------------------------------------------------------------------------------
" {{{   1) Vi/Ex compatibility

" Use 'evim.vim' for 'evim'
if v:progname =~? "evim"
        finish
endif

" This option has the effect of making Vim either more Vi-compatible, or
" make Vim behave in a more useful way.
" CAREFUL: Setting or resetting this option can have a lot of unexpected effects:
" Mappings are interpreted in another way, undo behaves differently, etc.
set nocompatible

" - activate Vi standards -
" A sequence of single character flags.
" When a character is present this indicates Vi-compatible behavior.
"set nocompatible -> set cpo=aAbBcCdDeEfFgHiIjJkKlLmMnoOpPqrRsStuvwWxXyZ$!%*-+<>
"set compatible -> set cpo=aABceFs

"set cpoptions+=$       " When making a change to one line, don't redisplay
                        " the line, but put a '$' at the end of the changed text.

" use 'Q' for Ex mode
map Q gq

" }}}

"------------------------------------------------------------------------------
" {{{   2) Local configuration

" If 'modeline' is on 'modelines' gives the number of lines that is
" checked for set commands.  If 'modeline' is off or 'modelines' is zero
" no lines are checked.
set nomodeline     " local to buffer
set modelines=0    " Ex. 1, 5, usw.

" Don't use .exrc, .vimrc or .gvimrc in actual directory !!
set noexrc

" When on, ":autocmd", shell and write commands are not allowed in
" ".vimrc" and ".exrc" in the current directory and map commands are displayed.
set secure

" }}}

"------------------------------------------------------------------------------
" {{{   3) Display configuration

"If in Insert, Replace or Visual mode put a message on the last line.
set showmode

" Show (partial) command in the last line of the screen.
" Set this option off if your terminal is slow.
set showcmd

" Show report on status bar.
" If you want it always, set 'report' to 0.
set report=0

" Number of screen lines to use for the command-line.
set cmdheight=2

" The key used in Command-line Mode to open the command-line window.
" The default is <CTRL-F> when 'compatible' is off.
set cedit=^F

" Number of screen lines to use for the command-line window.
"set cmdwinheight=7

" This option determines the content of the status line.
"set statusline=                " Default
"set statusline=%h%m%r
"set statusline=%t\ [%M%r%{&ff}]\ [%L/%04l,%04v,%p%%]

" The value of this option influences when the
" last window will have a status line:
"    0: never
"    1: only if there are at least two windows
"    2: always
set laststatus=2

" Show the line and column number of the cursor position,
" separated by a comma.
" (SET 'paste' -> 'noruler')
set ruler

" Set the format of ruler (:help 'rulerformat')
"set rulerformat=...
set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%)

" Highlight the screen line of the cursor with CursorLine hl-CursorLine
"set cursorline

" Highlight the screen column of the cursor with CursorColumn hl-CursorColumn
"set cursorcolumn

" The title of the window will be set to the value of filename
" (some terminals have no support!)
if &term =~ "xterm"
    " xterm title
"    if has('title')
"        set title       " show the filename on windows
"    endif

    " bar cursor shape
    if exists('&t_SI')
        let &t_SI = "\<Esc>]12;lightgoldenrod\x7"    " start insert mode
        let &t_EI = "\<Esc>]12;grey80\x7"            " end insert mode
    endif
endif

"set title            " Show the pagename on title of window
"set titlelen=50      " Gives the percentage of 'columns'
                      " to use for the length of the window title.
"set titleold=...     "
"set titlestring=...  " Set the title of window on manual (<empty>=filename)

" Show the filename on icon
set icon              " Show the filename as icon
"set iconstring=      " set with manual (<empty>=filename)

" Show the line number.
" Set the number of columns to use for the line number.
if has("gui_running")
    set number
    set numberwidth=4
else
    "set nonumber
    set number
    set numberwidth=4
endif

" Don't show the char of EOL! (lcs = listchars)
" (Ex.: Tabs are "^I" and EOL "$")
set nolist

" Set the special characters with 'list' (lcs=listchars, Ã~Vrn.: lcs=eol:$)
" tab:AB     = Tabs (Ex.: ^I)
" trail:C    = Trails (Ex.: empty)
" eol:C      = EOL (Ex.: $)
" precedes:C = Character to show in the first column, when 'wrap' is off and there is
"               text preceding the character visible in the first column.
" extends:C  = Character to show in the last column, when 'wrap' is
"              off and the line continues beyond the right of the screen.
" nbsp:C     = Character to show for a non-breakable space (Code 160)
"set listchars=tab:»\ ,trail:·,eol:$,precedes:«,extends:»;nbsp:·   " Variant 1
"set listchars=tab:»­,trail:·,eol:$,precedes:«,extends:»;nbsp:·    " Variant 2
"set listchars=tab:»­,trail:·,eol:¶,precedes:«,extends:»;nbsp:·    " Variant 3
"set lcs=tab:»°
"set lcs=tab:»·
"set lcs=tab:»¬
"set lcs=tab:»¨
set lcs=tab:»­
set lcs+=trail:·
set lcs+=eol:¶
set lcs+=precedes:«
set lcs+=extends:»
if v:version >= 700
        set lcs+=nbsp:·
endif

" ERROR BELL: Ring the bell (beep or screen flash) for error messages (Ex. 2x <ESC>)
set noerrorbells  " Don't beep if an error occours
set visualbell    " Use visual bell instead of beeping.
set t_vb=         " visual bell

" Show a dialog asking (Y/N) for some commands
" if you wish to save the current file(s)(Ex. :q)
"set confirm

" Show "More" and listings pause when the whole screen is filled
set more

" shortmess: This option helps to avoid all the hit-enter prompts
" caused by file messages, for example  with CTRL-G, and to avoid
" some other messages. It is a list of flags:
set shortmess=a         " all of the above abbreviations (a=filmnrwx)
set shortmess+=I        " don't give the intro message when starting Vim (":intro")
set shortmess+=oO       "
set shortmess+=tT       "
set shortmess+=s        " don't give "search hit BOTTOM, continuing at TOP" or
                        " search hit TOP, continuing at BOTTOM" messages
set shortmess-=AW       "
set terse               " Add 's' flag to 'shortmess' option
set warn                " Give a warning message when a shell command is used
                        "while the buffer has been changed.
"set shortmess=atI

" DISPLAY
" Change the way text is displayed.  This is comma separated list of flags:
"   lastline: as much as possible of the last line in a window will be displayed.
"   uhex: Show unprintable characters hexadecimal as <xx> instead of using ^C and ~C
set display=lastline

" fillchars: Characters to fill the statuslines and vertical separators
" stl:C   = statusline of the current window
" stlnc:C = statusline of the non-current windows
" vert:C  = vertical separators (:vsplit)
" fold:C  = filling "foldtext"
" diff:C  = deleted lines of the 'diff' option
"set fillchars=vert:| ,fold:-
set fillchars=vert:\ ,stl:\ ,fold:-
"set fcs=stl:^
"set fcs+=stlnc:-
"set fcs+=vert:|
"set fcs+=fold:-
"set fcs+=diff:-

" Option settings for 'DIFF' mode
"     filler    : Show filler lines, to keep the text synchronized with
"                 a window that has inserted lines at the same position
"     vertical  : Start diff mode with vertical splits
"     iwhite    : Ignore changes in amount of white space
"     context{n}: Use a context of {n} lines between a change and
"                 a fold that contains unchanged lines
set diffopt=filler,vertical,iwhite,context:10
"set diffopt=filler,vertical,context:15

" the screen contents is restored when exiting Vim
"set restorescreen

" HIGHLIGHTING (:h 'highlight')
" This option can be used to set highlighting mode for various occasions
"set highlight=KEY:GROUP,...
"set highlight=8:SpecialKey,@:NonText,d:Directory,e:ErrorMsg,i:IncSearch,l:Search,m:MoreMsg,M:ModeMsg,n:LineNr,r:Question,s:StatusLine,S:StatusLineNC,c:VertSplit,t:Title,v:Visual,V:VisualNOS,w:WarningMsg,W:WildMenu,f:Folded,F:FoldColumn,A:DiffAdd,C:DiffChange,D:DiffDelete,T:DiffText,>:SignColumn,B:SpellBad,P:SpellCap,R:SpellRare,L:SpellLocal,+:Pmenu,=:PmenuSel,x:PmenuSbar,X:PmenuThumb,*:TabLine,#:TabLineSel,_:TabLineFill,!:CursorColumn,.:CursorLine

" display orientation becomes right-to-left
"set rightleft

" }}}

"------------------------------------------------------------------------------
" {{{   4) Depiction of long lines

" wrapping: lines longer than the width of the window will wrap and displaying
"           continues on the next line
set wrap

" String to put at the start of lines that have been wrapped
" (Ex.: :set showbreak=>)
set showbreak=»

" wrap long lines at a character in 'breakat' rather than at the last character
" that fits on the screen
set linebreak

" choose which characters might cause a line break if 'linebreak' is on
"set breakat=\ ^I!@*-+;:,./?"

" sidescroll: Used only when the 'wrap' option is off and the cursor is moved
" off of the screen
"set sidescroll=1

" The minimal number of screen columns to keep to the left and
" to the right of the cursor if 'nowrap' is set
set sidescrolloff=0

" }}}

"------------------------------------------------------------------------------
" {{{   5) Wrapping for too long lines

" When typing text beyond this limit, an <EOL> will be inserted and
" inserting continues on the next line (0 = no wrapping)
" 'paste' -> 'wrapmargin=0'
set wrapmargin=0

" Maximum width of text that is being inserted
" (0 = inactive, alternative for 'wrapmargin')
" 'paste' -> 'textwidth=0'
set textwidth=0

" }}}

"------------------------------------------------------------------------------
" {{{   6) Movement for cursor

" Allow specified keys that move the cursor left/right to move to the
" previous/next line when the cursor is on the first/last character in the line
" (Ex.: b,s; cursor has been blocked on start/end of line)
"   b = Backspace
"   s = Space
"   < = Cursor-Left
"   > = Cursor-Right,
"   h = "h"=Left (DON'T USE!)
"   l = "l"=Right (DON'T USE!)
"   ~ = Change-case
"   [ = Cursor-Left (Insert)
"   ] = Cursor-Right (Insert)
"set whichwrap="b,s,<,>,~,[,]"     " WARNING: false to write into " "!
set whichwrap=b,s,<,>,~,[,]
"set whichwrap+=<,>,[,]

" Influences the working of <BS>, <Del>, <CTRL-W> and <CTRL-U> in Insert mode
" (0=No/Vi compatibility, 1=indent,eol, 2=indent,eol,start)
"   indent = Allow backspacing over autoindent
"   eol    = Allow backspacing over line breaks (join lines)
"   start  = Allow backspacing over the start of insert; CTRL-W and CTRL-U
"            stop once at the start of insert
set backspace=eol,start,indent

" Function keys that start with an <Esc> are recognized in Insert mode
set esckeys

" Virtual editing means that the cursor can be positioned where
" there is no actual character
" block   : Allow virtual editing in Visual block mode
" insert  : Allow virtual editing in Insert mode
" all     : Allow virtual editing in all modes
" onemore : Allow the cursor to move just past the end of the line
set virtualedit=block,onemore

" STARTOFLINE:
" *) When "on" the commands listed below move the cursor to the first
"    non-blank of the line
" *) When "off" the cursor is kept in the same column (if possible)
"    This applies to the commands:
"    CTRL-D, CTRL-U, CTRL-B, CTRL-F, "G", "H", "M", "L", gg, d, <<, >>
"set startofline
set nostartofline

" move cursor on next line in wrapped lines
map j gj
map k gk
" DON'T move cursor on next line in wrapped lines
"nnoremap j gj
"nnoremap k gk

" Number of lines to scroll with CTRL-U and CTRL-D commands
" (0 = half the window height)
set scroll=0

" Minimal number of lines to scroll when the cursor gets off the screen
"set scrolljump=1

" Minimal number of screen lines to keep above and below the cursor (0=nothing)
set scrolloff=2

" The current window scrolls as other scrollbind windows (windows that also
" have this option set) scroll.
" This option is useful for viewing the differences between two versions of
" a file (DIFF!)
set scrollbind

" Specifying how 'scrollbind' windows should behave
"   ver  : Vertical
"   hor  : Horizontal
"   jump : Relativ Offsets
set scrollopt=ver,jump

" The cursor jupms to the last position before the file closed!
autocmd BufWinLeave *.* mkview

" Don't load view if GUI isn't running
if has("gui_running")
	autocmd BufWinEnter *.* silent loadview
endif

" }}}

"------------------------------------------------------------------------------
" {{{   7) Text input

" Enable the entering of digraphs in Insert mode with {char1} <BS> {char2}
" (List: ":dig<CR>")
" (TIPP: define special Digraph - ":digraphs CHARCODE1 CHARCODE2 RESULTCODE")
"set digraph

" tildeop: The tilde command "~" behaves like an operator.
" notildeop: The tilde (~) is not an operator (Ex.: ~w = WORT)
"set notildeop

" Make "Insert Mode" as standard
" ("Almost Modeless Editing" - CTRL-O to execute one Normal mode command)
"set insertmode

" Change Backspace <BS> and Delete <DEL> (DON'T DO IT!)
":fixdel

" When you are typing text in Insert mode the characters are inserted directly
" When in command mode the 'langmap' option takes care of translating these
" special characters to the original meaning of the key
" See ":help langmap"!
"set langmap=...

" Setting this option to a valid keymap name has the side effect of setting
" 'iminsert' to one, so that the keymap becomes effective.
"set keymap=...

" Inserting characters in Insert mode will work backwards (NEVER!)
" (SET 'paste' -> 'norevins')
"set revins

" Allow CTRL-_ in Insert and Command-line mode.
"set allowrevins

" Put Vim in "Paste Mode".
" This option is reset when starting the GUI. Setting 'paste' in the GUI has
" side effects: e.g., the Paste toolbar button will no longer work in
" Insert mode, because it uses a mapping.
" When the 'paste' option is switched on (also when it was already on):
" 'paste' -> 'textwidth=0'
" 'paste' -> 'wrapmargin=0'
" 'paste' -> 'noautoindent'
" 'paste' -> 'nosmartindent'
" 'paste' -> 'nocindent'
" 'paste' -> 'softtabstop=0'
" 'paste' -> 'nolisp'
" 'paste' -> 'norevins'
" 'paste' -> 'noruler'
" 'paste' -> 'noshowmatch'
" 'paste' -> 'formatoptions=<LEER>'
"set nopaste
set pastetoggle=<F10>

" Insert two spaces after a '.', '?' and '!' with a join command.
" When 'cpoptions' includes the 'j' flag, only do this after a '.'.
"set nojoinspaces

" Specifies details about changing the case of letters.
"set casemap=internal,keepascii

" This defines what bases Vim will consider for numbers when using the
" CTRL-A and CTRL-X commands for adding to and subtracting from a number
" respectively
set nrformats=alpha,octal,hex

" }}}

"------------------------------------------------------------------------------
" {{{   8) File format and backups

" Byte Order Mark (BOM)
set nobomb

" Identify the file formats (Syntax Highlighting, auto commands etc.)
filetype plugin indent on

" Actual file format (Syntax-Coloring etc.)
"set filetype=vim

" Identify the file formats and give the end-of-line (<EOL>) formats
set fileformats=unix,dos,mac     " WARNING: ffs with "s"
"set fileformat=                 " WARNING: no "s": automatic

" Make a backup before overwriting a file (file name + "~")
if has("vms")
    set nobackup
else
    set backup
endif

"set nobackup

" If '~/tmp' directory not exists, then create it!
silent execute '!mkdir -p ~/tmp'

" Create 'backup' directory in '~/tmp' to backup the files
if $BACKUPDIR == ""
    let $BACKUPDIR = expand("$HOME/tmp/backup")
    if !isdirectory(expand("$BACKUPDIR"))
        call mkdir(expand("$BACKUPDIR"), "p", 0700)
    endif
endif

set backupcopy=auto       " When writing a file and a backup is made (Link, UNIX)
set backupdir=$BACKUPDIR  " Backup directory
"set backupext=~          " Extension of backup files (Suffix) (Ex.: ".bak")
set backupskip=/tmp/*,/var/tmp/*  " Make no backup files in this directories
"set patchmode=.org       " Make 'file' to 'file.org' if this file has been changed
"set writebackup          " Make a backup before overwriting a file. The backup
                          " is removed after the file was successfully written
"set nowritebackup

" List of directory names for undo files
try
    if has("win32")
        set undodir=C:\Windows\Temp
    else
        set undodir=~/tmp
    endif

    " Vim automatically saves undo history to an undo file when writing a buffer
    " to a file, and restores undo history from the same file on buffer read
    set undofile
catch
endtry

" The commands that move through the buffer list
set hidden

" Add always the end-of-file <EOF> into the last row (!!)
" ('noendofline' only 'binary')
" 'textwidth'     -> 0
" 'wrapmargin'    -> 0
" 'nomodeline'
" 'noexpandtab'   " don't use the blank spaces, only tabs
set endofline
set expandtab     " use always blank spaces for tabs

" Switch off the binary mode (:h xxd -> help for more)
" (No change in last row, Option -b)
set nobinary

" Specify the character encoding used in the scripts
scriptencoding utf-8

" Specify the character encoding used in opened files
if v:lang =~ "utf8$" || v:lang =~ "UTF-8$"
    set fileencodings=utf-8,latin1
endif

" Specify the character encoding used in NEW files
"set fileencoding=iso-8859-15
"setglobal fileencoding=iso-8859-15

" Use UTF-8 character encoding for terminal
"set termencoding=utf-8
if (&term =~ "xterm") && (&termencoding == "")
    set termencoding=utf-8
endif

" Intern encoding in Vi
"set encoding=iso-8859-15
set encoding=utf-8
try
    lang en_us
"    lang de_DE
"    lang tr_TR
catch
endtry

" Spell
if version >= 700
    set spelllang=en,de
"    set spelllang=de_at,en,tr
endif

au FileType text,markdown,rst setlocal spell spelllang=en_us
"au FileType text,markdown,rst setlocal spell spelllang=de_DE   " Deutsch
"au FileType text,markdown,rst setlocal spell spelllang=        " Türkçe

" }}}

"------------------------------------------------------------------------------
" {{{   9) Search and Replace

" Searches wrap around the end of the file
set wrapscan

" Ignore case in search patterns
set ignorecase

" Override the 'ignorecase' option if the search pattern contains
" upper case characters
set smartcase

" (:nohlsearch 'invhls' isaretle, 'invhls' tersine cevir!)
" :highlight IncSearch term=reverse cterm=reverse
" :highlight Search    term=reverse ctermfg=0 ctermbg=3
set hlsearch
set incsearch

" When on, the ":substitute" flag 'g' is default on.
" This means that all matches in a line are substituted instead of one.
"set gdefault

" Changes the special characters that can be used in search patterns (in
" Regular Expression)
" (\v       \m       \M       \V         matches
"         magic   nomagic
"  $        $        $        \$         end-of-line
"  .        .        \.       \.         any character
"  *        *        \*       \*         any number of previous atom
"  ()       \(\)     \(\)     \(\)       grouping
"  |        \|       \|       \|         alternatives
"  \a       \a       \a       \a         alphabetic character
"  \\       \\       \\       \\         literal backslash
"  \.       \.       .        .          literal dot
"  \{       {        {        {          literal '{'
"  a        a        a        a          literal 'a'
" (\v very m:   .  [  ]  ^  $  *  +  ?  =  (  )  {  }  |  & \\ (all but "0-9a-zA-Z_" have special meaning)
"  \m magic:    .  [  ]  ^  $  * \+ \?  = \( \) \{ \} \| \& \\ (some have special meaning)
"  \M nomagic: \. \[ \] \^ \$ \* \+ \? \= \( \) \{ \} \| \& \\
"  \V very nm: \. \[ \] \^ \$ \* \+ \? \= \( \) \{ \} \| \& \\ (only backslash has special meaning)
"set nomagic
set magic

" Accept Space, / and ? to search in file
map <space> /
map <c-space> ?
map <silent> <leader><cr> :noh<cr>

" }}}

"------------------------------------------------------------------------------
" {{{   10) Tabs (<TAB>, <CTRL-i>)

" Number of spaces that a <Tab> in the file counts for (Ex.: 4 or 8)
"set tabstop=8
set tabstop=4

" 'autoindent', 'cindent', ">>" ve "<<"
" Number of spaces to use for each step of (auto)indent.
"set shiftwidth=8
set shiftwidth=4

" Round indent to multiple of 'shiftwidth'.  Applies to > and <	commands.
set shiftround

" Number of spaces that a <Tab> counts for while performing editing operations,
" like inserting a <Tab> or using <BS>.
" Tab-Stop (Use: SPACE + TAB)
" SET 'paste' -> 'softtabstop=0'
set softtabstop=4

" Maximum number of tab pages to be opened by the -p command line argument
" or the ":tab all" command.
"set tabpagemax=55

" The value of this option specifies when the line with tab page labels will
" be displayed:
"   0: never
"   1: only if there are at least two tab pages
"   2: always
"set showtabline=2

" When on, a <Tab> in front of a line inserts blanks according to 'shiftwidth'.
" 'tabstop' or 'softtabstop' is used in other places.
set smarttab

" }}}

"------------------------------------------------------------------------------
" {{{   11) Programming (General)

" When a bracket "(){}[]" is inserted, briefly jump to the matching one.
" 'paste' -> 'noshowmatch'
"set noshowmatch
"set showmatch

" Characters that form pairs.  The "%" command jumps from one to the other.
" EGZOTIK: :au FileType c,cpp,java set mps+==:;
" TEST: [((([[[(((<<<((()))>>>)))]]])))]
set matchpairs=
set mps=(:)
set mps+=[:]
set mps+={:}
set mps+=<:>

" Tenths of a second to show the matching paren, when 'showmatch' is set.
set matchtime=2

" This is a sequence of letters which describes how automatic formatting
" is to be done (with "gq", see :h fo-table)
"   t:	Auto-wrap text using textwidth
"   c:	Auto-wrap comments using textwidth, inserting the current comment
"       leader automatically.
"   q	Allow formatting of comments with "gq".
"   r	Automatically insert the current comment leader after hitting
"       <Enter> in Insert mode.
"   v	Vi-compatible auto-wrapping in insert mode: Only break a line at a
"       blank that you have entered during the current insert command.
" 'paste' -> 'formatoptions=<BOS>'
" (Vim Standart: tcq, Vi-Std: vt)
"set formatoptions=tcqr
"set formatoptions=tcq
"set formatoptions+=2
"set formatoptions+=1

" The name of an external program that will be used to format the lines
" selected with the 'gq' operator. (use blank for "intern")
"set formatprg=/usr/bin/fmt

" Expression which is evaluated to format a range of lines for the "gq"
" operator or automatic formatting (see 'formatoptions').
"set formatexpr=

" External program to use for "=" command. (use blank for "intern" function)
"set equalprg=

" Program to use for the ':grep' command.  This option may contain '%'
" and '#' characters, which are expanded like when used in a command-line.
" The placeholder "$*" is allowed to specify where the arguments will be
" included.
"set grepprg=grep -n $* /dev/null
"set grepprg=grep\ -nH\ $*

" Format to recognize for the ":grep" command output.
"grepformat=%f:%l:%m,%f:%l%m,%f  %l%m

" Program to use for the ":make" command. (Ex.: cmake, rmake etc.)
"set makeprg=make

" The 'errorformat' option specifies a list of formats that are recognized.
"   :help errorformat
"errorformat=%f:%l:%m,%f:%l%m,%f  %l%m

" Name of the errorfile for the ':make' command (see ':make_makeprg') and
" the ':grep' command.
"set makeef=/tmp/vim##.err

" Name of the errorfile for the QuickFix mode (see ':cf').
"set errorfile=errors.err

" A pattern that is used to recognize a list header.  This is used for
" the "n" flag in 'formatoptions'.
"set formatlistpat=^\s*\d\+[\]:.)}\t ]\s*

" (<CTRL-t> 1 to add, <CTRL-D> 1 to delete)
" 'paste' -> 'noautoindent'
" 'paste' -> 'nosmartindent'
" (Quality: autoindent -> smartindent -> cindent)
"set noautoindent        "
"set autoindent
"set nosmartindent       " 'cindent' -> 'nosmartindent'
"set smartindent

" Expression which is evaluated to obtain the proper indent for a line.
"set indentexpr=c

" Copy the structure of the existing lines indent when autoindenting
" a new line, or not!
set nocopyindent

" When changing the indent of the current line, preserve as much of the indent
" structure as possible.
set nopreserveindent

" A comma separated list of strings that can start a comment line.
" (See format-comments)
"set comments=s1:/*,mb:*\end{x:*/,://\begin{:#,:%,:XCOMM,n:>,fb:- ???

" }}}

"------------------------------------------------------------------------------
" {{{   12) Syntax and Colors

" When this option is set, the syntax with this name is loaded,
" unless syntax highlighting has been switched off with ":syntax off".
"set syntax=vim

" Syntax on/off
"syntax off     " off
"syntax on      " on, and load the personal syntax rules
syntax enable   " on, but don't load the personal syntax rules

" colorscheme = Syntax colors (in the "$VIMRUNTIME/colors/*"):
" Predefined colors to see (www.vim.org has many colors!)
"           Quality Background  Pre-defines
" -------------------------------------------------------
"   blue       ---  Dark Blue    High Contrast
"   darkblue   +++  Black        Low Contrast
"   default    +++  White        Low Contrast
"   delek      +++  White        High Contrast
"   desert     ---  White        Low Contrast
"   elflord    ---  White        High Contrast
"   evening    ---  Black        High Contrast
"   koehler    ---  White        High Contrast
"   morning    ---  Rose         Low Contrast
"   murphy     ---  Black        High Contrast
"   pablo      ---  White        Black
"   peachpuff  +++  White        Brown
"   ron        ---  White        High Contrast
"   shine      +++  Rose         High Contrast
"   slate      +++  White        High Contrast
"   torte      ---  Black        Middle Contrast
"   zellner    +++  White        High Contrast
" (TIP: See the all of the list with ":colo <TAB>")
if has("gui_running")
    set t_Co=256
    try
        "colorscheme gruvbox
        "colorscheme solarized
        colorscheme PaperColor
    catch
        ":echo "default colorscheme will be used!"
        "colorscheme koehler
        colorscheme PaperColor
    endtry
else
    set t_Co=256
    try
        "colorscheme risto
        "colorscheme gruvbox
        colorscheme PaperColor
    catch
        ":echo "default colorscheme will be used!"
        colorscheme elflord
    endtry
endif

" Brightness of background ("dark" or "light")
set background=dark

" Maximum column in which to search for syntax items.  In long lines the
" text after this column is not highlighted and following lines may not
" be highlighted correctly, because the syntax state is cleared.
" (Standard: 3000)
"if v:version >= 700
"       set synmaxcol=500
"endif

" This option can be used to set highlighting mode for various occasions.
" (See ":h highlight")
"set highlight=KEY:GROUP,...
"set highlight=8:SpecialKey,@:NonText,d:Directory,e:ErrorMsg,i:IncSearch,l:Search,m:MoreMsg,M:ModeMsg,n:LineNr,r:Question,s:StatusLine,S:StatusLineNC,c:VertSplit,t:Title,v:Visual,V:VisualNOS,w:WarningMsg,W:WildMenu,f:Folded,F:FoldColumn,A:DiffAdd,C:DiffChange,D:DiffDelete,T:DiffText,>:SignColumn,B:SpellBad,P:SpellCap,R:SpellRare,L:SpellLocal,+:Pmenu,=:PmenuSel,x:PmenuSbar,X:PmenuThumb,*:TabLine,#:TabLineSel,_:TabLineFill,!:CursorColumn,.:CursorLine

" }}}

"------------------------------------------------------------------------------
" {{{   13) Personal rules for syntax

" Colorize the statements with "dark blue" instead of "yellow"
"hi statement ctermfg=darkblue guifg=darkblue

" Colorize the identifier with "black" instead of "yellow"
"hi identifier ctermfg=black guifg=black

" "xterm-color" for cterm colors
"   ctermfg             ctermbg
" ---------------------------------------
"   0 = black           0 = black
"   1 = brown           1 = brown
"   2 = dark green      2 = dark green
"   3 = yellow          3 = yellow
"   4 = blue            4 = blue
"   5 = purple          5 = purple
"   6 = turquoise       6 = turquoise
"   7 = gray            7 = gray
"   8 = black           8 = white
"
" Colors of GUI
"   White    Black         Brown
"   Orange   Purple        Violet
"   SeaGreen SlateBlue
"   Gray     LightGray     DarkGray
"   Grey     LightGrey     DarkGrey
"   Yellow   LightYellow   DarkYellow
"   Red      LightRed      DarkRed
"   Green    LightGreen    DarkGreen
"   Blue     LightBlue     DarkBlue
"   Cyan     LightCyan     DarkCyan
"   Magenta  LightMagenta  DarkMagenta
"
" Some syntax groups:
"   Comment    = ???
"   Constant   = ???
"   Identifier = ???
"   Statement  = ???
"   PreProc    = ???
"   Type       = ???
"   Special    = ???
"   Underlined = ???        ???
"   Ignore     = ???
"   Error      = ???
"   Todo       = ???
"
" Dark Background:
" SynColor Comment    term=bold      cterm=NONE ctermfg=Cyan ctermbg=NONE gui=NONE guifg=#80a0ff guibg=NONE
" SynColor Constant   term=underline cterm=NONE ctermfg=Magenta ctermbg=NONE gui=NONE guifg=#ffa0a0 gu
" SynColor Special    term=bold      cterm=NONE ctermfg=LightRed ctermbg=NONE gui=NONE guifg=Orange guibg=N
" SynColor Identifier term=underline cterm=bold ctermfg=Cyan ctermbg=NONE gui=NONE guifg=#40ffff g
" SynColor Statement  term=bold      cterm=NONE ctermfg=Yellow ctermbg=NONE gui=bold guifg=#ffff60 guib
" SynColor PreProc    term=underline cterm=NONE ctermfg=LightBlue ctermbg=NONE gui=NONE guifg=#ff80ff
" SynColor Type       term=underline cterm=NONE ctermfg=LightGreen ctermbg=NONE gui=bold guifg=#60ff60
" hi       type       term=underline cterm=NONE ctermfg=Green ctermbg=NONE gui=bold guifg=#60ff60
" hi       identifier term=underline cterm=NONE ctermfg=Yellow ctermbg=NONE gui=bold guifg=#60ff60
" SynColor Underlined term=underline cterm=underline ctermfg=LightBlue gui=underline guifg=#80a0ff
" SynColor Ignore     term=NONE      cterm=NONE ctermfg=black ctermbg=NONE gui=NONE guifg=bg guibg=NONE
" SynColor Error      term=reverse   cterm=NONE ctermfg=White ctermbg=Red gui=NONE guifg=White guibg=Red
" SynColor Todo       term=standout  cterm=NONE ctermfg=Black ctermbg=Yellow gui=NONE guifg=Blue guibg=
"
" Light Background:
" SynColor Comment    term=bold      cterm=NONE ctermfg=DarkBlue ctermbg=NONE gui=NONE guifg=Blue guibg=NON
" SynColor Constant   term=underline cterm=NONE ctermfg=DarkRed ctermbg=NONE gui=NONE guifg=Magenta gu
" SynColor Special    term=bold      cterm=NONE ctermfg=DarkMagenta ctermbg=NONE gui=NONE guifg=SlateBlue g
" SynColor Identifier term=underline cterm=NONE ctermfg=DarkCyan ctermbg=NONE gui=NONE guifg=DarkC
" SynColor Statement  term=bold      cterm=NONE ctermfg=Brown ctermbg=NONE gui=bold guifg=Brown guibg=N
" SynColor PreProc    term=underline cterm=NONE ctermfg=DarkMagenta ctermbg=NONE gui=NONE guifg=Purple
" SynColor Type       term=underline cterm=NONE ctermfg=DarkGreen ctermbg=NONE gui=bold guifg=SeaGreen
" hi       type       term=underline cterm=NONE ctermfg=LightGreen ctermbg=NONE gui=bold guifg=SeaGreen
" SynColor Underlined term=underline cterm=underline ctermfg=DarkMagenta gui=underline guifg=Slate
" SynColor Ignore     term=NONE      cterm=NONE ctermfg=white ctermbg=NONE gui=NONE guifg=bg guibg=NONE
" SynColor Error      term=reverse   cterm=NONE ctermfg=White ctermbg=Red gui=NONE guifg=White guibg=Red
" SynColor Todo       term=standout  cterm=NONE ctermfg=Black ctermbg=Yellow gui=NONE guifg=Blue guibg=
"

"hi Cursor       term=reverse cterm=NONE ctermfg=NONE ctermbg=7 gui=NONE guifg=NONE guibg=NONE
"hi CursorLine   term=reverse cterm=NONE ctermfg=NONE ctermbg=7 gui=NONE guifg=NONE guibg=NONE
"hi CursorColumn term=reverse cterm=NONE ctermfg=NONE ctermbg=7 gui=NONE guifg=NONE guibg=NONE
if version >= 500
        highlight Cursor guibg=Green guifg=NONE           " green cursor!
        "highlight iCursor guifg=white guibg=steelblue
endif

" }}}

"------------------------------------------------------------------------------
" {{{   14) Folding

" Disable folding
set nofoldenable

" Enable folding
"set foldenable

" When non-zero, a column with the specified width is shown at the side of the
" window which indicates open and closed folds.
"set foldcolumn=2
set foldcolumn=0

" Folding method (manual, indent,  expr, marker, syntax, diff)
" (Std: manual, 'expr' -> 'foldexpr', 'marker' -> 'foldmarker')
set foldmethod=syntax
"set foldmethod=marker

" If foldmethod is expr
set foldexpr=0

" The start and end marker used when 'foldmethod' is "marker".
set foldmarker={,}

" Quick folding
"set foldopen=all       " Std: block,hor,mark,percent,quickfix,search,tag,undo set
"foldclose=all          " Std: blank

" Ignore the folding: Used only when 'foldmethod' is "indent".
set foldignore=#

function! FoldText()
   return substitute(getline(v:foldstart), '{.*', '{...}', '')
endfunction
set foldtext=FoldText()
"set foldtext=foldtext()

" Template for a comment
"set commentstring=#%s

" }}}

"------------------------------------------------------------------------------
" {{{   15) Mouse

" Activate the cursor to controle with mouse
"       n       Normal mode
"       v       Visual mode
"       i       Insert mode
"       c       Command-line mode
"       h       all previous modes when editing a help file
"       a       all previous modes
"       r       for hit-enter and more-prompt prompt
if has('mouse')
        set mouse=a
endif
"set mouse=h

" The window that the mouse pointer is on is automatically activated.
set mousefocus

" GUI: When on, the mouse pointer is hidden when characters are typed.
set mousehide

" Sets the model to use for the mouse
" extend        Right mouse button extends a selection. This works like in an
"               xterm.
"
" popup         Right mouse button pops up a menu. The shifted left mouse
"               button extends a selection.
"
" popup_setpos  Like "popup", but the cursor will be moved to the position
"               where the mouse was clicked, and thus the selected operation
"               will act upon the clicked object.
"
set mousemodel=popup
"set mousemodel=extend

" GUI: Appearance of mouse
"set mouseshape=

" Defines the maximum time in msec between two mouse clicks for the second
" click to be recognized as a multi click. (Ex.: 500 ms)
set mousetime=250

" GUI: Selection: This option defines the behavior of the selection.
"                 :behave mswin   :behave xterm
"set selectmode=   mouse,key       (empty)      " cmd = Mouse, Shifted-Cursor, v/V/<CTRL-v>
"set mousemodel=   popup           extend       " popup, extend
"set   keymodel=   startsl,stopsel  (empty)     " startsel, stopsel
"set  selection=   exclusive       inclusive    " old, inclusive, exclusive
"set selection=    inclusive

" Specifie when to start Select mode instead of Visual mode.
"       mouse   when using the mouse
"       key     when using shifted special keys
"       cmd     when using "v", "V" or CTRL-V
"set selectmode=...

" Enable special things that keys can do.
" (<LEFT> <RIGHT> <UP> <DOWN> <END> <HOME> <PAGEUP> <PAGEDOWN>)
"       startsel        Using a shifted special key starts selection (either
"                       Select mode or Visual mode, depending on "key" being
"                       present in 'selectmode').
"
"       stopsel         Using a not-shifted special key stops selection.
"
"set keymodel=...

" }}}

"------------------------------------------------------------------------------
" {{{   16) Printing (:hardcopy or :hardcopy!)

" Printer device (Ex.: Standard Printer)
"set printdevice=

" Expression used to print the PostScript produced with ':hardcopy'.
"set printexpr=system('lpr' . v:fname_in)

" Options of printing
" left:NN    = left margin (Std: 10pc, "in/pt/mm")
" right:NN   = right margin (Std: 5pc, "in/pt/mm")
" top:NN     = top margin (Std: 5pc, "in/pt/mm")
" bottom:NN  = bottom margin (Std: 5pc, "in/pt/mm")
" header:Z   = number of lines to reserve for the header (Std: 2, 0=don't print)
" syntax:F   = use ot don't use syntax highlighting
" number:F   = include line numbers in the printed output, or don't
" wrap:F     = wrapping (y=wrap long lines, n=truncate long lines)
" duplex:TYP = print on one side
" collate:F  = collating (Std: y=123 123, n=111 222)
" jobsplit:F = co all copies in one print job (Std: y)
" portrait:F = orientation is portrait (Std: y=Portrait, n=Landspace)
" paper:TYP  = paper size (Std: A4)
" formfeed:F = treat form feed characters (0x0c) as a normal print character.
set printoptions=left:5pc       " left margin 5 char
set popt+=right:5pc             " right margin 5 carakter
set popt+=top:4pc               " top margin 4 carakter
set popt+=bottom:4pc            " bottom margin 4 carakter
set popt+=header:2              " header 2 carakter
set popt+=syntax:n              " syntax on (print with syntax colors)
set popt+=number:y             " include number of lines
set popt+=wrap:y                " wrap long lines
set popt+=duplex:y              " print on both sides (when possible)

" Font (Courier New 8 pt., analog 'guifont')
set printfont=courier_new:h8

" Header ('statusline')
set printheader=%<%f%h%m%=Page\ %N

" Coding
"set printencoding=

" }}}

"------------------------------------------------------------------------------
" {{{   17) Authorization

" Allows writing files
"set write

" Allows writing to any file with no need for "!" override.
"set writeany

" When a file has been detected to have been changed outside of Vim and it has
" not been changed inside of Vim, automatically read it again.
set autoread

" Write the contents of the file, if it has been modified, on each :next,
" :rewind, :last, :first, :previous, :stop, :suspend, :tag, :!, :make, CTRL-]
" and CTRL-^ command; and when a :buffer, CTRL-O, CTRL-I, '{A-Z0-9}, or
" `{A-Z0-9} command takes one to another file
set autowrite

" Like 'autowrite', but also used for commands ":edit", ":enew", ":quit",
" ":qall", ":exit", ":xit", ":recover" and closing the Vim window.
set autowriteall

" If on, writes fail unless you use a '!'.  Protects you from accidentally
" overwriting a file.
"set readonly

" When off the buffer contents cannot be changed.
"set nomodifiable

" When on, the buffer is considered to be modified.
"set modified

" Write quickly
nmap <leader>w :w!<cr>
command! W w
command! Wa wa

" Save all temp files with <CTRL-q> and quit from Vi.
nmap  <C-q>    :wqa<CR>

" Automatic load if "vimrc" file changed.
if has("win32")
    " save ".vimrc" quickly if it changed
    map <leader>e :e! ~/_vimrc<cr>

    " Load new ".vimrc" if it changed
    autocmd! bufwritepost vimrc source ~/_vimrc
else
    " save ".vimrc" quickly if it changed
    "map <leader>e :e! ~/.vimrc<cr>

    augroup VimConfig
        au!
        autocmd BufWritePost vimrc.vim  so ~/.vim/vimrcs/vimrc.vim
"       autocmd BufWritePost vim        so ~/.vimrc
    augroup END

    " Load new ".vimrc" if it changed
    "autocmd! BufWritePost vimrc source ~/vimrc
endif

" Which directory to use for the file browser:
"       last            Use same directory as with last file browser, where a
"                       file was opened or saved.
"       buffer	        Use the directory of the related buffer.
"       current	        Use the current directory.
"       {path}          Use the specified directory
set browsedir=current

" When on, Vim will change the current working directory whenever you open
" a file, switch buffers, delete a buffer or open/close a window.
" It will change to the directory containing the file which was opened
" or selected.
" Note: When this option is on some plugins may not work!
"set autochdir

" }}}

"------------------------------------------------------------------------------
" {{{   18) Shell

" Name of the shell to use for ! and :! commands.

let s:uname = system("uname -s")
if s:uname == "Darwin\n"
    set shell=/bin/bash\ --login\ -norc\ -noprofile
    "set shell=/bin/bash\ -norc
elseif s:uname == "Linux\n"
    set shell=/bin/bash\ --login\ -norc\ -noprofile
elseif s:uname == "FreeBSD\n"
    set shell=/bin/sh             " Pre-defined shell is "sh" in FreeBSD!
elseif s:uname == "OpenBSD\n"
    set shell=/bin/sh             " Use Pre-defined shell is "sh" in OpenBSD!
elseif s:uname == "NetBSD\n"
    set shell=/bin/sh             " Pre-defined shell is "sh" in NetBSD!
endif

" Flag passed to the shell to execute "!" and ":!" commands.
" (Ex.: "bash.exe -c ls" or "command.com /c dir")
"set shellcmdflag=-c

" Create "Pipe"
"set shellpipe=2>&1| tee

" Quoting character(s), put around the command passed to the shell, for the
" "!" and ":!" commands.
"set shellquote=

" Quoting character(s), put around the command passed to the shell, for the
" "!" and ":!" commands.
"set shellxquote=

" String to be used to put the output of a filter command in a temporary file.
"set shellredir=>%s 2>&1

" When on, use temp files for shell commands.  When off use a pipe.
"set shelltemp=

" When set, a forward slash is used when expanding file names. This is useful
" when a Unix-like shell is used instead of command.com or cmd.exe.
set shellslash

" Without argument this only detects the screen size and redraws the screen.
" With MS-DOS it is possible to switch screen mode.
" MSDOS: Screen Mod (B80, B40, c80, c40, ...)
":mode MODE

" }}}

"------------------------------------------------------------------------------
" {{{   19) Tags

" Show all tags (Tag + Definition)
set showfulltag

" Length of tag: If non-zero, tags are significant up to this number of
" characters.
set taglength=0

" Filenames for the tag command, separated by spaces or commas (to search)
"set tags=~/.vim/doc/,~/.vim/doc/tags,./tags,./TAGS,tags,TAGS

" If on and using a tags file in another directory, file names in that tags
" file are relative to the directory where the tags file is.
"set tagrelative

" }}}

"------------------------------------------------------------------------------
" {{{   20) Swapping

" Use a swapfile for the buffer.
set swapfile
"set noswapfile      " don't use swapfile

" Create directory for swapfiles
if $SWAPDIR == ""
        let $SWAPDIR = expand("$HOME/tmp/swap")
        if !isdirectory(expand("$SWAPDIR"))
                call mkdir(expand("$SWAPDIR"), "p", 0700)
        endif
endif

" List of directory names for the swap file, separated with commas.
set directory=$SWAPDIR

" Filenames are assumed to be 8 characters plus one extension of 3 characters.
"set shortname

" After typing this many characters the swap file will be written to disk.
" When zero, no swap file will be created at all.
set updatecount=200

" If this many milliseconds nothing is typed the swap file will be written to
" disk (see crash-recovery). (Ex.: 4000)
set updatetime=10000

" When on, the library function fsync() will be called after writing a file.
" This will flush a file to disk, ensuring that it is safely written even on
" filesystems which do metadata-only journaling. (Secure!)
if v:version >= 700
        set fsync
endif

" When this option is not empty a swap file is synced to disk after
" writing to it.
set swapsync=fsync

" Control the behavior when switching between buffers.
"       useopen         If included, jump to the first open window that contains
"                       the specified buffer (if there is one).
"       usetab          Like "useopen", but also consider windows in other tab
"                       pages.
"       split           If included, split the current window before loading a
"                       buffer for a quickfix command that display errors.
"       newtab          Like "split", but open a new tab page.  Overrules
"                       "split" when both are present.
try
        set switchbuf=usetab
        set stal=2      " showtabline
catch
endtry

" }}}

"------------------------------------------------------------------------------
" {{{   21) GUI

" List of fonts which will be used for the GUI version of Vim.
"set guifont=...
"set guifont=*
"set guifontwide=...

if has("win32")
        set guifont=Bitstream\ Vera\ Sans\ Mono:h10
else
        if s:uname == "Darwin\n"
                set guifont=Courier_New:h12
                "set guifont=Monokai:h11
                if has("gui_macvim")
                        "set transparency=5
                        set fuoptions=maxvert,maxhorz
                        "au GUIEnter * set fullscreen
                endif
        elseif s:uname == "Linux\n"
                set guifont=Courier\ New\ 10
        else    " FreeBSD, OpenBSD, and NetBSD
                set guifont=Courier\ New\ 10
    endif
endif

" GUI: Cursor
"   n:FORM  = Normal Mod
"   v:FORM  = Visual Mod
"   ve:FORM = Visual Mod ('selection'=exclusive)
"   c:FORM  = Command Line Mod
"   o:FORM  = Operator-pending Mod
"   i:FORM  = Insert Mod
"   r:FORM  = Replace Mod
"   ci:FORM = Command-line Insert Mod
"   cr:FORM = Command-line Replace Mod
"   sm:FORM = Showmatch in Insert Mod
"   a:FORM  = All Mods
"
" FORM
"   hor{N}       = horizontal bar, {N} percent of the character height
"   ver{N}       = vertical bar, {N} percent of the character width
"   block        = block cursor, fills the whole character
"   blinkwait{N} = cursor-blinking
"   blinkon{N}   = Blinking on
"   blinkoff{N}  = Blinking off
"   {group-name} = A highlight group name
"   {group-name}/{group-name} = Two highlight group names, the first is used
"                               when no language mappings are used, the other
"                               when they are.
"set guicursor=n-c-v:block-nCursor
"set guicursor=i-ci:ver30-iCursor-blinkwait300-blinkon200-blinkoff150
set guicursor=n-v-c:block,o:hor50,i-ci:hor15,r-cr:hor30,sm:block

" The number of pixels subtracted from the screen height when fitting the GUI
" window on the screen.
"set guiheadroom=...

" GUI: It is a sequence of letters which describes what components and options
" of the GUI should be used.
"   a=Autoselect
"   m=Menu
"   T=Toolbar
"set guioptions=aegimrLtT
"set guioptions+=a

" Only in the GUI: If on, an attempt is made to open a pseudo-tty for I/O
" to/from shell commands.
"set guipty

" When nonempty describes the text to use in a label of the GUI tab pages line.
"set guitablabel=%t

" When nonempty describes the text to use in a tooltip for the GUI tab pages line.
"set guitabtooltip

" GUI: Use "System Clipboard" for unnamed registers
"   unnamed     = "Unnamed Register" -> "System Clipboard"
"   autoselect  = "Visual Mode Selection" -> "System Clipboard"
set clipboard=unnamed

" GUI: The contents of this option controls various toolbar settings. The
" possible values are:
" (only for +GUI_GTK, +GUI_Athena, +GUI_Motif, +GUI_Photon and gui_macvim)
"		icons		Toolbar buttons are shown with icons.
"		text		Toolbar buttons shown with text.
"		horiz		Icon and text of a toolbar button are
"					horizontally arranged.  {only in GTK+ 2 GUI}
"		tooltips	Tooltips are active for toolbar buttons.
"if has("gui_macvim") || has("gui_gtk") || has("gui_gtk2")
"  set toolbar=icons,tooltips
"endif

" GUI: Controls the size of toolbar icons.  The possible values are:
"       tiny    Use tiny toolbar icons.
"       small   Use small toolbar icons (default).
"       medium  Use medium-sized toolbar icons.
"       large   Use large toolbar icons.
if has("gui_gtk") || has("gui_gtk2")
  set toolbariconsize=medium
endif

if has("gui_running")
    "set langmenu=de_DE.ISO_8859_15
    set langmenu=en_US.UTF-8
    setlocal lines=50
"    autocmd FileType * setlocal columns=90
    setlocal columns=95
    set guioptions-=T
    set guioptions="agimrLt"
    set guioptions+=c
endif

" }}}

"------------------------------------------------------------------------------
" {{{   22) Keywords

" Keywords are used in searching and recognizing with many commands
" (Ex.:"w", "b", "e", "ge")
set iskeyword=@,48-57,_,192-255       "  For example: äöüÄÖÜß
set isk+=.
set isk+=:
set isk+=-
set isk+=$
set isk+=@-@            "  for "@" !

" The characters given by this option are included in identifiers. (Ex.: "[d")
"set isident=@,48-57,_,192-255

" The characters specified by this option are included in file names and path
" names. (Ex.: "gf")
"set isfname=@,48-57,/,.,-,_,+,,,#,$,%,~,=

" The characters given by this option are displayed directly on the screen.
" (Ex.: "\p")
"set isprint=@,161-255

" }}}

"------------------------------------------------------------------------------
" {{{   23) Pages

" Minimal number of lines for the current window.
set winheight=1

" Minimal number of columns for the current window.
set winwidth=1

" The minimal height of a window, when it's not the current window.
set winminheight=1

" The minimal width of a window, when it's not the current window.
set winminwidth=1

" Keep the window height when windows are opened or closed and
" 'equalalways' is set.
"set winfixheight

"Keep the window width when windows are opened or closed and
" 'equalalways' is set.
"set winfixwidth

" When on, all the windows are automatically made the same size after
" splitting or closing a window.
"set equalalways

" Tells when the 'equalalways' option applies:
"   ver         vertically, width of windows is not affected
"   hor         horizontally, height of windows is not affected
"   both        width and height of windows is affected
"set eadirection=

" :split
" When on, splitting a window will put the new window below the current one.
"set splitbelow

" :vsplit
" When on, splitting a window will put the new window right of the current one.
"set splitright

" Default height for a preview window
" (":ptag", ":pedit" icin, CTRL-w, CTRL-w, Std: 12)
"set previewheight=12

" Identifies the preview window.  Only one window can have this option set.
"set previewwindow

" Switch windows between
" Alt+arrow Navigation
nmap <silent> <A-Up> :wincmd k<CR>
nmap <silent> <A-Down> :wincmd j<CR>
nmap <silent> <A-Left> :wincmd h<CR>
nmap <silent> <A-Right> :wincmd l<CR>

" }}}

"------------------------------------------------------------------------------
" {{{   24) Completion and Wildcard

" Character you have to type to start wildcard expansion in the command-line,
" as specified with 'wildmode'.
"set wildchar=<TAB>

" 'wildcharm' works exactly like 'wildchar', except that it is recognized when
" used inside a macro.
set wildcharm=0

" A list of file patterns. A file that matches with one of these patterns is
" ignored when expanding 'wildcards', completing file or directory names, and
" influences the result of expand(), glob() and globpath() unless a flag is
" passed to disable this.
"set wildignore=*.o,*.obj,*.aux,*.log,*.bak,*~
set wildignore+=*.swp,*.bak,*.pyc,*.pyo,*.6,*.o,*~,*.lo,*.obj,*.aux
set wildignore+=.hg,.git,.svn                    " Version control
set wildignore+=*.aux,*.out,*.toc                " LaTeX intermediate files
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg   " binary images
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest " compiled object files
set wildignore+=*.spl                            " compiled spelling word lists
set wildignore+=*.sw?                            " Vim swap files
set wildignore+=*.DS_Store                       " OS X
set wildignore+=*.luac                           " Lua byte code
set wildignore+=migrations                       " Django migrations
set wildignore+=*.pyc                            " Python byte code
set wildignore+=*.orig                           " Merge resolution files

" Files with these suffixes get a lower priority when multiple files match a
" wildcard.
"suffixes=.bak,~,.o,.h,.info,.swp,.obj
set suffixes+=.in,.a,.1,!

" Comma separated list of suffixes, which are used when searching for a file
" for the "gf", "[I", etc.
"suffixesadd=

" When 'wildmenu' is on, command-line completion operates in an enhanced mode.
" On pressing 'wildchar' (usually <Tab>) to invoke completion, the possible
" matches are shown just above the command line, with the first match
" highlighted (overwriting the status line, if there is one).
set wildmenu

" Completion mode that is used for the character specified with 'wildchar'.
"
"   ""                  Complete only the first match.
"   "full"              Complete the next full match.  After the last match, the
"                       original string is used and then the first match again.
"   "longest"           Complete till longest common string.  If this doesn't
"                       result in a longer string, use the next part.
"   "longest:full"      Like "longest", but also start 'wildmenu' if it is enabled.
"   "list"              When more than one match, list all matches.
"   "list:full"         When more than one match, list all matches and complete
"                       first match.
"   "list:longest"      When more than one match, list all matches and complete
"                       till longest common string.
"set wildmode=longest,full
set wildmode+=list:longest

" A list of words that change how command line completion is done.
"set wildoptions=

" }}}

"------------------------------------------------------------------------------
" {{{   25) Limitation

" Undo: Maximum number of changes that can be undone. (Std: 1000)
set undolevels=5000

" A history of ":" commands, and a history of previous search patterns are
" remembered.
set history=1000

" Maximum amount of memory (in Kbyte) to use for one buffer.
" When this limit is reached allocating extra memory for a buffer will cause
" other memory to be freed.
"set maxmem=517640

" Maximum amount of memory in Kbyte to use for all buffers together.
" The maximum usable value is about 2000000 (2 Gbyte).
" Use this to work without a limit.
"set maxmemtot=517640

" Maximum amount of memory (in Kbyte) to use for pattern matching.
"set maxmempattern=1000

" Maximum depth of function calls for user functions. This normally catches
" endless recursion.
"set maxfuncdepth=100

" Maximum number of times a mapping is done without resulting in a character
" to be used.
"set maxmapdepth=1000

" Parameters for :mkspell. This tunes when to start compressing the word tree.
"set mkspellmem=460000,2000,500

" Maximum number of items to use in a menu.
"set menuitems=25

" The maximum number of combining characters supported for displaying.
" Only used when 'encoding' is "utf-8".
"set maxcombine=2

" }}}

"------------------------------------------------------------------------------
" {{{   26) Terminal

" Name of the terminal.
"set term=xterm-color

" When this option is set, the screen will not be redrawn while executing
" macros, registers and other commands that have not been typed.
set nolazyredraw

" When on, the builtin termcaps are searched before the external ones.
" When off the builtin termcaps are searched after the external ones.
"set ttybuiltin

" Indicates a fast terminal connection.
set ttyfast

" Name of the terminal type for which mouse codes are to be recognized.
"set ttymouse

" Maximum number of lines to scroll the screen.
"set ttyscroll=999

" Program to use for the K command.
"set keywordprg=TERM=mostlike\ man\ -s\ -Pless

" }}}

"------------------------------------------------------------------------------
" {{{   27) Mapping

" Time for waiting
"set timeout
"set ttimeout
set timeoutlen=500
"set ttimeoutlen=1000

" Allows for mappings to work recursively.
set remap

" remap vim 0
map 0 ^

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = "-"
let g:mapleader = "-"

" Copy: CTRL-C
" Cut: CTRL-X
" Paste: CTRL-V
vmap <C-c> "+yi
vmap <C-x> "+c
vmap <C-v> c<ESC>"+p
imap <C-v> <ESC>"+pa

" CTRL-PgUp/PgDown
nmap <C-PageDown> :tabnext<CR>
nmap <C-PageUp> :tabprevious<CR>
imap <C-PageDown> :tabnext<CR>
imap <C-PageUp> :tabprevious<CR>

" Stroll between swapfiles with <Shift-R/L>
noremap <S-Left> :bprevious<CR>
noremap <S-Right> :bnext<CR>

" Spell scanning
map <leader>ss :setlocal spell!<cr>

" Linking for leader
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=

"Move a line of text using ALT+[jk] or Comamnd+[jk] on mac
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

" Use Apple-Key on Mac
if has("mac") || has("macunix")
  nmap <D-j> <M-j>
  nmap <D-k> <M-k>
  vmap <D-j> <M-j>
  vmap <D-k> <M-k>
endif

" Open a file with <CTRL-O>
map <C-O> :browse confirm e<CR>
imap <C-O> :browse confirm e<CR>

" Use the arrows to something usefull
"map <right> :bn<cr>
"map <left> :bp<cr>

" Configuration of tabular
map <leader>tn :tabnew! %<cr>
map <leader>te :tabedit
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove

" Go into the directory where is swapfile with "<leader>cd"
map <leader>cd :cd %:p:h<cr>

" Brackets
"vnoremap $1 <esc>`>a)<esc>`<i(<esc>
"vnoremap $2 <esc>`>a]<esc>`<i[<esc>
"vnoremap $3 <esc>`>a}<esc>`<i{<esc>
"vnoremap $$ <esc>`>a"<esc>`<i"<esc>
"vnoremap $q <esc>`>a'<esc>`<i'<esc>
"vnoremap $e <esc>`>a"<esc>`<i"<esc>

" Automatic completion for " (, ", ', [ "
"inoremap $1 ()<esc>i
"inoremap $2 []<esc>i
"inoremap $3 {}<esc>i
"inoremap $4 {<esc>o}<esc>O
"inoremap $q ''<esc>i
"inoremap $e ""<esc>i
"inoremap $t <><esc>i

" Automatic completion brackets in 'insert' mod
"imap ( ()<Left>
"imap [ []<Left>
"imap { {}<Left>

function! MoveLeft()
  let newpos = getpos('.')
  let newpos[2] -= 1
  if (newpos[2] < 1)
    let newpos[2] = 1
  endif
  call setpos('.', newpos)
  return ""
endfunction
"inoremap ( ()<C-R>=MoveLeft()<CR>
"inoremap [ []<C-R>=MoveLeft()<CR>
"inoremap { {}<C-R>=MoveLeft()<CR>
"inoremap " ""<C-R>=MoveLeft()<CR>

"inoremap ( ()<Left>
"inoremap [ []<Left>
"inoremap { {}<Left>
"inoremap " ""<Left>
"inoremap /*<CR>      /*<CR>*/<Esc>O
"inoremap /*<CR>      /*<CR>/<Esc>O
"inoremap /*          /**/<Left><Left>
"inoremap /*<Space>      /*<Space><Space>*/<Left><Left><Left>

" Automatic completion brackets in 'visual' mod
"vmap ( d<Esc>i(<Esc>p
"vmap [ d<Esc>i[<Esc>p
"vmap { d<Esc>i{<Esc>p

" Add a blank space after comma (,)
"imap , ,<Space>

" Remove the blank spaces from End-Of-Line
map <leader>cs :%s/\s\+$//e<CR>

" ALT + vocal -> Umlaeute
" ALT + s     -> (Deuutsch) add 'ß'
"map! <M-a> ä
"map! <M-o> ö
"map! <M-u> ü
"map! <M-s> ß
"map! <M-A> Ä
"map! <M-O> Ö
"map! <M-U> Ü

" If UTF-8 in local
"map! Ã¤ ae
"map! Ã¼ ue
"map! Ã¶ oe
"map! Ã„ Ae
"map! Ã– Oe
"map! Ãœ Ue
"map! ÃŸ ss

" }}}

"------------------------------------------------------------------------------
" {{{   28) Viminfo, Sessions and Views

" When non-empty, the viminfo file is read upon startup and written when
" exiting Vim (see viminfo-file).
"
"  '200 = Marks will be remembered for the last 200 files you edited.
"  "500 = Maximum number of lines saved for each register.
"     h = Disable the effect of 'hlsearch' when loading the viminfo file.
"    f1 = Whether file marks need to be stored.
"  :100 = Store max. 10 "ex" commands.
"  /100 = Maximum number of items in the search pattern history to be saved.
"     % = When included, save and restore the buffer list.
"     ! = When included, save and restore global variables that start with an
"         uppercase letter, and don't contain a lowercase letter.
"  n... = Name of the viminfo file. (Std: $HOME/.viminfo)
"set viminfo=\'500
"set vi+=\"500
"set vi+=h
"set vi+=f1
"set vi+=r/mnt
"set vi+=:100
"set vi+=/100
"set vi+=%
"set vi+=!
"set viminfo='20000,f1,<500,:1000,@1000,/1000,%
set viminfo="%200,'200,/800,h,<500,:500,s150,r/tmp,r"

" Changes the effect of the :mksession command.
"
"    word           save and restore ~
"    blank          empty windows
"    buffers        hidden and unloaded buffers, not just those in windows
"    curdir         the current directory
"    folds          manually created folds, opened/closed folds and local fold
"                   options
"    globals        global variables that start with an uppercase letter and
"                   contain at least one lowercase letter. Only String and
"                   Number types are stored.
"    help           the help window
"    localoptions   options and mappings local to a window or buffer (not
"                   global values for local options)
"    options        all options and mappings (also global values for local options)
"    resize         size of the Vim window: 'lines' and 'columns'
"    sesdir         the directory in which the session file is located will
"                   become the current directory (useful with projects accessed
"                   over a network from different systems)
"    slash          backslashes in file names replaced with forward slashes
"    tabpages       all tab pages; without this only the current tab page is
"                   restored, so that you can make a session for each tab page
"                   separately
"    unix           with Unix end-of-line format (single <NL>), even when on
"                   Windows or DOS
"    winpos         position of the whole Vim window
"    winsize        window sizes
"set sessionoptions=blank,buffers,curdir,folds,help,options,tabpages,winsize
set sessionoptions=blank,buffers,curdir,folds,tabpages,winsize
"set sessionoptions=winpos,localoptions

" Create directory for ":mkview"
if $VIEWDIR == ""
        let $VIEWDIR = expand("$HOME/tmp/view")
        if !isdirectory(expand("$VIEWDIR"))
                call mkdir(expand("$VIEWDIR"), "p", 0700)
        endif
endif
set viewdir=$VIEWDIR

" Changes the effect of the ":mkview" command.
"   cursor      cursor position in file and in window
"   folds       manually created folds, opened/closed folds and local fold options
"   options     options and mappings local to a window or buffer (not global
"               values for local options)
"   slash       backslashes in file names replaced with forward slashes
"   unix        with Unix end-of-line format (single <NL>), even when on
"               Windows or DOSi
"
"set viewoptions=folds,options,cursor
"set viewoptions+=options
set viewoptions+=cursor,folds,options,slash,unix

" Name of the main help file.
"set helpfile=/usr/share/vim/current/doc/help.txt

" Minimal initial height of the help window when it is opened with the ":help"
" command.
"set helpheight=20

" Comma separated list of languages.
"set helplang=de,tr
set helplang=en

" }}}

"------------------------------------------------------------------------------
" {{{   29) Movement of mouse

" <LeftMouse>   = Set the current cursor position.
" <RightMouse>  = Start Visual mode if it is not active.
" <MiddleMouse> = Put the text from a register before the cursor [count] times.
" <MouseUp>     = Move 3 lines up.
" <MouseDown>   = Move 3 lines down.
" <S-MouseUp>   = Move one page up.
" <S-MouseDown> = Move one page down.

" }}}

"------------------------------------------------------------------------------
" {{{   30) Definitions of menu
" (See $VIMRUNTIME/menu.vim)

" Show menu only in defined mods:
"   a = Normal, Visual, Operator Pending
"   n = Normal
"   v = Visual
"   o = Operator Pending
"   i = Insert
"   c = Command Line
" Special names on menu
"   ToolBar = Icons on menu
"   PopUp   = Pop-up menu when clicked mouse
":[MODE]menu [PRIORITY] ITEM COMMAND
":menu 10.340 &File.&Save<TAB>:w   :confirm w<CR>

" Define a tip for a menu or tool.
":tmenu ToolBar.Open Open file

" }}}

"------------------------------------------------------------------------------
" {{{   31) Definitions of input mod

" <CTRL-p> = Search back
" <CTRL-n> = Search forward
" <CTRL-x> = Search mod
"            <CTRL-d> = Macros "#define"
"            <CTRL-f> = Operations of files (in current directory)
"            <CTRL-k> = Dictionary
"            <CTRL-i> = Current file + "#includes"
"            <CTRL-l> = All of line
"            <CTRL-]> = Tags (created with "ctags ...")
"            <CTRL-p> = Analog search (without <CTRL-p>, <CTRL-x>)
"            <CTRL-o> = Insert Mod Omni Completion
"            <CTRL-n> = Analog search (without <CTRL-n>, <CTRL-x>)
"            <CTRL-y> = Fold page down
"            <CTRL-e> = Fold page up
"-------------------------------------------------------------------------------
" When doing keyword completion in insert mode ins-completion, and 'ignorecase'
" is also on, the case of the match is adjusted depending on the typed text.
"set infercase

" This option specifies how keyword completion ins-completion works when CTRL-P
" or CTRL-N are used.
"    .          scan the current buffer ( 'wrapscan' is ignored)
"    w          scan buffers from other windows
"    b          scan other loaded buffers that are in the buffer list
"    u          scan the unloaded buffers that are in the buffer list
"    U          scan the buffers that are not in the buffer list
"    k          scan the files given with the 'dictionary' option
"    kspell     use the currently active spell checking |spell|
"    k{dict}    scan the file {dict}.  Several "k" flags can be given, patterns
"               are valid too.  For example: >
"                       :set cpt=k/usr/dict/*,k~/spanish
"    s          scan the files given with the 'thesaurus' option
"    s{tsr}     scan the file {tsr}.  Several "s" flags can be given, patterns
"               are valid too.
"    i          scan current and included files
"    d          scan current and included files for defined name or macro
"               i_CTRL-X_CTRL-D
"    ]          tag completion
"    t          same as "]"

set complete=.,i
set cpt+=t
set cpt+=k
set cpt+=w

" This option specifies a function to be used for Insert mode completion with
" CTRL-X CTRL-U.
"set completefunc=

" Automatic completion
"   menu    = Use a popup menu to show the possible completions.
"   menuone = Use the popup menu also when there is only one match.
"   longest = Only insert the longest common text of the matches.
"   preview = Show extra information about the currently selected completion
"             in the preview window.
set completeopt+=menuone,preview,longest

" List of file names, separated by commas, that are used to lookup words for
" keyword completion commands i_CTRL-X_CTRL-K.
"set dictionary=/usr/share/dict/words    " /usr/dict/words,/usr/dict/extra.words

" This is a list of directories which will be searched when using the gf, [f,
" ]f, ^Wf, :find, :sfind, :tabfind and other commands, provided that the file
" being searched for has a relative path (not starting with "/", "./" or "../").
" The directories in the 'path' option may be relative or absolute.
"set path=.,/usr/include,,     " dir of file, /usr/include, current dir

" Pattern to be used to find a macro definition.
"set define=^\s*#\s*define

" Pattern to be used to find an include command.  It is a search pattern, just
" like for the "/" command.
"set include=^\s*#\s*include

" }}}

"------------------------------------------------------------------------------
" {{{   32) Debugging

" Show all debug messages
set debug=msg

" The number of microseconds to wait for each character sent to the screen.
set writedelay=0

" Verbose: Currently, these messages are given:
"   >= 1        When the viminfo file is read or written.
"   >= 2        When a file is ":source"'ed.
"   >= 5        Every searched tags file and include file.
"   >= 8        Files for which a group of autocommands is executed.
"   >= 9        Every executed autocommand.
"   >= 12       Every executed function.
"   >= 13       When an exception is thrown, caught, finished, or discarded.
"   >= 14       Anything pending in a ":finally" clause.
"   >= 15       Every executed Ex command (truncated at 200 characters).
set verbose=0

" When not empty all messages are written in a file with this name. When the
" file exists messages are appended.
if v:version >= 700
       set verbosefile=
endif

" }}}
