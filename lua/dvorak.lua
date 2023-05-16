------------------------------------------------------------------------------
--  dvorak.lua v. 20230510.1
--  Dvorak-friendly neovim remappings
--  Lives in ~/.config/nvim/lua
------------------------------------------------------------------------------
local apply_keymap  = require 'common'.apply_keymap

-- Build keymap tables for each mode, then loop-assign them
local all_modes = {}

local nox_modes = {

  {"t", "gk",},
  {"n",  "l",},
  {"d",  "h",},
  {"h", "gj",},   -- j,k default to screen lines not logical lines
  {"gh", "j",},   -- prefix a 'g' to change
  {"gt", "k",},

  -- ^n -> next search result, ^p -> prev
  {"<c-n>", "nzz",},
  {"<c-p>", "Nzz",},

  -- k -> d (mnemonic: k = 'kill')
  {"k", "d",},

  -- <space> accesses original binding
  {"<space>d", "d",},
  {"<space>h", "h",},
  {"<space>t", "t",},
  {"<space>n", "n",},
  {"<space>m", "m",},

  -- window navigation
  -- {"<leader>wd", "<c-w>h", desc = "move left one window",},
  {"<leader>wm", "<c-w>j", desc = "move down one window",},
  {"<leader>wt", "<c-w>k", desc = "move up one window",},
  {"<leader>wn", "<c-w>l", desc = "move right one window",},

  -- new convenience binding ('-' complements '_')
  {"-", "g_", {desc = "go to last char on line",},},
}

-- insert mode only
local i_mode = {
  -- indent/dedent uses meta key instead of ctrl
  {"<m-t>", "<c-t>", {desc = "indent one shiftwidth",},},
  {"<m-d>", "<c-d>", {desc = "dedent one shiftwidth",},},

  -- <c-d>, <c-v> deletes next (instead of prev) char/word
  {"<c-d>", "<c-o>dl", {desc = "delete next char",},},
  {"<c-v>", "<c-o>dw", {desc = "delete next word",},},
}


--- Loop assignment ----------------------------------------------------------
local mode_maps = {
  {{"", "!",},    all_modes},
  {{"",},         nox_modes},
  {{"i",},           i_mode},
  -- {{"c", "i", "n", "o", "x",}, all_modes},
  -- {{"n", "o", "x",},           nox_modes},
}

for _, mode_map in pairs (mode_maps) do
  local modes, maps = unpack (mode_map)
  if maps then
    for __, map in pairs (maps) do apply_keymap (modes, map) end
  end
end

