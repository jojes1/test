vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })
vim.keymap.set("n", "H", "^")
vim.keymap.set("n", "L", "$")

vim.keymap.set("n", "<leader>v", "<C-W>v", { desc = "Make verical split" })
vim.keymap.set("n", "<leader>h", "<C-W>s", { desc = "Make horizontal split" })

vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-l>", "<C-w>l")

vim.keymap.set("t", "<C-h>", "<C-\\><C-n><C-W>h", { desc = "Jump to the left window when in terminal mode", noremap = true, silent = true })
vim.keymap.set("t", "<C-j>", "<C-\\><C-n><C-W>j", { desc = "Jump to the window below when in terminal mode", noremap = true, silent = true })
vim.keymap.set("t", "<C-k>", "<C-\\><C-n><C-W>k", { desc = "Jump to the window above when in terminal mode", noremap = true, silent = true })
vim.keymap.set("t", "<C-l>", "<C-\\><C-n><C-W>l", { desc = "Jump to the right window when in terminal mode", noremap = true, silent = true })
vim.keymap.set("t", "ff", "<C-\\><C-n>", { desc = "Escape from terminal mode", noremap = true, silent = true })

vim.keymap.set("v", "<Tab>", ">gv")
vim.keymap.set("v", "<S-Tab>", "<gv")

-- vim.cmd "vnoremap <silent> y y`]"
-- vim.cmd "vnoremap <silent> p p`]"
-- vim.cmd "nnoremap <silent> p p`]"

vim.keymap.set("n", "<Esc>", ":noh<CR>", { silent = true })
-- vim.keymap.set("v", "p", '"_dP')
vim.keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode" })

vim.keymap.set("n", "<leader>e", "<cmd>Neotree toggle<CR>", { desc = "Toggle explorer" })

vim.keymap.set(
  "n",
  "<Up>",
  "[c",
  { noremap = true, silent = true, desc = "Jump backwards to the previous start of a change" }
)

vim.keymap.set(
  "n",
  "<Down>",
  "]c",
  { noremap = true, silent = true, desc = "Jump forwards to the next start of a change" }
)

vim.keymap.set(
  "n",
  "<Right>",
  "zR",
  { noremap = true, silent = true, desc = "Open all folds.  This sets 'foldlevel' to highest fold level" }
)

vim.keymap.set(
  "n",
  "<Left>",
  ":edit<cr>zM",
  { noremap = true, silent = true, desc = "Close all folds: set 'foldlevel' to 0" }
)

local list_on = false
vim.keymap.set("n", "<leader>ml", function()
  if not list_on then
    vim.cmd "set list"
    list_on = true
  else
    vim.cmd "set nolist"
    list_on = false
  end
end, { desc = "Toggle list" })

-- vim.keymap.set("n", "<C-n>", function()
--   require("fzf-lua").fzf_exec({ "Command", "Task" }, {
--     prompt = "Function > ",
--     actions = {
--       ["ctrl-l"] = function(selected, opts)
--         if selected[1] == "Command" then
--           print("Command selection")
--           -- command_selection()
--         elseif selected[1] == "Task" then
--           require("jesper.core.api.task-selection").task_selection()
--         end
--       end,
--     },
--   })
-- end, { desc = "Select Function" })

vim.keymap.set("n", "<C-p>", function()
  -- local curwd = vim.fn.getcwd()
  -- if curwd == "C:\\Users\\jeppe\\AppData\\Local\\nvim" then
    -- require("fzf-lua").files { rg_opts = "--files -g '!*.toml' -g '!*.json' -g '!*.git/' -g '!*.gitignore'" }
  -- elseif curwd == "/home/jesper/pnx/linux-applications/dpa-mx-printer-app" then
  --   require("fzf-lua").files { rg_opts = "--files -g '*.cpp' -g '*.hpp' -g '*.py'" }
  -- elseif curwd == "/home/jesper/pnx/tools/dpa-mx-phoenix-test" then
  --   require("fzf-lua").files { rg_opts = "--files -g '*.py' -g '*.feature'" }
  -- else
    require("fzf-lua").files()
  -- end
end, { desc = "Find files" })

vim.keymap.set("n", "<leader>st", function()
  -- local curwd = vim.fn.getcwd()
  -- if curwd == "C:\\Users\\jeppe\\AppData\\Local\\nvim" then
  --   require("fzf-lua").live_grep { rg_opts = "--column -n -g '!*.toml' -g '!*.json' -g '!*.git/' -g '!*.gitignore'" }
  -- elseif curwd == "/home/jesper/pnx/linux-applications/dpa-mx-printer-app" then
  --   require("fzf-lua").live_grep { rg_opts = "--column -n -g '*.cpp' -g '*.hpp' -g '*.py'" }
  -- elseif curwd == "/home/jesper/pnx/tools/dpa-mx-phoenix-test" then
  --   require("fzf-lua").live_grep { rg_opts = "--column -n -g '*.py' -g '*.feature'" }
  -- else
    require("fzf-lua").live_grep()
  -- end
end, { desc = "Find text" })
