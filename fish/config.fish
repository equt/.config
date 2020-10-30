bind \e fish_vi_key_bindings

function fish_title
end

alias c clear
alias v nvim
alias g git
alias l exa
alias ls exa
alias la 'exa -a'

set fish_greeting ''

set -gx XDG_CONFIG_HOME "$HOME/.config"
set -gx XDG_CACHE_HOME "$HOME/.cache"
set -gx XDG_DATA_HOME "$HOME/.local/share"

set -gx DOCKER_CONFIG "$XDG_CONFIG_HOME/docker"
set -gx FNM_DIR "$XDG_DATA_HOME/fnm"
set -gx RUSTUP_HOME "$XDG_DATA_HOME/rustup"
set -gx CARGO_HOME "$XDG_DATA_HOME/cargo"
set -gx STACK_ROOT "$XDG_DATA_HOME/stack"

starship init fish | source
fnm env | source
source (lua $XDG_CONFIG_HOME/fish/scripts/z.lua --init fish | psub)

set PATH "$XDG_DATA_HOME/cargo/bin" "$HOME/.cabal/bin" "$HOME/.local/bin" $PATH
