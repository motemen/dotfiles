syntax clear goExtraType
syntax clear goBuiltins

syntax match goFormatSpecifier +%_+ contained containedin=goString
syntax match goBuiltins /\<\v(append|cap|close|complex|copy|delete|imag|len)\ze\(/
syntax match goBuiltins /\<\v(make|new|panic|real|recover)\ze\(/
