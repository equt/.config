" See https://github.com/HerringtonDarkholme/yats.vim/issues/209

let s:prettier_config = {
    \ 'parser': &filetype,
\ }

let &l:formatexpr = 'prettier' . utils#map_as_cli_options(s:prettier_config)
