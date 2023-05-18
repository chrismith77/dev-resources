HOST_NAME=csmith

if [ -f ~/.bashrc ]; then
 . ~/.bashrc
fi

shopt -s autocd
shopt -s histappend

export PATH=$PATH:$HOME/bin
export BASH_SILENCE_DEPRECATION_WARNING=1

export HISTSIZE=5000
export HISTFILESIZE=10000

bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced

txtred='\e[0;31m' # Red
txtgrn='\e[0;32m' # Green
bldgrn='\e[1;32m' # Bold Green
bldyellow='\e[1;33m' # Bold Yellow
bldpur='\e[1;35m' # Bold Purple
bldcyan='\e[1;36m' # Bold Cyan
txtrst='\e[0m' # Text Reset

emojis=("🍻" "🤖" "🤯" "🙈" "🔥" "🎧")
EMOJI=${emojis[$RANDOM % ${#emojis[@]} ]}

print_before_the_prompt () {
  dir=$PWD
  home=$HOME
  dir=${dir/"$HOME"/"~"}
  printf "\n $txtred%s: $bldpur%s $txtgrn%s\n$txtrst" "$HOST_NAME" "$dir" "$(vcprompt -f [%b])"
}

PROMPT_ARROW=" ↳"
PROMPT_COMMAND=print_before_the_prompt
PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"
PS1="$EMOJI$PROMPT_ARROW "

eval "$(/opt/homebrew/bin/brew shellenv)"
eval "$(ssh-agent)"