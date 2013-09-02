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

_clear-line-echo "compinit..."

autoload -U compinit; compinit

# https://github.com/gitster/git/blob/master/contrib/completion/git-completion.bash
if [ -e ~/.zsh/completion/git-completion.bash ]; then
    _clear-line-echo "git-completion..."
    source ~/.zsh/completion/git-completion.bash
fi

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
alias lv='lv -c -T8192'
alias :e='vim'
alias :q='exit'
alias ssh="TERM=screen $(whence ssh)"
alias vi='vim'
alias vicat='if [ -p /dev/stdin ]; then vim -R -; else TEMPFILE=$(gmktemp) && vim $TEMPFILE && cat $TEMPFILE; fi'

EASYTETHER_EXT=/System/Library/Extensions/EasyTetherUSBEthernet.kext
alias easytether-on="sudo kextload $EASYTETHER_EXT"
alias easytether-off="sudo kextunload $EASYTETHER_EXT"
alias easytether-status="kextstat |grep EasyTether"

#
# Functions
#

# http://d.hatena.ne.jp/ka-nacht/20090112/1231746120
function _echo_git_head() {
    local git_dir="$($GIT_BIN rev-parse --git-dir 2>/dev/null)"
    if [ -z "$git_dir" ]; then
        return 1
    fi

    local head_name=''
    local additional_info=''
    if [ -d "$git_dir/rebase-apply" ]; then
        if [ -f "$git_dir/rebase-apply/rebasing" ]; then
            additional_info="REBASE"
        elif [ -f "$git_dir/rebase-apply/applying" ]; then
            additional_info="AM"
        else
            additional_info="AM/REBASE"
        fi

        local next="$(< "$git_dir/rebase-apply/next")"
        local last="$(< "$git_dir/rebase-apply/last")"

        if [ "$next" -a "$last" ]; then
            next=$[ $next - 1]
            additional_info="$additional_info ($next/$last)"
        fi

        head_name="$($GIT_BIN symbolic-ref HEAD 2>/dev/null)"
    elif [ -d "$git_dir/rebase-merge" ]; then
        if [ -f "$git_dir/rebase-merge/interactive" ]; then
            additional_info="REBASE-i"
            head_name="$(< "$git_dir/rebase-merge/head-name")"
            local left="$(grep '^[pes]' $git_dir/rebase-merge/git-rebase-todo | wc -l)"
            if [ "$left" ]; then
                left=$[ $left + 1 ]
                additional_info="$additional_info ($left left)"
            fi
        else
            additional_info="REBASE-m"
            head_name="$(< "$git_dir/rebase-merge/head-name")"
        fi
    elif [ -f "$git_dir/MERGE_HEAD" ]; then
        additional_info="MERGING"
        head_name="$($GIT_BIN symbolic-ref HEAD 2>/dev/null)"
    else
        head_name="$($GIT_BIN symbolic-ref HEAD 2>/dev/null)"
    fi

    if [ -z "$head_name" ]; then
        head_name="$($GIT_BIN name-rev --name-only HEAD)"
    fi

    head_name="${head_name##refs/heads/}"

    if [ -n "$additional_info" ]; then
        additional_info=", $additional_info"
    fi

    echo "$head_name$additional_info"

    return 0
}

function _update_prompt {
    GIT_BRANCH=$(_echo_git_head)

    PROMPT="[%{%(?.$fg_bold[green].$fg_bold[red])%}%(5~,%-2~/.../%2~,%~)${reset_color}]"
    if [ $GIT_BRANCH ]; then
        PROMPT="$PROMPT ${fg[yellow]}$GIT_BRANCH${reset_color}"
    fi
    if [ $PERLBREW_PERL ]; then
        PROMPT="$PROMPT  ${fg[white]}(${PERLBREW_PERL})${reset_color}"
    fi
    PROMPT="%D{%H:%M:%S} $PROMPT%E
"
    PROMPT="$PROMPT$HOST%# "
}

function chpwd() {
    _update_prompt
    ls -t
}

function precmd() {
    _update_prompt
    [ -n "$TMUX" ] && echo -ne "\ek$(basename $(pwd))\e\\"
}


if [ -e ~/.zsh/local ]; then
    source ~/.zsh/local
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

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

_clear-line-echo "＼＼\\└('ω')」//／／"
echo
