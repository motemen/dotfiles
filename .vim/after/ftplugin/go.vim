let &l:path='.,' . substitute($GOPATH, ':', '/src,', 'g') . '/src'
setlocal tabstop=4 shiftwidth=4 noexpandtab

highlight link goMethod Normal
highlight link goStruct Normal
highlight link goStructDef Normal

syntax clear goExtraType
