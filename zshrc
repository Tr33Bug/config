# time zsh startup
# zmodload zsh/zprof

eval "$(/opt/homebrew/bin/brew shellenv)"

# autoload things
autoload -Uz _zinit


### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi



source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
# autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

### End of Zinit's installer chunk

autoload -Uz compinit
# enshure cached file
compinit -C 
# run the following to rebuild the cache after new installations:
# rm ~/.zcompdump*
# exec zsh



### Add in zsh plugins 
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab
zinit light zsh-users/zsh-syntax-highlighting

# add in snippets from oh my zsh plugins
# zinit snippet OMZP::command-not-found


zinit cdreplay -q

autoload -Uz compinit -C
# enshure cached file
# compinit -C 
# run the following to rebuild the cache after new installations:
# rm ~/.zcompdump*
# exec zsh

# Hook brew commands to clean zsh completion cache after install/upgrade
brew() {
    # Run the real brew command
    command brew "$@"
    
    # Check if it was an install or upgrade
    if [[ "$1" == "install" || "$1" == "upgrade" || "$1" == "uninstall" ]]; then
        echo "[zsh] Cleaning completion cache..."
        rm -f ~/.zcompdump*
        # Trigger regeneration of zcompdump for current session
        compinit -C
    fi
}

# comand history
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


# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls -A --color=always $realpath'

# Use fzf-tab default command, no need to set :fzf-tab:* command anymore

# After zsh-syntax-highlighting is sourced
ZSH_HIGHLIGHT_STYLES[command]='fg=green'
ZSH_HIGHLIGHT_STYLES[alias]='fg=cyan'
ZSH_HIGHLIGHT_STYLES[path]='fg=blue,underline'
ZSH_HIGHLIGHT_STYLES[globbing]='fg=yellow'
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='fg=magenta'
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='fg=magenta,bold'


# FZF Shell integration for fuzzy finding
eval "$(fzf --zsh)"


alias ls='ls --color'
# Start starship prompt
eval "$(starship init zsh)"

# # >>> conda initialize >>>
# # !! Contents within this block are managed by 'conda init' !!
# __conda_setup="$('/opt/homebrew/Caskroom/miniconda/base/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
# if [ $? -eq 0 ]; then
#     eval "$__conda_setup"
# else
#     if [ -f "/opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.sh" ]; then
#         . "/opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.sh"
#     else
#         export PATH="/opt/homebrew/Caskroom/miniconda/base/bin:$PATH"
#     fi
# fi
# unset __conda_setup
# # Keep prompt clean
# conda config --set changeps1 False
# # disable auto base activation
# conda config --set auto_activate_base false
# # <<< conda initialize <<<

# CONDA LAZY EVALUATION
# this reduces startup time enorm
# Lazy-load conda
conda() {
    # Initialize conda on first use
    unset -f conda
    . "/opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.sh"
    conda "$@"
    conda config --set changeps1 False
	conda config --set auto_activate_base false
}

# ALIASES
alias pip='pip3'


# end of time analyze section 
# zprof
