-- lua/plugins/git.lua
return {
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      signs = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
        untracked = { text = "▎" },
      },
      current_line_blame = false,
      on_attach = function(buffer)
        local gs = package.loaded.gitsigns
        local function map(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
        end
        map("n", "]h", gs.next_hunk, "Next hunk")
        map("n", "[h", gs.prev_hunk, "Prev hunk")
        map("n", "<leader>gp", gs.preview_hunk, "Preview hunk")
        map("n", "<leader>gb", function() gs.blame_line({ full = true }) end, "Blame line")
        map("n", "<leader>gd", gs.diffthis, "Diff this")
        map("n", "<leader>gs", gs.stage_hunk, "Stage hunk")
        map("n", "<leader>gr", gs.reset_hunk, "Reset hunk")
        map("n", "<leader>gS", gs.stage_buffer, "Stage buffer")
        map("n", "<leader>gu", gs.undo_stage_hunk, "Undo stage")
        map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<cr>", "Select hunk")
      end,
    },
  },

  -- Fugitive para :Git
  {
    "tpope/vim-fugitive",
    cmd = { "Git", "G", "Gstatus", "Gblame", "Gpush", "Gpull" },
    keys = {
      { "<leader>gg", "<cmd>Git<cr>", desc = "Git status (Fugitive)" },
      { "<leader>gl", "<cmd>Git log --oneline<cr>", desc = "Git log" },
    },
  },

  -- Lazygit integração (se tiver lazygit instalado)
  {
    "kdheepak/lazygit.nvim",
    cmd = "LazyGit",
    keys = { { "<leader>gg", "<cmd>LazyGit<cr>", desc = "LazyGit" } },
    dependencies = { "nvim-lua/plenary.nvim" },
  },
}
