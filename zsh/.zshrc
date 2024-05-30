## >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/guilhermeg/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/guilhermeg/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/guilhermeg/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/guilhermeg/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<


#Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export LS_COLORS="di=0;94"
echo -ne "\033]0;Zsh\007"
export PATH="$HOME/.tmuxifier/bin:$PATH"
# Set the directory we want to store zinit and plugins

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

#Download Zinit if it's not there get

if [ ! -d "$ZINIT_HOME" ]; then
	mkdir -p "$(dirname $ZINIT_HOME)"
	git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Add in powerlevel10k
zinit ice depth=1; zinit light romkatv/powerlevel10k

zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Snippets
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::aws
zinit snippet OMZP::kubectl
zinit snippet OMZP::kubectx
zinit snippet OMZP::command-not-found

autoload -Uz compinit && compinit

zinit cdreplay -q
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.

 
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

bindkey '^f' autosuggest-accept
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward


# Command history settings
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion style
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath' 
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath' 

#Aliases
alias nvim='nvim'
alias quechua="$HOME/.local/bin/quechua.sh"
alias et4531="$HOME/.local/bin/et4351.sh"
alias mnt-et4351="$HOME/.local/bin/mnt_et4351.sh"
alias mnt-quechua="$HOME/.local/bin/mnt_quechua.sh"
alias umount-quechua="$HOME/.local/bin/umount-quechua.sh"
alias umount-et4351="$HOME/.local/bin/umount-et4351.sh"

# Exports
export HIP_VISIBLLE_DEVICE=0
export HSA_OVERRIDE_GFX_VERSION=10.3.0

 #Shell integration
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
eval "$(zoxide init --cmd cd zsh)"
