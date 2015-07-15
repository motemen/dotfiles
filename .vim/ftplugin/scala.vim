setlocal softtabstop=2 shiftwidth=2 tabstop=2

setlocal errorformat=%E\ %#[error]\ %#%f:%l:\ %m,%-Z\ %#[error]\ %p^,%-C\ %#[error]\ %m
setlocal errorformat+=,%W\ %#[warn]\ %#%f:%l:\ %m,%-Z\ %#[warn]\ %p^,%-C\ %#[warn]\ %m
setlocal errorformat+=,%-G%.%#
