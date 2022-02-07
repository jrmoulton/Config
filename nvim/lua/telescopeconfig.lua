	require('telescope').setup{
		defaults = {
            file_ignore_patterns = {".gitignore"},
			mappings = {
				i = {
					["<C-k>"] = "close",
				},
				n = {
					["<C-k>"] = "close",
				},
			}
		},
	}

