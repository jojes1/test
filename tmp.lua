return {
  "ibhagwan/fzf-lua",
  commit = "047f6862bb0c9710c06e5432d7ad50da9ea00e46",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  keys = {
    {
      "<leader>sw",
      function()
        require("fzf-lua").grep_cword()
      end,
      desc = "Word",
    },
    {
      "<leader>sW",
      function()
        require("fzf-lua").grep_cWORD()
      end,
      desc = "WORD",
    },
    {
      "<leader>sc",
      function()
        require("fzf-lua").lgrep_curbuf()
      end,
      desc = "Text current buffer",
    },
    {
      "<leader>sh",
      function()
        require("fzf-lua").helptags()
      end,
      desc = "Help",
    },
    -- {
    --   "<leader>so",
    --   function()
    --     require("fzf-lua").nvim_options()
    --   end,
    --   desc = "Options",
    -- },
    {
      "<leader>sb",
      function()
        require("fzf-lua").buffers()
      end,
      desc = "Buffers",
    },
    {
      "<leader>sgf",
      function()
        require("fzf-lua").git_files()
      end,
      desc = "Git files",
    },
    {
      "<leader>sgs",
      function()
        require("fzf-lua").git_status()
      end,
      desc = "Git status",
    },
    {
      "<leader>sgb",
      function()
        require("fzf-lua").git_branches()
      end,
      desc = "Git branches",
    },
    {
      "<leader>sdd",
      function()
        require("fzf-lua").diagnostics_document()
      end,
      desc = "Current buffer",
    },
    {
      "<leader>sdw",
      function()
        require("fzf-lua").diagnostics_workspace()
      end,
      desc = "Workspace",
    },
    { "<c-j>", "<c-j>", ft = "fzf", mode = "t", nowait = true },
    { "<c-k>", "<c-k>", ft = "fzf", mode = "t", nowait = true },
    { "<c-l>", "<c-l>", ft = "fzf", mode = "t", nowait = true },
    { "f", "f", ft = "fzf", mode = "t", nowait = true },
    -- { "//", LazyVim.pick("grep_visual"), mode = "v", desc = "Selection (Root Dir)" },
    -- { "??", LazyVim.pick("grep_cword", { root = false }), desc = "Word (Root Dir)" },
    -- { "??", LazyVim.pick("grep_visual", { root = false }), mode = "v", desc = "Selection (Root Dir)" },
  },
  opts = function(_, _) -- opts)
    local config = require "fzf-lua.config"
    -- Refer: https://github.com/ibhagwan/fzf-lua/blob/main/lua/fzf-lua/defaults.lua
    local file_win_opts = {
      fullscreen = true,
      preview = {
        layout = "vertical",
        vertical = "up:70%",
      },
    }
    config.defaults.actions.files["ctrl-t"] = require("fzf-lua.actions").file_tabedit
    config.defaults.actions.files["ctrl-l"] = require("fzf-lua.actions").file_edit_or_qf
    config.defaults.actions.files["alt-q"] = require("fzf-lua.actions").file_sel_to_qf
    config.defaults.keymap.fzf["ctrl-q"] = "select-all+accept"
    config.defaults.keymap.builtin["<a-f>"] = "toggle-fullscreen"
    -- config.defaults.keymap.builtin["<c-w>"] = "toggle-preview-wrap"
    config.defaults.keymap.builtin["<c-p>"] = "toggle-preview"
    return {
      defaults = {
        formatter = "path.filename_first",
        header = false,
        git_icons = false,
        file_icons = false,
        color_icons = false,
        prompt = " > ",
      },
      fzf_opts = {
        ["--cycle"] = true,
        ["--prompt"] = " > ",
        ["--no-scrollbar"] = true,
      },

      helptags = { winopts = file_win_opts },
      files = {
        rg_opts = [[--files -g "!*.toml" -g "!venv/" -g "!__pycache__/"]],
        -- winopts = file_win_opts,
        prompt = " > ",
        cwd_prompt_shorten_len = 200,
      },
      grep = {
        rg_opts = [[-g "!venv/" -g "!__pycache__/"]]
      }
      -- grep = { winopts = file_win_opts },
      -- oldfiles = { winopts = file_win_opts },
      -- git = {
      --   files = {
      --     winopts = file_win_opts,
      --   },
      -- },
    }
  end,
}

