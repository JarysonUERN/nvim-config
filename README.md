# nvim-config

Configuração modular do Neovim para Windows - **Tokyo Night** + **VSCode-like** + **IDE completo**.

> Gerado automaticamente - Neovim 0.12.4 + lazy.nvim

## ✨ Features

- **Tema:** Tokyo Night (	okyonight-night)
- **Gerenciador:** [lazy.nvim](https://github.com/folke/lazy.nvim)
- **LSP:** mason.nvim + mason-lspconfig (auto-install: lua_ls, pyright, ts_ls, html, cssls, jsonls, yamlls, bashls)
- **Completion:** [blink.cmp](https://github.com/Saghen/blink.cmp) + LuaSnip
- **Sintaxe:** [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) (master, 26 linguagens)
- **Editor:** telescope, neo-tree, which-key, autopairs, surround, Comment.nvim, todo-comments, bufferline
- **Formatação:** conform.nvim + nvim-lint + mason-tool-installer
- **Git:** gitsigns + fugitive + lazygit
- **Atalhos:** VSCode-like (<C-s>, <C-p>, <C-b>, <A-Up/Down>)

## 📁 Estrutura

\\\
C:\Users\jarys\AppData\Local\nvim\
├── init.lua
└── lua/
    ├── config/
    │   ├── options.lua
    │   ├── keymaps.lua
    │   └── autocmds.lua
    └── plugins/
        ├── ui.lua
        ├── editor.lua
        ├── treesitter.lua
        ├── lsp.lua
        ├── cmp.lua
        ├── formatting.lua
        └── git.lua
\\\

## 🚀 Instalação

\\\powershell
# Windows
git clone https://github.com/JarysonUERN/nvim-config.git $env:LOCALAPPDATA\nvim
nvim  # lazy.nvim instala plugins automaticamente
\\\

## ⌨️ Atalhos principais

| Atalho | Ação |
|--------|------|
| \<C-s>\ | Salvar |
| \<C-p>\ / \<leader>ff\ | Find files (Telescope) |
| \<C-b>\ / \<leader>e\ | Explorer (Neo-tree) |
| \<leader>fg\ | Live grep |
| \<leader>fb\ | Buffers |
| \gd\ / \gr\ / \K\ | LSP goto/references/hover |
| \<F2>\ / \<leader>cr\ | Rename |
| \<leader>ca\ | Code action |
| \<leader>cf\ / \<A-S-F>\ | Format |
| \gcc\ / \<C-/>\ | Comentar |

## 🔧 Comandos úteis

- \:Lazy\ - gerenciar plugins
- \:Mason\ - gerenciar LSPs/formatters
- \:checkhealth\ - verificar saúde

## 📋 Requisitos

- Neovim >= 0.9 (testado em 0.12.4)
- Git
- (Opcional) C compiler para treesitter: \zig\ ou Build Tools
- (Opcional) \ipgrep\ para Telescope live_grep
