syntax match fluentDirective +<[^>]*>+ contains=fluentDirectiveName fold
syntax match fluentParameter +^ *\zs[a-z]\S*+
syntax match fluentComment +#.*+
syntax match fluentDirectiveName +@\=[a-z_]\++ contained nextgroup=fluentDirectiveArg
syntax match fluentDirectiveArg +[^>]*+ contained

highlight link fluentDirective Label
highlight link fluentParameter Function
highlight link fluentComment Comment
highlight link fluentDirectiveName Label
highlight link fluentDirectiveArg String
