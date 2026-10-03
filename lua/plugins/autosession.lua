return {
	{
		"rmagatti/auto-session",
		opts = {
			auto_session_enable_last_session = false,
			auto_restore_enabled = false, -- THIS IS THE MAGIC LINE
			auto_save_enabled = true, -- Keep this true so it still saves!
		},
	},
}
