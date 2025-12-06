local theme = string.sub(vim.fn.system("tmux show-environment THEME"), 7):gsub("%s+$", "")

if theme == "light" then
	require("material").setup({
		custom_colors = function(colors)
			colors.editor.fg = "#213B47"
			colors.editor.fg_dark = "#61747D"
		end,
	})
	vim.o.background = "light"
	vim.g.material_style = "lighter"
	vim.cmd.colorscheme("material")
else
	-- Default to dark theme (tokyonight)
	vim.o.background = "dark"
	vim.cmd.colorscheme("tokyonight")
end
