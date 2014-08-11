autoload -U compinit promptinit colors
compinit
colors

# enable prompt substitution for git branch in prompt
setopt prompt_subst
autoload -Uz vcs_info
promptinit

# no history duplicates
setopt HIST_IGNORE_DUPS

# git in prompt
zstyle ':vcs_info:*' actionformats \
        '%F{5}[%F{2}%b%F{3}|%F{1}%a%F{5}]%f '
zstyle ':vcs_info:*' formats       \
        '%F{6}(%b)%f '
        # this bottom one is displayed for some reason, dunno about the top
        # the %F{6} is for cyan

zstyle ':vcs_info:*' enable git

vcs_info_wrapper() {
    vcs_info
    if [ -n "$vcs_info_msg_0_" ]; then
        echo "%{$fg[grey]%}${vcs_info_msg_0_}%{$reset_color%}$del"
    fi
}
RPROMPT=$'$(vcs_info_wrapper)'
if [ -z $RPROMPT ]; then
    git_prompt=""
else
    git_prompt=" $RPROMPT"
fi

PROMPT="%{$fg_bold[green]%}%m %{$fg_bold[yellow]%}%~$git_prompt%{$fg_bold[magenta]%}$ %{$reset_color%}"

# do right-prompt
RPROMPT=""

################################## aliases and PATH ##################################
uname -a | grep -o Linux>/dev/null
if [ $? -eq 0 ]
then
    alias ls='ls --color=auto'
else
    alias ls='ls -G'
fi
alias ll='ls -l'
alias grep='grep --color=auto'
alias py='python'
alias ipy='ipython'

vims () {
    local session_dir="${HOME}/.vim/sessions/$1.vim"
    if [ -f "${session_dir}" ]
    then
        vim -S "${session_dir}"
    else
        echo "No such session: ${session_dir}">&2
    fi
}
export vims

YELP_ALIAS_PATH="$HOME/.yelp_bash_alias"
if [ -f "$YELP_ALIAS_PATH" ]; then
    source "$YELP_ALIAS_PATH"
fi

SUBLIME_PATH="/opt/sublime_text/sublime_text"
if [ -x "$SUBLIME_PATH" ]; then
    alias sublime="$SUBLIME_PATH"
fi

ZSH_COLOR_PLUGIN="$HOME/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh"
if [ -f "$ZSH_COLOR_PLUGIN" ]; then
    source "$ZSH_COLOR_PLUGIN"
fi

### Added by the Heroku Toolbelt
if [ -d "/usr/local/heroku/bin" ]; then
    export PATH="/usr/local/heroku/bin:$PATH"
fi
#############################################################################

set -o emacs
