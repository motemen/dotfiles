export PATH=$PATH:/usr/sbin
export PATH=/usr/local/bin:$PATH
export PATH=$HOME/homebrew/bin:$PATH
export PATH=$HOME/.cabal/bin:$PATH
export PATH=$HOME/bin:$HOME/sbin:$PATH

export RLWRAP_HOME=~/.rlwrap

# export LD_LIBRARY_PATH=$HOME/homebrew/lib:/usr/lib
# export DYLD_FALLBACK_LIBRARY_PATH=/usr/local/mysql/lib
export C_INCLUDE_PATH=$HOME/homebrew/include
export CPLUS_INCLUDE_PATH=$HOME/homebrew/include

export MYSQL_PS1='\u@\h [\d]> '

export ANDROID_SDK_ROOT=/usr/local/opt/android-sdk
export NODE_PATH=/usr/local/lib/node_modules
export NODE_PATH=$NODE_PATH:$(brew --prefix)/lib/node_modules

export EDITOR="$(which vim)"
export LESS='--ignore-case --raw-control-chars --status-column --HILITE-UNREAD --LONG-PROMPT --force'
export PAGER="$(which less)"

export PERL_REPL=rp

export LANG=ja_JP.UTF-8

# export _JAVA_OPTIONS='-Dfile.encoding=UTF-8'

autoload -U compinit; compinit

export GOPATH=$HOME/dev
export PATH=$PATH:$GOPATH/bin:$(go env GOROOT)/bin

. $(brew --prefix)/share/zsh/site-functions/_go

export SSL_CERT_FILE="$(brew --prefix)/etc/openssl/cert.pem"

if [ -e ~/.zsh/local.profile ]; then
    . ~/.zsh/local.profile
fi

if which plenv > /dev/null; then
    export PATH=$HOME/.plenv/shims:$PATH
    eval "$(plenv init -)"
fi

if which rbenv > /dev/null; then
    eval "$(rbenv init -)"
fi
