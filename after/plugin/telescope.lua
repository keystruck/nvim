--[[
--  telescope.lua - config file
--]]
local ts  = require ('telescope.builtin')
local set = vim.keymap.set

set ('n', ';ff', ts.find_files, {desc = "fuzzy-find files with telescope",})
set ('n', ';fg', ts.live_grep,  {desc = "live grep files with telescope", })
set ('n', ';fb', ts.buffers,    {desc = "find buffers with telescope",    })
