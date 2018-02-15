setlocal ignorecase

nnoremap gK :<C-U>GoDocBrowser<CR>

inoremap <silent> <C-L> <ESC>viWd:GoImport <C-R>"<CR>a<C-R>=substitute(@", ".*/", "", "")<CR>.<C-X><C-O>
