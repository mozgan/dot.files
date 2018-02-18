"------------------------------------------------------------------------------
"                       Programming Style
"
"
" $Id: dot.vim/vimrcs/style.vim,v 0.5 17.02.2018 13:09:07 mozgan Exp $
"------------------------------------------------------------------------------

"------------------------------------------------------------------------------
" {{{   1) FreeBSD style
" https://github.com/freebsd/freebsd/blob/master/tools/tools/editing/freebsd.vim
" Follow the FreeBSD style(9).
function! StyleFreeBSD()
    let s:c_style = "FreeBSD style(9)"
    setlocal cindent
    setlocal cinoptions=(4200,u4200,+0.5s,*500,:0,t0,U4200
    setlocal indentexpr=IgnoreParenIndent()
    setlocal indentkeys=0{,0},0),:,0#,!^F,o,O,e
    setlocal noexpandtab
    setlocal shiftwidth=8
    setlocal softtabstop=0
    setlocal tabstop=8
    setlocal textwidth=80
    if v:version >= 703
    	set colorcolumn=80
    endif
endfun

" Ignore indents caused by parentheses in FreeBSD style.
function! IgnoreParenIndent()
    let indent = cindent(v:lnum)

    if indent > 4000
        if cindent(v:lnum - 1) > 4000
            return indent(v:lnum - 1)
        else
            return indent(v:lnum - 1) + 4
        endif
    else
        return (indent)
    endif
endfun

" }}}

"------------------------------------------------------------------------------
" {{{   2) Linux style

" Follow the Linux kernel coding style (linux/Documentation/CodingStyle).
function! StyleLinux()
    let s:c_style = "Linux kernel"
    setlocal cindent
    "setlocal cinoptions=:0,t0,(0
    setlocal cinoptions=:0,l1,t0,g0,(0
    setlocal noexpandtab
    setlocal shiftwidth=8
    setlocal softtabstop=0
    setlocal tabstop=8
    setlocal textwidth=80
endfun

" }}}

"------------------------------------------------------------------------------
" {{{   3) Toggle style

function! ToggleCStyle()
    if ! exists('s:c_style')
        let s:c_style = "Linux kernel"
    endif
    if s:c_style == "Linux kernel"
        call StyleFreeBSD()
    elseif s:c_style == "FreeBSD style(9)"
        call StyleLinux()
    endif
    echo s:c_style
endfunc

" }}}

