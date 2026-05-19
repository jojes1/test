return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    defaults = {
      mode = "n",
      prefix = "<leader>",
    },
    sort = { "manual" },
    preset = "helix",
    spec = {
      { "<leader>e", "<cmd>Neotree toggle<CR>", desc = "Toggle explorer", mode = "n" },
      { "<leader>h", "<C-W>s", desc = "Split Window Below", mode = "n" },
      { "<leader>v", "<C-W>v", desc = "Split Window Right", mode = "n" },
      { "<leader>y", "viwy", desc = "Copy word under cursor to system clipboard", mode = "n" },
      { "<leader>p", "viwpgvy", desc = "Paste from system clipboard to word under cursor", mode = "n" },
      { "<leader>p", "pgvy", desc = "Paste from system clipboard to selection", mode = "v" },
      { "<leader>f", "<cmd>w<cr><esc>", desc = "Save File", mode = "n" },
      { "<leader>q", "<cmd>qa<cr>", desc = "Quit All", mode = "n" },
      { "<leader>s", group = "Search", mode = { "n", "v" } },
      { "<leader>st", function()
        require("fzf-lua").live_grep({ fzf_opts = {['--layout'] = 'reverse-list' } })
      end, desc = "Search text", mode = "n" },
      { "<leader>sw", function()
        require("fzf-lua").grep_cword({ fzf_opts = {['--layout'] = 'reverse-list' } })
      end, desc = "Search word", mode = "n" },
      { "<leader>sc", function()
        require("fzf-lua").lgrep_curbuf({ fzf_opts = {['--layout'] = 'reverse-list' } })
      end, desc = "Search text in current buffer", mode = "n" },
      { "<leader>sb", function()
        require("fzf-lua").buffers({ fzf_opts = {['--layout'] = 'reverse-list' } })
      end, desc = "Search text in buffers", mode = "n" },
      { "<leader>sg", group = "Git", mode = { "n", "v" } },
      { "<leader>sgb", function()
        require("fzf-lua").git_branches({ fzf_opts = {['--layout'] = 'reverse-list' } })
      end, desc = "Search git branches", mode = "n" },
      { "<leader>w", group = "Window", mode = { "n" } },
      { "<leader>wm", function()
        require("maximize").toggle()
      end, desc = "Toggle maximizing the current window", mode = "n" },
      { "<leader>g", group = "Git", mode = { "n" } },
      { "<leader>gp", "<cmd>Gitsigns preview_hunk<cr>", desc = "Preview hunk", mode = "n" },
      { "<leader>gb", "<cmd>Gitsigns toggle_current_line_blame<cr>", desc = "Toggle current line blame", mode = "n" },
      { "<leader>gj", function()
        if vim.wo.diff then
          vim.cmd.normal({']c', bang = true})
        else
          require("gitsigns").nav_hunk('next')
        end
      end, desc = "Next hunk", mode = "n" },
      { "<leader>gk", function()
        if vim.wo.diff then
          vim.cmd.normal({'[c', bang = true})
        else
          require("gitsigns").nav_hunk('prev')
        end
      end, desc = "Prev hunk", mode = "n" },
      { "<leader>gn", "<cmd>Neogit<cr>", desc = "Show Neogit UI", mode = "n" },
      { "<leader>m", group = "Miscellaneous", mode = { "n" } },
      { "<leader>ml", "<cmd>Lazy<cr>", desc = "Lazy", mode = "n" },
      { "<leader>mm", "<cmd>Mason<cr>", desc = "Mason", mode = "n" },
      { "<leader>x", group = "Diagnostic", mode = { "n" } },
      { "<leader>xj", function()
        vim.diagnostic.jump({ count = 1 })
      end, desc = "Goto next diagnostic", mode = "n" },
      { "<leader>xk", function()
        vim.diagnostic.jump({ count = -1 })
      end, desc = "Goto previous diagnostic", mode = "n" },
      -- { "<leader>sd", group = "Diagnostic", mode = { "n" } },
      -- { "<leader>sg", group = "Git", mode = { "n" } },
      -- { "<leader>a", group = "Tabs" },
      -- { "<leader>am", group = "Move" },
      -- { "<leader>b", group = "Buffer" },
      -- { "<leader>c", group = "Snacks" },
      -- { "<leader>d", group = "Debug" },
      -- { "<leader>g", group = "Git", mode = { "n", "v" } },
      -- { "<leader>gg", group = "Git sign", mode = { "n", "v" } },
      -- { "<leader>w", group = "Window" },
      -- { "<leader>l", group = "LSP" },
      -- { "<leader>t", group = "Terminal" },
      -- { "<leader>u", group = "Toggle functions" },
      -- { "<leader>x", group = "Dagnostic" },
      -- { "<leader>xt", group = "Trouble" },
      -- { "<leader>j", group = "Notes" },
      -- { "<leader>js", group = "Search" },
      -- { "<leader>m", group = "Miscellaneous" },
      -- { "<leader> ", group = "Behave" },
    },
    -- local wk = require("which-key"),
    -- wk.add({
    --   { "<leader>e", "<cmd>Neotree toggle<CR>", { desc = "Toggle explorer", mode = "n" } },
    --   { "<leader>h", "<C-W>s", { desc = "Split Window Below", mode = "n" } },
    --   { "<leader>v", "<C-W>v", { desc = "Split Window Right", mode = "n" } },
    --   { "<leader>f", "<cmd>w<cr><esc>", { desc = "Save File", mode = "n" } },
    --   { "<leader>q", "<cmd>qa<cr>", { desc = "Quit All", mode = "n" } },
    --   { "<leader>s", group = "Search" }, -- group
    --   -- { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find File", mode = "n" },
    --   -- { "<leader>fb", function() print("hello") end, desc = "Foobar" },
    --   -- { "<leader>fn", desc = "New File" },
    --   -- { "<leader>f1", hidden = true }, -- hide this keymap
    --   -- { "<leader>w", proxy = "<c-w>", group = "windows" }, -- proxy to window mappings
    --   -- { "<leader>b", group = "buffers", expand = function()
    --   --     return require("which-key.extras").expand.buf()
    --   --   end
    --   -- },
    -- }),
    win = {
      padding = { 2, 2, 2, 2 },
      border = "rounded",
    },
  },
}

