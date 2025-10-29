-----------------------------------------------------------
-- Plugin manager configuration file
-----------------------------------------------------------

-- Plugin manager: packer.nvim
-- url: https://github.com/wbthomason/packer.nvim

-- For information about installed plugins see the README:
-- neovim-lua/README.md
-- https://github.com/brainfucksec/neovim-lua#readme


-- Automatically install packer
local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({
    'git',
    'clone',
    '--depth',
    '1',
    'https://github.com/wbthomason/packer.nvim',
    install_path
  })
  vim.o.runtimepath = vim.fn.stdpath('data') .. '/site/pack/*/start/*,' .. vim.o.runtimepath
end

-- Autocommand that reloads neovim whenever you save the packer_init.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost packer_init.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, 'packer')
if not status_ok then
  return
end

-- Install plugins
return packer.startup(function(use)
  -- Add you plugins here:
  use 'wbthomason/packer.nvim' -- packer can manage itself

  -- File explorer (e.g. ctrl+n to open it)
  use 'kyazdani42/nvim-tree.lua'

  -- Indent line
  use 'lukas-reineke/indent-blankline.nvim'

 -- Autopair
 use {
   'windwp/nvim-autopairs',
   config = function() require('nvim-autopairs').setup() end
 }

  -- Icons
  use 'kyazdani42/nvim-web-devicons'

  -- Color schemes
  -- use 'folke/tokyonight.nvim'
  use 'sainnhe/sonokai'
  -- use { "RRethy/nvim-base16" }
  -- use 'morhetz/gruvbox'
  use 'ellisonleao/gruvbox.nvim'

  -- CoC
  -- Nodejs extension host for vim & neovim, load extensions like VSCode and
  --   host language servers.
  use {'neoclide/coc.nvim', branch = 'release'}

  -- merge tmux and vim status line to not have 2 status lines
  use 'vimpostor/vim-tpipeline'

  -- this shows tabs on the top of vim
  use {'akinsho/bufferline.nvim', tag = "*", requires = 'nvim-tree/nvim-web-devicons'}

  -- tpope plugins
  use 'tpope/vim-surround'
  use 'tpope/vim-fugitive'  -- Git
  use 'tpope/vim-commentary'
  use 'tpope/vim-repeat'
  use 'tpope/vim-vinegar'
  use 'tpope/vim-sensible'
  use 'tpope/vim-markdown'
  use 'tpope/vim-characterize'
  use 'tpope/vim-endwise'
  use 'tpope/vim-obsession'

  -- show a git diff sign in the sign column (where line numbers are)
  use 'airblade/vim-gitgutter'  -- Git

  -- make e.g. this(a,b,c)
  -- transform into
  -- this(
  --   a,
  --   b,
  --   c
  -- ) 
  use 'AckslD/nvim-trevJ.lua'

  -- polyglot, language packs
  use 'sheerun/vim-polyglot'

  -- -- trouble - error diagnostics
  -- use {
  -- "folke/trouble.nvim",
  -- requires = "kyazdani42/nvim-web-devicons",
  -- config = function()
  --   require("trouble").setup {
  --     -- your configuration comes here
  --     -- or leave it empty to use the default settings
  --     -- refer to the configuration section below
  --   }
  -- end
  -- }

  -- nvim-treesitter
  -- provides for example nice syntax highlighting
  use {
      'nvim-treesitter/nvim-treesitter',
      run = ':TSUpdate'
  }

  -- Find, Filter, Preview, Pick texts, files
  use {
    'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/plenary.nvim'},
                 {'sharkdp/fd'},
                 {'BurntSushi/ripgrep'}
    }
  }

  -- use { 'nvim-telescope/telescope-fzf-native.nvim', build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }

  -- jump anywhere in a document with as few keystrokes as possible
  -- like easymotion
  use {
    'smoka7/hop.nvim',
    tag = '*', -- optional but strongly recommended
    config = function()
      -- you can configure Hop the way you like here; see :h hop-config
      -- require'hop'.setup { keys = 'etovxqpdygfblzhckisuran' }
      require'hop'.setup { keys = 'asdfghjklöäzxcvbnm' }
    end
  }

  -- markdown preview
  use {
      "iamcco/markdown-preview.nvim",
      run = function() vim.fn["mkdp#util#install"]() end,
  }

  -- usage e.g.
  -- vip
  -- Tabularize /|
  use 'godlygeek/tabular'

  -- vim-slime to use a REPL of many languages
  use 'jpalardy/vim-slime'

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)

