set nocompatible
filetype off

scriptencoding utf-8

call plug#begin()

set spellfile=~/.vim/spell/en.utf-8.add

set directory=~/.vim/swap

Plug 'kana/vim-metarw'
Plug 'kana/vim-metarw-git'
" Plug 'motemen/git-vim'
Plug 'vim-scripts/wombat256.vim'
Plug 'vim-scripts/desert-warm-256'
Plug 'vim-scripts/smartchr'

Plug 'vim-scripts/closetag.vim'

" Plug 'plasticboy/vim-markdown'
" let g:vim_markdown_frontmatter = 1
" let g:vim_markdown_folding_disabled = 1

Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-syntax'
Plug 'kana/vim-textobj-lastpat'
Plug 'thinca/vim-textobj-function-perl'
" Plug 'mjbrownie/html-textobjects'

Plug 'motemen/vim-help-random'

" Plug 'motemen/vim-syntax-dockerfile'

Plug 'gre/play2vim'

Plug 'editorconfig/editorconfig-vim'

Plug 'thinca/vim-qfreplace'

Plug 'leafgarland/typescript-vim'

Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
let g:fzf_command_prefix = 'Fzf'
let g:fzf_action = {
  \ 'ctrl-k': 'vsplit',
  \ 'ctrl-j': 'split',
  \ 'ctrl-t': 'tab split',
  \ 'tab': 'tab split' }

nnoremap <silent> <C-S>  :FzfFiles<CR>
nnoremap <silent> <C-B>  :FzfBuffers<CR>
nnoremap <silent> ]<C-S> :FzfTags<CR>
nnoremap <silent> m<C-S> :FzfHistory<CR>
nnoremap g<C-S> :FzfFiles =expand('%:h').'/'<CR>
command! -nargs=* FzfGrep call fzf#vim#grep('pt ' . <q-args>, 1)
command! FzfPtFiles call fzf#vim#grep('pt -g ""', 0)
nnoremap <silent> '<C-S> :FzfMarks<CR>
nnoremap <silent> =<C-S> :call Fzf_ghq()<CR>

function! Fzf_ghq()
    call fzf#run(fzf#wrap({
        \ 'source': "ghq list -p | PLENV_VERSION=system perl -ple 'BEGIN { $re = join q(|), sort { length $a <=> length $b } split /\n/, qx(ghq root --all) } s/$/ $_/; s<^(?:$re)/><>'",
        \ 'options': ' --with-nth=1' . fzf#wrap()['options'],
        \ 'sink': funcref('Fzf_ghq_sink')
    \ }))
endfunction

function! Fzf_ghq_sink(lines)
    echo a:lines
    echo split(a:lines, ' ')
    let parts = split(a:lines, ' ')
    if len(parts) == 0
        return
    endif
    execute 'tabedit' parts[1]
    " echo split(a:lines, ' ')[1]
    " execute 'tabedit' split(a:lines, ' ')[1]
endfunction

Plug 'wellle/targets.vim'

let g:ftplugin_sql_omni_key = '<C-K>'

