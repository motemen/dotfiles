setlocal path^=lib
setlocal path^=extlib
setlocal path^=t/lib
setlocal path^=modules/*/lib
setlocal path^=modules/*/t/lib
setlocal path^=../../modules/*/lib
setlocal includeexpr=substitute(substitute(v:fname,'^.\\{-}\\([A-Za-z0-9_:]\\+\\)[^A-Za-z0-9_:]*$','\\1.pm',''),'::','/','g')
setlocal suffixesadd=.pm

if expand('%:e') == 'pl'
    setlocal makeprg=perl\ %
elseif expand('%:t') == 'Makefile.PL'
    setlocal makeprg=perl\ %\ &&\ make
elseif expand('%:e') == 't'
    " setlocal makeprg=prove\ -v\ %
    nnoremap <buffer> <ESC>m :wall<CR>:call tap#prove(expand('%'))<CR>
else
    nnoremap <buffer> <ESC>m :wall<CR>:call tap#prove('t')<CR>
endif

iabbrev <buffer> Pkg <F10>package <C-R>=<SID>perl_package()<CR>;<CR>use strict;<CR>use warnings;<CR><CR><CR>1;<Up><Up><C-R>=['',getchar(0)][0]<CR><F10>
iabbrev <buffer> PKg <F10>package <C-R>=<SID>perl_package()<CR>;<CR>use strict;<CR>use warnings;<CR><CR><CR>1;<Up><Up><C-R>=['',getchar(0)][0]<CR><F10>

function! s:perl_package()
    return join(split(substitute(expand('%:r'), '.*lib/', '', ''), '[/-]'), '::')
endfunction

inoremap <buffer> <silent> <expr> <C-]> gabbrev#i_start()
setlocal completefunc=gabbrev#complete

function! s:test_class_test_method()
    let re = 'sub\s\+\(\S\+\)\s*:\s*Test'
    let line = search(re, 'bn')
    if line
        let res = matchlist(getline(line), re)
        let $TEST_METHOD=res[1]
        " make
        normal m
        let $TEST_METHOD=''
        return
    endif
endfunction

nnoremap <ESC>t :update<Enter>:call <SID>test_class_test_method()<CR>
