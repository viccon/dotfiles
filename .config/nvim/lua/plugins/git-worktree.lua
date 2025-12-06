return {
	"ThePrimeagen/git-worktree.nvim",
	dependencies = { "nvim-telescope/telescope.nvim" },
	keys = {
		{ "<Leader>gw", function() require("telescope").extensions.git_worktree.git_worktrees() end, desc = "Git worktrees" },
		{ "<Leader>gc", function() require("telescope").extensions.git_worktree.create_git_worktree() end, desc = "Create git worktree" },
	},
	config = function()
		require("telescope").load_extension("git_worktree")
	end,
}
