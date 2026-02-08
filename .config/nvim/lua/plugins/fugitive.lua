return {
	"tpope/vim-fugitive",
	cmd = { "G", "Git", "Gclog", "Gvdiffsplit", "Gdiffsplit", "Gread", "Gwrite", "GBrowse", "Gdiff" },
	keys = {
		{ "<Leader>gs", "<cmd>G<CR>", desc = "Git status" },
		{ "<Leader>gd", "<cmd>Gvdiffsplit<CR>", desc = "Git diff (vsplit)" },
		{ "<Leader>gp", "<cmd>Git pull<CR>", desc = "Git pull" },
		{ "<Leader>gh", "<cmd>0Gclog<CR>", desc = "Git file history" },
		{ "dv", "<cmd>Gdiff<CR>", desc = "Git diff" },
	},
}
