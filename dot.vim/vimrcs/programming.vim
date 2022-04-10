"------------------------------------------------------------------------------
"                           Programming
"
"
" $Id: dot.vim/vimrcs/programming.vim,v 0.7 08.04.2022 22:32:10 mozgan Exp $
"------------------------------------------------------------------------------

"------------------------------------------------------------------------------
" {{{   1) Make[file]

autocmd BufNewFile,BufRead [Mm]akefile* setlocal filetype=make
autocmd BufNewFile,BufRead [Mm]akefile* set noexpandtab tabstop=8 shiftwidth=8 softtabstop=0

au BufEnter *.c map <C-Return> :w\|:!gcc -Wall -g -O3 -c %<CR>

" }}}

"------------------------------------------------------------------------------
" {{{	2) C/C++

autocmd BufNewFile,BufRead *.{c,h} let c_C99=1
autocmd BufNewFile,BufRead *.{c,h} let c_c_vim_compatible=1
autocmd BufNewFile,BufRead *.{c,h} let c_comment_strings=1
autocmd BufNewFile,BufRead *.{c,h} let c_comment_numbers=1
autocmd BufNewFile,BufRead *.{c,h} let c_comment_types=1
autocmd BufNewFile,BufRead *.{c,h} let c_warn_nested_comments=1
autocmd BufNewFile,BufRead *.{c,h} let c_cpp_comments=1
autocmd BufNewFile,BufRead *.{c,h} let c_ansi_typedefs=1
autocmd BufNewFile,BufRead *.{c,h} let c_ansi_constants=1
autocmd BufNewFile,BufRead *.{c,h} let c_posix=1
autocmd BufNewFile,BufRead *.{c,h} let c_comment_date_time=1
autocmd BufNewFile,BufRead *.{c,h} let c_minlines=25
autocmd BufNewFile,BufRead *.{c,h} let c_C89=1
autocmd BufNewFile,BufRead *.{c,h} let c_gnu=1
autocmd BufNewFile,BufRead *.{c,h} let c_syntax_for_h=1

"autocmd BufNewFile,BufRead *.{c,cpp,cc,h} call FreeBSD_Style()
"autocmd BufNewFile,BufRead *.{c,cpp,cc,h,h} call FreeBSD_Style()
"autocmd BufNewFile,BufRead *.{c,cpp,cc,h,h} call FreeBSD_Style()

autocmd BufNewFile,BufRead *.{cpp,cc,h} setlocal filetype=cpp

autocmd FileType c set colorcolumn=80
autocmd FileType cpp set colorcolumn=80
autocmd FileType h set colorcolumn=80

let g:C_UseTool_cmake    = 'yes'
let g:C_UseTool_doxygen  = 'yes'

" }}}

"------------------------------------------------------------------------------
" {{{   3) Vim

autocmd BufNewFile,BufRead *.vim,vimrc,*.vimrc setlocal filetype=vim
autocmd BufNewFile,BufRead *.vim,vimrc,*.vimrc setlocal tabstop=4
autocmd BufNewFile,BufRead *.vim,vimrc,*.vimrc setlocal shiftwidth=4
autocmd BufNewFile,BufRead *.vim,vimrc,*.vimrc setlocal textwidth=500
autocmd BufNewFile,BufRead *.vim,vimrc,*.vimrc setlocal formatoptions=tcroqn
autocmd BufNewFile,BufRead *.vim,vimrc,*.vimrc setlocal commentstring="%s

" }}}

"------------------------------------------------------------------------------
" {{{   4) Bash

autocmd BufNewFile,BufRead *.{sh,bash*,zsh,cron} setlocal filetype=sh
autocmd BufNewFile,BufRead *.{sh,bash*,zsh,cron} setlocal tabstop=4
autocmd BufNewFile,BufRead *.{sh,bash*,zsh,cron} setlocal shiftwidth=4
autocmd BufNewFile,BufRead *.{sh,bash*,zsh,cron} setlocal textwidth=500
autocmd BufNewFile,BufRead *.{sh,bash*,zsh,cron} setlocal commentstring="%s

" }}}

"------------------------------------------------------------------------------
" {{{   5) Perl

autocmd BufNewFile,BufRead *.p[lm] setlocal filetype=perl

autocmd FileType perl set tabstop=4
autocmd FileType perl set shiftwidth=4
autocmd FileType perl set expandtab
autocmd FileType perl set softtabstop=4
autocmd FileType perl set textwidth=80

autocmd FileType perl set autoindent
autocmd FileType perl set smartindent

