return {
	"neovim/nvim-lspconfig",
	dependencies = { "williamboman/mason-lspconfig", "olexsmir/gopher.nvim" },
	config = function()
		local lspconfig = require("lspconfig")
		local util = require("lspconfig/util")

		-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

		local function on_attach() end

		-- Setup mason so it can manage external tooling
		require("mason").setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})

		local mason_lspconfig = require("mason-lspconfig")

		-- Ensure that the servers below are installed
		local servers = {
			ts_ls = {},
			gopls = {},
			bashls = {},
			dockerls = {},
			vimls = {},
			cssls = {},
			html = {},
			eslint = {},
			templ = {},
			lua_ls = {
				Lua = {
					workspace = { checkThirdParty = false },
					telemetry = { enable = false },
				},
			},
			-- clangd = {
			-- 	cmd = {
			-- 		"clangd",
			-- 		"--background-index",
			-- 		"--clang-tidy",
			-- 		"--header-insertion=iwyu",
			-- 		"--completion-style=detailed",
			-- 		"--function-arg-placeholders",
			-- 		"--limit-references=0",
			-- 		"--limit-results=0",
			-- 		"--rename-file-limit=0",
			-- 		"--fallback-style=llvm",
			-- 	},
			-- },
		}

		local clangd = {
			-- cmd = {
			-- 	"clangd",
			-- 	"--background-index",
			-- 	"--clang-tidy",
			-- 	"--header-insertion=iwyu",
			-- 	"--completion-style=detailed",
			-- 	"--function-arg-placeholders",
			-- 	"--limit-references=0",
			-- 	"--limit-results=0",
			-- 	"--rename-file-limit=0",
			-- 	"--fallback-style=llvm",
			-- },
			cmd = {
				"clangd",
				"--clang-tidy",
				"--completion-style=detailed",
				"--function-arg-placeholders",
			},
		}

		mason_lspconfig.setup({
			ensure_installed = vim.tbl_keys(servers),
		})

		mason_lspconfig.setup_handlers({
			function(server_name) -- default handler (optional)
				if server_name == "tsserver" then
					server_name = "ts_ls"
				end
				require("lspconfig")[server_name].setup({
					capabilities = capabilities,
					on_attach = on_attach,
					settings = servers[server_name],
				})
			end,
		})

		require("lspconfig")["clangd"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
			settings = clangd,
		})

		-- Configure diagnostics display
		vim.diagnostic.config({
			underline = true,
			update_in_insert = false,
			virtual_text = false,
			severity_sort = true,
			signs = true,
		})

		vim.filetype.add({ extension = { templ = "templ" } })

		-- Setup the diagnostics icons
		local function lspSymbol(name, icon)
			vim.fn.sign_define("DiagnosticSign" .. name, { text = icon, numhl = "DiagnosticDefault" .. name })
		end

		lspSymbol("Error", "󰅙")
		lspSymbol("Warn", "")
		lspSymbol("Info", "")
		lspSymbol("Hint", "")

		-- Configure the look for all floating previews
		-- For more info see: https://github-wiki-see.page/m/neovim/nvim-lspconfig/wiki/UI-customization
		local border = {
			{ "╭", "FloatBorder" },
			{ "─", "FloatBorder" },
			{ "╮", "FloatBorder" },
			{ "│", "FloatBorder" },
			{ "╯", "FloatBorder" },
			{ "─", "FloatBorder" },
			{ "╰", "FloatBorder" },
			{ "│", "FloatBorder" },
		}
		local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
		function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
			opts = opts or {}
			opts.border = opts.border or border
			return orig_util_open_floating_preview(contents, syntax, opts, ...)
		end

		lspconfig.gopls.setup({
			cmd = { "gopls", "serve" },
			filetypes = { "go", "gomod", "gowork", "gotmpl" },
			root_dir = util.root_pattern("go.work", "go.mod", ".git"),
			settings = {
				gopls = {
					completeUnimported = true,
					usePlaceholders = true,
					gofumpt = true,
					analyses = {
						unusedparams = true,
					},
					staticcheck = true,
					env = {
						GOFLAGS = "-tags=windows,linux,darwin,integration",
					},
				},
			},
		})

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				-- Buffer local mappings.
				local opts = { buffer = ev.buf }
				vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
				vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
				vim.keymap.set("n", "<Leader>f", vim.lsp.buf.code_action, opts)
				vim.keymap.set("v", "<Leader>f", vim.lsp.buf.code_action, opts)
				vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, opts)
				vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)

				-- make gq work with lsp
				vim.bo[ev.buf].formatexpr = ""
			end,
		})

		-- vim.lsp.set_log_level("debug")
	end,
}
