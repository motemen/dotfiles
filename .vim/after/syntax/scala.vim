" scala.vim
" syntax keyword scalaScopeDecl implicit

syntax clear scalaInstanceDeclaration
syntax clear scalaCapitalWord
" syntax clear scalaSpecial
highlight link scalaSpecial Special
highlight link scalaEscapedChar Special
highlight link scalaKeywordModifier Keyword
highlight link scalaNameDefinition None
highlight link scalaTypeDeclaration None
highlight link scalaSquareBracketsBrackets None

syntax clear scalaAkkaSpecialWord
syntax clear scalaAkkaFSM

syntax keyword scalaTypeKeyword nextgroup=scalaInstanceDeclaration skipwhite object
syntax keyword scalaTypeKeyword nextgroup=scalaInstanceDeclaration skipwhite class
syntax keyword scalaTypeKeyword nextgroup=scalaInstanceDeclaration skipwhite trait
syntax keyword scalaTypeKeyword nextgroup=scalaNameDefinition,scalaQuasiQuotes skipwhite val
syntax keyword scalaTypeKeyword nextgroup=scalaNameDefinition skipwhite var
syntax keyword scalaTypeKeyword nextgroup=scalaNameDefinition skipwhite def
highlight link scalaTypeKeyword TypeDef
