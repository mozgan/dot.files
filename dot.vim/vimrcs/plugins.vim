"------------------------------------------------------------------------------
"                           Plugins
"
"
" $Id: dot.vim/vimrcs/plugins.vim,v 0.8 17.02.2018 20:28:44 mozgan Exp $
"------------------------------------------------------------------------------

"------------------------------------------------------------------------------
" {{{    1) Vundle

set nocompatible              " be iMproved, required
filetype off                  " required

let vundleInstalled=0
let vundle_readme=expand('~/.vim/bundle/Vundle.vim/README.md')

if !filereadable(vundle_readme)
	silent !mkdir -p ~/.vim/bundle/
	silent !git clone https://github.com/VundleVim/Vundle.vim ~/.vim/bundle/Vundle.vim
	let vundleInstalled=1
endif

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

" === === === Install plugins === === === "

""" Colors """
Plugin 'altercation/vim-colors-solarized'
Plugin 'vim-scripts/molokai'
Plugin 'NLKNguyen/papercolor-theme'

Plugin 'vim-scripts/Risto-Color-Scheme'
Plugin 'jacoborus/tender.vim'
Plugin 'toupeira/vim-desertink'

""" Plugins """

" NERDTree
Plugin 'scrooloose/nerdtree'
Plugin 'Xuyuanp/nerdtree-git-plugin'

" Airline
Plugin 'bling/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
"Plugin 'powerline/fonts'
" fugitive
Plugin 'tpope/vim-fugitive'

" gundo
Plugin 'sjl/gundo.vim'

" syntastic
Plugin 'vim-syntastic/syntastic'

" GitGutter
"Plugin 'airblade/vim-gitgutter'

" signify
Plugin 'mhinz/vim-signify'

" Programming Plugins
"Plugin 'WolfgangMehner/vim-plugins'
Plugin 'WolfgangMehner/c-support'
Plugin 'WolfgangMehner/bash-support'
Plugin 'WolfgangMehner/latex-support'
Plugin 'WolfgangMehner/matlab-support'
Plugin 'WolfgangMehner/perl-support'
Plugin 'WolfgangMehner/vim-support'
Plugin 'WolfgangMehner/git-support'

"Plugin 'vim-scripts/LaTeX-Suite-aka-Vim-LaTeX'
Plugin 'vim-latex/vim-latex'

" autocomplete pairs
Plugin 'jiangmiao/auto-pairs'

" linux kernel coding style
"Plugin 'vivien/vim-linux-coding-style'

" Vim-Do
"Plugin 'WolfgangMehner/vim-do'

" snippets
"Plugin 'msanders/snipmate.vim'  " -> too old
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'garbas/vim-snipmate'

" Optional:
Plugin 'honza/vim-snippets'
" Optional: Nedd Python support in Vim
"Plugin 'MarcWeber/vim-addon-manager'
"Plugin 'honza/vim-snippets'

" some toolkits
Plugin 'vim-scripts/DoxygenToolkit.vim'
Plugin 'dkasak/manpageview'

" Highlight_unwanted_spaces
Plugin 'bronson/vim-trailing-whitespace'

Plugin 'yggdroot/indentline'
"Plugin 'vim-scripts/vimwiki'

":TODO:"
"kynan/dokuvimki
"nblock/vim-dokuwiki

" === === === PluginInstall === === === "
if vundleInstalled == 1
     :PluginInstall

    if filereadable(expand("$HOME/.vim/snippets/my.c.comments.template"))
		:silent !cp "$HOME/.vim/snippets/my.c.comments.template" "$HOME/.vim/bundle/c-support/c-support/templates/c.comments.template"
	endif

	if filereadable(expand("$HOME/.vim/snippets/my.c.snippets"))
		:silent !cp "$HOME/.vim/snippets/my.c.snippets" "$HOME/.vim/bundle/vim-snippets/snippets/c.snippets"
	endif
endif

call vundle#end()
filetype plugin indent on    " required
syntax on                    " enable syntax

"}}}

"------------------------------------------------------------------------------
" {{{    2) TOhtml

let html_number_lines=1
let html_use_css=1
let use_xhtml=1

" }}}

"------------------------------------------------------------------------------
" {{{    3) Solarized

" Rules of solarized
let g:solarized_termcolors=256
let g:solarized_termtrans=0
let g:solarized_degrade=0

let g:solarized_bold=0
let g:solarized_underline=1
let g:solarized_italic=1

let g:solarized_style='dark'
let g:solarized_contrast='high'

"------------------------------------------------------------------------------
" {{{   4) NERDTree

" Open NERDTree automatically when vim starts up if no files were specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" Toggle NERDTree (Ctrl-n)
map <C-n> :NERDTreeToggle<CR>

" }}}

"------------------------------------------------------------------------------
" {{{   5) vim-airline

"  variable names                default contents
"  ----------------------------------------------------------------------------
"  let g:airline_section_a       (mode, crypt, paste, iminsert)
"  let g:airline_section_b       (hunks, branch)
"  let g:airline_section_c       (bufferline or filename)
"  let g:airline_section_gutter  (readonly, csv)
"  let g:airline_section_x       (tagbar, filetype, virtualenv)
"  let g:airline_section_y       (fileencoding, fileformat)
"  let g:airline_section_z       (percentage, line number, column number)
"  let g:airline_section_warning (syntastic, whitespace)

