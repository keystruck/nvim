------------------------------------------------------------------------------
--  maps.lua v. 20230418.1
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
local all_modes = {
  {"<m-e>", "<esc>", {desc = "synonym for escape",},},
}


--  "motion" modes
local nox_modes = {
  -- eliminate timeout lag
  {";;",       ";", },
  {";<space>", ";", },
  {"<space>;", ";", },
  {",,",       ",", },
  {",<space>", ",", },
  {"<space>,", ",", },

  -- eliminate movement when <space> used as command prefix or terminator
  {"<space>", "<nop>",  },

  -- recenter screen on ^u or ^d
  {"<c-b>", "<c-b>zz",  },
  {"<c-d>", "<c-d>zz",  },
  {"<c-f>", "<c-f>zz",  },
  {"<c-u>", "<c-u>zz",  },

  -- toggle numbering; <leader>r (relative), <leader>R (absolute)
  {"<leader>r",   -- relative numbering
    function()
      vim.wo.relativenumber = not vim.wo.relativenumber
    end,
  },

  {"<leader>R",   -- absolute numbering
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

  -- same effect as built-in <c-6> [<c-^>]
  {"<leader>b",
    function() cmd.buffer('#') end,
    {desc = "alt buffer"},
  },

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

  {"<leader>p", cmd.bprevious, {desc = "prev buffer"}, },

  {"<leader>l", cmd.ls, {desc = "list buffers"}, },

  {"<leader>so",
    function()
      cmd.source("%")
      print (fn.printf ("'%s' sourced", fn.expand ("%:t")))
    end,
    {desc = "source active file",},
  },

  -- use <leader> with tmux prefixes to create new splits
  {'<leader>=', cmd.split,  {desc = "new horizontal split"},},
  {'<leader>"', cmd.vsplit, {desc = "new vertical split"},  },

  -- <meta> key assignments
  {"<m-t>", ":move .-2<cr>==", {desc = "move line up"},  },
  {"<m-h>", ":move .+1<cr>==", {desc = "move line down"},},
}


local i_mode = {
  -- {"<m-t>", "<esc>:move '.-2<cr>==gi",
  --   {desc = "move selected line/block up"},
  -- },
  -- {"<m-h>", ":<esc>move '.+1<cr>==gi",
  --   {desc = "move selected line/block down"},
  -- },
}


local v_mode = {
  {"<", "<gv",},                    -- stay selected after indent/dedent
  {">", ">gv",},
  {"<m-k>", ":move '<-2<cr>gv=gv", {desc = "move selected line/block up"},  },
  {"<m-j>", ":move '>+1<cr>gv=gv", {desc = "move selected line/block down"},},
}


local x_mode = {
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
