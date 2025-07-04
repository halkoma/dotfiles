-----------------------------------------------------------
-- Define keymaps of Neovim and installed plugins.
-----------------------------------------------------------

local function map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- Change leader to a space
vim.g.mapleader = ' '

-----------------------------------------------------------
-- Neovim shortcuts
-----------------------------------------------------------

-- Map Esc to kk
map('i', 'kj', '<Esc>')

-- Toggle auto-indenting for code paste
map('n', '<F3>', ':set invpaste paste?<CR>')

-- Change split orientation
map('n', '<leader>th', '<C-w>t<C-w>K') -- change vertical to horizontal
map('n', '<leader>tk', '<C-w>t<C-w>H') -- change horizontal to vertical

-- Reload configuration without restart nvim
map('n', '<leader>r', ':luafile $MYVIMRC<CR>')

-- Fast saving with <leader> and s
map('n', '<C-S>', ':update<CR>')
map('i', '<C-S>', '<C-C>:update<CR>')
map('v', '<C-S>', '<C-O>:update<CR>')

-- switch buffer
map('n', '<Left>', ':bp<CR>')
map('n', '<Right>', ':bn<CR>')

-- yank line back to Y
map('n', 'Y', 'yy')

-- Clear search highlights
map('n', '<C-L>', ':noh<CR><C-L>')

-----------------------------------------------------------
-- Applications and Plugins shortcuts
-----------------------------------------------------------

-- -- NvimTree
map('n', '<C-n>', ':NvimTreeToggle<CR>')            -- open/close
-- map('n', '<leader>f', ':NvimTreeRefresh<CR>')       -- refresh
-- map('n', '<leader>n', ':NvimTreeFindFile<CR>')      -- search file

-- Telescope
map('n', '<leader>ff', '<cmd>lua require("telescope.builtin").find_files()<cr>')
-- below: fuzzy search from cWORD under cursor
map('n', '<leader>fF', '<cmd>lua require("telescope.builtin").find_files({find_command={"fdfind", "-p", vim.fn.expand("<cWORD>")}})<cr>')
map('n', '<leader>fg', '<cmd>lua require("telescope.builtin").live_grep()<cr>')
map('n', '<leader>fb', '<cmd>lua require("telescope.builtin").buffers()<cr>')
map('n', '<leader>fh', '<cmd>lua require("telescope.builtin").help_tags()<cr>')
-- below: live_grep for word under cursor
map('n', '<leader>fG', '<cmd>lua require(\'telescope.builtin\').grep_string({search = vim.fn.expand("<cword>")})<cr>', {})

-- hop
-- place this in one of your configuration file(s)
local hop = require('hop')
local directions = require('hop.hint').HintDirection
hop.setup {
  quit_key = '<Esc>',
}
vim.keymap.set('', '<leader>f', function()
  hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = false })
end, {remap=true})
vim.keymap.set('', '<leader>F', function()
  hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = false })
end, {remap=true})
vim.keymap.set('', '<leader>t', function()
  hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = false, hint_offset = -1 })
end, {remap=true})
vim.keymap.set('', '<leader>T', function()
  hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = false, hint_offset = 1 })
end, {remap=true})
vim.keymap.set('', '<leader>w', function()
  hop.hint_words()
end, {remap=true})
vim.keymap.set('', '<leader>/', function()
  hop.hint_patterns()
end, {remap=true})
vim.keymap.set('', '<leader>?', function()
  hop.hint_patterns({ direction = directions.BEFORE_CURSOR })
end, {remap=true})

-- copy filename to clipboard
map('n', '<leader>cf', ':let @+=expand("%")<CR>')

-- system clipboard: yank, paste and delete
-- must have set opt.clipboard = 'unnamed'  and not 'unnamedplus'
map('n', '<leader>y', '"+y')
map('n', '<leader>p', '"+p')
map('n', '<leader>d', '"+d')
-- visual mode, yank selected
map('v', '<leader>y', '"+y')

-- kill to end of line
map('n', 'då', 'd$')

-- switch to last buffer
map('n', '<Tab>', ':e #<CR>')

-- wrap paragraph (normal mode)
map('n', '<leader>q', 'vipJgqq')
-- wrap selection (same but visual mode)
map('v', '<leader>q', 'gqq')

-- ``` is needed for code block in markdown
map('n', '<leader>å', 'i```<esc>')

-- nvim-trevJ.lua
-- make e.g. this(a,b,c)
-- transform into
-- this(
--   a,
--   b,
--   c
-- )
local trevj = require('trevj')
trevj.setup {
  containers = {
    lua = {
      table_constructor = {final_separator = ',', final_end_line = true},
      arguments = {final_separator = false, final_end_line = true},
      parameters = {final_separator = false, final_end_line = true},
    },
    yaml = {
      table_constructor = {final_separator = '', final_end_line = true},
      arguments = {final_separator = false, final_end_line = true},
      parameters = {final_separator = false, final_end_line = true},
    },
  }
}
vim.keymap.set('', 'gs', function()
  trevj.format_at_cursor()
end, {remap=true})

-- remove trailing whitespace on every line
map('n', '<leader>s', [[ms :let _s=@/ <Bar> :%s/\s\+$//e <Bar> :let @/=_s <Bar> :nohl <Bar> :unlet _s <CR> `s]])

-- set sensible navigation repeat directions
-- map('n', ',', ';')
-- map('n', ';', ',')
--

---- coc. function check_back_space() is related to the map below it
-- use Tab to trigger completion for the currently selected completion
local opts = {silent = true, noremap = true, expr = true, replace_keycodes = false}
-- autocomplete
function _G.check_back_space()
    local col = vim.fn.col('.') - 1
    return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
end
map("i", "<TAB>", 'coc#pum#visible() ? coc#pum#confirm() : v:lua.check_back_space() ? "<TAB>" : coc#refresh()', opts)

-- /coc
