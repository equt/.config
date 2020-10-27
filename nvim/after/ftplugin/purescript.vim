setlocal sw=2 sts=2 formatoptions-=o foldmethod=syntax nofoldenable
let &l:formatprg = 'purty format -'

call coc#config('languageserver.purescript',
    \ {
        \ 'command': 'purescript-language-server',
        \ 'args': ['--stdio'],
        \ 'filetypes': ['purescript'],
        \ 'rootPatterns': ['spago.dhall'],
    \ }
\ )

call coc#config('purescript', {
    \ 'addSpagoSources': v:true,
    \ 'buildCommand': 'spago build -- --json-errors',
\ })
