augroup HelpForwardBackwardRemap
    autocmd!
    autocmd BufEnter * if &filetype ==# 'help'
        \ | call utils#map_help_forward_backward()
        \ | endif
    autocmd BufLeave * if &filetype ==# 'help'
        \ | call utils#unmap_help_forward_backward()
        \ | endif
augroup END
