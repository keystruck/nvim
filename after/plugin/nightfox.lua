------------------------------------------------------------------------------
--  nightfox.lua v. 20230510.1
--  Nightfox/carbonfox colorscheme
--  Lives in ~/.config/nvim/after/plugin/
--  https://github.com/EdenEast/nightfox.nvim
------------------------------------------------------------------------------

local options = {
  styles = {
    -- :help attr-list for list of valid syntax groups
    comments = 'italic',
  },
}

local palettes = {
  carbonfox = {

    bg0 = '#000000',
    bg1 = '#000000',    -- normal dark
    bg2 = '#000204',
    -- bg3 = '#000000',
    -- bg4 = '#000000',

    fg1 = '#c4c6cc',
    fg2 = '#d8dae4',
    fg3 = '#ffffff',

    sel0 = "#660000",   -- popup bg, visual selection bg
    sel1 = "#004488",   -- popup select, search bg

    comment = '#777777',
  },
}

-- inverse highlights
local inverse = {
  inverse = {
    visual = true,
    search = true,
  }
}

require ('nightfox').setup {
  options   = options,
  palettes  = palettes,
  inverse   = inverse,
}

-- setup must be called before loading
vim.cmd ("colorscheme carbonfox")
