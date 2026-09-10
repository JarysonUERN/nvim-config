-- lua/config/options.lua
local opt = vim.opt

-- Aparência
opt.number = true
opt.relativenumber = true
opt.termguicolors = true
opt.signcolumn = "yes"
opt.cursorline = true
opt.wrap = false
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.showmode = false -- lualine já mostra
opt.laststatus = 3 -- statusline global

-- Indentação (2 espaços - padrão web moderno)
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.smartindent = true
opt.autoindent = true

-- Busca
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true

-- Arquivos e undo
opt.backup = false
opt.writebackup = false
opt.swapfile = false
opt.undofile = true
opt.undodir = vim.fn.stdpath("data") .. "/undo"
opt.hidden = true
opt.autoread = true

-- Comportamento
opt.mouse = "a"
opt.clipboard = "unnamedplus" -- integra com clipboard do Windows
opt.splitbelow = true
opt.splitright = true
opt.updatetime = 250
opt.timeoutlen = 300
opt.completeopt = { "menu", "menuone", "noselect" }
opt.pumheight = 10
opt.conceallevel = 0
opt.fileencoding = "utf-8"
opt.iskeyword:append("-")

-- Pastas lider por espaço
opt.wildmode = "longest:full,full"
opt.wildignore:append({ "*.o", "*.obj", "*.pyc", "node_modules/*", ".git/*" })

-- Desativa netrw (usaremos neo-tree)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Fonte para GUI (Neovide / nvim-qt)
if vim.g.neovide then
  vim.o.guifont = "JetBrainsMono Nerd Font:h11"
end

-- Provider python/node (evita checkhealth warning se não tiver)
vim.g.loaded_python3_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
