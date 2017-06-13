syntax clear asciidocQuotedMonospaced2
syntax match asciidocQuotedMonospaced2 /\(^\|[| \t([.,=\]（）、。]\)\@<=`\([` \n\t]\)\@!\(.\|\n\(\s*\n\)\@!\)\{-}\S\(`\([| \t)[\],.?!;:=（）]\|$\)\@=\)/
