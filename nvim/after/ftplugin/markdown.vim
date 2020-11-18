setlocal sw=2 sts=2 formatoptions-=o foldenable foldmethod=expr spell conceallevel=2

let s:prettier_config = {
    \ 'prose-wrap': 'always',
    \ 'print-width': 80,
    \ 'parser': 'markdown',
\ }

let &l:formatprg = 'prettier' . utils#map_as_cli_options(s:prettier_config)
