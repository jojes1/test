vim.keymap.set('i', 'jk', '<esc>', { desc = 'Exit insert mode' })
vim.keymap.set('i', 'jj', '<esc>', { desc = 'Exit insert mode' })

-- Move between windows with Ctrl+hjkl (like tmux)
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window", remap = true })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window", remap = true })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window", remap = true })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window", remap = true })

-- Resize windows with Ctrl+Shift+arrows
vim.keymap.set("n", "<C-S-Up>", "<cmd>resize +5<cr>", { desc = "Resize up", noremap = true, silent = true } )
vim.keymap.set("n", "<C-S-Down>", "<cmd>resize -5<cr>", { desc = "Resize down", noremap = true, silent = true })
vim.keymap.set("n", "<C-S-Left>", "<cmd>vertical resize -5<cr>", { desc = "Resize left", noremap = true, silent = true })
vim.keymap.set("n", "<C-S-Right>", "<cmd>vertical resize +5<cr>", { desc = "Resize right", noremap = true, silent = true })

-- Clear search highlighting
vim.keymap.set({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and Clear hlsearch" })

-- Smart search navigation (n always goes forward, N always backward)
vim.keymap.set("n", "n", "'Nn'[v:searchforward].'zv'", { expr = true, desc = "Next Search Result" })
vim.keymap.set("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
vim.keymap.set("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
vim.keymap.set("n", "N", "'nN'[v:searchforward].'zv'", { expr = true, desc = "Prev Search Result" })
vim.keymap.set("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })
vim.keymap.set("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })

-- Better indenting (stay in visual mode)
vim.keymap.set("v", "<S-Tab>", "<gv")
vim.keymap.set("v", "<Tab>", ">gv")

-- Save file (works in all modes)
vim.keymap.set({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save File" })

-- function PersistentSignatureHelp()
--     vim.api.nvim_exec2([[
--         augroup SigHelp
--             autocmd!
--             autocmd CursorMovedI <buffer> lua vim.lsp.buf.signature_help()
--         augroup end
--         autocmd InsertLeave <buffer> ++once augroup! SigHelp
--     ]], {})
--     vim.lsp.buf.signature_help()
-- end
-- vim.keymap.set('i', '<C-g>', '<cmd>lua PersistentSignatureHelp()<CR>', {})

vim.keymap.set("i", "<M-g>", "<esc>lli")
vim.keymap.set('i', '<C-g>', '(<bs>', {}) -- to get signature help after that the parantheces have been inserted after autocompletion

vim.keymap.set("n", "<C-p>", function()
  require("fzf-lua").files({ fzf_opts = {['--layout'] = 'reverse-list' } })
end, { desc = "Find files" })

vim.keymap.set('n', 'gl', vim.diagnostic.open_float, { desc = "Show diagnostic" })
vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', { desc = "Goto definition" })

-- Dependency to plugins
