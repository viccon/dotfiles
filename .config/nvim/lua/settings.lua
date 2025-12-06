local opt = vim.opt

-- Disable some of the builtin plugins.
local disabled_plugins = {
	"gzip",
	"tar",
	"tarPlugin",
	"zip",
	"zipPlugin",
	"getscript",
	"getscriptPlugin",
	"vimball",
	"vimballPlugin",
	"matchit",
	"matchparen",
	"2html_plugin",
	"logiPat",
	"rrhelper",
	"netrw",
	"netrwPlugin",
	"netrwSettings",
	"netrwFileHandlers",
}
for _, plugin in ipairs(disabled_plugins) do
	vim.g["loaded_" .. plugin] = 1
end

-- General
opt.updatetime = 200
opt.shell = "zsh"
opt.history = 10000
opt.swapfile = false
opt.hidden = true
opt.cmdheight = 2
opt.inccommand = "nosplit"
opt.showmode = false
opt.joinspaces = false
opt.undolevels = 1000
opt.completeopt = "menuone,noselect"

-- Line numbers
opt.number = true
opt.relativenumber = true

-- Indentation
opt.list = false
opt.listchars = { eol = "↲", tab = "▸ ", trail = "·", multispace = "▫", extends = "▶", precedes = "◀", nbsp = "‿" }
opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
opt.expandtab = false

-- Clipboard
opt.clipboard = "unnamed,unnamedplus"

-- Searching
opt.ignorecase = true
opt.smartcase = true
opt.wrapscan = true

-- Splits
opt.splitbelow = true
opt.splitright = true

-- Completion popup
opt.pumblend = 10
opt.pumheight = 10

-- Folding
opt.foldmethod = "indent"
opt.foldlevel = 99

-- UI
opt.termguicolors = true

-- Include hyphen in word motions (e.g., "some-word" is treated as one word)
opt.iskeyword:append("-")
