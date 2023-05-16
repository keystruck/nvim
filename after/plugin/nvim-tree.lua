--  nvim-tree.lua config file

-- disable netrw in init.lua to avoid race conditions
require ('nvim-tree').setup {}
local cmd = vim.cmd
local set = vim.keymap.set

set ('n', ';nt', cmd['NvimTreeToggle'], {desc = "toggle Neotree",})

