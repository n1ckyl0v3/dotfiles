require("bufferline").setup({
	options = {
		mode = "buffers",
		-- separator_style = "slant",
		themable = true,
		show_buffer_close_icons = false,
		diagnostics = "nvim_lsp",
		diagnostics_indicator = function(count, level, diagnostics_dict, context)
			local icon = level:match("error") and " " or ""
			return " " .. icon
		end,
		indicator = {
			style = "icon",
		},
		modified_icon = "●",
		close_icon = "",
		left_trunc_marker = "",
		right_trunc_marker = "",
		tab_size = 20,
		diagnostics_update_in_insert = true,
		-- icon = "▎", -- this should be omitted if indicator style is not 'icon'
	},
	highlights = {
		buffer_selected = {
			fg = "#c0e4eb",
			bold = true,
		},
		warning = {
			fg = "#d9ca00",
			sp = "#d9ca00",
			bg = "#27283d",
		},
		warning_visible = {
			fg = "#d9ca00",
			bg = "#27283d",
		},
		warning_selected = {
			fg = "#d9ca00",
			sp = "#d9ca00",
			bold = true,
			italic = true,
		},
		warning_diagnostic = {
			fg = "#d9ca00",
			sp = "#d9ca00",
			bg = "#27283d",
		},
		warning_diagnostic_visible = {
			fg = "#d9ca00",
			bg = "#27283d",
		},
		warning_diagnostic_selected = {
			fg = "#d9ca00",
			bold = true,
			italic = true,
		},
		error = {
			fg = "#cf1114",
			bg = "#27283d",
			sp = "#cf1114",
		},
		error_visible = {
			fg = "#cf1114",
			bg = "#27283d",
		},
		error_selected = {
			fg = "#cf1114",
			sp = "#cf1114",
			bold = true,
			italic = true,
		},
		error_diagnostic = {
			fg = "#cf1114",
			bg = "#27283d",
			sp = "#cf1114",
		},
		error_diagnostic_visible = {
			fg = "#cf1114",
			bg = "#27283d",
		},
		error_diagnostic_selected = {
			fg = "#cf1114",
			sp = "#cf1114",
			bold = true,
			italic = true,
		},
		hint = {
			bg = "#27283d",
		},
		hint_diagnostic = {
			bg = "#27283d",
		},
		info = {
			bg = "#27283d",
		},
		info_visible = {
			bg = "#27283d",
		},
		info_diagnostic = {
			bg = "#27283d",
		},
		info_diagnostic_visible = {
			bg = "#27283d",
		},

		background = {
			bg = "#27283d",
			fg = "#6d6e78",
		},
		fill = {
			bg = "#27283d",
		},
		separator = {
			bg = "#27283d",
		},
		separator_selected = {
			fg = "#3640f5",
			bg = "#3640f5",
		},
		indicator_selected = {
			fg = "#3366d6",
			-- bg = "#3640f5",
		},
	},
})
