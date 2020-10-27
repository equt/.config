setlocal tw=98 formatoptions+=t formatoptions-=o fdm=syntax nofoldenable

let s:rustfmt_config = {
    \ 'edition': 2018
\}
let &l:formatexpr = 'rustfmt' . utils#map_as_cli_options(s:rustfmt_config)

nnoremap <silent><leader>t :RustTest<CR>
nnoremap <silent><leader>d :Dispatch! cargo doc<CR>

call coc#add_extension('coc-rust-analyzer')
call coc#config('rust-analyzer.cargo.allFeatures', v:true)
call coc#config('rust-analyzer.checkOnSave.command', 'clippy')
