
:lua vim.opt.termguicolors = true

"--- Load plugins
:source ~/.config/nvim/setup/plugins.vim

"   __  __                   _                 
"  |  \/  |                 (_)                
"  | \  / | __ _ _ __  _ __  _ _ __   __ _ ___ 
"  | |\/| |/ _` | '_ \| '_ \| | '_ \ / _` / __|
"  | |  | | (_| | |_) | |_) | | | | | (_| \__ \
"  |_|  |_|\__,_| .__/| .__/|_|_| |_|\__, |___/
"               | |   | |             __/ |    
"               |_|   |_|            |___/     

"--- Set the leader key
let mapleader=" "

"--- Select all
nnoremap <leader>a ggVG

"--- Hold indent in visual mode
xnoremap < <gv
xnoremap > >gv

"--- Move text up and down
nnoremap <M-j> :m .+1<CR>==
nnoremap <M-k> :m .-2<CR>==
inoremap <M-j> <Esc>:m .+1<CR>==gi
inoremap <M-k> <Esc>:m .-2<CR>==gi
vnoremap <M-j> :move '>+1<CR>gv-gv
vnoremap <M-k> :move '<-2<CR>gv-gv

"--- Add a new carrage return in normal mode
"--- TODO: want to evntually map shift <cr> when possible
nnoremap <cr> o<Esc>
:autocmd CmdwinEnter * nnoremap <CR> <CR>
:autocmd BufReadPost quickfix nnoremap <CR> <CR>

"--- Fixing pasting in visual mode
xnoremap p pgvy

"--- Making G work better
nmap G Gzz

"--- Select word
inoremap <C-w> <Esc>viw

"--- Emacs basics movement in insert mode
inoremap <C-A> <Home>
inoremap <C-B> <Left>
inoremap <C-E> <End>
inoremap <C-F> <Right>

"--- Quit VIM
nnoremap <leader>q <cmd>:q <cr>

"--- Save the current file
nnoremap <leader>sf <cmd>:w <cr>

"--- Better ESC (the only way to escape)
inoremap jk <esc>

"--- Esc to hide highlight after search
nnoremap <silent> <esc> :noh <CR>

"--- Save and source your config file (while you have it open)
nnoremap <leader>rr <cmd>:w <cr>:source $MYVIMRC<cr>

"--- Run the npm run start command 
nnoremap <leader>rs <cmd>:w <cr> :!npm run start<cr>

"--- Open the init.vim config file
nnoremap <leader>fc <cmd>:e ~/.config/nvim<cr>

"--- Tab bindings
nnoremap tt :tabnext<CR>
nnoremap tb :tabprev<CR>
nnoremap tn :tabnew<CR>

"--- Toggle the line numbers
nnoremap <leader>n <cmd>:set number!<cr>

"--- Telescope bindings
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope grep_string<cr>
nnoremap <leader>fl <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
noremap <leader>fs <cmd>Telescope lsp_document_symbols<cr>

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

"--- Set some vars
set timeoutlen=300

"--- Some search options
set ignorecase
set smartcase

"--- Smart Indent
set smartindent

"--- Not sure what this does, please tell me
set fillchars=eob:\ 

"--- Turn on line numbers 
set number

"--- Auto close tag filetypes
let g:closetag_filenames = '*.html,*.xhtml,*.js,*.jsx,javascript,*.ts,*.tsx,typescript,vue,*.vue'

"--- Use system clipboard
set clipboard=unnamedplus

"--- Spaces & Tab
set tabstop=4       " number of visual spaces per TAB
set softtabstop=4   " number of spaces in tab when editing
set shiftwidth=4    " number of spaces to use for autoindent
set expandtab       " tabs are space
set autoindent
set copyindent      " copy indent from the previous line

"--- Current theme controls
let g:dracula_colorterm = 1
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

"--- Set up Telescope
:lua require("telescope").setup()
:lua require("telescope").load_extension "file_browser"

"--- Setup hop
:lua require'hop'.setup()
:lua vim.api.nvim_set_keymap('n', 'f', ":HopChar1<CR>", {})
:lua vim.api.nvim_set_keymap('n', '<leader>hl', ":HopLineStart<CR>", {})

"--- Automaticaly close NVIM if NERDTree is only thing left open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

"--- Turn terminal to normal mode with escape
tnoremap <Esc> <C-\><C-n>

"--- Start terminal in insert mode
au BufEnter * if &buftype == 'terminal' | :startinsert | endif

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

"--- Colorizer setup"
:lua require'colorizer'.setup()

lua <<EOF
-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end
require'lspconfig'.tsserver.setup{
    on_attach = on_attach,
    filetypes = { "typescript", "typescriptreact", "typescript.tsx", "javascript" },
    root_dir = function() return vim.loop.cwd() end      -- run lsp for javascript in any directory
}
EOF

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
            init_selection = "<leader>s",
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

if has("nvim")
  au TermOpen * tnoremap <Esc> <c-\><c-n>
  au FileType fzf tunmap <Esc>
endif

if (has("termguicolors"))
 set termguicolors
endif

syntax enable
colorscheme dracula

"green="#8aff80"
"yellow="#ffff80"
"pink="#ff80bf"
"purple="#9580ff"
"cyan="#80ffea"
"orange="#ffca80"
"red="#ff9580"

"--- Set curserLine only on current window
set cursorline

"--- Default Colors for CursorLine
highlight CursorLine ctermbg=White  guibg=#232530
highlight CursorLineNr ctermfg=White cterm=bold guifg=#ffffff

"--- Change Color when entering Insert Mode
autocmd InsertEnter * highlight CursorLine ctermbg=None guibg=None
autocmd InsertLeave * highlight CursorLine ctermbg=White guibg=#232530

augroup highlight_yank
    autocmd!
    au TextYankPost * silent! lua vim.highlight.on_yank({higroup="IncSearch", timeout=700})
augroup END

lua <<EOF
local wk = require("which-key")
wk.register({
  ["<leader>"] = {
    f = {
      name = "+Files/Find",
      f = { "File Git file" },
      b = { "Find in buffer" },
      l = { "Live Grep" },
      g = { "Grep String" },
      h = { "Help Tags" },
      s = { "Find Symbols" },
      c = { "Open Config" },
    },
    s = {
        name = "Text Select [Save Commands]",
        f = "Save File",
    },
    b = {"Tree Toggle"},
    e = {
        name = "Misc",
        e = { "Open Config"},
    },
    l = { "Word Hope Line"},
    r = {
        name = "Commands",
        s = "NPM Run Start",
        r = "Reload Config",
    },
    q = { "Quit VIM"},
    n = { "Set Numbers"},
  },
})
EOF

" Colors in tmux
if exists('$TMUX')
    let &t_8f = "<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "<Esc>[48;2;%lu;%lu;%lum"
endif

set termguicolors