syntax on
filetype plugin indent on

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
"set backupcopy=no
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
set path^=lib,modules/*/lib,templates
set wildmode=list:longest,list:full
set wildmenu
set wildignore=*.o,*.hi,*.obj,*.sw?,blib*,cover_db*
set mouse=a

set complete-=i
set completeopt=menu,longest,menuone,preview,noselect

set fileencodings=ucs-bom,utf-8,euc-jp,cp932 ",ucs-2le,utf-16
set fileformats=unix,dos
set termencoding=utf-8
set encoding=utf-8
set ambiwidth=single
set cmdheight=3
set showcmd
set laststatus=2
set cpoptions+=F

set statusline=[%n]%m\ %(%1*%{fugitive#head(6)}%*\ %)%f\ %<%h%w%r%y[%{&fenc!=''?&fenc:&enc}][%{&ff}]%=[%{Cwd()}]\ %l,%c%V\ %4P

set cedit=<C-O>
set history=1000

set shortmess+=A
set splitright
" set grepprg=git\ grep\ --line-number\ -I\ --no-index\ --exclude-standard
set grepprg=pt\ --nogroup
set pastetoggle=<F10>
set display=lastline
set pumheight=15

nnoremap <silent> cd    :lcd %:p:h<Return>
nnoremap          <C-J> :
vnoremap          <C-J> :
inoremap          <C-J> <ESC>

iabbrev shfit  <F10>shift<F10>
iabbrev sfhit  <F10>shift<F10>
iabbrev sfhti  <F10>shift<F10>
iabbrev sfthi  <F10>shift<F10>
iabbrev sefl   <F10>self<F10>
iabbrev sned   <F10>send<F10>
iabbrev arsg   <F10>args<F10>
iabbrev lenght <F10>length<F10>
iabbrev argumetns <F10>arguments<F10>
iabbrev serach <F10>search<F10>

nnoremap <silent> j gj
nnoremap <silent> k gk
vnoremap <silent> j gj
vnoremap <silent> k gk

nnoremap g<Enter> :redraw!<Enter>:redrawstatus!<Enter>:syntax sync fromstart<Enter>
nnoremap g<C-A> :<C-U>execute 'normal' '^' . v:count . "\<C-A>"<CR>
nnoremap g<C-X> :<C-U>execute 'normal' '^' . v:count . "\<C-X>"<CR>

nnoremap gi :<C-U>terminal gi
nnoremap gI gi

nnoremap <silent> <ESC>z :pclose<CR>:cclose<CR>

nnoremap <silent> <C-]> <C-]>zt

" inoremap <silent> <BS>  <C-G>u<BS>
"inoremap <silent> <C-H> <C-G>u<C-H>
"inoremap <silent> <C-W> <C-G>u<C-W>
"inoremap <silent> <C-U> <C-G>u<C-U>
"inoremap <silent> <C-R> <C-G>u<C-R>
" inoremap <silent> <CR>  <C-G>u<CR>
inoremap <silent> <C-F> <Right>
inoremap <silent> <C-B> <Left>

inoremap <C-S> <C-O>:update<CR>

" inoremap <expr> <C-L> pumvisible() ? "\<C-L>" : smartchr#one_of('->', '=>')
inoremap <expr> <C-K> smartchr#one_of('->', '=>', '=')

" inoremap <expr> <C-N> pumvisible() ? "\<Down>" : "\<C-N>"
" inoremap <expr> <C-P> pumvisible() ? "\<Up>"   : "\<C-P>"

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

if has('nvim')
    cnoremap <expr> <C-J>  getcmdline() == '' ? '!' : getcmdline() == '!' ? "\<C-U>belowright split term://zsh " : "\<CR>"
    autocmd TermOpen * startinsert
else
    cnoremap <expr> <C-J>  getcmdline() == '' ? '!' : getcmdline() == '!' ? "\<C-U>TmuxSplitRun " : "\<CR>"
endif

nnoremap <silent> gs0 :echo synIDattr(synID(line('.'), col('.'), 1), 'name')<CR>
nnoremap <silent> gs1 :echo synIDattr(synID(line('.'), col('.'), 0), 'name')<CR>
nnoremap gs <nop>

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
nnoremap <ESC>m :update<Enter>:Make<Enter>

nnoremap <A-u> :update<Enter>
nnoremap <A-.> :cnext<Enter>
nnoremap <A-,> :cprev<Enter>

nnoremap <ESC> <C-W>

nnoremap <A-q> <C-W>q
nnoremap <A-o> <C-W>o
nnoremap <A-j> <C-W>j
nnoremap <A-k> <C-W>k
nnoremap <A-h> <C-W>h
nnoremap <A-l> <C-W>l
nnoremap <A-z> <C-W>z
nnoremap <A-J> <C-W>J
nnoremap <A-K> <C-W>K
nnoremap <A-H> <C-W>H
nnoremap <A-L> <C-W>L

" nnoremap <C-Q> :set hlsearch!<Enter>
" nnoremap /     :set hlsearch<Enter>/
" nnoremap ?     :set hlsearch<Enter>?
" nnoremap *     :set hlsearch<Enter>*

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

cnoremap <expr> <C-G> "\<C-U>grep" . (len(@/) ? ' ' . substitute(@/, '^\\<\(.*\)\\>', '-w \1', '') : '')

nmap <Space> [Space]
nmap [Space] <NOP>
let mapleader='0'

Plug 'motemen/vim-guess-abbrev'
inoremap <silent> <expr> <C-]> gabbrev#i_start()
let g:gabbrev#keyword_ch_pattern = '[[:alnum:]:]'

Plug 'tpope/vim-surround'
" let g:surround_no_mappings = 1
" nmap      ds   <Plug>Dsurround

" fuzzyfinder {{{
" Plug 'L9'
" Plug 'FuzzyFinder'
" let g:fuf_autoPreview = 0
" let g:fuf_previewHeight = 5
" let g:fuf_smartBs = 0
" let g:fuf_keyOpenTabpage = '<C-]>'
" let g:fuf_keyPreview = '<C-I>'
" let g:fuf_buffer_keyDelete = '<C-L>'
" let g:fuf_mrufile_keyExpand = '<C-L>'
" let g:fuf_enumeratingLimit = 300
" let g:fuf_maxMenuWidth = 100
" let g:fuf_splitPathMatching = 0
" 
" augroup vimrc-fuf
"     autocmd!
"     autocmd FileType fuf inoremap <buffer> <C-C> <ESC>
"     " autocmd FileType fuf inoremap <buffer> <C-D> <C-O>:FufRenewCache<CR><C-X><C-N>
"     autocmd FileType fuf inoremap <buffer> <F5>  <C-O>:FufRenewCache<CR><C-X><C-N>
"     autocmd FileType fuf inoremap <buffer> <C-S> <C-R>=fuf#launch('coveragefile', '', '') ? '' : ''<CR>
"     autocmd FileType fuf inoremap <buffer> <C-D> <C-R>=fuf#file#renewCache() ? '' : ''<CR>
" augroup END
"
" if exists('*neocomplcache#disable')
"     autocmd BufEnter \[fuf\] silent call neocomplcache#disable()
" endif
"
" if exists('*fuf#addMode')
"     autocmd VimEnter * call fuf#addMode('tab')
" endif
"
" let g:fuf_modesDisable = ['mrucmd','coveragefile','bookmarkfile','bookmarkdir']
"
" autocmd VimEnter * call fuf#addMode('vcsall')
" }}}

" tap.vim {{{
Plug 'motemen/tap-vim'
autocmd FileType tap-result nnoremap <buffer> <ESC>m :call tap#prove(b:tap_arg)<CR>
" }}}

noremap K <NOP>
nnoremap <Leader>* *N

nnoremap <C-W><C-U> :update<Enter>
nnoremap <C-W><C-C> <Nop>
nnoremap <ESC>/     :split<CR>/

command! -range=% Source silent split `=tempname()` | silent put=getbufline('#', <line1>, <line2>) | silent write | source % | bwipeout

""" Plug settings """

"  " CtrlP
"  Plug 'kien/ctrlp.vim'
"  Plug 'sgur/ctrlp-extensions.vim'
"  let g:ctrlp_extensions = ['ghq', 'quickfix', 'cmdline', 'yankring', 'tag' ]
"  let g:ctrlp_prompt_mappings = {
"    \ 'PrtBS()':              ['<bs>','<c-h>'],
"    \ 'PrtDelete()':          ['<del>'],
"    \ 'PrtDeleteWord()':      ['<c-w>'],
"    \ 'PrtClear()':           ['<c-u>'],
"    \ 'PrtSelectMove("j")':   ['<c-n>', '<down>'],
"    \ 'PrtSelectMove("k")':   ['<c-p>', '<up>'],
"    \ 'PrtHistory(-1)':       ['<m-p>'],
"    \ 'PrtHistory(1)':        ['<m-n>'],
"    \ 'AcceptSelection("e")': ['<cr>', '<2-LeftMouse>'],
"    \ 'AcceptSelection("h")': ['<c-j>', '<c-cr>', '<c-s>'],
"    \ 'AcceptSelection("t")': ['<c-]>', '<MiddleMouse>'],
"    \ 'AcceptSelection("v")': ['<c-k>', '<c-q>', '<RightMouse>'],
"    \ 'ToggleFocus()':        ['<s-tab>'],
"    \ 'ToggleRegex()':        ['<c-r>'],
"    \ 'ToggleByFname()':      ['<c-d>'],
"    \ 'ToggleType(1)':        ['<c-f>', '<c-up'],
"    \ 'ToggleType(-1)':       ['<c-b>', '<c-down>'],
"    \ 'PrtExpandDir()':       ['<tab>'],
"    \ 'PrtCurStart()':        ['<c-a>'],
"    \ 'PrtCurEnd()':          ['<c-e>'],
"    \ 'PrtCurLeft()':         ['<left>'],
"    \ 'PrtCurRight()':        ['<right>'],
"    \ 'PrtClearCache()':      ['<F5>'],
"    \ 'PrtDeleteMRU()':       ['<F7>'],
"    \ 'CreateNewFile()':      ['<c-y>'],
"    \ 'MarkToOpen()':         ['<c-z>'],
"    \ 'OpenMulti()':          ['<c-o>'],
"    \ 'PrtExit()':            ['<esc>', '<c-g>', '<c-c>'],
"    \ }
"  let g:ctrlp_max_depth = 10
"  let g:ctrlp_user_command = ['.git/', 'cd %s && git ls-files']
"  let g:ctrlp_use_caching = 1
"  let g:ctrlp_clear_cache_on_exit = 1
"  let g:ctrlp_map = 'g<C-P>'
"  
"  Plug 'mattn/ctrlp-ghq'
"  let g:ctrlp_ghq_default_action='tabedit'

Plug 'itchyny/lightline.vim' " {{{
let g:lightline = {}
let g:lightline.component = { 'filename': '%f' }
let g:lightline.active = {
            \ 'left': [ [ 'mode', 'paste' ],
            \           [ 'bufnum' ],
            \           [ 'readonly', 'filename', 'modified' ]
            \         ],
            \ 'right': [ [ 'cwd' ],
            \            [ 'lineinfo', 'gitbranch' ],
            \            [ 'preview', 'fileencoding', 'filetype' ]
            \          ]
            \ }
let g:lightline.inactive = {
            \ 'left': [ [ 'bufnum' ], [ 'filename' ], [ 'preview' ] ]
            \ }
let g:lightline.component_function = {
            \ 'cwd': 'Cwd',
            \ 'gitbranch': 'LightlineFugitive',
            \ 'preview': 'LightLine_Preview'
            \ }
function! LightlineFugitive()
    if exists('*fugitive#head')
        return fugitive#head(6)
    endif
    return ''
endfunction

function! LightLine_Preview()
    return &previewwindow ? '*PREVIEW*' : ''
endfunction
" }}}

" nnoremap <silent>    :let g:ctrlp_default_input = 0<CR>:CtrlPMixed<CR>
" nnoremap <silent>  :let g:ctrlp_default_input = 0<CR>:CtrlPMixed<CR>
" nnoremap <silent> t  :let g:ctrlp_default_input = 0<CR>:CtrlPTag<CR>
" nnoremap <silent> t  :let g:ctrlp_default_input = 0<CR>:CtrlPTag<CR>
" nnoremap <silent> p  :call ctrlp#init(ctrlp#perldoc#id())<CR>
" nnoremap <silent> <C-P>p  :call ctrlp#init(ctrlp#perldoc#id())<CR>
" nnoremap <silent> <C-P>g  :call ctrlp#init(ctrlp#ghq#id())<CR>

" override
" runtime autoload/ctrlp.vim

" redir => sc_names
" silent scriptnames
" redir END
" 
" let s:ctrlp_sid = matchstr(sc_names, '\zs[0-9]\+\ze: \S\+autoload/ctrlp\.vim')

" function! ctrlp#buffers(...)
"     let ids = sort(filter(range(1, bufnr('$')),
"                 \ 'getbufvar(v:val, "&bl") && strlen(bufname(v:val))'), '<SNR>'.s:ctrlp_sid.'_compmreb')
"     retu a:0 && a:1 == 'id' ? ids : map(ids, 'fnamemodify(bufname(v:val), ":.")')
" endf

Plug 'Lokaltog/vim-easymotion'
let g:EasyMotion_keys = 'abcdefghijklmnopqrstuvwxyz0123456789'
let g:EasyMotion_grouping = 1

" syntax/sh.vim
let g:is_bash = 1

" TOhtml
let html_number_lines = 0
let html_use_css = 1

" omap ab <Plug>(textobj-multiblock-a)
" omap ib <Plug>(textobj-multiblock-i)
" vmap ab <Plug>(textobj-multiblock-a)
" vmap ib <Plug>(textobj-multiblock-i)

autocmd BufRead *.tt      setfiletype html
autocmd BufNewFile,BufReadPost *.t   setlocal filetype=perl
autocmd BufRead *.psgi    setfiletype perl
autocmd BufReadPost GIT_COMMIT set fileencoding=utf-8
autocmd BufReadPost COMMIT_EDITMSG set fileencoding=utf-8

""" autocmds """
" autocmd BufWritePost,FileWritePost {*.vim,*vimrc} if &autoread | source <afile> | endif
autocmd Filetype html,xml,xsl,xhtml,markdown runtime plugin/closetag.vim | inoremap <silent> <C-_> <C-R>=GetCloseTag()<CR>
" autocmd QuickFixCmdPre * silent botright pedit \*preview\* | 99wincmd w | silent enew
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

augroup vimrc-cd-to-project-dir
    autocmd!
    autocmd BufEnter * if !exists('t:cwd') | call s:cd_to_project_dir() | endif

    nnoremap cD :call <SID>cd_to_project_dir()<CR>

    function! s:cd_to_project_dir()
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
            if filereadable('package.json')
                compiler npm
            endif
        endif
    endfunction
augroup END

function! s:SpacesAsAbove()
    let [lnum, col] = getpos('.')[1:2]
    let line_above  = getline(lnum - 1)
    if col >= len(line_above)
        return "\<C-U>"
    endif
    let string_ahead = matchstr(line_above, '\%' . (col + 1) . 'c\S*\s*')
    let len = strlen(string_ahead)
    return repeat(' ', len + 1)
endfunction

inoremap <expr> <C-E> pumvisible() ? "\<C-E>" : <SID>SpacesAsAbove()

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
"command! -nargs=* -complete=shellcmd TmuxSplitRun let _cmd = len(<q-args>) ? shellescape(substitute(<q-args> . '; read' , '%', expand('%'), '')) : '' | let tmux_run_command = printf('tmux if-shell "tmux select-pane -t.1" "send-keys ^C" \; if-shell "tmux respawn-pane -t.1 %s" "select-window" "split-window -d -v -p 30 %s"', _cmd, _cmd) | ruby `#{VIM::evaluate('tmux_run_command')}`
command! -nargs=* -complete=shellcmd -bang TmuxSplitRun
            \ let _cmd = len(<q-args>) ? shellescape(substitute(<q-args> . '; read' , '%', expand('%'), '')) : '' |
            \ let tmux_cmd = printf('tmux if-shell "tmux select-pane -t.1" "send-keys ^C" \; if-shell "tmux respawn-pane -t.1 %s" "select-window" "split-window -d -v -p 30 %s"%s', _cmd, _cmd, len('<bang>') ? ' \; resize-pane -Z' : '') |
            \ call system(tmux_cmd)
" nnoremap <Leader>! :TmuxSplitRun

nnoremap <Leader>c :call QlistFromTmux()<CR>
function! QlistFromTmux()
    let tmpfile = tempname()
    echo system("tmux 'capture-pane' '-t:.+' ';' 'save-buffer' " . tmpfile)
    execute 'cfile' tmpfile
endfunction

nnoremap <ESC>m :update<Enter>:execute 'TmuxSplitRun' &makeprg<Enter>

augroup vimrc-add-highlights
    autocmd!
    autocmd ColorScheme * call s:add_highlights()
    function! s:add_highlights()
        highlight clear MatchParen
        highlight MatchParen term=bold gui=bold cterm=bold
        highlight CursorLine ctermbg=NONE
        highlight CursorColumn ctermbg=NONE
        " highlight Pmenu ctermbg=grey ctermfg=236 guibg=grey guifg=#111111
        highlight Pmenu guibg=#000000 guifg=#c0c0aa
        highlight Pmenusel ctermbg=lightblue ctermfg=236
        highlight Pmenuselbar ctermbg=grey
        highlight Folded ctermbg=240 ctermfg=252 cterm=NONE
        highlight TabLine cterm=underline ctermbg=NONE
        highlight Title cterm=underline
        highlight Search ctermbg=cyan ctermfg=black
        highlight Visual cterm=NONE ctermbg=yellow ctermfg=black
        highlight StatusLine ctermbg=236
        highlight StatusLineNC ctermbg=236
        highlight Normal ctermbg=none
        highlight User1 ctermbg=NONE ctermfg=2
        highlight SpecialKey ctermfg=DarkGray
        highlight SpellBad ctermbg=NONE ctermfg=red cterm=underline
        highlight SpellCap ctermbg=Blue ctermfg=Black
        highlight NonText guibg=NONE guifg=#335393

        highlight clear LspErrorHighlight
        highlight LspErrorHighlight ctermfg=9 ctermbg=None guibg=#772222

        highlight clear LspErrorText
        highlight LspErrorText ctermfg=246 ctermbg=None guifg=#BBBBBB

        highlight clear LspWarningText
        highlight LspWarningText ctermfg=246 ctermbg=None guifg=#BBBBBB

        highlight clear LspWarningHighlight
        highlight LspWarningHighlight cterm=underline guibg=#555522

        highlight clear LspHintText
        highlight LspHintText ctermfg=246 ctermbg=None
    endfunction
augroup END

set termguicolors

command! -nargs=1 -complete=custom,PerlModules Perldoc new | :call Perldoc(<q-args>)
command! -nargs=* -range GitBrowseRemote !git browse-remote --rev -L<line1>,<line2> <f-args> -- %
command! -nargs=* -range GitBrowseRemoteCopy !git browse-remote --rev -L<line1>,<line2> <f-args> -- %
" vnoremap <silent> u :<C-U>let @+ = split(system('git browse-remote --rev -L' . line("'<") . ',' . line("'>") . ' --stdout -- ' . expand('%')), '\n')[0]<CR>:echo 'Copied "' . @+ . '" to clipboard'<CR>
vnoremap <silent> u :<C-U>call CopyGitReference()<CR>

function! CopyGitReference()
    let text = split(system('git browse-remote --rev -L' . line("'<") . ',' . line("'>") . ' --stdout -- ' . expand('%')), '\n')[0]
    let text = substitute(text, '#L1$', '', '')
    if visualmode() ==# 'v'
        normal! gv"xy
        let m = matchlist(getline(1), 'package \([^;]\+\)')
        if len(m)
            let @x = m[1] . '#' . @x
        endif
        let text = '<code>[' . text . ':title=' . @x . ']</code>'
    endif
    let @+ = text
    echo 'Copied "' . @+ . '" to clipboard'
endfunction

" nnoremap <silent> <C-]> :call UpdateCtags()<CR>:normal! \<C-]\><CR>

function! UpdateCtags()
    if stridx(expand('%:p'), getcwd()) != 0
        return 0
    end

    for tagfile in tagfiles()
        if getftime(tagfile) > getftime(expand('%'))
            return 0
        endif
    endfor

    !ctags -R $(git ls-tree --name-only HEAD)
endfunction

function! PerlModules(arg_lead, cmd_line, cursor_ops)
    return system('pm-packages.pl --local')
endfunction

function! Perldoc(args)
    if !&modifiable || &modified || bufname('%') != ''
        throw 'Perldoc: cannot use this buffer'
    endif

    let bufname = '[perldoc ' . a:args . ']'

    if bufexists(bufname)
        execute 'buffer' bufnr(fnameescape(bufname))
        return
    endif

    enew

    let perldoc = 'perldoc'
    if isdirectory('local/lib/perl5')
        let perldoc = 'PERL5OPT=-Ilocal/lib/perl5 ' . perldoc
    end

    setlocal buftype=nofile
    silent execute '0read!' . perldoc . ' -otext -T' a:args

    if v:shell_error
        let message = getline(1)
        bwipeout
        echohl Error
        echo message
        echohl None
    else
        let b:perldoc_args = a:args
        file `=bufname`
        setlocal noswapfile nomodifiable
        setfiletype man
        execute "nnoremap <buffer> s :edit `=system('" . perldoc . " -l ' . b:perldoc_args)`<Enter>"
        0
    endif
endfunction

augroup pm-autoinsert-package
    autocmd!
    autocmd BufNewFile *.pm call append(0, [
                    \ 'package ' . fnamemodify(expand('%'), ':r:s.^lib/..:gs./.::.') . ';',
                    \ 'use strict;', 'use warnings;'
                \ ])
                \ | call append(line('$'), '1;')
                \ | set modified
augroup END

augroup gemfile-autoinsert-source
    autocmd!
    autocmd BufNewFile Gemfile call append(0, "source 'https://rubygems.org'") | set modified
augroup END

augroup maincpp--autoinsert
    autocmd!
    autocmd BufNewFile main.cpp call append(0, [ '#include <iostream>', '', 'using namespace std;', '', 'int main() {', '}' ]) | set modified | delete | normal! k
augroup END

function! ReadVimCommand(command)
    let f = tempname()
    execute 'redir >' f
    execute a:command
    redir END
    execute 'split' f
endfunction

""" Experimental zone

Plug 'tpope/vim-abolish'

" Bundle "osyo-manga/vim-textobj-multiblock"
" Bundle 'c9s/perlomni.vim'
Plug 'LeafCage/yankround.vim'
nmap p <Plug>(yankround-p)
nmap P <Plug>(yankround-P)
nmap <C-p> <Plug>(yankround-prev)
nmap <C-n> <Plug>(yankround-next)

Plug 'osyo-manga/vim-over'
cnoremap <C-S> <C-U>OverCommandLine<CR>

nnoremap m* :<C-U>grep <cword><CR>
vnoremap m* :<C-U>let x_save = @x <Bar> normal "xy <Bar> grep <C-R>x<CR> <Bar> let @x = x_save

Plug 'severin-lemaignan/vim-minimap'

Plug 'majutsushi/tagbar' "{{{

let g:tagbar_sort = 0
let g:tagbar_iconchars = ['▸', '▾']
let g:tagbar_type_javascript = {
    \ 'ctagstype' : 'JavaScript',
    \ 'kinds'     : [
        \ 'f:functions',
        \ 'c:classes',
        \ 'm:methods',
        \ 'p:properties',
        \ 'v:global variables',
        \ 'C:Angular controllers',
        \ 'S:Angular services',
        \ 'D:Angular directives',
        \ 'F:Angular factories'
    \ ],
    \ 'replace': 1
\ }

let g:tagbar_type_scala = {
    \ 'ctagstype' : 'scala',
    \ 'kinds'     : [
        \ 'c:Classes',
        \ 'o:Objects',
        \ 'C:Case classes',
        \ 'O:Case objects',
        \ 't:Traits',
        \ 'T:Types',
        \ 'm:Methods',
        \ 'v:Values',
        \ 'V:Variables',
        \ 'p:Packages'
    \ ]
\ }

let g:tagbar_type_go = {
    \ 'ctagstype' : 'go',
    \ 'kinds'     : [
        \ 'p:Package',
        \ 'i:Imports:1',
        \ 'c:Constants',
        \ 'v:Variables',
        \ 't:Types',
        \ 'n:Interfaces',
        \ 'w:Fields',
        \ 'e:Embedded',
        \ 'm:Methods',
        \ 'r:Constructor',
        \ 'f:Functions'
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : {
        \ 't' : 'ctype',
        \ 'n' : 'ntype'
    \ },
    \ 'scope2kind' : {
        \ 'ctype' : 't',
        \ 'ntype' : 'n'
    \ },
    \ 'ctagsbin'  : 'gotags',
    \ 'ctagsargs' : '-sort -silent'
\ }
" }}}

Plug 'haya14busa/incsearch.vim'
let g:incsearch#auto_nohlsearch = 1
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map n  <Plug>(incsearch-nohl-n)
map N  <Plug>(incsearch-nohl-N)
nnoremap g/ /

Plug 'haya14busa/vim-asterisk'
map *  <Plug>(incsearch-nohl0)<Plug>(asterisk-z*)
map g* <Plug>(incsearch-nohl0)<Plug>(asterisk-gz*)
map #  <Plug>(incsearch-nohl0)<Plug>(asterisk-z#)
map g# <Plug>(incsearch-nohl0)<Plug>(asterisk-gz#)

Plug 'tpope/vim-dispatch'

command! -range GitLogRange TmuxSplitRun git log -p -L <line1>,<line2>:%

Plug 'terryma/vim-expand-region'

vmap v <Plug>(expand_region_expand)

Plug 'junegunn/vim-easy-align'
vmap <Enter> <Plug>(EasyAlign)

Plug 'garyburd/go-explorer'

Plug 'Townk/vim-autoclose'

" Plug 'digitaltoad/vim-jade'

let g:loaded_matchparen = 1
Plug 'itchyny/vim-parenmatch'
Plug 'itchyny/vim-cursorword'

" Plug 'motemen/hatena-vim'

" Plug 'vim-syntastic/syntastic' " {{{
" let g:syntastic_typescript_checkers = ['tslint']
" let g:syntastic_check_on_open = 1
" let g:syntastic_check_on_wq = 0
" " }}}

" Plug 'w0rp/ale'
" let g:ale_linters = {
"             \ 'perl': [],
"             \ 'ruby': [],
"             \ 'java': [],
"             \ }

" Plug 'ensime/ensime-vim'

if has('nvim')
  Plug 'Shougo/vimproc.vim'
endif

Plug 'runoshun/vim-alloy'

autocmd! filetypedetect BufReadPost *.run

Plug 'vim-scripts/nagios-syntax'

Plug 'eagletmt/ghcmod-vim'

" test!!!
" inoremap jj <ESC>

Plug 'tpope/vim-fugitive'
nnoremap <Leader>gd :Gdiff<CR>
nnoremap <Leader>gs :Gstatus<CR>
nnoremap <Leader>gc :Gcommit<CR>

Plug 'glidenote/keepalived-syntax.vim'

if !has('nvim')
    Plug 'davidhalter/jedi-vim'
endif

" Plug 'maralla/completor.vim'
" let g:completor_completion_delay = 300

Plug 'vim-airline/vim-airline'
let g:airline#extensions#whitespace#checks = []
let g:airline#extensions#tagbar#enabled = 0
let g:airline_symbols = {
    \ 'maxlinenr': ''
    \ }

Plug 'aklt/plantuml-syntax'

Plug 'jparise/vim-graphql'
autocmd BufRead *.graphql set filetype=graphql

" Plug 'pedrohdz/vim-yaml-folds'

" Plug 'prabirshrestha/asyncomplete.vim'
" " let g:asyncomplete_auto_popup = 0
" inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
" inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
" inoremap <expr> <CR>    pumvisible() ? "\<C-y>" : "\<CR>"

Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'
" Plug 'prabirshrestha/asyncomplete-lsp.vim'

let g:lsp_async_completion = 1
let g:lsp_signs_enabled = 1
let g:lsp_diagnostics_echo_cursor = 1
let g:lsp_signs_error   = {'text': 'x'}
let g:lsp_signs_warning = {'text': '!'}
let g:lsp_signs_hint    = {'text': 'o'}
let g:lsp_preview_doubletap = 0

if executable('gopls')
    augroup LspGopls
        autocmd!
        autocmd User lsp_setup call lsp#register_server({
            \ 'name': 'gopls',
            \ 'cmd': {server_info->['gopls', '-mode', 'stdio']},
            \ 'whitelist': ['go'],
            \ 'workspace_config': {'gopls': {
            \     'staticcheck': v:true,
            \     'completeUnimported': v:true,
            \     'caseSensitiveCompletion': v:true,
            \     'usePlaceholders': v:true,
            \     'completionDocumentation': v:true,
            \     'watchFileChanges': v:true,
            \     'hoverKind': 'SingleLine',
            \   }},
            \ })
        autocmd BufWritePre *.go LspDocumentFormatSync
        autocmd FileType go setlocal omnifunc=lsp#complete
        autocmd FileType go nnoremap <buffer> <C-]> :LspDefinition<CR>
    augroup END
endif

if executable('rls')
    augroup LspRls
        autocmd!
        autocmd User lsp_setup call lsp#register_server({
                    \ 'name': 'rls',
                    \ 'cmd': {server_info->['rustup', 'run', 'stable', 'rls']},
                    \ 'workspace_config': {'rust': {'clippy_preference': 'on'}},
                    \ 'whitelist': ['rust'],
                    \ })
        autocmd BufWritePre *.rs LspDocumentFormatSync
        autocmd FileType rust setlocal omnifunc=lsp#complete
        autocmd FileType rust nnoremap <buffer> <C-]> :LspDefinition<CR>
    augroup END
endif

Plug 'natebosch/vim-lsc'

if executable('typescript-language-server')
    autocmd User lsp_setup call lsp#register_server({
        \ 'name': 'typescript-language-server',
        \ 'cmd': {server_info->[&shell, &shellcmdflag, 'typescript-language-server --stdio']},
        \ 'root_uri':{server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'tsconfig.json'))},
        \ 'whitelist': ['typescript', 'typescript.tsx'],
        \ })
    autocmd FileType typescript setlocal omnifunc=lsp#complete
endif

if executable('vls')
    augroup LspVls
        autocmd!
        autocmd User lsp_setup call lsp#register_server({
                    \ 'name': 'vue-language-server',
                    \ 'cmd': {server_info->['vls']},
                    \ 'whitelist': ['vue'],
                    \ 'initialization_options': {
                    \     'config': {
                    \         'html': {},
                    \         'vetur': {
                    \             'validation': {},
                    \             'completion': {}
                    \          }
                    \        }
                    \     }
                    \ })
        autocmd FileType vue setlocal omnifunc=lsp#complete
    augroup end
endif

inoremap <C-L> <C-O>:LspHover<CR>
nnoremap <C-K><C-I> :LspHover<CR>

Plug 'prettier/vim-prettier', { 'do': 'yarn install' }

Plug 'sheerun/vim-polyglot'
let g:rust_recommended_style = 0 " sets tabstop=8 :(

call plug#end()

colorscheme desert-warm-256
" colorscheme wombat256mod

finish
