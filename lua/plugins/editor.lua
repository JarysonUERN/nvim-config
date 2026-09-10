-- lua/plugins/editor.lua - Telescope, Neo-tree, edição
return {
  -- Telescope
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    version = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release",
        cond = function()
          return vim.fn.executable("cmake") == 1
        end,
      },
      "nvim-tree/nvim-web-devicons",
    },
    keys = {
      { "<C-p>", "<cmd>Telescope find_files<cr>", desc = "Find files (VSCode)" },
      { "<C-S-p>", "<cmd>Telescope commands<cr>", desc = "Commands (VSCode)" },
      { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files" },
      { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live grep" },
      { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
      { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help" },
      { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent" },
      { "<leader>fc", "<cmd>Telescope grep_string<cr>", desc = "Grep string" },
      { "<leader>fd", "<cmd>Telescope diagnostics<cr>", desc = "Diagnostics" },
      { "<leader>fs", "<cmd>Telescope lsp_document_symbols<cr>", desc = "Document symbols" },
      { "<C-f>", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Fuzzy find buffer" },
    },
    opts = function()
      local actions = require("telescope.actions")
      return {
        defaults = {
          prompt_prefix = " ",
          selection_caret = " ",
          path_display = { "truncate" },
          mappings = {
            i = {
              ["<C-j>"] = actions.move_selection_next,
              ["<C-k>"] = actions.move_selection_previous,
              ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
              ["<Esc>"] = actions.close,
            },
            n = {
              ["q"] = actions.close,
            },
          },
          file_ignore_patterns = { "node_modules", ".git/", "dist/", "build/" },
        },
        pickers = {
          find_files = { hidden = true },
        },
      }
    end,
    config = function(_, opts)
      local telescope = require("telescope")
      telescope.setup(opts)
      pcall(telescope.load_extension, "fzf")
    end,
  },

  -- Neo-tree (file explorer)
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    cmd = "Neotree",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    keys = {
      { "<C-b>", "<cmd>Neotree toggle<cr>", desc = "Explorer (VSCode)" },
      { "<leader>e", "<cmd>Neotree toggle<cr>", desc = "Explorer" },
      { "<leader>o", "<cmd>Neotree focus<cr>", desc = "Focus explorer" },
    },
    opts = {
      close_if_last_window = true,
      filesystem = {
        filtered_items = { visible = true, hide_dotfiles = false, hide_gitignored = false },
        follow_current_file = { enabled = true },
        group_empty_dirs = true,
      },
      window = {
        width = 30,
        mappings = {
          ["<space>"] = "none",
        },
      },
      default_component_configs = {
        indent = { with_expanders = true, expander_collapsed = "", expander_expanded = "" },
      },
    },
  },

  -- Auto pairs
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {},
  },

  -- Surround
  {
    "kylechui/nvim-surround",
    version = "*",
    event = { "BufReadPost", "BufNewFile" },
    opts = {},
  },

  -- Comentário
  {
    "numToStr/Comment.nvim",
    event = { "BufReadPost", "BufNewFile" },
    opts = {},
    keys = {
      { "gcc", mode = "n", desc = "Comment line" },
      { "gc", mode = { "n", "v" }, desc = "Comment" },
      { "<C-/>", "gcc", mode = "n", desc = "Comment (VSCode)", remap = true },
      { "<C-/>", "gc", mode = "v", desc = "Comment (VSCode)", remap = true },
    },
  },

  -- Todo comments
  {
    "folke/todo-comments.nvim",
    cmd = { "TodoTelescope", "TodoQuickFix" },
    event = { "BufReadPost", "BufNewFile" },
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
    keys = {
      { "<leader>st", "<cmd>TodoTelescope<cr>", desc = "Todo" },
    },
  },

  -- Bufferline (opcional mas útil para IDE-like)
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    version = "*",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      options = {
        mode = "buffers",
        diagnostics = "nvim_lsp",
        offsets = { { filetype = "neo-tree", text = "Explorer", separator = true } },
        show_buffer_close_icons = true,
        separator_style = "slant",
      },
    },
  },

  -- Noice / notificações melhores (opcional)
  {
    "rcarriga/nvim-notify",
    lazy = true,
    opts = {
      timeout = 3000,
      background_colour = "#1a1b26",
      render = "compact",
    },
    init = function()
      vim.notify = require("notify")
    end,
  },
}
