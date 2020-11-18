bind \e fish_vi_key_bindings

function fish_title; end
function has; type -q $argv; end

alias c clear
alias v vim
has nvim; and alias vim nvim
has git; and alias g git
has lazygit; and alias lg lazygit
has direnv; and eval (direnv hook fish)
alias l ls; alias la 'ls -a'
has exa; and alias l exa; and alias ls exa; and alias la 'exa -a'
has fzf; and alias f 'fzf --height 50% --reverse --preview-window down:50%:noborder --print0 -m \
    --bind "ctrl-j:preview-down,ctrl-k:preview-up" --preview "bat --style=numbers \
    --color=always {} --line-range :50"'
and alias vf 'v (f)'

set fish_greeting ''

set -gx EDITOR "nvim"
set -gx PAGER "less"

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

function prompt_fzf_opts --on-event fish_prompt

  if has dark-mode; and test (dark-mode status) = "off"
    # BG                 ; Not candidate text   ; Candidate text
    set color00 '#F0F0F4'; set color04 '#a0a0ad'; set color06 '#676880'
    # Line no && Curr >  ; Selected >           ; Matched part
    set color0A '#676880'; set color0C '#676880'; set color0D '#4969a3'
  else
    # BG                 ; Not candidate text   ; Candidate text
    set color00 '#1d242d'; set color04 '#546478'; set color06 '#546478'
    # Line no && Curr >  ; Selected >           ; Matched part
    set color0A '#546478'; set color0C '#546478'; set color0D '#4d75bd'
  end

  set -gx FZF_DEFAULT_OPTS "
      --color=bg+:$color00,bg:$color00,spinner:$color0C,hl:$color0D
      --color=fg:$color04,header:$color0D,info:$color0A,pointer:$color0C
      --color=marker:$color0C,fg+:$color06,prompt:$color0A,hl+:$color0D
      --height=40% --reverse
  "
end

function ok
  printf '%b\n' "\u001b[0m\u001b[0m\u001b[30m\u001b[42m OK \u001b[0m\u001b[0m $argv"
end

function alac
  function _ffmpeg
    set file $argv[1]
    set name (echo $file | sed 's/\.[^.]*$//')
    ffmpeg -i "$file" -c:v copy -c:a libfdk_aac -vbr 5 -hide_banner -loglevel panic -- "$name.m4a"
    ok $name
  end
  for file in $argv
    _ffmpeg "$file"
  end
end

set PATH "$XDG_DATA_HOME/cargo/bin" "$HOME/.cabal/bin" "$HOME/.local/bin" $PATH
