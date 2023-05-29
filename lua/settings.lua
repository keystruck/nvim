------------------------------------------------------------------------------
--  settings.lua v. 20230528.1
--  General neovim options and settings
--  Lives in ~/.config/nvim/lua
------------------------------------------------------------------------------

-- define colorscheme in after/plugin/nightfox.lua

-- global options (loop-assigned below)
local options = {

  -- theme
  syntax          = 'on',
  termguicolors   = true,

  -- encoding
  encoding        = 'utf8',
  fileencoding    = 'utf8',

  -- numbering
  number          = true,
  relativenumber  = true,
  numberwidth     = 3,

  -- whitespace
  expandtab	      = true,
  shiftwidth	    = 4,
  softtabstop	    = 4,
  tabstop	        = 4,

  -- key lag
  timeoutlen      = 500,
  ttimeoutlen     = 20,

  -- search
  ignorecase      = true,
  smartcase       = true,
  incsearch       = true,
  hlsearch        = true,

  -- mere intuitive placement of new windows
  splitbelow      = true,
  splitright      = true,

  -- minimum context
  scrolloff       = 5,
  sidescrolloff   = 5,

  -- editor width
  colorcolumn     = '78',
  signcolumn      = 'yes',

}

--- Loop assignment ----------------------------------------------------------
for key, val in pairs (options) do vim.opt[key] = val end


-- ftplugin scripts, which are sourced after user scripts, may overwrite
-- formatoptions, so persistent changes are best made via autocmds
-- https://vi.stackexchange.com/questions/1983/how-can-i-get-vim-to-stop-putting-comments-in-front-of-new-lines
vim.api.nvim_create_autocmd ("FileType", {
  pattern = "*",
  callback = function () vim.opt.formatoptions:remove ("o") end,
  desc = "do not prepend comment char to new lines opened with O or o",
})


--- Notes --------------------------------------------------------------------
-- Excellent model file:
--    https://dev.to/voyeg3r/my-ever-growing-neovim-init-lua-h0pB
