if [[ -n "$HOMEBREW_DEV_CMD_RUN" ]]; then
    return
fi

# Vim で Ctrl-Q, Ctrl-S が効くように
stty -ixon -ixoff
# https://github.com/neomutt/neomutt/issues/1195#issuecomment-388016804
stty discard undef

autoload -U colors; colors

autoload -Uz compinit && compinit -C

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
setopt no_auto_remove_slash
setopt interactive_comments
setopt null_glob

# https://blog.vghaisas.com/zsh-beep-sound/
unsetopt LIST_BEEP

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
if [ -d ~/.cache/zsh ]; then
    zstyle ':completion:*' use-cache yes
    zstyle ':completion:*' cache-path ~/.cache/zsh
fi

# https://zsh.sourceforge.io/FAQ/zshfaq04.html#l55
zstyle ':completion:*' completer _complete _ignored _files


# https://unix.stackexchange.com/a/174641
ZLE_SPACE_SUFFIX_CHARS=$'|&'

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
            tmux attach $*
        else
            tmux -2 $*
        fi
    fi
}

# export FZF_DEFAULT_OPTS='--preview="cat {}" --bind "tab:execute(less {})"'
export FZF_DEFAULT_OPTS='--inline-info' # --border
# export FZF_DEFAULT_COMMAND='fd --type f --hidden --no-ignore-vcs'

export BAT_THEME=zenburn

#
# History
#
HISTFILE=$HOME/.zsh_history
HISTSIZE=100000
SAVEHIST=1000000
setopt append_history
setopt inc_append_history
setopt share_history
setopt extended_history
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
    # printf "%-${COLUMNS}s\r" $1
}

# http://chneukirchen.org/blog/archive/2013/03/10-fresh-zsh-tricks-you-may-not-know.html
autoload -Uz copy-earlier-word
zle -N copy-earlier-word
bindkey "^[m" copy-earlier-word

#
# Aliases
#
_clear-line-echo "aliasing..."

alias rm='rm -i'
alias mv='mv -i'
alias cp='cp -i'
alias vim='nvim'

ls=$(which gls > /dev/null 2>&1 && echo 'gls' || echo 'ls')
if [ $(uname) = 'Darwin' -a "$ls" = 'ls' ]; then
    export LS_OPTIONS=-GF
else
    export LS_OPTIONS='--color -F'
fi
alias ls="$ls $LS_OPTIONS"

if which gdircolors > /dev/null 2>&1; then
    eval $(gdircolors)
fi

# alias lv='lv -c -T8192'
# alias lv='lv -R'
alias :e='vim'
alias :q='exit'
alias ssh="TERM=screen $(whence ssh)"
alias vi='vim'
alias s='git status --short --branch --untracked-files=no'
# alias l='exa --long --git --time-style=long-iso'
alias l='lsd --date relative --long --blocks name,size,date --no-symlink --git'
alias la='lsd --date relative --long --blocks name,size,date --almost-all --no-symlink --git'
alias lw='lsd -F'

#
# Functions
#
_clear-line-echo "functions..."

export GIT_PS1_SHOWUPSTREAM='verbose'
export GIT_PS1_DESCRIBE_STYLE='branch'
export GIT_PS1_SHOWDIRTYSTATE='yes'
export GIT_PS1_SHOWSTASHSTATE='yes'
export GIT_PS1_SHOWCOLORHINTS='yes'

brew_prefix=''
if type brew > /dev/null; then
    brew_prefix="$(brew --prefix)"
fi

if [ -n "$brew_prefix" ]; then
    . "$brew_prefix/etc/bash_completion.d/git-prompt.sh"
    test -e "$brew_prefix/share/zsh/site-functions/aws_zsh_completer.sh" && . "$brew_prefix/share/zsh/site-functions/aws_zsh_completer.sh"
    fpath=("$brew_prefix/share/zsh/site-functions" $fpath)

    if [ -d "$brew_prefix/Caskroom/google-cloud-sdk" ]; then
        source "$brew_prefix/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc"
        source "$brew_prefix/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc"
    fi
elif [ -e /etc/bash_completion.d/git-prompt ]; then
    . /etc/bash_completion.d/git-prompt
fi

fpath=("$HOME/local/fpath" $fpath)

