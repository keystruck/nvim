------------------------------------------------------------------------------
--  lsp.lua v. 20230510.2
--  Setup file for neovim lsp-related packages
--  Lives in ~/.config/nvim/after/plugin/
------------------------------------------------------------------------------
-- turn on error messages
-- https://stackoverflow.com/questions/74166479/neovims-lsp-does-not-show-error-messages
vim.diagnostic.config {virtual_text = true,}

-- nvim-lspconfig
local lspconfig = require 'lspconfig'

-- mason
require 'mason'.setup ()
pcall (vim.cmd, "MasonUpdate")

-- mason-lspconfig
require 'mason-lspconfig'.setup {
  ensure_installed = {
    -- list of required LSP servers
  }
}

-- cmp-nvim-lsp
local lsp_capabilities = require 'cmp_nvim_lsp'.default_capabilities ()
local lsp_attach = function (client, bufnr)
  -- add keybindings here
end

-- nvim-cmp
require 'cmp'.setup {
  sources = {
    {name = 'nvim_lsp',}
  }
}

require 'mason-lspconfig'.setup_handlers {
  function (server_name)
    lspconfig [server_name].setup {
      on_attach = lsp_attach,
      capabilities = lsp_capabilities,    -- from cmp-nvim-lsp
    }
  end,
}

