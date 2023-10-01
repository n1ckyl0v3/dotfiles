require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = {
						"lua_ls",
						"csharp_ls",
						"tsserver",
						"tailwindcss",
						"html",
						"cssls",
						"angularls",
            "tailwindcss",
            "jdtls"
	},
})
require("mason-null-ls").setup({
   ensure_installed = { "stylua", "prettier", "csharpier", "clang-format" }
})

local lspconfig = require("lspconfig")
			local status_cmp_nvim_lsp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
			if not status_cmp_nvim_lsp then
				return
			end

			local capabilities = cmp_nvim_lsp.default_capabilities()
			local capabilities_css = vim.lsp.protocol.make_client_capabilities()
			capabilities_css.textDocument.completion.completionItem.snippetSupport = true

			-- tsserver
			lspconfig.tsserver.setup({
				capabilities = capabilities,
				-- on_attach = on_attach(),
			})

			-- angular
			lspconfig.angularls.setup({
				capabilities = capabilities,
				-- on_attach = on_attach(),
			})

			-- cpp
			lspconfig.clangd.setup({
				capabilities = capabilities,
				-- on_attach = on_attach(),
			})

			-- css
			lspconfig.cssls.setup({
				-- on_attach = on_attach(),

				capabilities = capabilities_css,
			})

			-- html
			lspconfig.html.setup({
				-- on_attach = on_attach(),

				capabilities = capabilities_css,
			})

			-- angular

			lspconfig.angularls.setup({

				capabilities = capabilities_css,
			})

			-- tailwind
			lspconfig.tailwindcss.setup({
				{
					-- on_attach = on_attach(),

					capabilities = capabilities,
				},
			})

			-- lua
			lspconfig.lua_ls.setup({
				-- on_attach = on_attach(),

				capabilities = capabilities,
				settings = {
					Lua = {
						diagnostics = {
							-- Get the language server to recognize the `vim` global
							globals = { "vim" },
						},

						workspace = {
							-- Make the server aware of Neovim runtime files
							library = vim.api.nvim_get_runtime_file("", true),
							checkThirdParty = false,
						},
					},
				},
			})

			-- csharp
			lspconfig.csharp_ls.setup({
				-- on_attach = on_attach(),

				capabilities = capabilities,
			})

			vim.lsp.handlers["textDocument/publishDiagnostics"] =
				vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
					-- underline = true,
					undercurl = true,
					update_in_insert = false,
					signs = true,
					virtual_text = { spacing = 4, prefix = "●" },
					severity_sort = true,
				})

			-- Diagnostic symbols in the sign column (gutter)
			local signs = { Error = "⛔", Warn = "⚠️ ", Hint = "💡", Info = " " }
			for type, icon in pairs(signs) do
				local hl = "DiagnosticSign" .. type
				vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
			end

