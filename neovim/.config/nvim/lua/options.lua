-----------------------------------------------------------
-- General Neovim settings and configuration
-----------------------------------------------------------

-- Default options are not included
-- See: https://neovim.io/doc/user/vim_diff.html
-- [2] Defaults - *nvim-defaults*

local g = vim.g       -- Global variables
local opt = vim.opt   -- Set options (global/buffer/windows-scoped)

-----------------------------------------------------------
-- General
-----------------------------------------------------------
opt.mouse = 'a'                       -- Enable mouse support
-- opt.clipboard = 'unnamedplus'         -- Copy/paste to system clipboard
opt.clipboard = 'unnamed'         -- Do not Copy/paste to system clipboard
opt.swapfile = false                  -- Don't use swapfile
opt.completeopt = 'menuone,noinsert,noselect'  -- Autocomplete options
-- opt.virtualedit.onemore = true  -- not sure if it's like this
-- opt.spelllang = 'en'
-- opt.spell = true

-----------------------------------------------------------
-- Neovim UI
-----------------------------------------------------------
opt.number = true           -- Show line number
opt.relativenumber = true
opt.showmatch = true        -- Highlight matching parenthesis
opt.foldmethod = 'expr'     -- Enable folding
opt.foldexpr = "getline(v:lnum)=~'^\\s*$'&&getline(v:lnum+1)=~'\\S'?'<1':1"
opt.foldenable = false      -- Enable folding
opt.colorcolumn = '80'      -- Line lenght marker at 80 columns
opt.splitright = true       -- Vertical split to the right
opt.splitbelow = true       -- Horizontal split to the bottom
opt.ignorecase = true       -- Ignore case letters when search
opt.smartcase = true        -- Ignore lowercase for the whole pattern
opt.linebreak = true        -- Wrap on word boundary
opt.termguicolors = false    -- Disable 24-bit RGB colors - use with urxvt 
-- opt.termguicolors = true    -- Enable 24-bit RGB colors
opt.laststatus=2            -- Set global statusline
opt.list=true               -- helps viewing whitespace at EOL

-----------------------------------------------------------
-- Tabs, indent
-----------------------------------------------------------
opt.expandtab = true        -- Use spaces instead of tabs
opt.shiftwidth = 2          -- Shift 4 spaces when tab
opt.shiftround = true       -- use multiples of shiftwidth when using > and <
opt.tabstop = 4             -- 1 tab == 4 spaces
opt.smartindent = true      -- Autoindent new lines
opt.autoindent = true

-----------------------------------------------------------
-- Memory, CPU
-----------------------------------------------------------
opt.hidden = true           -- Enable background buffers
opt.history = 100           -- Remember N lines in history
opt.lazyredraw = true       -- Faster scrolling
opt.synmaxcol = 240         -- Max column for syntax highlight
opt.updatetime = 700        -- ms to wait for trigger an event
opt.ttimeoutlen = 10        -- Time in milliseconds to wait for a key code sequence to complete. 

-----------------------------------------------------------
-- Startup
-----------------------------------------------------------
-- Disable nvim intro
opt.shortmess:append "sI"

-- Disable builtins plugins
local disabled_built_ins = {
  "netrw",
  "netrwPlugin",
  "netrwSettings",
  "netrwFileHandlers",
  "gzip",
  "zip",
  "zipPlugin",
  "tar",
  "tarPlugin",
  "getscript",
  "getscriptPlugin",
  "vimball",
  "vimballPlugin",
  "2html_plugin",
  "logipat",
  "rrhelper",
  "spellfile_plugin",
  "matchit"
}

for _, plugin in pairs(disabled_built_ins) do
  g["loaded_" .. plugin] = 1
end

-----------------------------------------------------------
-- Plugins
-----------------------------------------------------------

-- coc
vim.g['coc_filetype_map'] = {
  'yaml.ansible', 'ansible',
}
-- this is to prevent the cursor disappearing eg. after :CocList 
vim.g['coc_disable_transparent_cursor'] = 1
vim.g['yaml.schemaStore.enable'] = false

vim.cmd [[ 
function! GitStatus()
  let [a,m,r] = GitGutterGetHunkSummary()
  return printf('+%d ~%d -%d', a, m, r)
endfunction
set statusline+=%{GitStatus()}
]]

-- -- this is to avoid deprecation warnings until plugins (bufferline) makes an update
-- vim.tbl_add_reverse_lookup = function (tbl)
--   for k, v in pairs(tbl) do
--     tbl[v] = k
--   end
-- end

-- vim-slime
g.slime_target = "tmux"
