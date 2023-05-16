--[[
--  neotree.lua
--]]
local cmd = vim.cmd
local set = vim.keymap.set

set ('n', ';nt', cmd['Neotree'], {desc = "toggle Neotree",})

