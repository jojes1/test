return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require("lualine").setup {
        options = {
          globalstatus = true,
          component_separators = { left = "", right = "" },
          section_separators = { left = "", right = "" },
          ignore_focus = { "neo-tree" },
          -- theme = custom_wombat,
          theme = 'nordic',
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch" },
          -- lualine_c = { "diagnostics" },
          lualine_c = { { "filename", path = 2 }, "diagnostics" },
          lualine_x = { "filetype" },
          lualine_y = { "progress" },
          lualine_z = {},
        },
        extensions = { "quickfix", "man", "fugitive" },
      }
    end
}
