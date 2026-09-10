-- lua/config/keymaps.lua - Atalhos VSCode-like + Vim
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Leader já definido no init.lua

-- === VSCode-like ===
map("n", "<C-s>", "<cmd>w<cr>", { desc = "Salvar (VSCode)" })
map("i", "<C-s>", "<esc><cmd>w<cr>a", { desc = "Salvar (VSCode)" })
map("v", "<C-s>", "<esc><cmd>w<cr>gv", { desc = "Salvar (VSCode)" })

map("n", "<C-a>", "ggVG", { desc = "Selecionar tudo" })
map("i", "<C-a>", "<esc>ggVG", { desc = "Selecionar tudo" })

map("n", "<C-z>", "u", { desc = "Desfazer" })
map("i", "<C-z>", "<esc>ui", { desc = "Desfazer" })
map("n", "<C-y>", "<C-r>", { desc = "Refazer" })
map("i", "<C-y>", "<esc><C-r>i", { desc = "Refazer" })

-- Ctrl+C / Ctrl+V no visual (mantém vim yank também)
map("v", "<C-c>", '"+y', { desc = "Copiar" })
map("n", "<C-v>", '"+p', { desc = "Colar" })
map("i", "<C-v>", '<C-r>+', { desc = "Colar" })
map("v", "<C-v>", '"+p', { desc = "Colar" })

-- Mover linhas (Alt+Up/Down como VSCode)
map("n", "<A-Up>", "<cmd>m .-2<cr>==", { desc = "Mover linha cima" })
map("n", "<A-Down>", "<cmd>m .+1<cr>==", { desc = "Mover linha baixo" })
map("i", "<A-Up>", "<esc><cmd>m .-2<cr>==gi", { desc = "Mover linha cima" })
map("i", "<A-Down>", "<esc><cmd>m .+1<cr>==gi", { desc = "Mover linha baixo" })
map("v", "<A-Up>", ":m '<-2<cr>gv=gv", { desc = "Mover seleção cima" })
map("v", "<A-Down>", ":m '>+1<cr>gv=gv", { desc = "Mover seleção baixo" })

-- Duplicar linha (Shift+Alt+Down)
map("n", "<S-A-Down>", "<cmd>t.<cr>", { desc = "Duplicar linha" })
map("i", "<S-A-Down>", "<esc><cmd>t.<cr>gi", { desc = "Duplicar linha" })

-- === Navegação ===
-- Melhor navegação entre splits
map("n", "<C-h>", "<C-w>h", opts)
map("n", "<C-j>", "<C-w>j", opts)
map("n", "<C-k>", "<C-w>k", opts)
map("n", "<C-l>", "<C-w>l", opts)

-- Redimensionar splits com Alt+Setas
map("n", "<A-Left>", "<cmd>vertical resize -2<cr>", opts)
map("n", "<A-Right>", "<cmd>vertical resize +2<cr>", opts)
map("n", "<A-Up>", "<cmd>resize -2<cr>", opts) -- conflito leve com mover linha, mover linha tem prioridade em n
map("n", "<C-Up>", "<cmd>resize +2<cr>", opts)
map("n", "<C-Down>", "<cmd>resize -2<cr>", opts)

-- Buffers
map("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Buffer anterior" })
map("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Próximo buffer" })
map("n", "<leader>bd", "<cmd>bdelete<cr>", { desc = "Fechar buffer" })
map("n", "<C-Tab>", "<cmd>bnext<cr>", { desc = "Próximo buffer (VSCode)" })
map("n", "<C-S-Tab>", "<cmd>bprevious<cr>", { desc = "Buffer anterior" })

-- Limpar highlight de busca
map("n", "<Esc>", "<cmd>nohlsearch<cr>", opts)

-- Manter seleção ao indentar
map("v", "<", "<gv", opts)
map("v", ">", ">gv", opts)

-- Mover melhor com j/k em linhas quebradas
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Terminal
map("t", "<Esc>", "<C-\\><C-n>", { desc = "Sair do terminal" })
map("t", "<C-h>", "<C-\\><C-n><C-w>h", opts)

-- Atalhos Leader (which-key vai mostrar)
map("n", "<leader>w", "<cmd>w<cr>", { desc = "Salvar" })
map("n", "<leader>q", "<cmd>q<cr>", { desc = "Sair" })
map("n", "<leader>h", "<cmd>nohlsearch<cr>", { desc = "Limpar highlight" })

-- Comentário rápido é do plugin Comment.nvim (gcc)

-- Diagnósticos
map("n", "[d", vim.diagnostic.goto_prev, { desc = "Diagnóstico anterior" })
map("n", "]d", vim.diagnostic.goto_next, { desc = "Próximo diagnóstico" })
map("n", "<leader>e", vim.diagnostic.open_float, { desc = "Mostrar erro" })
map("n", "<leader>ld", vim.diagnostic.setloclist, { desc = "Lista diagnósticos" })
