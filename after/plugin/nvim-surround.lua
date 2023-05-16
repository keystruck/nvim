--  nvim-surround.lua - config file

local keymaps = {
  normal  = ";ss",  -- cf. 'ys'
  change  = ";cs",  -- cf. 'cs'
  delete  = ";ds",  -- cf. 'ds'
}

require ('nvim-surround').setup {keymaps = keymaps,}
