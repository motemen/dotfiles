export RLWRAP_HOME=~/.rlwrap

export PATH=$PATH:/usr/sbin
export PATH=/usr/local/bin:$PATH
export PATH=/usr/local/Cellar/python/2.7.1/bin/:$PATH
# export PATH=/usr/local/Cellar/ruby/1.9.3-p0/bin:$PATH
export PATH=$HOME/.cabal/bin:$PATH
export PATH=$HOME/bin:$HOME/sbin:$PATH

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

# eval `ssh-agent -t 1800`
if which keychain > /dev/null; then
    eval $(keychain --agents ssh --quick --timeout 30 --nogui --eval id_rsa)
fi
