hs.loadSpoon("ReloadConfiguration")
spoon.ReloadConfiguration:start()

local jinrai = dofile("/Users/masaki/ghq/github.com/tadashi-aikawa/jinrai/init.lua")

jinrai.setup({
	focus_border = {
		borderWidth = 10,
		borderColor = { red = 0.40, green = 0.68, blue = 0.98, alpha = 0.95 },
		outlineWidth = 2,
		outlineColor = { red = 0, green = 0, blue = 0, alpha = 0.70 },
		duration = 0.5,
		fadeSteps = 18,
		cornerRadius = 10,
		minWindowSize = 480,
	},
	window_hints = {
		hintChars = {
			"A",
			"S",
			"D",
			"F",
			"G",
			"H",
			"J",
			"K",
			"L",
			"Q",
			"W",
			"E",
			"R",
			"T",
			"Y",
			"U",
			"I",
			"O",
			"P",
			"Z",
			"X",
			"C",
			"V",
			"B",
			"N",
			"M",
		},
		hotkeyModifiers = { "alt" },
		hotkeyKey = "tab",
		iconSize = 72,
		titleMaxSize = 72,
		centerCursor = true,
		onError = function(err)
			hs.alert.show("Window Hints error: " .. tostring(err), 3)
		end,
	},
	focus_back = {
		hotkeyModifiers = { "alt" },
		hotkeyKey = "w",
		centerCursor = true,
	},
})
