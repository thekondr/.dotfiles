local return_status="%(?:%{$fg_bold[green]%}:%{$fg_bold[red]%})$%{$reset_color%}"
local current_directory="%{$fg_bold[cyan]%}%c%{$reset_color%}"
local current_time="%{$fg_bold[yellow]%}%T%{$reset_color%}"
PROMPT='${current_time} ${current_directory}$(git_prompt_info) ${return_status} '

ZSH_THEME_GIT_PROMPT_PREFIX=" %{$fg_bold[magenta]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[yellow]%}*%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN=""