set laststatus=2               " enable airline even if no splits

" remove the bar for fileencoding
let g:airline_section_y = ''

"let g:airline#extensions#default#layout = [
"      \ [ 'a', 'b', 'c' ],
"      \ [ 'x', 'y', 'z', 'warning' ]
"      \ ]

" the separator used on the left side
let g:airline_left_sep='>'
let g:airline_left_alt_sep = '»'

" the separator used on the right side
let g:airline_right_sep='<'
let g:airline_right_alt_sep = '«'

" use vim-airline symbols if GUI is running
if has("gui_running")
	"let g:airline_powerline_fonts = 1
	let g:airline_linecolumn_prefix = '¶ '
	let g:airline_branch_prefix = '⎇ '
	let g:airline_paste_symbol = 'ρ'
endif

"""
"enable modified detection
let g:airline_detect_modified=1

" enable paste detection
let g:airline_detect_paste=1

" enable crypt detection
let g:airline_detect_crypt=1

" enable iminsert detection
let g:airline_detect_iminsert=0

" determine whether inactive windows should have the left section collapsed to
" only the filename of that buffer.
let g:airline_inactive_collapse=1

"""
"enable/disable fugitive/lawrencium integration
let g:airline#extensions#branch#enabled = 1
let g:airline_enable_branch=1

"change the text for when no branch is detected
let g:airline#extensions#branch#empty_message = ''

" truncate long branch names to a fixed length
let g:airline#extensions#branch#displayed_head_limit = 10

" customize formatting of branch name >
" default value leaves the name unmodifed
let g:airline#extensions#branch#format = 0

"""
" enable/disable showing a summary of changed hunks under source control.
let g:airline#extensions#hunks#enabled = 1

" enable/disable showing only non-zero hunks.
let g:airline#extensions#hunks#non_zero_only = 1

" set hunk count symbols.
let g:airline#extensions#hunks#hunk_symbols = ['+', '~', '-']

"""
" enable/disable detection of whitespace errors.
let g:airline#extensions#whitespace#enabled = 1

" customize the whitespace symbol.
let g:airline#extensions#whitespace#symbol = '!'

" configure which whitespace checks to enable.
let g:airline#extensions#whitespace#checks = [ 'indent', 'trailing' ]

" configure whether a message should be displayed. >
let g:airline#extensions#whitespace#show_message = 1

" configure the formatting of the warning messages.
let g:airline#extensions#whitespace#trailing_format = 'trailing[%s]'
let g:airline#extensions#whitespace#mixed_indent_format = 'mixed-indent[%s]'

"""
" enable smart tabs
let g:airline#extensions#tabline#enabled = 1

" configure separators for the tabline only
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#right_sep = ''
let g:airline#extensions#tabline#right_alt_sep = '|'

" configure whether close button should be shown
let g:airline#extensions#tabline#show_close_button = 1

" configure symbol used to represent close button
let g:airline#extensions#tabline#close_symbol = 'X'

"""
" enable/disable syntastic integration
"let g:airline#extensions#syntastic#enabled = 1
let g:airline_enable_syntastic=1

" airline theme
"let g:airline_theme='papercolor'
let g:airline_theme='powerlineish'

" }}}

"------------------------------------------------------------------------------
" {{{   6) Gundo

" Toggle gundo (Ctrl-g)
map <C-g> :GundoToggle<CR>

" }}}

"------------------------------------------------------------------------------
" {{{   7) Syntastic

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0

let g:syntastic_enable_signs=1
let g:syntastic_quiet_messages = { "type": "style" }

let g:syntastic_aggregate_errors = 1

let g:syntastic_enable_perl_checker = 1

let g:syntastic_error_symbol = "✗"
let g:syntastic_warning_symbol = "!"

" Error and Warning messages format for statusline
let g:syntastic_stl_format = '[%E{Err: %fe #%e}%B{, }%W{Warn: %fw #%w}]'

"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*

"let g:syntastic_python_checkers = ['pylint']

" }}}


"------------------------------------------------------------------------------
" {{{   8) indentline

":set list lcs=tab:\|\
"let g:indentLine_color_term = 239
"let g:indentLine_color_gui = '#A4E57E'

" }}}

"-------------------------------------------------------
" {{{   9) LaTeX-Suite
"let g:tex_indent_items=1
let g:tex_flavor='latex'

au BufEnter *.tex set autowrite formatoptions=tcroqn21
let g:Tex_DefaultTargetFormat = 'pdf'
let g:Tex_MultipleCompileFormats = 'pdf'
let g:Tex_CompileRule_pdf = 'pdflatex -interaction=nonstopmode $*'
let g:Tex_GotoError = 0
let g:Tex_ViewRule_pdf = 'evince'

" }}}

"-------------------------------------------------------
" {{{   10) DoxygenToolkit

"let g:DoxygenToolkit_briefTag_pre="@Synopsis  "
"let g:DoxygenToolkit_paramTag_pre="@Param "
"let g:DoxygenToolkit_returnTag="@Returns   "
let g:DoxygenToolkit_authorName="M. Ozgan"
let g:DoxygenToolkit_licenseTag="FreeBSD License"






