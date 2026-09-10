-- lua/plugins/formatting.lua - conform + nvim-lint
return {
  -- Formatação
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
      {
        "<leader>cf",
        function()
          require("conform").format({ async = true, lsp_fallback = true })
        end,
        mode = { "n", "v" },
        desc = "Format (conform)",
      },
      { "<A-S-F>", function() require("conform").format({ async = true, lsp_fallback = true }) end, mode = { "n", "v" }, desc = "Format (VSCode Shift+Alt+F)" },
    },
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        python = { "black", "isort" },
        javascript = { "prettier", "prettierd", stop_after_first = true },
        javascriptreact = { "prettier", stop_after_first = true },
        typescript = { "prettier", stop_after_first = true },
        typescriptreact = { "prettier", stop_after_first = true },
        html = { "prettier" },
        css = { "prettier" },
        json = { "prettier" },
        jsonc = { "prettier" },
        yaml = { "prettier" },
        markdown = { "prettier" },
        toml = { "taplo" },
        sh = { "shfmt" },
        go = { "gofmt" },
        rust = { "rustfmt" },
      },
      format_on_save = function(bufnr)
        -- Desativa para arquivos grandes ou se .editorconfig mandar
        if vim.b[bufnr].disable_autoformat then
          return
        end
        return { timeout_ms = 1500, lsp_fallback = true }
      end,
      formatters = {
        shfmt = { prepend_args = { "-i", "2" } },
      },
    },
    init = function()
      vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
      -- Comando para toggle
      vim.api.nvim_create_user_command("FormatToggle", function()
        vim.b.disable_autoformat = not vim.b.disable_autoformat
        vim.notify("Autoformat " .. (vim.b.disable_autoformat and "OFF" or "ON"))
      end, {})
    end,
  },

  -- Lint
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      linters_by_ft = {
        python = { "ruff" },
        javascript = { "eslint_d" },
        typescript = { "eslint_d" },
        sh = { "shellcheck" },
      },
    },
    config = function(_, opts)
      local lint = require("lint")
      lint.linters_by_ft = opts.linters_by_ft
      vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
        callback = function()
          require("lint").try_lint()
        end,
      })
    end,
  },

  -- Mason garante formatters/linters
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "williamboman/mason.nvim" },
    opts = {
      ensure_installed = {
        "stylua",
        "prettier",
        "black",
        "isort",
        "shfmt",
        "shellcheck",
        "eslint_d",
        "ruff",
        "taplo",
      },
      auto_update = false,
      run_on_start = true,
    },
  },
}
