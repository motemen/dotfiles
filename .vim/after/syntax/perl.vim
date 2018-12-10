syntax region perlString matchgroup=perlStringStartEnd start=/</ end=/>/  keepend extend contains=@perlInterpDQ oneline
highlight link perlMethod Normal

syntax clear perlStatementControl
syntax match perlStatementControl /\<\%(return\|last\|next\|redo\|goto\|break\)\>/
