return {
  "nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()

		local function maximize_status()
			return vim.t.maximized and '   ' or ''
		end

    require("lualine").setup {
      options = {
        globalstatus = true,
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        ignore_focus = { "neo-tree" },
        -- theme = custom_wombat,
        theme = 'gruvbox-material',
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch" },
        -- lualine_c = { "diagnostics" },
        lualine_c = { maximize_status, { "filename", path = 2 }, "diagnostics" },
        lualine_x = { "filetype" },
        lualine_y = { "progress" },
        lualine_z = {},
      },
      extensions = { "quickfix", "man", "fugitive" },
      -- vim.api.nvim_set_hl(0, "lualine_c_normal", { fg = "#2e2c2f", bg = "#729b79" })
      -- windows_color = {
      --   active = 'lualine_{section}_inactive',
      --   inactive = 'lualine_{section}_inactive',
      -- },
    }
  end,
}

