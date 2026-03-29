export QT_STYLE_OVERRIDE=kvantum
#export QT_QPA_PLATFORMTHEME=qt5ct

export _JAVA_OPTIONS="-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel -Dswing.crossplatformlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel"
# export _JAVA_OPTIONS="-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel -Dswing.crossplatformlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel ${_JAVA_OPTIONS}"

# for nix-on-droid
# export PATH="$PATH:/opt/nvim/"

# for arch
export PATH=$PATH:/home/notscripter/.local/bin

# for fedora
# export PATH=$PATH:/home/notscripter/bin

export DOTFILES=~/dotfiles
export ANDROID_SDK=~/opt/android-sdk
# export PATH=/opt/android-sdk/emulator
# export PATH=/opt/android-sdk/platform-tools
# export PATH=$ANDROID_SDK/emulator:$ANDROID_SDK/tools:$PATH

# Shell integrations
if [ "$TERM_PROGRAM" != "Apple_Terminal" ]; then
eval "$(oh-my-posh init zsh --config ~/.config/zsh/theme.omp.yaml)"
fi
eval "$(fzf --zsh)"
eval "$(zoxide init zsh)"

# Aliases
alias ls='ls --color'
alias la='ls -A --color'
alias du='du -h'
alias n='nvim'
alias c='clear'
alias q='exit'
alias grubup='sudo grub-mkconfig -o /boot/grub/grub.cfg'
alias cpc='sudo pacman -Sc && yay -Sc'

alias bunst='bun start'
alias bunrd='bun run dev'

alias yt='yt-dlp -F'
alias ytd='yt-dlp -f'
alias ytp='sh ./dotfiles/scripts/ytdlp-segment.sh'
alias ytdk='ytd 244+251-drc'
alias ytdm='ytd 135+140-drc'

alias mkpaper='sh $DOTFILES/scripts/setpaper.sh'

# alias ..="z .."
setopt autocd
setopt cdsilent
setopt histignoredups

# Keybindings
bindkey -e

# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

zinit ice depth=1

# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab
zinit light MichaelAquilina/zsh-you-should-use
zinit light jeffreytse/zsh-vi-mode

# Add in snippets
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::command-not-found
zinit snippet OMZP::node
zinit snippet OMZP::npm
zinit snippet OMZP::python
# zinit snippet OMZP::vi-mode

# Load completions
autoload -Uz compinit && compinit

zinit cdreplay -q

# History
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
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# NOTE: Multiple Neovim Config

# alias nvim-test="NVIM_APPNAME=TestVim nvim"
# alias nvim-astro="NVIM_APPNAME=AstroNvim nvim"
# alias nvim-lazy="NVIM_APPNAME=LazyVim nvim"
# alias nvim-chad="NVIM_APPNAME=NvChad nvim"
#
# function nvims() {
#   items=("default" "TestVim" "AstroNvim" "LazyVim" "NvChad")
#   config=$(printf "%s\n" "${items[@]}" | fzf --prompt=" Neovim Config  " --height=~50% --layout=reverse --border --exit-0)
#   if [[ -z $config ]]; then
#     echo "Nothing selected"
#     return 0
#   elif [[ $config == "default" ]]; then
#     config=""
#   fi
#   NVIM_APPNAME=$config nvim $@
# }
#
# bindkey -s ^a "nvims\n"

# NOTE: Multiple Neovim Config

### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

### End of Zinit's installer chunk

# bun completions
[ -s "/home/notscripter/.bun/_bun" ] && source "/home/notscripter/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
