call plug#begin("~/.vim/plugged")
	Plug 'dracula/vim'
	Plug 'scrooloose/nerdtree'
	Plug 'ryanoasis/vim-devicons'
	Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
	Plug 'junegunn/fzf.vim'
	Plug 'phaazon/hop.nvim'
	Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim'
    Plug 'sheerun/vim-polyglot'
    if has('nvim') || has('patch-8.0.902')
      Plug 'mhinz/vim-signify'
    else
      Plug 'mhinz/vim-signify', { 'branch': 'legacy' }
    endif
    Plug 'preservim/nerdcommenter'
    Plug 'nvim-telescope/telescope-file-browser.nvim'
call plug#end()

let g:dracula_colorterm = 1
nnoremap <SPACE> <Nop>
let mapleader=" "
set updatetime=100
filetype plugin on
" Clear search by pressing enter
nnoremap <CR> :noh<CR><CR>
" nnoremap <silent> <Esc><Esc> :let @/=""<CR>

" Use system clipboard
set clipboard=unnamedplus

" Spaces & Tabs {{{
set tabstop=4       " number of visual spaces per TAB
set softtabstop=4   " number of spaces in tab when editing
set shiftwidth=4    " number of spaces to use for autoindent
set expandtab       " tabs are space
set autoindent
set copyindent      " copy indent from the previous line

" Telescope stuff
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>rr <cmd>:w <cr> :source %<cr>

" 
" Better ESC
inoremap jj <esc>

" Setup hop
:lua require'hop'.setup()
:lua require("telescope").setup()
lua require("telescope").load_extension "file_browser"
" Place this in one of your configuration file(s)
lua vim.api.nvim_set_keymap('n', '<leader><leader>', ":HopChar1<CR>", {})
lua vim.api.nvim_set_keymap('n', 'f', ":HopChar2<CR>", {})
lua vim.api.nvim_set_keymap('n', '<leader>l', ":HopLineStart<CR>", {})
lua vim.api.nvim_set_keymap('n', '<leader>w', ":HopWord<CR>", {})


let g:NERDTreeShowHidden = 1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeIgnore = []
let g:NERDTreeStatusline = ''
" Automaticaly close nvim if NERDTree is only thing left open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" Toggle
"<silent> <C-b>:NERDTreeToggle<cr>

" open new split panes to right and below
set splitright
set splitbelow
" turn terminal to normal mode with escape
tnoremap <Esc> <C-\><C-n>
" start terminal in insert mode
au BufEnter * if &buftype == 'terminal' | :startinsert | endif
" open terminal on ctrl+n
function! OpenTerminal()
  split term://bash
  resize 10
endfunction
nnoremap <c-n> :call OpenTerminal()<CR>

" use alt+hjkl to move between split/vsplit panels
tnoremap <A-h> <C-\><C-n><C-w>h
tnoremap <A-j> <C-\><C-n><C-w>j
tnoremap <A-k> <C-\><C-n><C-w>k
tnoremap <A-l> <C-\><C-n><C-w>l
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l

nnoremap <C-p> :FZF<CR>
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit'
  \}

if has("nvim")
  au TermOpen * tnoremap <Esc> <c-\><c-n>
  au FileType fzf tunmap <Esc>
endif


if (has("termguicolors"))
 set termguicolors
endif
syntax enable
colorscheme dracula
