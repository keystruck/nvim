------------------------------------------------------------------------------
--  pack.lua v. 20230525.1
--  packer.nvim config file
--  Lives in ~/.config/nvim/lua
--  https://github.com/wbthomason/packer.nvim
------------------------------------------------------------------------------
return require 'packer'.startup (
  function (use)

    -- requires nvim >= 0.9 --------------------------------------------------
    use {'nvim-treesitter/nvim-treesitter',
          run = pcall (vim.cmd, "TSUpdate"),
        }

    -- requires nvim >= 0.8 --------------------------------------------------
    use 'EdenEast/nightfox.nvim'
    use 'kylechui/nvim-surround'
    use {'nvim-tree/nvim-tree.lua',
          requires  = 'nvim-tree/nvim-web-devicons',
        }
    use 'neovim/nvim-lspconfig'

    -- requires nvim >= 0.7 --------------------------------------------------
    use 'terrortylor/nvim-comment'
    use 'ggandor/leap.nvim'
    use {'nvim-telescope/telescope.nvim',
          branch = '0.1.x',
          requires = 'nvim-lua/plenary.nvim',
        }
    use 'nvim-tree/nvim-web-devicons'
    use {'williamboman/mason.nvim',
          run = pcall (vim.cmd, "MasonUpdate"),
        }
    use 'williamboman/mason-lspconfig.nvim'
    use 'simrat39/rust-tools.nvim'

    -- requires nvim >= 0.5 --------------------------------------------------
    use 'wbthomason/packer.nvim'
    use 'folke/zen-mode.nvim'
    use {'nvim-lualine/lualine.nvim',
          requires = {'nvim-tree/nvim-web-devicons', opt = true,}
        }

    -- min nvim version not given
    use 'windwp/nvim-autopairs'
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-nvim-lsp'
    use {'nvim-treesitter/nvim-treesitter-textobjects',
          after     = 'nvim-treesitter',
          requires  = 'nvim-treesitter/nvim-treesitter',
        }

    -- Other plugins:
    --   startup.nvim (start screen)
    --   neoscroll (smooth scrolling)
    -- https://github.com/max397574/better-escape.nvim
    -- https://github.com/folke/which-key.nvim

  end
)
