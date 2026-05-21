local M = {}

function M.augroup(name)
  return vim.api.nvim_create_augroup("user_" .. name, { clear = true })
end

function M.split_filename(strFilename)
  -- Returns the Path, Filename, and Extension as 3 values
  return string.match(strFilename, "^(.-)([^\\/]-)%.([^\\/%.]-)%.?$")
end

function M.open_corresponding_file(how_to_open)
  -- local root_patterns = { ".git", ".clang-format", "pyproject.toml", "setup.py" }
  -- local root_dir = vim.fs.dirname(vim.fs.find(root_patterns, { upward = true })[1])
  local name = vim.api.nvim_buf_get_name(0)
  name = name.gsub(name, "\\", "/")
  local _,file,ext = M.split_filename(name)

  -- local file_name = ""
  -- for part in name:gmatch("([^/]+)") do
  --     file_name = part
  -- end

  local new_ext = "h"
  if ext == "c" then new_ext = "h"
  elseif ext == "cpp" then new_ext = "hpp"
  elseif ext == "h" then new_ext = "c"
  elseif ext == "hpp" then new_ext = "cpp" end

  local new_file = file .. "." .. new_ext

  local pattern = {new_file}
  local found = vim.fs.find(pattern, { upward = false })[1]


  if how_to_open == "vs" then
    vim.cmd('vsplit')
  elseif how_to_open == "hs" then
    vim.cmd('split')
  elseif how_to_open == "h" then
    vim.cmd("wincmd h")
  elseif how_to_open == "l" then
    vim.cmd("wincmd l")
  elseif how_to_open == "j" then
    vim.cmd("wincmd j")
  elseif how_to_open == "k" then
    vim.cmd("wincmd k")
  end
  vim.cmd('e ' .. found)
end

return M
