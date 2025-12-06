-- Leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Helper for cleaner keymap definitions
local function map(mode, lhs, rhs, desc)
	vim.keymap.set(mode, lhs, rhs, { silent = true, desc = desc })
end

-- =============================================================================
-- === NORMAL MODE =============================================================
-- =============================================================================

map("n", "<Leader><tab>", "<cmd>set list!<CR>", "Toggle list chars")
map("n", "Y", "y$", "Yank to end of line")
map("n", "cp", '<cmd>let @* = expand("%")<CR>', "Copy file path to clipboard")
map("n", "n", "nzzzv", "Next search result (centered)")
map("n", "N", "Nzzzv", "Previous search result (centered)")
map("n", "J", "mzJ`z", "Join lines (cursor stays)")
map("n", ",x", "<cmd>split<CR>", "Horizontal split")
map("n", ",v", "<cmd>vsplit<CR>", "Vertical split")
map("n", ",<space>", "<cmd>noh<CR>", "Clear search highlight")

-- Diagnostics
map("n", "<A-[>", vim.diagnostic.goto_prev, "Previous diagnostic")
map("n", "<A-]>", vim.diagnostic.goto_next, "Next diagnostic")

-- =============================================================================
-- === VISUAL MODE =============================================================
-- =============================================================================

map("v", "<", "<gv", "Indent left (stay in visual)")
map("v", ">", ">gv", "Indent right (stay in visual)")
map("v", "K", ":m '<-2<CR>gv=gv", "Move selection up")
map("v", "J", ":m '>+1<CR>gv=gv", "Move selection down")

-- =============================================================================
-- === INSERT MODE =============================================================
-- =============================================================================

-- Undo breakpoints at punctuation
map("i", ",", ",<c-g>u", "Undo breakpoint at comma")
map("i", ".", ".<c-g>u", "Undo breakpoint at period")
map("i", "!", "!<c-g>u", "Undo breakpoint at exclamation")
map("i", "?", "?<c-g>u", "Undo breakpoint at question mark")

-- =============================================================================
-- === EXPRESSION MAPPINGS =====================================================
-- =============================================================================

-- Mutate the jumplist when moving more than 5 lines
vim.keymap.set("n", "k", function()
	return (vim.v.count > 5 and "m'" .. vim.v.count or "") .. "k"
end, { expr = true, silent = true, desc = "Up (jumplist if >5 lines)" })

vim.keymap.set("n", "j", function()
	return (vim.v.count > 5 and "m'" .. vim.v.count or "") .. "j"
end, { expr = true, silent = true, desc = "Down (jumplist if >5 lines)" })
