-- lua/plugins/lsp.lua - LSP genérico com Mason auto-install
return {
  -- Mason
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    build = ":MasonUpdate",
    opts = {
      ui = {
        border = "rounded",
        icons = { package_installed = "✓", package_pending = "➜", package_uninstalled = "✗" },
      },
    },
  },

  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    opts = {
      ensure_installed = {
        "lua_ls",
        "pyright",
        "ts_ls",
        "html",
        "cssls",
        "jsonls",
        "yamlls",
        "bashls",
        "marksman",
        "taplo", -- toml
      },
      automatic_installation = true,
    },
  },

  -- LSP Config
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "saghen/blink.cmp",
      { "j-hui/fidget.nvim", opts = {} },
    },
    opts = {
      diagnostics = {
        underline = true,
        update_in_insert = false,
        virtual_text = { spacing = 4, source = "if_many", prefix = "●" },
        severity_sort = true,
        float = { border = "rounded", source = "always" },
      },
      inlay_hints = { enabled = true },
    },
    config = function(_, opts)
      -- Diagnósticos
      vim.diagnostic.config(opts.diagnostics)

      -- Borda arredondada para hover/signature
      local handlers = {
        ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" }),
        ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" }),
      }

      -- Capabilities do blink.cmp
      local capabilities = require("blink.cmp").get_lsp_capabilities()

      -- On attach
      local on_attach = function(_, bufnr)
        local map = function(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc, silent = true })
        end
        map("n", "gd", vim.lsp.buf.definition, "Goto definition")
        map("n", "gD", vim.lsp.buf.declaration, "Goto declaration")
        map("n", "gr", "<cmd>Telescope lsp_references<cr>", "References")
        map("n", "gi", vim.lsp.buf.implementation, "Goto implementation")
        map("n", "K", vim.lsp.buf.hover, "Hover")
        map("n", "<C-k>", vim.lsp.buf.signature_help, "Signature help")
        map("i", "<C-k>", vim.lsp.buf.signature_help, "Signature help")
        map("n", "<leader>ca", vim.lsp.buf.code_action, "Code action")
        map("n", "<leader>cr", vim.lsp.buf.rename, "Rename (VSCode F2)")
        map("n", "<F2>", vim.lsp.buf.rename, "Rename")
        map("n", "<leader>cf", function()
          require("conform").format({ async = true, lsp_fallback = true })
        end, "Format")
        map("n", "<leader>cd", vim.diagnostic.open_float, "Line diagnostics")
      end

      -- Servidores
      local servers = {
        lua_ls = {
          settings = {
            Lua = {
              diagnostics = { globals = { "vim" } },
              workspace = { checkThirdParty = false },
              telemetry = { enable = false },
              completion = { callSnippet = "Replace" },
            },
          },
        },
        pyright = {},
        ts_ls = {
          settings = {
            completions = { completeFunctionCalls = true },
          },
        },
        html = {},
        cssls = {},
        jsonls = {},
        yamlls = {
          settings = {
            yaml = {
              keyOrdering = false,
            },
          },
        },
        bashls = {},
        marksman = {},
        taplo = {},
      }

      -- Setup via lspconfig (compatível com nvim 0.12)
      for server, server_opts in pairs(servers) do
        server_opts = vim.tbl_deep_extend("force", {
          capabilities = vim.deepcopy(capabilities),
          handlers = handlers,
          on_attach = on_attach,
        }, server_opts)
        require("lspconfig")[server].setup(server_opts)
      end

      -- Ícones de diagnóstico
      for _, type in ipairs({ "Error", "Warn", "Hint", "Info" }) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = ({ Error = " ", Warn = " ", Hint = " ", Info = " " })[type], texthl = hl, numhl = hl })
      end
    end,
  },
}
