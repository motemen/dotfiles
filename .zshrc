# Vim で Ctrl-Q, Ctrl-S が効くように
stty -ixon -ixoff

autoload -U colors; colors

# PATH 指定前に
GIT_BIN="$(which git)"

setopt auto_cd
setopt auto_pushd
setopt pushd_ignore_dups
setopt auto_menu
setopt equals
setopt no_flow_control
setopt no_hup
setopt brace_ccl        # {a-c} -> a b c
setopt extended_glob
setopt list_types
setopt multios
setopt numeric_glob_sort
setopt no_promptcr
setopt pushd_ignore_dups
setopt auto_resume
setopt extended_history
setopt no_auto_remove_slash
setopt interactive_comments
setopt null_glob

# export WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'
export WORDCHARS=${WORDCHARS//[\/]}

#
# Prompt
#

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

#
# Key binding
#
bindkey -e
bindkey '^R' history-incremental-pattern-search-backward
bindkey '^S' history-incremental-pattern-search-forward

bindkey -s '5~'   ' f5\n'
bindkey -s '7~'   ' f6\n'
bindkey -s '7;2~' ' s_f6\n'
bindkey -s '8~'   ' f7\n'
bindkey -s '9~'   ' f8\n'

may_fg () {
    if [ -z "$(jobs -s)" ]; then
        tmux last-pane
    else
        fg
    fi
    zle reset-prompt
}
zle -N may_fg
bindkey '^Z' may_fg

# http://qiita.com/items/1e1d3053c33f528363d9
tm () {
    if [ -z $TMUX ]; then
        if tmux has-session 2> /dev/null; then
            tmux -2 attach $*
        else
            tmux -2 $*
        fi
    fi
}

# perlbrew
if [ -e "$HOME/perl5/perlbrew/etc/bashrc" ]; then
    source "$HOME/perl5/perlbrew/etc/bashrc"
fi

#
# History
#
HISTFILE=$HOME/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
setopt append_history
setopt share_history
setopt hist_ignore_dups
setopt hist_ignore_space

autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

autoload -U modify-current-argument
_quote-previous-word-in-single() {
    modify-current-argument '${(qq)${(Q)ARG}}'
    zle vi-forward-blank-word
}
zle -N _quote-previous-word-in-single
bindkey '^[s' _quote-previous-word-in-single

zstyle ':completion:*:default' menu select=1

_vim-this() {
    modify-current-argument 'vim ${(Q)ARG}'
    zle accept-line
}
zle -N _vim-this
bindkey '^[v' _vim-this

_clear-line-echo () {
    printf "%-${COLUMNS}s\r" $1
}

#
# Completion
#

# XXX moved to zprofile
# _clear-line-echo "compinit..."
# 
# autoload -U compinit; compinit

#
# Aliases
#
_clear-line-echo "aliasing..."

alias rm='rm -i'
alias mv='mv -i'

ls=$(which gls > /dev/null 2>&1 && echo 'gls' || echo 'ls')
if [ $(uname) = 'Darwin' -a "$ls" = 'ls' ]; then
    export LS_OPTIONS=-GF
else
    export LS_OPTIONS='--color -F'
fi
alias ls="$ls $LS_OPTIONS"
alias ll="$ls -hAlt"
# alias lv='lv -c -T8192'
# alias lv='lv -R'
alias :e='vim'
alias :q='exit'
alias ssh="TERM=screen $(whence ssh)"
alias vi='vim'
alias vicat='if [ -p /dev/stdin ]; then vim -R -; else TEMPFILE=$(gmktemp) && vim $TEMPFILE && cat $TEMPFILE; fi'

#
# Functions
#

export GIT_PS1_SHOWUPSTREAM='verbose'
export GIT_PS1_DESCRIBE_STYLE='branch'
export GIT_PS1_SHOWDIRTYSTATE='yes'
export GIT_PS1_SHOWCOLORHINTS='yes'

if which brew > /dev/null; then
    . $(brew --prefix)/etc/bash_completion.d/git-prompt.sh
elif [ -e /etc/bash_completion.d/git-prompt ]; then
    . /etc/bash_completion.d/git-prompt
fi

function _update_prompt {
    GIT_BRANCH=$(__git_ps1 '%s')

    PROMPT="[%{%(?.$fg_bold[green].$fg_bold[red])%}%(5~,%-2~/.../%2~,%~)${reset_color}]"
    if [ $GIT_BRANCH ]; then
        PROMPT="$PROMPT ${fg[yellow]}$GIT_BRANCH${reset_color}"
    fi
    if [ $PERLBREW_PERL ]; then
        PROMPT="$PROMPT  ${fg[white]}(${PERLBREW_PERL})${reset_color}"
    fi
    PROMPT="%D{%H:%M:%S} $PROMPT%E
$HOST%# "

    jobs_suspended=$(( $(jobs -s | wc -l) ))
    if [ $jobs_suspended != 0 ]; then
        if [ $jobs_suspended = 1 ]; then
            jobs_suspended=''
        fi
        PROMPT="$fg[yellow]${jobs_suspended}z${reset_color} $PROMPT"
    fi

    jobs_background=$(( $(jobs -r | wc -l) ))
    if [ $jobs_background != 0 ]; then
        if [ $jobs_background = 1 ]; then
            jobs_background=''
        fi
        PROMPT="$fg[yellow]${jobs_background}&${reset_color} $PROMPT"
    fi
}

function chpwd() {
    _update_prompt
    # ls -t
    # k || ls -t
}

function precmd() {
    _update_prompt
    [ -n "$TMUX" ] && echo -ne "\ek$(basename $(pwd))\e\\"
}

function sssh () {
    tmux new-window "ssh $1"
    shift

    for host in $* ; do
        tmux split-window "ssh $host || read"
    done

    tmux select-layout tiled > /dev/null
    tmux select-pane -t 0 > /dev/null
    tmux set-window-option synchronize-panes on > /dev/null
}

if [ -e ~/.zsh/local ]; then
    source ~/.zsh/local
fi

if [ -e ~/.zsh.d/k/k.sh ]; then
    source ~/.zsh.d/k/k.sh
fi

#
# Setting for screen
#
# From <http://www.nijino.com/ari/diary/?20020614&to=200206141S1#200206141S1>
if [ "$TERM" = "screen" -o "$TERM" = "screen-256color" ]; then
    preexec() {
        if [ -n "$TMUX" ]; then
            emulate -L zsh
            local -a cmd; cmd=(${(z)2})

            if [[ $cmd[1] = 'fg' ]]; then
                echo -ne "\ek%$(builtin jobs -l %+)\e\\" 2> /dev/null
            elif [[ $cmd[1] = 'ssh' ]]; then
                echo -ne "\ek%$cmd[2]\e\\"
            else
                echo -ne "\ek@${${1#*=* }%% *}\e\\"
            fi
        fi
    }
fi

if which brew > /dev/null; then
    if [ -f "$(brew --prefix)/etc/autojump" 2> /dev/null ]; then
        _clear-line-echo "autojump..."
        . "$(brew --prefix)/etc/autojump"
    fi
fi


. $(brew --prefix)/share/zsh/site-functions/go

export GOROOT=$(brew --prefix go)
export GOPATH=$HOME/.go

export PATH=$PATH:$GOPATH/bin

# testing
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format 'No matches for: %d'
zstyle ':completion:*' group-name ''

_clear-line-echo "＼＼\\└('ω')」//／／"
echo