PATH=$PATH:$brew_prefix/opt/git/share/git-core/contrib/diff-highlight
PATH=$PATH:$brew_prefix/opt/git/share/git-core/contrib/git-jump

fpath=(~/.zsh.d/fpath ~/dev/go/src/github.com/motemen/hub-pr/zsh $fpath)

_clear-line-echo "functions... _update_prompt"
function _update_prompt {
    GIT_BRANCH=$(__git_ps1 '%s')

    PROMPT="%{%(?.$fg_bold[green].$fg_bold[red])%}%(5~,%-1~/…/%2~,%~)${reset_color}"
    if [ $GIT_BRANCH ]; then
        PROMPT="$PROMPT ${fg[yellow]}$GIT_BRANCH${reset_color}"
    fi
    if [ -d .github-commit-status ] && which github-commit-status-mark > /dev/null 2>&1; then
        github-commit-status-mark >/dev/null 2>&1 &!
        PROMPT="$PROMPT $(github-commit-status-mark -cached)"
    fi
    if [ "$VIRTUAL_ENV" ]; then
        PROMPT="$PROMPT ${fg[cyan]}$(basename "$VIRTUAL_ENV")${reset_color}"
    fi
    PROMPT="$PROMPT%E
%D{%H:%M:%S} %# "

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

    if command update-cwds 2>/dev/null; then
        update-cwds
    fi
}

autoload -U add-zsh-hook

add-zsh-hook precmd _update_prompt

# _clear-line-echo "functions... _tmux_echo_pwd"
# function _tmux_echo_pwd() {
#     [ -n "$TMUX" ] && [ -z "$VIM" ] && echo -ne "\ek$(basename $(pwd))\e\\"
# }
#
# add-zsh-hook precmd _tmux_echo_pwd

#
# Setting for screen
#
# From <http://www.nijino.com/ari/diary/?20020614&to=200206141S1#200206141S1>
# if [ "$TERM" = "screen" -o "$TERM" = "screen-256color" ]; then
#     _preexec_tmux() {
#         if [ -n "$TMUX" ]; then
#             emulate -L zsh
#             local -a cmd; cmd=(${(z)2})
# 
#             if [[ $cmd[1] = 'fg' ]]; then
#                 # echo -ne "\ek%$(builtin jobs -l %+)\e\\" 2> /dev/null
#                 echo -ne "\ek%$(ps -o command= $(builtin jobs -l %+ 2> /dev/null | awk '{print $3}') 2>/dev/null)\e\\" 2> /dev/null
#             elif [[ $cmd[1] = 'ssh' ]]; then
#                 echo -ne "\ek%$cmd[2]\e\\"
#             else
#                 echo -ne "\ek@${${1#*=* }%% *}\e\\"
#             fi
#         fi
#     }
#     add-zsh-hook preexec _preexec_tmux
# fi

# https://gitlab.freedesktop.org/Per_Bothner/specifications/-/blob/master/proposals/prompts-data/shell-integration.zsh
_prompt_executing=""
function __prompt_precmd() {
    local ret="$?"
    if test "$_prompt_executing" != "0"
    then
      _PROMPT_SAVE_PS1="$PS1"
      _PROMPT_SAVE_PS2="$PS2"
      PS1=$'%{\e]133;P;k=i\a%}'$PS1$'%{\e]133;B\a\e]122;> \a%}'
      PS2=$'%{\e]133;P;k=s\a%}'$PS2$'%{\e]133;B\a%}'
    fi
    if test "$_prompt_executing" != ""
    then
       printf "\033]133;D;%s;aid=%s\007" "$ret" "$$"
    fi
    printf "\033]133;A;cl=m;aid=%s\007" "$$"
    _prompt_executing=0
}
function __prompt_preexec() {
    PS1="$_PROMPT_SAVE_PS1"
    PS2="$_PROMPT_SAVE_PS2"
    printf "\033]133;C;\007"
    _prompt_executing=1
}
preexec_functions+=(__prompt_preexec)
precmd_functions+=(__prompt_precmd)


if [ -n "$brew_prefix" ]; then
    export XML_CATALOG_FILES="$brew_prefix/etc/xml/catalog"
fi

# _clear-line-echo "＼＼\\└('ω')」//／／"
# echo

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

ghq () {
    if [ "$1" = look -a -n "$2" ]; then
        cd $(command ghq list -p $2)
        return
    fi

    command ghq "$@"
}

