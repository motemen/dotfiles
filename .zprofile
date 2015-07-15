export PATH=$PATH:/usr/sbin
export PATH=/usr/local/bin:$PATH
export PATH=$HOME/homebrew/bin:$PATH
export PATH=$HOME/.cabal/bin:$PATH
export PATH=$HOME/bin:$HOME/dev/bin:$HOME/sbin:$PATH
export PATH=$PATH:$HOME/Library/Haskell/bin

export RLWRAP_HOME=~/.rlwrap

# export LD_LIBRARY_PATH=$HOME/homebrew/lib:/usr/lib
# export DYLD_FALLBACK_LIBRARY_PATH=/usr/local/mysql/lib
export C_INCLUDE_PATH=$HOME/homebrew/include
export CPLUS_INCLUDE_PATH=$HOME/homebrew/include

export MYSQL_PS1='\u@\h [\d]> '

export ANDROID_SDK_ROOT=/usr/local/opt/android-sdk
export NODE_PATH=/usr/local/lib/node_modules
if type brew > /dev/null; then
    export NODE_PATH=$NODE_PATH:$(brew --prefix)/lib/node_modules
fi

export EDITOR="$(which vim)"
export LESS='--ignore-case --raw-control-chars --status-column --HILITE-UNREAD --LONG-PROMPT --force'
export PAGER="$(which less)"

export PERL_REPL=rp

export LANG=ja_JP.UTF-8

# export _JAVA_OPTIONS='-Dfile.encoding=UTF-8'
if [ -x /usr/libexec/java_home ]; then
    export JAVA_HOME=$(/usr/libexec/java_home -v 1.7)
fi

autoload -U compinit; compinit

export GOPATH=$HOME/dev/go:$HOME/dev
export PATH=$PATH:$HOME/dev/bin:$HOME/dev/go/bin:$(go env GOROOT)/bin

# . $(brew --prefix)/share/zsh/site-functions/_go

if type brew > /dev/null; then
    export SSL_CERT_FILE="$(brew --prefix)/etc/openssl/cert.pem"
fi

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

if which exa >/dev/null 2>&1; then
    alias l='exa -a'
    alias ll='exa -la'
fi
