local Module = {}

local function map(keymap, mapTarget, buffer, desc, mode)
	mode = mode or "n"
	local opts = { remap = false, silent = true, buffer = buffer, desc = desc }

	vim.keymap.set(mode, keymap, mapTarget, opts)
end

Module.setup = {
	lsp = function(buffer)
		local lsp = vim.lsp.buf
		local diagnostic = vim.diagnostic

		map("gd", require("telescope.builtin").lsp_definitions, buffer, "[G]oto [D]efinition (LSP)")
		map("gD", lsp.declaration, buffer, "[G]oto [D]eclaration (LSP)")

		map("gr", require("telescope.builtin").lsp_references, buffer, "[G]oto [R]eferences (LSP)")
		map("gI", require("telescope.builtin").lsp_implementations, buffer, "[G]oto [I]mplementation (LSP)")
		map("gk", lsp.signature_help, buffer, "[G]et Signature help (LSP)")

		map("ga", lsp.code_action, buffer, "[G]et  [C]ode action")
		map("gl", "<cmd>lua vim.diagnostic.open_float()<CR>", buffer, "Open Float diagnostic")

		map("<leader>D", require("telescope.builtin").lsp_type_definitions, buffer, "List Type [D]efinition (LSP)")
		map("<leader>ds", require("telescope.builtin").lsp_document_symbols, buffer, "[D]ocument [S]ymbols (LSP)")

		--Workspace
		map(
			"<leader>ws",
			require("telescope.builtin").lsp_dynamic_workspace_symbols,
			buffer,
			"[W]orkspace [S]ymbols (LSP)"
		)
		map("<leader>wa", lsp.add_workspace_folder, buffer, "[W]orkspace [A]dd folder (LSP)")
		map("<leader>wr", lsp.remove_workspace_folder, buffer, "[W]orkspace [R]emove folder (lsp)")
		map("<leader>wl", function()
			vim.print(lsp.list_workspace_folders())
		end, buffer, "list workspace folder")

		--formatting
		map("<leader>f", function()
			local client_names = vim.tbl_map(function(client)
				return client.name
			end, vim.lsp.get_clients({ bufnr = 0 }))
			vim.ui.select(client_names, { prompt = "Select al client to format current buffer:" }, function(client_name)
				if vim.tbl_contains(client_names, client_name) then
					local choice = client_name
					require("conform").format({
						filter = function(client)
							return client.name == choice
						end,
					})
				else
					vim.notify("invaid client name", vim.log.levels.INFO)
				end
			end)
		end, buffer, "[F]ormat choose (lsp)")

		map("<leader>rn", lsp.rename, buffer, "[R]e[n]ame")

		map("K", lsp.hover, buffer, "Hover")

		map("[d", diagnostic.goto_prev, buffer, "previous diagnostic")
		map("]d", diagnostic.goto_next, buffer, "next diagnostic")

		-- this puts diagnostics from opened files to quickfix
		-- map("<space>qw", diagnostic.setqflist, buffer, "put window diagnostics to qf")
		-- this puts diagnostics from current buffer to quickfix
		-- map("<space>qb", function()
		-- 	set_qflist(buffer)
		-- end, "put buffer diagnostics to qf")
		--
		if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
			local highlight_augroup = vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
			vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
				buffer = event.buf,
				group = highlight_augroup,
				callback = vim.lsp.buf.document_highlight,
			})

			vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
				buffer = event.buf,
				group = highlight_augroup,
				callback = vim.lsp.buf.clear_references,
			})

			vim.api.nvim_create_autocmd("LspDetach", {
				group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
				callback = function(event2)
					vim.lsp.buf.clear_references()
					vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
				end,
			})
		end

		if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
			map("<leader>th", function()
				vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
			end, "[T]oggle Inlay [H]ints")
		end
		--]]
	end,
}
--Random plugings mappings here.
Module.cmp = {
	insert = function()
		local cmp = require("cmp")
		local luasnip = require("luasnip")

		local check_backspace = function()
			local col = vim.fn.col(".") - 1
			return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
		end

		return cmp.mapping.preset.insert({
			["<Down>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
			["<Up>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
			["<C-j>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
			["<C-k>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
			["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
			["<C-e>"] = cmp.mapping({
				i = cmp.mapping.abort(),
				c = cmp.mapping.close(),
			}),
			["<CR>"] = cmp.mapping.confirm({ select = true }),
			["<Tab>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_next_item()
				elseif luasnip.expandable() then
					luasnip.expand()
				elseif luasnip.expand_or_jumpable() then
					luasnip.expand_or_jump()
				elseif check_backspace() then
					fallback()
				else
					fallback()
				end
			end, { "i", "s" }),

			["<S-Tab>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_prev_item()
				elseif luasnip.jumpable(-1) then
					luasnip.jump(-1)
				else
					fallback()
				end
			end, { "i", "s" }),
		})
	end,
}
--keymaps for oil.nvim
Module.oil = {
	config = function()
		map("<space>-", "<CMD>Oil<CR>", nil, "Open parent directory")
		map("-", require("oil").toggle_float)
	end,
}
return Module
