setlocal sw=2 sts=2 formatoptions-=o fdm=syntax nofoldenable

let s:prettier_config = {
    \ 'parser': &filetype,
\}

let &l:formatprg = 'prettier' . utils#map_as_cli_options(s:prettier_config)
