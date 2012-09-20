syntax on
filetype plugin indent on
colorscheme desert

if &term =~ 'screen'
    autocmd BufEnter * if bufname('') !~ '^\[A-Za-z0-9\]*://' | silent! exe '!echo -n "k+' . expand('%:t') . '\\"' | endif
endif

set tabstop=8
set shiftwidth=4
set softtabstop=4
set expandtab
set autoindent
set smartindent
set listchars=tab:▸\ ,trail:$
set list
set virtualedit=block
set scrolloff=1
set isfname+=-
set timeoutlen=400
set noequalalways
set concealcursor=n
set backspace=indent,eol,start
set number
set numberwidth=4
set nobackup
set backupcopy=no
set hidden
"set switchbuf=useopen,split
set foldmethod=marker
set tags=tags,TAGS
set ignorecase
set smartcase
set incsearch
set hlsearch
set wrapscan
set showmatch
set nowarn
set notagbsearch
set updatetime=400
set path^=lib,modules/*/lib
set wildmode=list:longest,list:full
set wildmenu
set wildignore=*.o,*.hi,*.obj,*.sw?,blib*,cover_db*
set complete-=i
set fileencodings=ucs-bom,utf-8,euc-jp,cp932 ",ucs-2le,utf-16
set fileformats=unix,dos
set termencoding=utf-8
set encoding=utf-8
set ambiwidth=double
set cmdheight=2
set showcmd
set laststatus=2

if exists('*GetGitBranch()')
    set statusline=[%n]%m\ %(%1*%{GetGitBranch()}%*\ %)%f\ %<%h%w%r%y[%{&fenc!=''?&fenc:&enc}][%{&ff}]%=[%{Cwd()}]\ %l,%c%V\ %4P
else
    set statusline=[%n]%m\ %f\ %<%h%w%r%y[%{&fenc!=''?&fenc:&enc}][%{&ff}]%=[%{Cwd()}]\ %l,%c%V\ %4P
endif

set cedit=<C-O>
set history=10000

set shortmess+=A
set splitright
set grepprg=git\ grep\ -n
set pastetoggle=<F10>

nnoremap <silent> cd    :lcd %:p:h<Return>
nnoremap          <C-J> :
vnoremap          <C-J> :

iabbrev shfit  <F10>shift<F10>
iabbrev sfhit  <F10>shift<F10>
iabbrev sfhti  <F10>shift<F10>
iabbrev sfthi  <F10>shift<F10>
iabbrev sefl   <F10>self<F10>
iabbrev sned   <F10>send<F10>
iabbrev lenght <F10>length<F10>
iabbrev argumetns <F10>arguments<F10>

nnoremap <silent> j gj
nnoremap <silent> k gk
vnoremap <silent> j gj
vnoremap <silent> k gk

nnoremap g<Enter> :redraw!<Enter>:redrawstatus!<Enter>
nnoremap g<C-A> :<C-U>execute 'normal' '^' . v:count . "\<C-A>"<CR>
nnoremap g<C-X> :<C-U>execute 'normal' '^' . v:count . "\<C-X>"<CR>

nnoremap <silent> <ESC>z :pclose<CR>:cclose<CR>

inoremap <silent> <BS>  <C-G>u<BS>
inoremap <silent> <C-H> <C-G>u<C-H>
inoremap <silent> <C-W> <C-G>u<C-W>
inoremap <silent> <C-U> <C-G>u<C-U>
inoremap <silent> <C-R> <C-G>u<C-R>
inoremap <silent> <C-F> <Right>
inoremap <silent> <C-B> <Left>

inoremap <C-S> <C-O>:update<CR>

cnoremap <C-A>      <Home>
cnoremap <C-B>      <Left>
cnoremap <C-D>      <Del>
cnoremap <C-E>      <End>
cnoremap <C-F>      <Right>
cnoremap <C-N>      <Down>
cnoremap <C-P>      <Up>
cnoremap <Esc>b     <S-Left>
cnoremap <Esc>f     <S-Right>

cnoremap <C-S>      <cword>
cnoremap <C-X>      =expand('%:h').'/'<Enter>
cnoremap <C-CR>     =getcmdtype()=='/'?'/0':''<Enter>:nohlsearch<Enter>

cnoremap <expr> <C-J>  getcmdline() == '' ? '!' : getcmdline() == '!' ? "\<C-U>TmuxSplitRun " : "\<CR>"

nnoremap <silent> gs0 :echo synIDattr(synID(line('.'), col('.'), 1), 'name')<CR>
nnoremap <silent> gs1 :echo synIDattr(synID(line('.'), col('.'), 0), 'name')<CR>

nnoremap <silent> <TAB>      gt
nnoremap <silent> <S-TAB>    gT
nnoremap <silent> [Z    gT
nnoremap <silent> <C-L>      <C-I>

nnoremap <expr> ^ search('^\s*\%#\S', 'n') ? '0' : '^'

" Q
nnoremap gq q

" QuickFix
nnoremap <ESC>. :cnext<Enter>
nnoremap <ESC>, :cprev<Enter>
nnoremap <ESC>u :update<Enter>
nnoremap <ESC>m :update<Enter>:make<Enter>

nnoremap <ESC> <C-W>

nnoremap <C-Q> :set hlsearch!<Enter>
nnoremap /     :set hlsearch<Enter>/
nnoremap ?     :set hlsearch<Enter>?
nnoremap *     :set hlsearch<Enter>*

nnoremap qo     :botright copen<Enter>
nnoremap qc     :cclose<Enter>
nnoremap qn     :cnext<Enter>
nnoremap qp     :cprev<Enter>
nnoremap qq     :cc<Enter>
nnoremap qf     :cfile<Enter>
nnoremap q      <NOP>

nnoremap Qo     :lopen<Enter>
nnoremap Qn     :lnext<Enter>
nnoremap Qp     :lprev<Enter>
nnoremap Qc     :lclose<Enter>
nnoremap QO     :lopen<Enter>
nnoremap QN     :lnext<Enter>
nnoremap QP     :lprev<Enter>
nnoremap QC     :lclose<Enter>
nnoremap QQ     :ll<Enter>
nnoremap Q      <NOP>

nnoremap Y y$

nmap <Space> [Space]
nmap [Space] <NOP>
let mapleader='0'

" gabbrev {{{
inoremap <silent> <expr> <C-]> gabbrev#i_start()
let g:gabbrev#keyword_ch_pattern = '[[:alnum:]:]'
" }}}

" fuzzyfinder {{{
let g:fuf_autoPreview = 0
let g:fuf_previewHeight = 5
let g:fuf_smartBs = 0
let g:fuf_keyOpenTabpage = '<C-]>'
let g:fuf_keyPreview = '<C-I>'
let g:fuf_buffer_keyDelete = '<C-L>'
let g:fuf_enumeratingLimit = 300
let g:fuf_maxMenuWidth = 100
let g:fuf_splitPathMatching = 0

nnoremap <silent> <C-S>  :FufFile<CR>
nnoremap <silent> g<C-S> :FufFileWithCurrentBufferDir<CR>
nnoremap <silent> m<C-S> :FufMruFile<CR>
nnoremap <silent> t<C-S> :FufTab<CR>
nnoremap <silent> q<C-S> :FufQuickfix<CR>
nnoremap <silent> <C-B>  :FufBuffer<CR>
cnoremap <silent> <expr> <C-S> getcmdtype() =~ '[/?]' ? "<C-C>:FufLine! " . getcmdline() . "<CR>" : ''

autocmd FileType fuf inoremap <buffer> <C-C> <ESC>
autocmd FileType fuf inoremap <buffer> <C-D> <C-O>:FufRenewCache<CR><C-X><C-N>

autocmd BufEnter \[fuf\] silent call neocomplcache#disable()

if exists('*fuf#addMode')
    autocmd VimEnter * call fuf#addMode('tab')
endif
" }}}

" tap.vim {{{
autocmd FileType tap-result nnoremap <buffer> <ESC>m :call tap#prove(b:tap_arg)<CR>
" }}}

noremap K <NOP>
nnoremap <Leader>* *N

nnoremap <C-W><C-U> :update<Enter>
nnoremap <C-W><C-C> <Nop>
nnoremap <ESC>/     :split<CR>/

command! -range=% Source silent split `=tempname()` | silent put=getbufline('#', <line1>, <line2>) | silent write | source % | bwipeout

""" Plugin settings """

" Git
let git_bin = '/usr/local/bin/git'
let git_highlight_blame = 1
let git_no_map_default = 1
nnoremap <Leader>gd :GitDiff -M --no-prefix<Enter>
nnoremap <Leader>gD :GitDiff -M --cached --no-prefix<Enter>
nnoremap <Leader>gs :GitStatus<Enter>
nnoremap <Leader>ga :GitAdd<Enter>
nnoremap <Leader>gA :GitAdd -u<Enter>
nnoremap <Leader>gc :GitCommit<Enter>
nnoremap <Leader>gp :GitPullRebase<Enter>

" CtrlP
let g:ctrlp_extensions = ['quickfix', 'cmdline', 'yankring', 'tag', 'perldoc']
let g:ctrlp_prompt_mappings = {
  \ 'PrtBS()':              ['<bs>','<c-h>'],
  \ 'PrtDelete()':          ['<del>'],
  \ 'PrtDeleteWord()':      ['<c-w>'],
  \ 'PrtClear()':           ['<c-u>'],
  \ 'PrtSelectMove("j")':   ['<c-n>', '<down>'],
  \ 'PrtSelectMove("k")':   ['<c-p>', '<up>'],
  \ 'PrtHistory(-1)':       ['<m-p>'],
  \ 'PrtHistory(1)':        ['<m-n>'],
  \ 'AcceptSelection("e")': ['<cr>', '<2-LeftMouse>'],
  \ 'AcceptSelection("h")': ['<c-j>', '<c-cr>', '<c-s>'],
  \ 'AcceptSelection("t")': ['<c-]>', '<MiddleMouse>'],
  \ 'AcceptSelection("v")': ['<c-k>', '<c-q>', '<RightMouse>'],
  \ 'ToggleFocus()':        ['<s-tab>'],
  \ 'ToggleRegex()':        ['<c-r>'],
  \ 'ToggleByFname()':      ['<c-d>'],
  \ 'ToggleType(1)':        ['<c-f>', '<c-up'],
  \ 'ToggleType(-1)':       ['<c-b>', '<c-down>'],
  \ 'PrtExpandDir()':       ['<tab>'],
  \ 'PrtCurStart()':        ['<c-a>'],
  \ 'PrtCurEnd()':          ['<c-e>'],
  \ 'PrtCurLeft()':         ['<left>'],
  \ 'PrtCurRight()':        ['<right>'],
  \ 'PrtClearCache()':      ['<F5>'],
  \ 'PrtDeleteMRU()':       ['<F7>'],
  \ 'CreateNewFile()':      ['<c-y>'],
  \ 'MarkToOpen()':         ['<c-z>'],
  \ 'OpenMulti()':          ['<c-o>'],
  \ 'PrtExit()':            ['<esc>', '<c-g>', '<c-c>'],
  \ }
let g:ctrlp_max_depth = 10
let g:ctrlp_user_command = ['.git/', 'cd %s && git ls-files']
let g:ctrlp_use_caching = 1
let g:ctrlp_clear_cache_on_exit = 1
let g:ctrlp_map = ''

nnoremap <silent>    :let g:ctrlp_default_input = 0<CR>:CtrlPRoot<CR>
nnoremap <silent>  :let g:ctrlp_default_input = 0<CR>:CtrlPBuffer<CR>
nnoremap <silent> g  :let g:ctrlp_default_input = 1<CR>:CtrlPRoot<CR>
nnoremap <silent> m  :let g:ctrlp_default_input = 0<CR>:CtrlPMRUFiles<CR>
nnoremap <silent> t  :let g:ctrlp_default_input = 0<CR>:CtrlPTag<CR>
nnoremap <silent> !  :call ctrlp#init(ctrlp#perldoc#id())<CR>

" syntax/sh.vim
let g:is_bash = 1

" TOhtml
let html_number_lines = 0
let html_use_css = 1

autocmd BufRead *.tt      setfiletype html
autocmd BufNewFile,BufReadPost *.t   setlocal filetype=perl
autocmd BufRead *.psgi    setfiletype perl

""" autocmds """
autocmd BufWritePost,FileWritePost {*.vim,*vimrc} if &autoread | source <afile> | endif
autocmd Filetype html,xml,xsl,xhtml,markdown runtime plugin/closetag.vim | inoremap <silent> <C-_> <C-R>=GetCloseTag()<CR>
autocmd QuickFixCmdPre * silent botright pedit \*preview\* | 99wincmd w | silent enew
autocmd QuickFixCmdPost {make*,grep*,vim*,c*} if len(filter(getqflist(), 'v:val.bufnr')) | else | pclose | endif

autocmd InsertLeave * set nopaste

function! Cwd()
    if exists('b:Cwd') && exists('b:cwd') && b:cwd == getcwd()
        return b:Cwd
    endif
    if !exists('g:statusline_cwd_maxlen')
        let g:statusline_cwd_maxlen = winwidth(0) / 3
    endif
    let delim = has('win32') ? '\' : '/'
    let b:cwd = fnamemodify(getcwd(), ':~')
    let components = split(b:cwd, '[\\/]', 1)

    let cwd = join(components, delim)
    let i = 0
    while len(components) > i && len(cwd) > g:statusline_cwd_maxlen
        let cwd = join(map(components[0:i], 'v:val[0]') + components[i+1:], delim)
        let i += 1
    endwhile

    let b:Cwd = substitute(cwd, '/*$', '', '')
    let t:cwd = b:cwd
    return b:Cwd
endfunction

command! -nargs=1 -complete=file Move file <args> | silent write | call delete(expand('#'))

nnoremap cD :call CDToProjectDir()<CR>
autocmd BufEnter * if !exists('t:cwd') | call CDToProjectDir() | endif

function! CDToProjectDir()
    if len(&buftype)
        return
    endif
    let dir = system('cd "' . expand('%:p:h') . '"; git rev-parse --show-toplevel 2>/dev/null')
    let dir = substitute(dir, '\n', '', '')
    if v:shell_error == 0 && strlen(dir) && isdirectory(dir)
        execute 'lcd' fnameescape(dir)
        if exists('b:git_dir')
            unlet b:git_dir
        endif
    endif
endfunction

" TODO <expr> に
function! InsertSpaceAsAbove()
    let [lnum, col] = getpos('.')[1:2]
    let line_above  = getline(lnum - 1)
    let string_ahead = matchstr(line_above, '\%' . (col + 1) . 'c\S*\s*')
    let len = strlen(string_ahead)
    if strlen(getline('.'))
        execute 'normal ' . len . 'a '
    else
        execute 'normal ' . (len + 1) . 'a '
    endif
endfunction

inoremap <C-E> <ESC>:call InsertSpaceAsAbove()<CR>a

augroup vimrc-auto-mkdir
    autocmd!
    autocmd BufWritePre * call s:auto_mkdir(expand('<afile>:p:h'))
    function! s:auto_mkdir(dir)
        if !isdirectory(a:dir)
            call mkdir(a:dir, 'p')
        endif
    endfunction
augroup END

" tmux
command! -nargs=* -complete=shellcmd TmuxSplitRun let _cmd = len(<q-args>) ? shellescape(substitute(<q-args>, '%', expand('%'), '') . '; tmux copy-mode -t.1 \; send-keys C-y') : '' | let tmux_run_command = printf('tmux set-window-option remain-on-exit on \; if-shell "tmux respawn-pane -t.1 %s" "select-window" "split-window -d -h -p 30 %s"', _cmd, _cmd) | ruby `#{VIM::evaluate('tmux_run_command')}`
nnoremap <Leader>! :TmuxSplitRun 

nnoremap <ESC>m :update<Enter>:execute 'TmuxSplitRun' &makeprg<Enter>
