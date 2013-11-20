setlocal ignorecase

if has('mac')
    nnoremap <silent> K :call system('open dash://go:' . expand('<cword>'))<CR>
endif