### experimental

## cdr
autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs
zstyle ':chpwd:*' recent-dirs-max 1000

_fuzzy-cdr () {
    local r=$({ cdr -l | awk '{ print $2 }' & ghq list -p | sed "s#^$HOME#~#" & } | ASDF_PERL_VERSION=system PLENV_VERSION=system perl -anal -e '$h{$_}++ or print' | fzf --no-preview)
    if [ -n "$r" ]; then
        # zle autosuggest-suspend
        BUFFER="cd -- $r"
        zle accept-line
    fi
    zle reset-prompt
}
zle -N _fuzzy-cdr
bindkey '^x^b' _fuzzy-cdr
bindkey '^x^k' _fuzzy-cdr

_fuzzy-ghq () {
    local r=$(ghq list | fzf --no-preview --extended-exact --delimiter=/ --nth=2,3,4,5)
    if [ -n "$r" ]; then
        r=$(ghq list -e -p $r)

        # zle autosuggest-suspend
        BUFFER="cd -- $r"
        zle accept-line
    fi
    zle reset-prompt
}
zle -N _fuzzy-ghq
bindkey '^x^g' _fuzzy-ghq

# https://zsh.sourceforge.io/FAQ/zshfaq04.html#l55

zle -C complete-file complete-word _generic
zstyle ':completion:complete-file::::' completer _files
bindkey '^x^f' complete-file

function fzf-furo2-history-exec () {
  local cmd=$(furo2 history --pretty=format:%s | grep -v -F '[failed]' | fzf --exit-0 --query "$LBUFFER")
  if [ $? -ne 0 ]; then
      return $?
  fi
  if [ -n "$cmd" ]; then
    BUFFER=
    LBUFFER+="furo2 exec $cmd"
  fi
  zle reset-prompt
}
zle -N fzf-furo2-history-exec
bindkey '^x^h' fzf-furo2-history-exec

function re-prompt() {
  zle .reset-prompt
  zle .accept-line
}
zle -N accept-line re-prompt  # update date on execute command

# zle-line-init() {
#     zle autosuggest-start
# }
# zle -N zle-line-init

compdef _g g

if type zprof > /dev/null 2>&1; then
  zprof | less
fi

ZINIT_HOME=~/.zsh.d/zinit
source "$ZINIT_HOME/zinit.zsh"

zinit load zsh-users/zsh-completions

zinit load zsh-users/zsh-history-substring-search

zinit load momo-lab/zsh-abbrev-alias
bindkey -M isearch " " magic-space # https://blog.patshead.com/2012/11/automatically-expaning-zsh-global-aliases---simplified.html

MAGIC_ENTER_GIT_COMMAND='git st'
MAGIC_ENTER_OTHER_COMMAND="dt \"PP E pp y'W'w\""
zinit snippet OMZP::magic-enter

HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND='fg=yellow,underline'

ZSH_AUTOSUGGEST_ACCEPT_WIDGETS=(
    end-of-line
)

ZSH_AUTOSUGGEST_PARTIAL_ACCEPT_WIDGETS=(
    forward-word
    forward-char
    vi-forward-word
    vi-forward-word-end
    vi-forward-blank-word
    vi-forward-blank-word-end
)

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

_clear-line-echo "local ..."
if [ -e ~/.zsh.d/local ]; then
    source ~/.zsh.d/local
fi

abbrev-alias -g B='bundle exec'
abbrev-alias -g F='furo2 exec'
abbrev-alias -g K='kubectl'
abbrev-alias -g D='docker'
abbrev-alias -g DC='docker compose'
abbrev-alias -g DR='docker run --rm -it'

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

if which zprof > /dev/null; then
      zprof | less
fi

# if [ -d "$brew_prefix/opt/asdf/libexec" ]; then
#     export ASDF_DIR="$brew_prefix/opt/asdf/libexec"
#     . $ASDF_DIR/asdf.sh
# fi

if which mise > /dev/null; then
    eval "$(mise activate)"
fi

eval "$(direnv hook zsh)"

export PATH=$HOME/bin:$PATH

# if which kubectl > /dev/null; then
#     source <(kubectl completion zsh)
# fi

if which kubectl-krew > /dev/null; then
    export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
fi

### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
export PATH="/Users/motemen/.rd/bin:$PATH"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)
