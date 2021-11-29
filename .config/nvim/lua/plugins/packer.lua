local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  use {
    'RRethy/nvim-base16',
    config = function()
      vim.cmd('colorscheme base16-chalk')
    end
  }

  use 'sheerun/vim-polyglot'

  use {
    'nvim-lualine/lualine.nvim',
    requires = {'kyazdani42/nvim-web-devicons', opt = true},
    config = function()
      require('lualine').setup({
        options = {
          component_separators = { " ", " " },
          section_separators = { " ", " " }
        },
        sections = {
          lualine_a = {'mode', 'paste'},
        }
      })
    end
  }

  use 'tversteeg/registers.nvim'
  use 'direnv/direnv.vim'
  use 'editorconfig/editorconfig-vim'

  use 'junegunn/vim-easy-align'

  use {
    'windwp/nvim-autopairs',
    config = function()
      require('nvim-autopairs').setup({
          check_ts = true,
        })
    end
  }

  use 'tpope/vim-surround'
  use 'tpope/vim-endwise'
  use 'tpope/vim-sleuth'

  use {
    'mbbill/undotree',
    cmd = { 'UndotreeShow', 'UndotreeToggle', 'UndotreeHide', 'UndotreeFocus' }
  }


  use { 'ibhagwan/fzf-lua',
    requires = {
      'vijaymarupudi/nvim-fzf',
      'kyazdani42/nvim-web-devicons' }
  }

  use {
    'nvim-telescope/telescope.nvim',
    requires = {
      'nvim-lua/plenary.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
    }
  }

  use 'neovim/nvim-lspconfig'

  use {
    'L3MON4D3/LuaSnip',
    requires = {
        'rafamadriz/friendly-snippets'
    }
  }

  use {
    'hrsh7th/nvim-cmp',
    requires = {
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-nvim-lua',
      'hrsh7th/cmp-cmdline',
      'ray-x/cmp-treesitter',
      'lukas-reineke/cmp-rg',
      'saadparwaiz1/cmp_luasnip',
      'onsails/lspkind-nvim',
    }
  }

  use {
    'nvim-treesitter/nvim-treesitter'
  }
  use 'nvim-treesitter/nvim-treesitter-textobjects'

  use {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end
  }

  use {
    'lukas-reineke/indent-blankline.nvim',
    config = function()
      require('indent_blankline').setup {
        buftype_exclude = {"terminal"},
        space_char_blankline = " ",
        show_current_context = true,
        show_current_context_start = true,
        use_treesitter = true,
      }
    end
  }

  use { "liuchengxu/vista.vim", cmd = "Vista" }
  use 'simrat39/symbols-outline.nvim'

  use 'tpope/vim-fugitive'
  use 'tpope/vim-rhubarb'
  use {
    'lewis6991/gitsigns.nvim',
    requires = {
      'nvim-lua/plenary.nvim'
    },
    config = function()
      require('gitsigns').setup()
    end
  }
  use {
    'mrjones2014/dash.nvim',
    run = 'make install',
  }

  use 'itspriddle/vim-marked'

  use {
    'oberblastmeister/rooter.nvim',
    config = function()
      require('rooter').setup {
        manual = false,
        echo = false,
      }
    end
  }
  use {
    "folke/trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require("trouble").setup()
    end
  }
  if packer_bootstrap then
    require('packer').sync()
  end
end)
