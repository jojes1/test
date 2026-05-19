return {
  cmd = { "lua-language-server" },
  filetypes = { "lua" },
  root_markers = {
    ".git",
    ".luacheckrc",
    ".luarc.json",
    ".stylua.toml",
    "stylua.toml",
  },
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT'
      },
      diagnostics = {
        globals = {
          "vim",
          "require",
        },
      },
      workspace = {
        checkThirdParty = false,
        library = vim.api.nvim_get_runtime_file("", true),
      },
      telemetry = { enable = false },
    },
  },
}
