setlocal sw=2 sts=2 formatoptions-=o formatoptions+=t foldmethod=syntax nofoldenable

let &l:formatprg = 'brittany'

call coc#config('languageserver.haskell', {
    \ 'command': 'hie-wrapper',
    \ 'args': ['--lsp'],
    \ 'rootPatterns': [
    \     'stack.yaml',
    \ ],
    \ 'filetypes': [
    \     'haskell',
    \ ],
    \ 'initializationOptions': {
    \     'languageServerHaskell': {
    \         'hlintOn': v:true,
    \     },
    \ },
\})
