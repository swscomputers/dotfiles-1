"   _____  _             _           
"  |  __ \| |           (_)          
"  | |__) | |_   _  __ _ _ _ __  ___ 
"  |  ___/| | | | |/ _` | | '_ \/ __|
"  | |    | | |_| | (_| | | | | \__ \
"  |_|    |_|\__,_|\__, |_|_| |_|___/
"                   __/ |            
"                  |___/            

call plug#begin("~/.vim/plugged")
	Plug 'dracula/vim'
	Plug 'scrooloose/nerdtree'
	Plug 'ryanoasis/vim-devicons'
	Plug 'phaazon/hop.nvim'
	Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim'
    Plug 'sheerun/vim-polyglot'
    Plug 'preservim/nerdcommenter'
    Plug 'nvim-telescope/telescope-file-browser.nvim'
    Plug 'neovim/nvim-lspconfig'
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'hrsh7th/cmp-buffer'
    Plug 'hrsh7th/cmp-path'
    Plug 'hrsh7th/cmp-cmdline'
    Plug 'hrsh7th/nvim-cmp'
    Plug 'onsails/lspkind-nvim'
    Plug 'L3MON4D3/LuaSnip'
    Plug 'saadparwaiz1/cmp_luasnip'
    Plug 'steelsojka/pears.nvim'
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    Plug 'ur4ltz/surround.nvim'
    Plug 'mg979/vim-visual-multi', {'branch': 'master'}
    if has('nvim') || has('patch-8.0.902')
      Plug 'mhinz/vim-signify'
    else
      Plug 'mhinz/vim-signify', { 'branch': 'legacy' }
    endif
call plug#end()

"   __  __                   _                 
"  |  \/  |                 (_)                
"  | \  / | __ _ _ __  _ __  _ _ __   __ _ ___ 
"  | |\/| |/ _` | '_ \| '_ \| | '_ \ / _` / __|
"  | |  | | (_| | |_) | |_) | | | | | (_| \__ \
"  |_|  |_|\__,_| .__/| .__/|_|_| |_|\__, |___/
"               | |   | |             __/ |    
"               |_|   |_|            |___/     

let mapleader=" "

"--- Add a new carrage return in normal mode
nmap <leader><cr> o<Esc>

"--- Fixing pasting in visual mode
xnoremap p pgvy

"--- Select word
inoremap <C-w> <Esc>viw

"--- Quit VIM
nnoremap <leader>q <cmd> :q <cr>

"--- Better ESC (the only way to escape)
inoremap jk <esc>
nnoremap <C-f> /
inoremap <C-f> <Esc>/

"--- Save and source your config file (while you have it open)
nnoremap <leader>rr <cmd>:w <cr> :source %<cr>

"--- Open the init.vim config file
nnoremap <leader>ee <cmd>:e ~/.config/nvim/init.vim<cr>

"--- Tab bindings
nnoremap tt :tabnext<CR>
nnoremap tb :tabprev<CR>
nnoremap tn :tabnew<CR>

"--- Toggle the line numbers
nnoremap <leader>n <cmd>:set number!<cr>

"--- Clear search by pressing enter 
"--- But I need more tweaks cause I hate search on VIM
"--- nnoremap <CR> :noh<CR><CR>

"--- Telescope bindings
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

"--- Move lines up and down, not ready for prime time
"--- To the end of the bench!
"--- nmap n :m +1<CR>
"--- nmap m :m -2<CR>

"--- Use alt + hjkl to move between split/vsplit panels
tnoremap <A-h> <C-\><C-n><C-w>h
tnoremap <A-j> <C-\><C-n><C-w>j
tnoremap <A-k> <C-\><C-n><C-w>k
tnoremap <A-l> <C-\><C-n><C-w>l
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l

"--- NERDTree bindings
nnoremap <leader>b <cmd>:NERDTreeToggle<cr>
let g:NERDTreeShowHidden = 1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeIgnore = []
let g:NERDTreeStatusline = ''
let NERDTreeQuitOnOpen = 1
let g:NERDTreeHighlightCursorline = 1

"--- SET SOME VARS
set fillchars=eob:\ 
"Turn on line numbers 
set "number"

"--- Auto close tag filetypes
let g:closetag_filenames = '*.html,*.xhtml,*.js,*.jsx,javascript,*.ts,*.tsx,typescript,vue,*.vue'

"--- Use system clipboard
set clipboard=unnamedplus

