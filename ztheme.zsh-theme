#!/bin/zsh
#Gianu theme via https://github.com/robbyrussell/oh-my-zsh/blob/master/themes/gianu.zsh-theme
# PROMPT='[%{$fg_bold[white]%}%n%{$reset_color%}@%{$fg_bold[red]%}%m%{$reset_color%} %{$fg[cyan]%}%c%{$reset_color%} $(git_prompt_info)%{$reset_color%}]$ '
PROMPT='%{$fg_bold[white]%}%n%{$reset_color%} [%{$fg[cyan]%}%c%{$reset_color%} $(git_prompt_info)%{$reset_color%}]$ '

ZSH_THEME_GIT_PROMPT_PREFIX="(%{$fg_bold[green]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX=")"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[green]%} %{$fg[yellow]%}✗%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$reset_color%}"

function battery_charge {
    echo `$BATTERY` 2>/dev/null
}
RPROMPT='$(battery_charge)'