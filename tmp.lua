vim.lsp.enable({
  "lua_ls",
  "clangd",
  "vim-language-server",
})

vim.diagnostic.config({
  -- virtual_lines = true,
    virtual_text = false,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
    float = {
      border = "rounded",
      source = true,
    },
    signs = {
      text = {
        [vim.diagnostic.severity.ERROR] = "󰅚 ",
        [vim.diagnostic.severity.WARN] = "󰀪 ",
        [vim.diagnostic.severity.INFO] = "󰋽 ",
        [vim.diagnostic.severity.HINT] = "󰌶 ",
      },
      numhl = {
        [vim.diagnostic.severity.ERROR] = "ErrorMsg",
        [vim.diagnostic.severity.WARN] = "WarningMsg",
      },
    },
    jump = {
      -- When jumping, automatically open the floating window
      on_jump = function(_, _)
        vim.diagnostic.open_float({
          -- Focus = false keeps cursor in the code, true jumps into the float
          focus = false,
          -- "cursor" shows only error at cursor, "line" shows all on line
          scope = "cursor",
          -- Optional: close float when moving cursor or switching buffers
          close_events = {"BufLeave", "CursorMoved", "InsertEnter", "FocusLost"},
        })
      end,
    },

    -- vim.api.nvim_create_autocmd('LspAttach', {
    --   group = vim.api.nvim_create_augroup('my.lsp', {}),
    --   callback = function(ev)
    --     local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))
    --
    --     if client:supports_method('textDocument/completion') then
    --       vim.lsp.completion.enable(true, client.id, ev.buf, {autotrigger = true})
    --     end
    --   end,
    -- })

})

