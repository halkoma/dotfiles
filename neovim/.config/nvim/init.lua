vim.deprecate = function() end   -- ignore deprecation warnings regarding this (remove later!)

local install_path = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
  vim.cmd 'packadd packer.nvim'
end
require('packer_init')

require('options')
require('colors')
require('keymaps')

require('bufferline').setup{}  -- show tabs on top

require('lualine').setup {  -- status bar
  sections = {
    lualine_a = {
      {
        'filename',
        file_status = true, -- displays file status (readonly status, modified status)
        path = 3 -- 0 = just filename, 1 = relative path, 2 = absolute path, 3 = absolute path with $HOME=~
      }
    }
  }
}

require("nvim-tree").setup()

require('telescope').setup {
  pickers = {
    find_files = {
      find_command = {
          "fdfind",
          ".",
          "--type",
          "f",
          "--hidden",
          "--follow",
          "--exclude",
          ".git",
          -- os.getenv("HOME"),
      },
    },
  },
  extensions = {
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = true,  -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
    }
  }
}
require('telescope').load_extension('fzf')

require('nvim-treesitter.configs').setup {
  -- A list of parser names, or "all"
  ensure_installed = { "yaml", "lua", "python", "markdown" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  auto_install = true,

  -- List of parsers to ignore installing (for "all")
  ignore_install = { "javascript" },

  highlight = {
    -- `false` will disable the whole extension
    enable = true,

    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled
    disable = { "c", "rust" },

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}

-- indent-blankline.nvim
-- vertical lines to indicate indentation
require("ibl").setup()
