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
# setopt no_hup
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
REPORTTIME=5

#
# Completion
#

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
# zstyle ':completion:*' verbose yes
zstyle ':completion:*' group-name ''
zstyle ':completion:*:default' menu select=1
zstyle ':completion:*:descriptions' format '%B%d%b'
# zstyle ':completion:*:messages' format '%d'
# zstyle ':completion:*:warnings' format 'No matches for: %d'
if [ -d ~/.zsh/cache ]; then
    zstyle ':completion:*' use-cache yes
    zstyle ':completion:*' cache-path ~/.zsh/cache
fi

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
        builtin fg
    fi
    _update_prompt
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

export FZF_DEFAULT_OPTS='+2 -x'
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
# alias lv='lv -c -T8192'
# alias lv='lv -R'
alias :e='vim'
alias :q='exit'
alias ssh="TERM=screen $(whence ssh)"
alias vi='vim'
alias vicat='if [ -p /dev/stdin ]; then vim -R -; else TEMPFILE=$(gmktemp) && vim $TEMPFILE && cat $TEMPFILE; fi'
alias curl='noglob curl'

#
# Functions
#
_clear-line-echo "functions..."

export GIT_PS1_SHOWUPSTREAM='verbose'
export GIT_PS1_DESCRIBE_STYLE='branch'
export GIT_PS1_SHOWDIRTYSTATE='yes'
export GIT_PS1_SHOWCOLORHINTS='yes'

brew_prefix=''
if type brew > /dev/null; then
    brew_prefix="$(brew --prefix)"
fi

if [ -n "$brew_prefix" ]; then
    . "$brew_prefix/etc/bash_completion.d/git-prompt.sh"
    fpath=("$brew_prefix/share/zsh/site-functions" $fpath)
elif [ -e /etc/bash_completion.d/git-prompt ]; then
    . /etc/bash_completion.d/git-prompt
fi

_clear-line-echo "functions... _update_prompt"
function _update_prompt {
    GIT_BRANCH=$(__git_ps1 '%s')

    PROMPT="[%{%(?.$fg_bold[green].$fg_bold[red])%}%(5~,%-2~/.../%2~,%~)${reset_color}]"
    if [ $GIT_BRANCH ]; then
        PROMPT="$PROMPT ${fg[yellow]}$GIT_BRANCH${reset_color}"
    fi
    if [ $PERLBREW_PERL ]; then
        PROMPT="$PROMPT  ${fg[white]}(${PERLBREW_PERL})${reset_color}"
    fi
    if [ -d .github-commit-status ] && which github-commit-status-mark > /dev/null 2>&1; then
        github-commit-status-mark >/dev/null 2>&1 &!
        PROMPT="$PROMPT $(github-commit-status-mark -cached)"
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

    shell_level=$(( $SHLVL - 1 ))
    if [ -n "$TMUX" ]; then
        shell_level=$(( $shell_level - 1 ))
    fi

    if [ $shell_level -ge 1 ]; then
        if [ $shell_level = 1 ]; then
            shell_level=''
        fi
        PROMPT="$fg[blue]$shell_level\$${reset_color} $PROMPT"
    fi

    if [ -n "$DYLD_INSERT_LIBRARIES" ]; then
        PROMPT="🚇 $PROMPT"
    fi
}

_clear-line-echo "functions... chpwd"
function chpwd() {
    _update_prompt
}

autoload -U add-zsh-hook

add-zsh-hook precmd _update_prompt

_clear-line-echo "functions... _tmux_echo_pwd"
function _tmux_echo_pwd() {
    [ -n "$TMUX" ] && echo -ne "\ek$(basename $(pwd))\e\\"
}

add-zsh-hook precmd _tmux_echo_pwd

_clear-line-echo "functions... sssh"
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

_clear-line-echo "local ..."
if [ -e ~/.zsh/local ]; then
    source ~/.zsh/local
fi

if functions p > /dev/null; then
    compdef _precommand p
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
                # echo -ne "\ek%$(builtin jobs -l %+)\e\\" 2> /dev/null
                echo -ne "\ek%$(ps -o command= $(builtin jobs -l %+ 2> /dev/null | awk '{print $3}') 2>/dev/null)\e\\" 2> /dev/null
            elif [[ $cmd[1] = 'ssh' ]]; then
                echo -ne "\ek%$cmd[2]\e\\"
            else
                echo -ne "\ek@${${1#*=* }%% *}\e\\"
            fi
        fi
    }
fi

if [ -n "$brew_prefix" ]; then
    export XML_CATALOG_FILES="$brew_prefix/etc/xml/catalog"
fi

_clear-line-echo "＼＼\\└('ω')」//／／"
echo

g () {
    dir=$(ghq list -p | fzf --extended-exact --select-1 --query="$1" --delimiter=/ --nth=5,6,7,8,9)
    test -z "$dir" && return 1
    cd $dir
}

_g() {
    local -a __repos
    # __repos=( ${(@f)"$({ ghq list | cut -d/ -f2,3; ghq list | cut -d/ -f3;  } | sort | uniq)"} )
    # __repos=( ${(@f)"$({ ghq list | cut -d/ -f3;  } | sort | uniq)"} )
    __repos=( ${(@f)"$({ ghq list | perl -F/ -anal -e 'print $F[-1]';  } | sort | uniq)"} )
    _describe Repositories __repos
}

compdef _g g

ghq () {
    if [ "$1" = look -a -n "$2" ]; then
        cd $(command ghq list -p $2)
        return
    fi

    command ghq "$@"
}

### experimental

## zgen

source ~/.zsh.d/zgen/zgen.zsh

if ! zgen saved; then
  zgen load zsh-users/zsh-syntax-highlighting

  zgen load tarruda/zsh-autosuggestions

  # zgen load hchbaw/auto-fu.zsh
  # function zle-line-init () {
  #     auto-fu-init
  # }
  # zle -N zle-line-init
  # zstyle ':completion:*' completer _oldlist _complete

  zgen load zsh-users/zsh-completions src

  zgen save
fi

ZSH_HIGHLIGHT_STYLES[function]='fg=green,bold'
ZSH_HIGHLIGHT_STYLES[command]='fg=cyan,bold'
ZSH_HIGHLIGHT_STYLES[path_approx]='none'

## cdr
autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs
zstyle ':chpwd:*' recent-dirs-max 1000

_fuzzy-cdr () {
    local r=$(cdr -l | awk '{ print $2 }' | fzf)
    if [ -n "$r" ]; then
        zle autosuggest-suspend
        BUFFER="cd -- $r"
        zle accept-line
    fi
    zle reset-prompt
}
zle -N _fuzzy-cdr
bindkey '^x^b' _fuzzy-cdr

_fuzzy-ghq () {
    local r=$(ghq list | fzf --extended-exact --delimiter=/ --nth=2,3,4,5)
    if [ -n "$r" ]; then
        r=$(ghq list -e -p $r)

        zle autosuggest-suspend
        BUFFER="cd -- $r"
        zle accept-line
    fi
    zle reset-prompt
}
zle -N _fuzzy-ghq
bindkey '^x^g' _fuzzy-ghq

zle-line-init() {
    zle autosuggest-start
}
zle -N zle-line-init

_clear-line-echo "compinit..."
autoload -U compinit; compinit
