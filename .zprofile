eval "$(/opt/homebrew/bin/brew shellenv)"
export PATH=$PATH:/usr/sbin
export PATH=/usr/local/bin:$PATH
export PATH=$HOME/.cabal/bin:$PATH
export PATH=$HOME/.local/bin:$PATH
export PATH=$PATH:$HOME/Library/Haskell/bin
export PATH=$PATH:$HOME/dev/flutter/bin

export RLWRAP_HOME=~/.rlwrap

# export LD_LIBRARY_PATH=$HOME/homebrew/lib:/usr/lib
# export DYLD_FALLBACK_LIBRARY_PATH=/usr/local/mysql/lib
export C_INCLUDE_PATH=$HOME/homebrew/include
export CPLUS_INCLUDE_PATH=$HOME/homebrew/include

export MYSQL_PS1='\u@\h [\d]> '

export ANDROID_SDK_ROOT=$HOME/Library/Android/sdk
export ANDROID_HOME=$HOME/Library/Android/sdk
# export NODE_PATH=/usr/local/lib/node_modules
# if type brew > /dev/null; then
#     export NODE_PATH=$NODE_PATH:$(brew --prefix)/lib/node_modules
# fi

export LESS='--ignore-case --raw-control-chars --status-column --HILITE-UNREAD --LONG-PROMPT --force'
export PAGER="$(which less)"
export FILTER=fzf

export PERL_REPL=rp

export LANG=ja_JP.UTF-8

# export _JAVA_OPTIONS='-Dfile.encoding=UTF-8'
# if [ -x /usr/libexec/java_home ]; then
#     export JAVA_HOME=$(/usr/libexec/java_home -v 1.7)
# fi

# autoload -U compinit; compinit

# . $(brew --prefix)/share/zsh/site-functions/_go

# if type brew > /dev/null; then
#     export SSL_CERT_FILE="$(brew --prefix)/etc/openssl/cert.pem"
# fi

if [ -e ~/.zsh/local.profile ]; then
    . ~/.zsh/local.profile
fi

# if which plenv > /dev/null; then
#     eval "$(plenv init - --no-rehash)"
# fi

# if which rbenv > /dev/null; then
#     eval "$(rbenv init - --no-rehash)"
# fi

# if which nodenv > /dev/null; then
#     eval "$(nodenv init - --no-rehash)"
# fi

# if which pyenv > /dev/null; then
#     eval "$(pyenv init - --no-rehash)"
# fi

export PATH=$HOME/bin:$PATH


export RUST_SRC_PATH=~/.multirust/toolchains/stable-x86_64-apple-darwin/lib/rustlib/src/rust/src
export RIPGREP_CONFIG_PATH=~/.ripgreprc

export ANDROID_HOME=$HOME/Library/Android/sdk

export PATH="$HOME/.poetry/bin:$PATH"

export GOPATH=$HOME/dev
export PATH=$PATH:$HOME/dev/bin:$(go env GOROOT)/bin
export EDITOR="$(which nvim)"
