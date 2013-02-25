highlight link tt2_tag Special
highlight link tt2_variable Normal
highlight link tt2_operator Normal
syntax clear tt2_comment
syntax match tt2_comment +#.\{-}\ze\(\s*%]\)\=$+ contained extend