"autocmd FileType perl set makeprg=perl\ -Ilib\ -c\ %\ $*
"autocmd FileType perl set makeprg=perl\ -c\ %\ $*
autocmd FileType perl set makeprg=perl\ -c\ -T\ \"%\"\ $*
autocmd FileType perl set errorformat=%f:%l:%m
autocmd FileType perl set autowrite

" make lines longer than 80 characters errors (including newline)
autocmd FileType perl match ErrorMsg /\%>79v.\+/

" make tabs and trailing spaces errors
autocmd FileType perl 2match ErrorMsg /[\t]\|\s\+\%#\@<!$/

" set compiler
autocmd BufNewFile,BufRead *.p[lm] compiler perl

" }}}

"------------------------------------------------------------------------------
" {{{   6) Python

autocmd BufNewFile,BufRead *.py setlocal tabstop=4
autocmd BufNewFile,BufRead *.py setlocal softtabstop=4
autocmd BufNewFile,BufRead *.py setlocal shiftwidth=4
autocmd BufNewFile,BufRead *.py setlocal textwidth=80
autocmd BufNewFile,BufRead *.py setlocal smarttab
autocmd BufNewFile,BufRead *.py setlocal expandtab

au FileType python setlocal smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class,with
au BufRead *.py set efm=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m
au BufEnter *.py map <C-Return> :w\|:!python %<CR>

"au FileType python colorscheme desertink

" }}}

"------------------------------------------------------------------------------
" {{{   7) Haskell

" source: http://www.haskell.org/haskellwiki/Vim

" Tab specific option
autocmd BufNewFile,BufRead *.{hs} setlocal filetype=haskell
autocmd BufNewFile,BufRead *.{hs} setlocal tabstop=8
autocmd BufNewFile,BufRead *.{hs} setlocal expandtab
autocmd BufNewFile,BufRead *.{hs} setlocal softtabstop=4
autocmd BufNewFile,BufRead *.{hs} setlocal shiftwidth=4
autocmd BufNewFile,BufRead *.{hs} setlocal shiftround

" }}}

"------------------------------------------------------------------------------
" {{{   8) Skeleton

" load skeletons
if filereadable(expand("$HOME/.vim/vimrcs/skeleton.vim"))
    source $HOME/.vim/vimrcs/skeleton.vim
endif

" }}}


"------------------------------------------------------------------------------
" {{{   9) Remove blank spaces

function StripTrailingWhitespace()
  if !&binary && &filetype != 'diff'
    normal mz
    normal Hmy
    %s/\s\+$//e
    normal 'yz<CR>
    normal `z
  endif
endfunction

"autocmd FileType c,cpp,python
"    \ autocmd BufWritePre <buffer> call StripTrailingWhitespace()

autocmd BufWritePre * %s/\s\+$//e

" }}}

"------------------------------------------------------------------------------
" {{{   10) google AutoFormattig

""" For plugin vim-codefmt
augroup autoformat_settings
  autocmd FileType bzl AutoFormatBuffer buildifier
  autocmd FileType c,cpp,proto,javascript,arduino AutoFormatBuffer clang-format
  autocmd FileType dart AutoFormatBuffer dartfmt
  autocmd FileType go AutoFormatBuffer gofmt
  autocmd FileType gn AutoFormatBuffer gn
  autocmd FileType html,css,sass,scss,less,json AutoFormatBuffer js-beautify
  autocmd FileType java AutoFormatBuffer google-java-format
  autocmd FileType python AutoFormatBuffer yapf
  " Alternative: autocmd FileType python AutoFormatBuffer autopep8
  autocmd FileType rust AutoFormatBuffer rustfmt
  autocmd FileType vue AutoFormatBuffer prettier
augroup END

""" For plugin vim-clang-format
"let g:clang_format#style_options = {
"            \ "AccessModifierOffset" : -4,
"            \ "AllowShortIfStatementsOnASingleLine" : "true",
"            \ "AlwaysBreakTemplateDeclarations" : "true",
"            \ "Standard" : "C++17"}
"
"" map to <Leader>cf in C++ code
"autocmd FileType c,cpp,objc nnoremap <buffer><Leader>cf :<C-u>ClangFormat<CR>
"autocmd FileType c,cpp,objc vnoremap <buffer><Leader>cf :ClangFormat<CR>
"" if you install vim-operator-user
"autocmd FileType c,cpp,objc map <buffer><Leader>x <Plug>(operator-clang-format)
"" Toggle auto formatting:
"nmap <Leader>C :ClangFormatAutoToggle<CR>

" }}}
