return {
  "nvim-treesitter/nvim-treesitter",
  commit = "fd59f984416f696d85119fd4d15ce0965b179944",
  event = { "BufReadPost", "BufNewFile" },
  lazy = false,
  build = ":TSUpdate",

  config = function()
    require("nvim-treesitter.configs").setup {
      ensure_installed = { "lua", "vim", "vimdoc", "markdown", "markdown_inline", "bash", "python", "c", "cpp" },
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      -- indent = { enable = false, disable = { "python" } },
      indent = { enable = true },
    }
  end,
}
