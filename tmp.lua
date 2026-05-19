
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight on yank",
  group = require("config.helpers").augroup("highlight_yank"),
  callback = function()
    (vim.hl or vim.highlight).on_yank()
  end,
})

vim.api.nvim_create_autocmd({ "VimResized" }, {
  desc = "Resize splits if window got resized",
  group = require("config.helpers").augroup("resize_splits"),
  callback = function()
    local current_tab = vim.fn.tabpagenr()
    vim.cmd("tabdo wincmd =")
    vim.cmd("tabnext " .. current_tab)
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  desc = "Close some filetypes with <q>",
  group = require("config.helpers").augroup("close_with_q"),
  pattern = {
    "PlenaryTestPopup",
    "checkhealth",
    "dbout",
    "gitsigns-blame",
    "grug-far",
    "help",
    "lspinfo",
    "neotest-output",
    "neotest-output-panel",
    "neotest-summary",
    "notify",
    "qf",
    "spectre_panel",
    "startuptime",
    "tsplayground",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.schedule(function()
      vim.keymap.set("n", "q", function()
        vim.cmd("close")
        pcall(vim.api.nvim_buf_delete, event.buf, { force = true })
      end, {
        buffer = event.buf,
        silent = true,
        desc = "Quit buffer",
      })
    end)
  end,
})

-- Prevent repeating comments when creating new line
vim.cmd('autocmd BufEnter * set formatoptions-=cro')
vim.cmd('autocmd BufEnter * setlocal formatoptions-=cro')

vim.api.nvim_create_autocmd('CursorMoved', {
  group = vim.api.nvim_create_augroup("LspReferenceHighlight", { clear = true }),
  desc = "Highlight references under cursor",
  callback = function ()
    if vim.fn.mode() ~= "i" then
      local clients = vim.lsp.get_clients({ bufnr = 0 })
      local supports_highlight = false
      for _, client in ipairs(clients) do
        if client.server_capabilities.documentHighlightProvider then
          supports_highlight = true
          break
        end
      end
      if supports_highlight then
        vim.lsp.buf.clear_references()
        vim.lsp.buf.document_highlight()
      end
    end
  end
})

vim.api.nvim_create_autocmd("CursorMovedI", {
  group = "LspReferenceHighlight",
  desc = "Clear highlight when entering insert mode",
  callback = function ()
    vim.lsp.buf.clear_references()
  end
})

