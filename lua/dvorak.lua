------------------------------------------------------------------------------
--  dvorak.lua v.20230626.1
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
    {"h", "gj",},   -- default to screen lines not logical lines
    {"gh", "j",},   -- prefix a 'g' to jump logical lines
    {"gt", "k",},

    -- n is remapped, so <c-n> becomes 'next search result' (N is not remapped)
    -- recenter screen when jumping to prev/next seach result
    {"<c-n>", "nzz",},
    {"N",     "Nzz",},

    -- k -> d (mnemonic: k = 'kill')
    {"k", "d",},

    -- <space> accesses original binding
    {"<space>d", "d",},
    {"<space>h", "h",},
    {"<space>t", "t",},
    {"<space>n", "n",},
    {"<space>m", "m",},

    -- split navigation
    {"<c-w>t", "<c-w>k", desc = "move to next split up",   },
    {"<c-w>h", "<c-w>j", desc = "move to next split down", },
    {"<c-w>d", "<c-w>h", desc = "move to next split left", },
    {"<c-w>n", "<c-w>l", desc = "move to next split right",},
}

local ci_modes = {

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

local n_mode = {
    -- move line up/down, reindenting
    {"<m-t>",     ":move .-2<cr>==", {desc = "move line up"},  },
    {"<leader>t", ":move .-2<cr>==", {desc = "move line up"},  },
    {"<m-h>",     ":move .+1<cr>==", {desc = "move line down"},},
    {"<leader>h", ":move .+1<cr>==", {desc = "move line down"},},
}

local v_mode = {
    -- move region up/down, reindenting
    {"<m-t>", ":move '<-2<cr>gv=gv", {desc = "move region up"},  },
    {"<m-h>", ":move '>+1<cr>gv=gv", {desc = "move region down"},},
}


--- Loop assignment ----------------------------------------------------------
local mode_maps = {
    {{"",},         nox_modes},
    {{"!",},         ci_modes},
    {{"i",},           i_mode},
    {{"n",},           n_mode},
    {{"v",},           v_mode},
    {{"", "!",},    all_modes},
}

for _, mode_map in pairs (mode_maps) do
    local modes, maps = unpack (mode_map)
    if maps then
        for _, map in pairs (maps) do apply_keymap (modes, map) end
    end
end

