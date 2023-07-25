return {
	-- mason
	{
		"williamboman/mason.nvim",
		build = ":MasonUpdate",
		config = function()
			require("mason").setup()
		end,
	},

	-- lsp config
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			{
				"williamboman/mason-lspconfig.nvim",
				opts = {
					ensure_installed = {
						"lua_ls",
						"csharp_ls",
						"tsserver",
						"tailwindcss",
						"html",
						"cssls",
						"angularls",
					},
				},
			},
			{ "jay-babu/mason-null-ls.nvim", opts = { ensure_installed = { "stylua", "prettier", "csharpier" } } },
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "hrsh7th/nvim-cmp" },
			{ "jose-elias-alvarez/null-ls.nvim" },
		},
		key = {
			{ "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", mod = "n" },
			{ "<leader>ca", "<Cmd>lua vim.lsp.buf.code_action()<CR>", mod = "n, v" },
			{ "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", mod = "n" },
		},
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local lspconfig = require("lspconfig")
			local status_cmp_nvim_lsp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
			if not status_cmp_nvim_lsp then
				return
			end

			-- local on_attach = function(client, bufnr)
			-- 	-- client.server_capabilities.semanticTokensProvider = nil
			-- 	client.server_capabilities.semanticTokensProvider = vim.NIL
			-- end

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
		end,
	},

	-- null_ls
	{
		"jose-elias-alvarez/null-ls.nvim",
		dependencies = { "williamboman/mason.nvim", "nvim-lua/plenary.nvim" },
		event = { "BufReadPre", "BufNewFile" },

		config = function()
			local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
			require("null-ls").setup({
				sources = {
					require("null-ls").builtins.formatting.stylua,
					require("null-ls").builtins.formatting.prettier,
					-- require("null-ls").builtins.formatting.astyle.with({
					--   args = { "--options=/mnt/Pury/Workspaces/codestyle.cfg" },
					-- }),
					-- require("null-ls").builtins.formatting.clang_format,
					require("null-ls").builtins.formatting.csharpier,
				},
				-- you can reuse a shared lspconfig on_attach callback here
				on_attach = function(client, bufnr)
					if client.supports_method("textDocument/formatting") then
						vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
						vim.api.nvim_create_autocmd("BufWritePre", {
							group = augroup,
							buffer = bufnr,
							callback = function()
								-- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
								-- on later neovim version, you should use vim.lsp.buf.format({ async = false }) instead
								vim.lsp.buf.format({ async = false })
								-- vim.lsp.buf.format({ async = true })
							end,
						})
					end
				end,
				-- on_attach = function(_, _)
				-- 	vim.api.nvim_create_augroup("Format on save", { clear = false })
				-- 	vim.api.nvim_create_autocmd("BufWritePre", {
				-- 		callback = function()
				-- 			vim.lsp.buf.format({
				-- 				async = true,
				-- 				filter = function(client)
				-- 					return client.name == "null-ls"
				-- 				end,
				-- 			})
				-- 		end,
				-- 		group = "Format on save",
				-- 	})
				-- end,
			})
		end,
	},

	-- Debugger
	{
		"mfussenegger/nvim-dap",
		config = function()
			local dap = require("dap")

			dap.adapters.coreclr = {
				type = "executable",
				command = "/home/pury/Downloads/netcoredbg/build/src/netcoredbg",
				args = { "--interpreter=vscode" },
			}

			dap.configurations.cs = {
				{
					type = "coreclr",
					name = "launch - netcoredbg",
					request = "launch",
					program = function()
						return vim.fn.input("Path to dll", vim.fn.getcwd() .. "/bin/Debug/", "file")
					end,
				},
			}
		end,
	},

	{
		"rcarriga/nvim-dap-ui",
		dependencies = {
			{
				"mfussenegger/nvim-dap",
			},
		},

		config = function()
			local dap, dapui = require("dap"), require("dapui")

			dapui.setup({
				icons = { expanded = "▾", collapsed = "▸", current_frame = "▸" },
				mappings = {
					expand = { "<CR>", "<2-LeftMouse>" },
					open = "o",
					remove = "d",
					edit = "e",
					repl = "r",
					toggle = "t",
				},
				element_mappings = {
					-- Example:
					-- stacks = {
					--   open = "<CR>",
					--   expand = "o",
					-- }
				},
				expand_lines = vim.fn.has("nvim-0.7") == 1,
				layouts = {
					{
						elements = {
							{ id = "scopes", size = 0.25 },
							"breakpoints",
							"stacks",
							"watches",
						},
						size = 40, -- 40 columns
						position = "left",
					},
					{
						elements = {
							"repl",
							"console",
						},
						size = 0.25, -- 25% of total lines
						position = "bottom",
					},
				},
				controls = {
					-- Requires Neovim nightly (or 0.8 when released)
					enabled = true,
					-- Display controls in this element
					element = "repl",
					icons = {
						pause = "",
						play = "",
						step_into = "",
						step_over = "",
						step_out = "",
						step_back = "",
						run_last = "↻",
						terminate = "□",
					},
				},
				floating = {
					max_height = nil, -- These can be integers or a float between 0 and 1.
					max_width = nil, -- Floats will be treated as percentage of your screen.
					border = "single", -- Border style. Can be "single", "double" or "rounded"
					mappings = {
						close = { "q", "<Esc>" },
					},
				},
				windows = { indent = 1 },
				render = {
					max_type_length = nil, -- Can be integer or nil.
					max_value_lines = 100, -- Can be integer or nil.
				},
			})

			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close()
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close()
			end
		end,
	},
}
