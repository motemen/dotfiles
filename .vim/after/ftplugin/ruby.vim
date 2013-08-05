setlocal softtabstop=2 shiftwidth=2

let b:bundle_prefix = ''
if len(glob('Gemfile')) > 0
    let b:bundle_prefix = 'bundle exec '
end

if expand('%') =~ '^spec/'
    let &l:makeprg = b:bundle_prefix . 'rspec --format documentation %'
endif

setlocal includeexpr=substitute(system(b:bundle_prefix.'gem\ which\ '.v:fname.'\ 2>/dev/null'),'[\\r\\n]','','g')
