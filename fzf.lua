return {
  "ibhagwan/fzf-lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  -- opts == function(_,_)
  config = function()
    local config = require "fzf-lua.config"
    config.defaults.actions.files["ctrl-t"] = require("fzf-lua.actions").file_tabedit
    config.defaults.actions.files["ctrl-l"] = require("fzf-lua.actions").file_edit_or_qf
    config.defaults.actions.files["alt-q"] = require("fzf-lua.actions").file_sel_to_qf
    config.defaults.keymap.fzf["ctrl-q"] = "select-all+accept"
    config.defaults.keymap.builtin["<a-f>"] = "toggle-fullscreen"
    config.defaults.keymap.builtin["<c-p>"] = "toggle-preview"
    require("fzf-lua").setup({
      "ivy",
      winopts = {
        height = 0.4,
        -- preview = { hidden = true },
        fullscreen = true,
        -- border = "none",
        preview = {
          border = "none",
          vertical = "up:80%",
          layout = "vertical",
          scrollbar = false,
        }
      },
      fzf_opts = {
        ["--no-scrollbar"] = true,
      },
      files = {
        git_icons = false,
        file_icons = false,
      },
      grep = {
        git_icons = false,
        file_icons = false,
      }
    })
    vim.keymap.set('n', 'gr', require("fzf-lua").lsp_references, { desc = "Goto references" })
  end
}
