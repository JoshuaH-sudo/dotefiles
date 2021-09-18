let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'preservim/nerdcommenter'
Plug 'preservim/nerdtree'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'yuezk/vim-js'
Plug 'neoclide/jsonc.vim'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript' 
Plug 'morhetz/gruvbox'
Plug 'reedes/vim-pencil'
Plug 'LunarWatcher/auto-pairs', { 'tag': '*' }
Plug 'preservim/vim-lexical'
Plug 'dbmrq/vim-ditto'
Plug 'rhysd/vim-grammarous'
Plug 'tpope/vim-fugitive'
call plug#end()
set encoding=UTF-8

set spell spelllang=en_us

cabb W w
cabb Q q

command! -nargs=0 Prettier :CocCommand prettier.formatFile
nmap <leader>f  <Plug>(coc-format-selected)

filetype plugin on
autocmd FileType json syntax match Comment +\/\/.\+$+

"nert tree shortcuts"
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>

autocmd vimenter * ++nested colorscheme gruvbox
set background=dark

"move betten terminals
nmap <silent> <C-k> :wincmd k<CR>
nmap <silent> <C-j> :wincmd j<CR>
nmap <silent> <C-h> :wincmd h<CR>
nmap <silent> <C-l> :wincmd l<CR>

"terminal text settings
syntax on
set tabstop=2
set shiftwidth=2
set expandtab
set number
set cursorline
set showcmd
set showmatch
set incsearch
set hlsearch
set foldenable
nnoremap <space> za
set foldmethod=indent
set foldlevelstart=10

"hybrid number lines
set number
augroup numbertoggle
  autocmd!
	autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
	autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
augroup END

"search
vnoremap / /\v
nnoremap / /\v

"resize window
nmap _ :vertical res-5<CR>
nmap - :vertical res+5<CR>
nmap + :res-5<CR>
nmap = :res+5<CR>

"remap esc key 
"inoremap <C-[> <ESC>

"ubuntu keycode issues"
map <Esc>k <A-k>
map <Esc>j <A-j>

"move lines
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

" open terminal below all splits
cabbrev term bo term 
set termwinsize=10x0
nmap <Leader>t :term

"misc
nmap <Leader>l :nohl

"coc settings
" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

"writeing config
set nocompatible
augroup pencil
  autocmd!
  autocmd FileType markdown,mkd call pencil#init()
  autocmd FileType text         call pencil#init()
  autocmd FileType txt         call pencil#init()
augroup END

let g:lexical#spell_key = '<leader>s'
let g:lexical#spell = 1         " 0=disabled, 1=enabled
let g:lexical#dictionary_key = '<leader>k'

augroup lexical
  autocmd!
  autocmd FileType markdown,mkd call lexical#init({ 'spell': 1 })
  autocmd FileType txt call lexical#init({ 'spell': 1 })
  autocmd FileType text call lexical#init({ 'spell': 1 })
augroup END

" Use autocmds to check your text automatically and keep the highlighting
" up to date (easier):
au FileType markdown,text,tex DittoOn  " Turn on Ditto's autocmds
nmap <leader>di <Plug>ToggleDitto      " Turn Ditto on and off

" If you don't want the autocmds, you can also use an operator to check
" specific parts of your text:
" vmap <leader>d <Plug>Ditto	       " Call Ditto on visual selection
" nmap <leader>d <Plug>Ditto	       " Call Ditto on operator movement

nmap =d <Plug>DittoNext                " Jump to the next word
nmap -d <Plug>DittoPrev                " Jump to the previous word
nmap +d <Plug>DittoGood                " Ignore the word under the cursor
nmap _d <Plug>DittoBad                 " Stop ignoring the word under the cursor
nmap ]d <Plug>DittoMore                " Show the next matches
nmap [d <Plug>DittoLess                " Show the previous matches

