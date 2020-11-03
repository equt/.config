bind \e fish_vi_key_bindings

function fish_title; end
function has; type -q $argv; end

alias c clear
has nvim; and alias v nvim; and alias vim nvim
has git; and alias g git
alias l ls; alias la 'ls -a'
has exa; and alias l exa; and alias ls exa; and alias la 'exa -a'

set fish_greeting ''

set -gx XDG_CONFIG_HOME "$HOME/.config"
set -gx XDG_CACHE_HOME "$HOME/.cache"
set -gx XDG_DATA_HOME "$HOME/.local/share"

set -gx DOCKER_CONFIG "$XDG_CONFIG_HOME/docker"
set -gx FNM_DIR "$XDG_DATA_HOME/fnm"
set -gx RUSTUP_HOME "$XDG_DATA_HOME/rustup"
set -gx CARGO_HOME "$XDG_DATA_HOME/cargo"
set -gx STACK_ROOT "$XDG_DATA_HOME/stack"
set -gx STARSHIP_CONFIG "$XDG_CONFIG_HOME/starship/starship.toml"

has starship; and starship init fish | source
has fnm; and fnm env | source
has lua; source (lua $XDG_CONFIG_HOME/fish/scripts/z.lua --init fish | psub)

set PATH "$XDG_DATA_HOME/cargo/bin" "$HOME/.cabal/bin" "$HOME/.local/bin" $PATH
