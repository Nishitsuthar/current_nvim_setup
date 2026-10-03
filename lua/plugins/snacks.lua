return {

	-- modern ui
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,

		opts = {

			-- ADDED: Notifier configuration
			notifier = {
				enabled = true,
				timeout = 3000, -- How long notifications stay on screen (in ms)
			},

			-- ADDED: Lazygit configuration
			lazygit = {
				-- Leaving this empty uses the excellent default settings,
				-- but you can customize window size, themes, etc., here later.
			},

			scroll = {
				enabled = true,
				animate = {
					duration = { step = 15, total = 250 },
					easing = "linear",
				},
			},
			dashboard = {
				enabled = true,
                pane_gap = 4,
				sections = {
                    { padding = 7 },
					-- { section = "header", pane = 1, indent = 10 },
					{ section = "keys", gap = 1, padding = 1, pane = 1, indent = 10 },
					-- { section = "startup", pane = 1, indent = 10 },
					{
						section = "terminal",
						cmd = "ascii-image-converter ~/.config/pngwing.com.png -C -c",
						random = 10,
						pane = 2,
						indent = 0,
						height = 30,
					},
				},
			},
			explorer = {},
			picker = {
				-- notice: cwd = vim.fn.getcwd() is completely removed from here
				sources = {
					files = {
						hidden = true,
					},
                    explorer = {
						win = {
							input = {
								keys = {
									["<BS>"] = false, -- Disable Backspace going up a directory in input
								},
							},
							list = {
								keys = {
									["<BS>"] = false, -- Disable Backspace going up a directory in list
								},
							},
						},
					},
				},
			},
		},
		keys = {
			-- we put vim.fn.getcwd() inside the function() so it grabs the fresh directory
			-- from your set_root script at the exact moment you press the key
            -- Always opens explorer at the initial directory Neovim was started in
			{
				"<leader>e",
				function()
					Snacks.explorer({ cwd = vim.g.initial_cwd or vim.fn.getcwd() })
				end,
				desc = "file explorer",
			},	
			{
				"<leader>ff",
				function()
					Snacks.picker.files({ cwd = vim.fn.getcwd() })
				end,
				desc = "find files",
			},
			{
				"<leader>fg",
				function()
					Snacks.picker.grep({ cwd = vim.fn.getcwd() })
				end,
				desc = "grep search",
			},
			{
				"<leader>fs",
				function()
					Snacks.picker.lines()
				end,
				desc = "search in file",
			},
            {
				"<leader>fB",
				function()
					Snacks.picker.grep_buffers()
				end,
				desc = "grep open buffers",
			},
			{
				"<leader>fb",
				function()
					Snacks.picker.buffers()
				end,
				desc = "search in buffer",
			},
			-- ADDED: Lazygit keymap
			{
				"<leader>gg",
				function()
					Snacks.lazygit()
				end,
				desc = "Lazygit",
			},

			-- ADDED: Notifier keymaps
			{
				"<leader>un",
				function()
					Snacks.notifier.hide()
				end,
				desc = "Dismiss All Notifications",
			},
			{
				"<leader>nh",
				function()
					Snacks.notifier.show_history()
				end,
				desc = "Notification History",
			},
		},
	},
}
