local api = vim.api

-- Resize vim windows when window size changes, usually caused by opening a tmux split
api.nvim_create_autocmd("VimResized", {
	pattern = "*",
	command = "wincmd =",
})

-- Automatically clean trailing whitespace
api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	command = "%s/\\s\\+$//e",
})

-- Enable spell check for markdown files
api.nvim_create_autocmd("FileType", {
	pattern = "markdown",
	command = "setlocal spell spelllang=en_us",
})

-- Set filetype to cmake for CMakeLists.txt
api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = { "CMakeLists.txt" },
	command = "set ft=cmake",
})

-- Set filetype to json for various configuration files
api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = { ".eslintrc", ".jscsrc", ".jshintrc", ".babelrc" },
	command = "set ft=json",
})

-- Set filetype to gitconfig for gitconfig files
api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = "gitconfig",
	command = "set ft=gitconfig",
})
