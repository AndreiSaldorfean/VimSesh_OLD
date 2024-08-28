-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
require("lazy").setup({
    {
      "HiPhish/rainbow-delimiters.nvim",
      config = function ()
          -- This module contains a number of default definitions
          local rainbow_delimiters = require 'rainbow-delimiters'

          vim.g.rainbow_delimiters = {
              strategy = {
                  [''] = rainbow_delimiters.strategy['global'],
                  vim = rainbow_delimiters.strategy['local'],
              },
              query = {
                  [''] = 'rainbow-delimiters',
                  lua = 'rainbow-blocks',
              },
              priority = {
                  [''] = 110,
                  lua = 210,
              },
              highlight = {
                  'RainbowDelimiterRed',
                  'RainbowDelimiterYellow',
                  'RainbowDelimiterBlue',
                  'RainbowDelimiterOrange',
                  'RainbowDelimiterGreen',
                  'RainbowDelimiterViolet',
                  'RainbowDelimiterCyan',
              },
          }
      end
    },
    {
      "onsails/lspkind.nvim"
    },
    {
      "goolord/alpha-nvim",
      config = function()
          require'alpha'.setup(require'alpha.themes.dashboard'.config)
      end,
      -- enabled = lvim.builtin.alpha.active,
      event = "VimEnter",
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        ---@module "ibl"
        ---@type ibl.config
        opts = {},
        config = function ()
            require("ibl").setup{
           }
        end
    },
    {
      "NeogitOrg/neogit",
       dependencies = {
        "nvim-lua/plenary.nvim",         -- required
        "sindrets/diffview.nvim",        -- optional - Diff integration

        -- Only one of these is needed, not both.
        "nvim-telescope/telescope.nvim", -- optional
        "ibhagwan/fzf-lua",              -- optional
      },
      config = true
    },
      -- Used for linters
    {
      'jose-elias-alvarez/null-ls.nvim'
    },
    {
      "olimorris/persisted.nvim",
      lazy = false, -- make sure the plugin is always loaded at startup
      config = true
    },
    {
      "folke/noice.nvim",
      event = "VeryLazy",
      opts = {
        -- add any options here
      },
      dependencies = {
        -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
        "MunifTanjim/nui.nvim",
        -- OPTIONAL:
        --   `nvim-notify` is only needed, if you want to use the notification view.
        --   If not available, we use `mini` as the fallback
        },
      config = function ()
        require("noice").setup {
          notify = {
            enabled = false
          }
        }
      end
    },
    -- Vim fugitive, used for seeing files and folders ignored by gitignore
    {
      'tpope/vim-fugitive'
    },
    -- Tree-sitter for syntax highlighting and parsing
    {
      "nvim-treesitter/nvim-treesitter",
      lazy = false,
      run = ":TSUpdate",
      config = function()
        require('nvim-treesitter.configs').setup {
          prefer_git = false,
          auto_install = false,
          compiler = "gcc",
          ensure_installed = { "c", "python", "cpp", "lua","markdown","markdown_inline"}, -- Add other parsers as needed
          highlight = {
            enable = true,  -- Enable Tree-sitter based highlighting
            additional_vim_regex_highlighting = false,  -- Disable Vim regex based highlighting
          },
        }
      end,
    },
    -- Markdown
    {
        "OXY2DEV/markview.nvim",
        lazy = false,      -- Recommended

        dependencies = {
            "nvim-tree/nvim-web-devicons"
        }
    },
   -- Diff view
   {
      'sindrets/diffview.nvim',
      requires = 'nvim-lua/plenary.nvim',
      config = function()
        require('diffview').setup {}
      end
    },
    -- AUTO PAIRS
    {
      'windwp/nvim-autopairs',
      event = "InsertEnter",
      config = true
    },
    --Comments
    {
        "tpope/vim-commentary",
        event = "VeryLazy",
    },
    -- GITSIGNS
    {
        "lewis6991/gitsigns.nvim"
    },
    -- LSP
    {
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',
        'neovim/nvim-lspconfig',
        'VonHeikemen/lsp-zero.nvim', branch = 'v4.x',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/nvim-cmp',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path'
    },
    {
      "nvim-neo-tree/neo-tree.nvim",
      branch = "v3.x",
      dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
        "MunifTanjim/nui.nvim",
        -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
      },
      config = function ()
        require("neo-tree").setup({
          filesystem = {
              filtered_items={
                hide_dotfiles = false,
                hide_gitignored = false,
              },
              hide_by_name = {
                  --"node_modules"
              },
              always_show = {".gitignore"}
          }
        })
      end
    },
    -- STATUS BAR
    {
        "famiu/feline.nvim"
    },
    -- COLORSCHEME
    {
        "catppuccin/nvim",
        "rose-pine/neovim", name = "rose-pine",
        'kvrohit/rasmus.nvim', --  No 2
        "scottmckendry/cyberdream.nvim", -- No 1
        'ribru17/bamboo.nvim', -- Nice
        lazy = false,
        priority = 1000,
        config = function()
            require('rose-pine').load()
            require('bamboo').load()
        end,
    },
    -- BARBAR
    {
        'romgrk/barbar.nvim',
        dependencies = {
            'lewis6991/gitsigns.nvim', -- OPTIONAL: for git status
            'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
        },
        init = function() vim.g.barbar_auto_setup = false end,
        opts = {
            -- lazy.nvim will automatically call setup for you. put your options here, anything missing will use the default:
            -- animation = true,
            -- insert_at_start = true,
            -- …etc.
        },
        version = '^1.0.0', -- optional: only update when a new 1.x version is released
    },
    -- TELESCOPE
    {
      'nvim-telescope/telescope.nvim', tag = '0.1.8',
      dependencies = { 'nvim-lua/plenary.nvim' }
    },
    -- TERMINAL
    {
        'akinsho/toggleterm.nvim', version = "*", config = true
    },
  })
