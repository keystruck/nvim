------------------------------------------------------------------------------
--  maps.lua v.20230626.1
--  General neovim remappings
--  Lives in ~/.config/nvim/lua
------------------------------------------------------------------------------
vim.g.mapleader   = ','
vim.g.localleader = '\\'


--- Save typing --------------------------------------------------------------
local cmd   = vim.cmd
local fn    = vim.fn
local apply_keymap  = require 'common'.apply_keymap
--local ts    = require 'telescope.builtin'


--- Keymaps ------------------------------------------------------------------
--  Build tables of key assignments, then loop-apply them
local all_modes = { }

--  "motion" modes (normal, visual, select, operator pending)
local nox_modes = {

    -- eliminate movement when <space> used as command prefix or terminator
    {"<space>", "<nop>",  },

    -- eliminate timeout lag
    {";;",       ";", },
    {";<space>", ";", },
    {"<space>;", ";", },
    {",,",       ",", },
    {",<space>", ",", },
    {"<space>,", ",", },

    -- recenter screen on ^u or ^d
    {"<c-b>", "<c-b>zz",  },
    {"<c-d>", "<c-d>zz",  },
    {"<c-f>", "<c-f>zz",  },
    {"<c-u>", "<c-u>zz",  },

    -- new convenience binding ('-' complements '_')
    {"-", "g_", {desc = "go to last char on line",},},

    -- toggle numbering
    {"<leader>r",         -- relative numbering
        function()
            vim.wo.relativenumber = not vim.wo.relativenumber
        end,
    },

    {"<leader>R",         -- absolute numbering
        function()
            vim.wo.number = not vim.wo.number
        end,
    },

    {"<leader><space>r",  -- absolute numbering (alt)
        function()
            vim.wo.number = not vim.wo.number
        end,
    },
}

local ox_modes = {
  -- 'r' is already a defined text object in nvim-surround
  -- {"ir", "i[", {desc = "inside rectangular bracket text object"},},
  -- {"ar", "a[", {desc = "around rectangular bracket text object"},},
}

-- normal but not visual/select modes
local n_mode = {

    -- telescope commands
    --{";ff", ts.find_files},
    --{";fg", ts.live_grep },
    --{";fb", ts.buffers   },

    -- nvim-tree commands
    {";tt", function() cmd {cmd = 'NvimTreeToggle'} end,},
    -- {";tf", function() cmd {cmd = 'NvimTreeFocus'} end,}, -- toggle focus

    -- recenter screen when jumping to prev/next seach result
    -- (n is remapped in dvorak.lua)
    {"n", "nzz",},    -- remapped in dvorak.lua
    {"N", "Nzz",},

    {"Q", "gqap", {desc = "reformat paragraph"},},

    --  ^l clears highlighting
    {"<c-l>",
        function()
            cmd.nohlsearch()
            cmd.redraw()
        end,
        {desc = "clear search highlighting and redraw screen"},
    },

    {"<c-s>", cmd.write, {desc = "save buffer"},       },

    -- open/close splits
    {'<c-w>-', cmd.split,  {desc = "new horizontal split"},},
    {'<c-w>/', cmd.vsplit, {desc = "new vertical split"},  },
    {'<c-w>x', cmd.close,  {desc = "close split"},         },

    -- delete current buffer if not modified
    {"<leader>d",
        function()
            if fn.getbufinfo("%").changed then
                print ("Buffer modified since last save")
            elseif fn.bufexists (fn.bufname ("#")) then
                cmd.buffer("#")
                cmd.bdelete('#')
            else
                cmd.bdelete("%")
            end
        end,
        {desc = "close current buffer, preserving window layout"},
    },

    -- delete current buffer, discarding modifications
    {"<leader>D",
        function()
            if fn.bufexists (fn.bufname ("#")) then
                cmd.buffer("#")
                cmd.bdelete {args = {"#",}, bang = true,}
            else
                cmd.bdelete {args = {"%",}, bang = true,}
            end
        end,
        {desc = "close current buffer, preserving window layout"},
    },

    {"<leader>l", cmd.ls, {desc = "list buffers"}, },

    {"<leader>so",
        function()
            cmd.source("%")
            print (fn.printf ("'%s' sourced", fn.expand ("%:t")))
        end,
        {desc = "source active file",},
    },

    -- paste from clipboard
    {"<m-p>",            '"+p', {desc = "paste below from clipboard"},  },
    {"<leader>p",        '"+p', {desc = "paste below from clipboard"},  },
    {"<leader>P",        '"+P', {desc = "paste above from clipboard"},  },
    {"<leader><space>p", '"+P', {desc = "paste above from clipboard"},  },

    -- move line up/down
    {"<m-k>", ":move .-2<cr>==", {desc = "move line up"},  },
    {"<m-j>", ":move .+1<cr>==", {desc = "move line down"},},
}

local i_mode = { }

local v_mode = {
    -- stay selected after region indent/dedent
    {"<", "<gv",},
    {">", ">gv",},

    -- move region up/down
    {"<m-k>", ":move '<-2<cr>gv=gv", {desc = "move region up"},  },
    {"<m-j>", ":move '>+1<cr>gv=gv", {desc = "move region down"},},

    -- yank to clipboard
    {"<m-y>",     '"+y', {desc = "yank to clipboard"},  },
    {"<leader>y", '"+y', {desc = "yank to clipboard"},  },
}

local x_mode = {
    -- operate inside, around line
    {"il", "g_o^",},
    {"al", "V",},
}


--- Loop assignment ----------------------------------------------------------
local mode_maps = {
    {{"", "!",},    all_modes},   -- "" = :map, "!" = :map!
    {{"",},         nox_modes},
    {{"o", "x",},    ox_modes},
    {{"i",},           i_mode},
    {{"n",},           n_mode},
    {{"v",},           v_mode},
    {{"x",},           x_mode},
}

for _, mode_map in pairs (mode_maps) do
    local modes, maps = unpack (mode_map)
    if maps then
        for __, map in pairs (maps) do apply_keymap (modes, map) end
    end
end


-- some useful mapping tips:
--   for a list of mapped keys:  :help index
--   to find out whether a key is mapped to something:  :help {k}{^D}

-- function pointers
-- for info on neovim lua autocmds:
--   https://neovim.io/doc/user/lua-guide.html#lua-guide-autocommands
-- for a list of vim autocmd events: :he autocmd-event
-- in particular, look for the ModeChanged event

-- https://vim.fandom.com/wiki/Moving_lines_up_or_down#:~:text=In%20normal%20mode%20or%20in,to%20move%20the%20block%20up.
--