"--- Spaces & Tabs {{{
set tabstop=4       " number of visual spaces per TAB
set softtabstop=4   " number of spaces in tab when editing
set shiftwidth=4    " number of spaces to use for autoindent
set expandtab       " tabs are space
set autoindent
set copyindent      " copy indent from the previous line

"--- Current theme controls
let g:dracula_colorterm = 1
nnoremap <SPACE> <Nop>
set updatetime=100
filetype plugin on

"--- Easy moving between paragraphs but 
"--- To the beging and end of lines
"--- This will now also center your cursor as well
function! MoveParagraph(x,y) abort
  if empty(getline(line('.') + (a:x == '{' ? -1 : 1)))
     exec "norm! ".a:x
   endif
  exec "norm! ".a:x
  if empty(getline('.')) | exec "norm! ".a:y | endif
endfunction
nnoremap <C-k> :call MoveParagraph('{', 'wzz')<CR>
nnoremap <C-j> :call MoveParagraph('}', 'gezz')<CR>

"--- Setup hop
:lua require'hop'.setup()
:lua require("telescope").setup()
:lua require("telescope").load_extension "file_browser"
:lua vim.api.nvim_set_keymap('n', 'f', ":HopChar1<CR>", {})
":lua vim.api.nvim_set_keymap('n', 's', ":HopWordCurrentLine<CR>", {})
:lua vim.api.nvim_set_keymap('n', '<leader>l', ":HopLineStart<CR>", {})
:lua vim.api.nvim_set_keymap('n', 'w', ":HopWordCurrentLine<CR>", {})

"--- Automaticaly close NVIM if NERDTree is only thing left open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

"--- Turn terminal to normal mode with escape
tnoremap <Esc> <C-\><C-n>

"--- Start terminal in insert mode
au BufEnter * if &buftype == 'terminal' | :startinsert | endif

"---  Open terminal on ctrl+n
function! OpenTerminal()
  split term://bash
  resize 10
endfunction

"   _____                  _              
"  |  __ \                (_)             
"  | |__) |___  __ _ _   _ _ _ __ ___ ___ 
"  |  _  // _ \/ _` | | | | | '__/ _ / __|
"  | | \ |  __| (_| | |_| | | | |  __\__ \
"  |_|  \_\___|\__, |\__,_|_|_|  \___|___/
"                 | |                     
"                 |_|     

"---  Pears setup
:lua require "pears".setup()
:lua require'lspconfig'.tsserver.setup{}

lua <<EOF
local cmp = require'cmp'
local lspkind = require('lspkind')
cmp.setup {
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        end
    },
    mapping = {
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-e>"] = cmp.mapping.close(),
        ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
        ["<c-y>"] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Insert,
            select = true,
        },
    },
    formatting = {
        format = lspkind.cmp_format({
        mode = 'symbol', -- show only symbol annotations
        maxwidth = 50,  
        before = function (entry, vim_item)
            return vim_item
        end
        })
    },
    sources = {
        { name = "nvim_lsp"},
        { name = "path" },
        { name = "buffer" , keyword_length = 3},
    },
    experimental = {
        ghost_text = true
    }
}
EOF

lua <<EOF
require'nvim-treesitter.configs'.setup {
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "<CR>",
            scope_incremental = "<CR>",
            node_incremental = "<TAB>",
            node_decremental = "<S-TAB>",
        }
    },
}
EOF

lua <<EOF
require'surround'.setup {
    context_offset = 100,
    load_autogroups = false,
    mappings_style = "sandwhich",
    quotes = {"'", '"'},
    brackets = {"(", '{', '['},
    space_on_closing_char = false,
    pairs = {
        nestable = { b = { "(", ")" }, s = { "[", "]" }, B = { "{", "}" }, a = { "<", ">" } },
        linear = { q = { "'", "'" }, t = { "`", "`" }, d = { '"', '"' }
        },
    prefix = "s"
    }
}
EOF

"--- Some stuff a I picked up from https://github.com/Matsuuu/
"--- Source statusline
source ~/.config/nvim/setup/statusline.vim

"--- Source statusline
source ~/.config/nvim/setup/tabline.vim

if has("nvim")
  au TermOpen * tnoremap <Esc> <c-\><c-n>
  au FileType fzf tunmap <Esc>
endif

if (has("termguicolors"))
 set termguicolors
endif

syntax enable
colorscheme dracula
