return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = { "lua_ls" },
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			local lspconfig = require("lspconfig")

			local esp_idf_path = os.getenv("IDF_PATH")

			lspconfig.lua_ls.setup({
				capabilities = capabilities,
			})

			lspconfig.ts_ls.setup({
				capabilities = capabilities,
			})

			if esp_idf_path then
				lspconfig.clangd.setup({
					capabilities = capabilities,
					cmd = {
						"/home/finn/.espressif/tools/esp-clang/esp-18.1.2_20240912/esp-clang/bin/clangd",
						"--background-index",
						"--query-driver=**",
					},
					root_dir = function()
						-- leave empty to stop nvim from cd'ing into ~/ due to global .clangd file
					end,
				})
			else
				lspconfig.clangdsetup({
					capabilities = capabilities,
				})
			end

			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
			vim.keymap.set("n", "gr", vim.lsp.buf.references, {})
			vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
		end,
	},
}
