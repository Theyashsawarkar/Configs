########################################
# Powerlevel10k Instant Prompt (FAST)
########################################

# Must stay at the very top (no output before this)
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


########################################
# Oh My Zsh Bootstrap (User-space)
########################################

if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
  echo "⚡ Installing Oh My Zsh..."
  RUNZSH=no KEEP_ZSHRC=yes \
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

export ZSH="$HOME/.oh-my-zsh"


########################################
# Powerlevel10k Bootstrap
########################################

ZSH_CUSTOM="${ZSH_CUSTOM:-$ZSH/custom}"

if [[ ! -d "$ZSH_CUSTOM/themes/powerlevel10k" ]]; then
  git clone --depth=1 \
    https://github.com/romkatv/powerlevel10k.git \
    "$ZSH_CUSTOM/themes/powerlevel10k"
fi


########################################
# Oh My Zsh Configuration
########################################

ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(
  git
)

source "$ZSH/oh-my-zsh.sh"


########################################
# History & Completion
########################################

HISTFILE="$HOME/.histfile"
HISTSIZE=10000
SAVEHIST=10000

setopt hist_ignore_dups
setopt hist_ignore_space
setopt share_history

autoload -Uz compinit
compinit


########################################
# Environment & PATH
########################################

export PATH="$HOME/.local/bin:$PATH"

# Node (NVM)
export NVM_DIR="$HOME/.nvm"
[[ -s "$NVM_DIR/nvm.sh" ]] && source "$NVM_DIR/nvm.sh"

# Rust
[[ -f "$HOME/.cargo/env" ]] && source "$HOME/.cargo/env"


########################################
# Tooling Integrations
########################################

# Zoxide (smart cd)
eval "$(zoxide init zsh --cmd cd)"


########################################
# Aliases
########################################

alias cat="batcat"
alias ls="eza --icons"
alias ll="eza -l --icons"
alias fd="fdfind"
alias vim="nvim"


########################################
# Prompt Configuration
########################################

# Load Powerlevel10k config (keep at bottom)
[[ -f "$HOME/.p10k.zsh" ]] && source "$HOME/.p10k.zsh"


########################################
# Cosmetic: Vertical spacing before prompt
########################################

precmd() {
  print ""
}
