-----------------------------------------------------------
-- Color schemes configuration file
-----------------------------------------------------------

-- vim.cmd[[colorscheme tokyonight]]
-- vim.cmd[[colorscheme sonokai]]
vim.cmd[[colorscheme gruvbox]]

-- vim.o.background = "dark" -- or "light" for light mode
vim.g['yaml.schemaStore.enable'] = false

-- transparency
vim.cmd[[hi Normal guibg=none ctermbg=none]]
vim.cmd[[hi LineNr guibg=none ctermbg=none]]
vim.cmd[[hi Folded guibg=none ctermbg=none]]
vim.cmd[[hi NonText guibg=none ctermbg=none]]
vim.cmd[[hi SpecialKey guibg=none ctermbg=none]]
vim.cmd[[hi VertSplit guibg=none ctermbg=none]]
vim.cmd[[hi SignColumn guibg=none ctermbg=none]]
vim.cmd[[hi EndOfBuffer guibg=none ctermbg=none]]

-- search highlight color
vim.cmd[[hi IncSearch guifg=#ff0000]]
