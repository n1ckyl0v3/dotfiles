" Option
set number
set nocompatible
set wrap
set encoding=utf-8
set tabstop=2
set shiftwidth=2
set expandtab
set autoindent
set ignorecase
set smartcase
set cursorline
set termguicolors
set background=dark
set signcolumn=auto
set backspace=indent,eol,start

hi Error guisp=#B58900 guibg=#002b36 gui=undercurl

 " hi Error guisp=#B58900 guibg=#002b36 gui=undercurl

if has("autocmd")
  au VimEnter,InsertLeave * silent execute '!echo -ne "\e[2 q"' | redraw!
  au InsertEnter,InsertChange *
\ if v:insertmode == 'i' |
\   silent execute '!echo -ne "\e[6 q"' | redraw! |
\ elseif v:insertmode == 'r' |
\   silent execute '!echo -ne "\e[4 q"' | redraw! |
\ endif
au VimLeave * silent execute '!echo -ne "\e[ q"' | redraw!
endif

set guioptions -=T
" set linespace=1

" autocmd vimenter * hi Normal guibg=NONE ctermbg=NONE

set noerrorbells visualbell t_vb=
if has('autocmd')
  autocmd GUIEnter * set visualbell t_vb=
endif

set clipboard=unnamedplus
syntax enable
set guifont=JetBrainsMono\ Nerd\ Font\ Medium\ 11

  " let $NVIM_TUI_ENABLE_TRUE_COLOR=1

augroup highlight_yank
autocmd!
au TextYankPost * silent! lua vim.highlight.on_yank({higroup="Visual", timeout=100})
augroup END

" let g:python3_host_prog="/usr/bin/python3"

" Keymap
let g:mapleader=' '
inoremap jj <esc>
nnoremap <C-s> :w<cr>
inoremap <C-s> <esc>:w<cr>
inoremap <C-v> <esc>"+pa
inoremap <C-S-v> <esc>"+pa
nnoremap <leader>q :bdelete<cr>
nnoremap <C-e> :bnext<cr>
nnoremap <C-q> :bprev<cr>
nnoremap <C-p> :Files<cr>    
nnoremap <leader>fm :Neoformat<CR>

" Plugin
call plug#begin()
Plug 'morhetz/gruvbox' "colorschemes
" Plug 'altercation/vim-colors-solarized'
Plug 'bluz71/vim-moonfly-colors', { 'as': 'moonfly' }
Plug 'overcache/NeoSolarized'

Plug 'preservim/nerdtree' " nerdtree
" Plug 'ryanoasis/vim-devicons' 

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } "fzf
Plug 'junegunn/fzf.vim'

Plug 'neoclide/coc.nvim', {'branch': 'release'} "coc

Plug 'sbdchd/neoformat' " formatter

Plug 'vim-airline/vim-airline' "vim airline

Plug 'tpope/vim-commentary' " comment

Plug 'jiangmiao/auto-pairs' " auto pair

Plug 'tpope/vim-fugitive'

Plug 'voldikss/vim-floaterm' " terminal

Plug 'christoomey/vim-tmux-navigator' 


call plug#end()


" Themes
 let g:gruvbox_bold = 0
 let g:gruvbox_italic = 0
let g:gruvbox_contrast_dark = "hard"
 colorscheme gruvbox
" colorscheme NeoSolarized
" let g:neosolarized_contrast = "hard"
" " let g:neosolarized_underline = 1
" let g:neosolarized_termtrans = 1
" let g:neosolarized_visibility = "high"


" colorscheme moonfly
let g:lightline = { 'colorscheme': 'moonfly' }
let g:moonflyItalics=v:false
let g:moonflyVirtualTextColor = v:true
let g:moonflyTransparent = v:true

" Nerdtree
nnoremap <C-n> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>
 
" Coc
" hi CocUnderline gui=underline term=underline

  " autocmd BufWritePost * call timer_start(1000, { tid -> execute('execute "CocDiagnostics 5" | execute "botright lwindow" | execute "wincmd p"') })
hi CocUnderline gui=undercurl term=undercurl
hi CocErrorHighlight ctermfg=red guisp=red guifg=#f5190a gui=undercurl term=undercurl
hi CocWarningHighlight ctermfg=yellow guifg=#c4ab39 gui=undercurl term=undercurl
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

nmap <leader>ac  <Plug>(coc-codeaction-cursor)
nmap <leader>as  <Plug>(coc-codeaction-source)
nmap <leader>qf  <Plug>(coc-fix-current)

nmap <silent> <leader>re <Plug>(coc-codeaction-refactor)
xmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)
nmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)

nmap <leader>cl  <Plug>(coc-codelens-action)

xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

command! -nargs=0 Format :call CocActionAsync('format')

command! -nargs=? Fold :call     CocAction('fold', <f-args>)
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

let g:coc_global_extensions = ['coc-json', 'coc-css', 'coc-cssmodules','coc-diagnostic','coc-eslint', 'coc-html','coc-html-css-support', 'coc-prettier', 'coc-snippets','coc-tailwindcss','coc-tsserver', 'coc-vimlsp','coc-xml','coc-yaml']


let g:coc_node_path = "/home/pury/.nvm/versions/node/v18.16.1/bin/node"

" Neoformat
"let g:neoformat_enabled_python = ['astyle', 'prettier']
let g:neoformat_try_formatprg = 1
let g:neoformat_enabled_javascript = ['prettier']
let g:neoformat_enabled_typescript = ['prettier']
let g:neoformat_enabled_json = ['prettier']
let g:neoformat_enabled_css = ['prettier']
let g:neoformat_enabled_html = ['prettier']


let g:neoformat_csharp_csharpier = {
     \ 'exe': 'csharpier',
     \ 'args': ['--single-line', '--indent-size', '4'],
     \ 'stdin': 1,
     \ }


" augroup fmt
"   autocmd!
"   autocmd BufWritePre * undojoin | Neoformat
" augroup END

" vim-airline
let g:airline#extensions#tabline#enabled = 1

" floaterm
let g:floaterm_wintype="split"
let g:floaterm_height=0.4

let g:floaterm_keymap_new    = '<leader>ft'
let g:floaterm_keymap_prev   = '<leader>fp'
let g:floaterm_keymap_next   = '<leader>fn'
let g:floaterm_keymap_toggle = '<C-\>'
let g:floaterm_keymap_kill = '<leader>fk'
nnoremap   <silent>   <C-\>   :FloatermToggle<CR>
tnoremap   <silent>   <C-\>   <C-\><C-n>:FloatermToggle<CR>

