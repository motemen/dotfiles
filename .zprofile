export RLWRAP_HOME=~/.rlwrap

export PATH=$PATH:/usr/sbin
export PATH=/usr/local/bin:$PATH
export PATH=$HOME/homebrew/bin:$PATH
export PATH=$HOME/.cabal/bin:$PATH
export PATH=$HOME/bin:$HOME/sbin:$PATH

# export LD_LIBRARY_PATH=$HOME/homebrew/lib:/usr/lib
# export DYLD_FALLBACK_LIBRARY_PATH=/usr/local/mysql/lib
export C_INCLUDE_PATH=$HOME/homebrew/include
export CPLUS_INCLUDE_PATH=$HOME/homebrew/include

if which rbenv > /dev/null; then
    eval "$(rbenv init -)"
fi

export MYSQL_PS1='\u@\h [\d]> '

export ANDROID_SDK_ROOT=/usr/local/opt/android-sdk
export NODE_PATH=/usr/local/lib/node_modules

export EDITOR="$(which vim)"
export PAGER="$(which lv) -c -T8192"

export PERL_REPL=rp

export LANG=ja_JP.UTF-8

export _JAVA_OPTIONS='-Dfile.encoding=UTF-8'
