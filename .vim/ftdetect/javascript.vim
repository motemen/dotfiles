autocmd BufRead * if !did_filetype() && getline(1) =~ '^#!.*node' | setfiletype javascript | endif
