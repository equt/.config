function! utils#system(cmd) abort
    return substitute(system(a:cmd), '\n', '', 'g')
endfunction

function! utils#dark() abort
    let l:status = utils#system('dark-mode status')
    if l:status == 'on'
        return v:true
    else
        return v:false
    endif
endfunction

function! utils#window_should_hide() abort
    let l:name = expand('%:t')
    return l:name =~ "NERD_" || l:name == '' ? 1 : 0
endfunction

function! utils#mode() abort
    return utils#window_should_hide() ? '' : lightline#mode()
endfunction

function! utils#filename()
    if utils#window_should_hide()
        return ''
    endif

    let l:name = expand('%:t:r')
    let l:name = &readonly ? '! ' . l:name : l:name
    let l:name = &modified ? l:name . "'" : l:name
    let l:attr = []
    if &fileencoding !=# 'utf-8'
        if &fileencoding == ''
            call add(l:attr, '? enc')
        else
            call add(l:attr, &fileencoding)
        endif
    end
    if &fileformat !=# 'unix'
        call add(l:attr, &fileformat)
    end
    if len(l:attr) != 0
        let l:name = l:name . ' (' . join(l:attr, ', ') . ')'
    endif
    return l:name
endfunction

function! utils#filetype()
    return utils#window_should_hide() ? '' : &filetype
endfunction

function! utils#git_branch()
    let l:branch = FugitiveHead()
    if utils#window_should_hide() || l:branch ==# 'master' || l:branch == ''
        return ''
    endif
    return ' ' . l:branch
endfunction

function! utils#file_percentage()
    if utils#window_should_hide()
        return ''
    endif
    let [_, l:max_line; _] = getpos('$')
    let [_, l:line, l:column, _] = getpos('.')
    let l:percent = float2nr((l:line / (l:max_line + 0.0) * 10))
    return ['', '', '', '', '', '', '', '', '', '', '', ''][l:percent]
endfunction

function! utils#fzf_statusline() abort
    if !utils#dark()
        highlight fzf1 guifg=#102C4E guibg=#F0F0F4
    else
        highlight fzf1 guifg=#908f95 guibg=#1d242d
    endif
    setlocal statusline=%#fzf1#\ Searching
endfunction

function! utils#check_backspace() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

function! utils#show_documentation() abort
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    else
        call CocAction('doHover')
    endif
endfunction

function! utils#map_as_cli_options(map) abort
    let l:options = ''
    for [k, v] in items(a:map)
        let l:options .= ' --' . k . ' ' . v
        unlet k v
    endfor
    return l:options
endfunction

function! utils#map_help_forward_backward()
    nnoremap q <C-o>
    nnoremap <CR> <C-]>
endfunction

function utils#unmap_help_forward_backward()
    nunmap q
    nunmap <CR>
endfunction
