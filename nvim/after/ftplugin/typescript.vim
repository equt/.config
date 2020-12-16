setlocal tw=80 sw=2 sts=2 formatoptions+=t formatoptions-=o fdm=syntax nofoldenable

call coc#add_extension(
    \ 'coc-tsserver',
    \ 'coc-eslint',
\)

let s:prettier_config = {
    \ 'parser': 'typescript',
\ }

let &l:formatprg = 'prettier' . utils#map_as_cli_options(s:prettier_config)
