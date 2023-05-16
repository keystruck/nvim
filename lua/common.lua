------------------------------------------------------------------------------
--   ___   __    
--  ( _ ) / /   Dave Getzinger <codecrank86@skullandquills.com> 
--  / _ \/ _ \  
--  \___/\___/  
--  
--  common.lua    Rev. 20230420.1
--  Functions used in more than one neovim config file
--  Lives in ~/.config/nvim/lua
--
------------------------------------------------------------------------------

local M = {}

-- M.config_home = nil   -- nvim config home directory, under 'lua'


--- Combines a list of strings into a lua module path, skipping nils.
function M.path2 (...)
  local nodes = {}    -- a table of non-nil, non-zero-length path nodes
  local sep   = "."   -- module separator

  -- table.concat chokes on nil values, so filter them out
  for i = 1, select ("#", ...) do
    local piece = select (i, ...)
    if type (piece) == "string" and #piece >= 1 then
      nodes[#nodes + 1] = piece
    end
  end
  return #nodes >= 1 and table.concat(nodes, sep) or nil
end


--- Combines a list of strings into a lua module path, starting from home dir
-- function M.path2 (...)
--   return M.path (M.config_home, ...)
-- end


--- Take a mode and a keymap and applies the latter to the former.
function M.apply_keymap(mode, keymap)
  local lhs, rhs, opts = unpack(keymap)
  local options = {noremap = true, silent = true}
  if opts then
    -- merge options tables, overwriting conflicting defaults
    options = vim.tbl_extend("force", options, opts)
  end
  vim.keymap.set(mode, lhs, rhs, options)
end


return M
