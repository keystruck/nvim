------------------------------------------------------------------------------
--   ___   __    
--  ( _ ) / /   Dave Getzinger <codecrank86@skullandquills.com> 
--  / _ \/ _ \  
--  \___/\___/  
--  
--  init.lua    Rev. 20230418.1
--  neovim master config file
--  Lives in ~/.config/nvim
--
------------------------------------------------------------------------------

-- disable netrw (recommended for nvim-tree)
vim.g.loaded_netrw        = 1
vim.g.loaded_netrwPlugin  = 1

--- Build a filepath from the config home directory
local path2 = require 'common'.path2

require (path2 'pack')      -- packer.nvim configuration
require (path2 'settings')  -- general options and settings
require (path2 'maps')      -- general remappings
require (path2 'dvorak')    -- Dvorak keyboard layout remappings

--  Plugin-specific config files live in .config/nvim/after/plugin
