" exclude `--foo)` matches from within `$(cmd --foo)`
syntax match shOption "\s\zs--[^ \t$`'"|)]\+"

" Wondering why vim's default syntax/sh.vim tries to include `-' as a keyword :/
execute 'syntax iskeyword ' . &iskeyword
