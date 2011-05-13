# ZSH Theme - Preview: http://gyazo.com/8becc8a7ed5ab54a0262a470555c3eed.png
typeset -A host_color
host_color=(Adrian white Keith red spoon cyan matrix green cube blue)

function prompt_char {
	if [ `whoami` = "root" ]; then
		echo '#'
		return
	fi
    git branch >/dev/null 2>/dev/null && echo '±' && return
    hg root >/dev/null 2>/dev/null && echo '☿' && return
    echo '○'
}

typeset -Ag FX FG BG
FX=(
	reset		"[00m"
	bold		"[01m"	no-bold		"[22m"
	italic		"[03m"	no-italic	"[23m"
	underline	"[04m"	no-underline	"[24m"
	blink		"[05m"	no-blink	"[25m"
	reverse		"[07m"	no-reverse	"27m"
)

for color in {000...255}; do
	FG[$color]="[38;5;${color}m"
	BG[$color]="[48;5;${color}m"
done

local host=`hostname -s`

local return_code="%(?..%{$fg[red]%}%? ↵%{$reset_color%})"

local username=`whoami`
if [ $username = "root" ]; then
	local username_prompt="%{$terminfo[bold]$fg[white]$bg[red]%}$FX[blink]$username$FX[reset]%{$reset_color%}@"
else
	local username_prompt="%{$terminfo[bold]$fg[green]%}$username%{$reset_color%}@"
fi

local user_host='$username_prompt%{$fg[$host_color[$host]]$host%}%{$reset_color%}'
local current_dir='%{$terminfo[bold]$fg[blue]%} %~%{$reset_color%}'
#local rvm_ruby='%{$fg[red]%}‹$(rvm-prompt i v g)›%{$reset_color%}'
local git_branch='$(git_prompt_info)%{$reset_color%}'


PROMPT="╭─${user_host} %D{[%I:%M:%S]} ${current_dir} ${git_branch}
╰─%B$(prompt_char)%b "
RPS1="${return_code}"

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[yellow]%}‹"
ZSH_THEME_GIT_PROMPT_SUFFIX="› %{$reset_color%}"
