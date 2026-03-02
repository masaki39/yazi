hs.loadSpoon("SpoonInstall")

spoon.SpoonInstall:andUse("ReloadConfiguration", { start = true })

spoon.SpoonInstall:andUse("EjectMenu", {
	config = { never_eject = { "/Users/masaki/pCloud Drive" } },
	hotkeys = { ejectAll = { { "ctrl", "alt", "shift", "cmd" }, "e" } },
	start = true,
})

spoon.SpoonInstall:andUse("PopupTranslateSelection", {
	hotkeys = {
		translate_to_ja = { { "alt", "cmd", "shift", "ctrl" }, "t" },
	},
})

-- Ryoiki: window layout manager
spoon.SpoonInstall.repos.masaki39 = {
	url = "https://github.com/masaki39/ryoiki",
	desc = "masaki39's Hammerspoon Spoons",
	branch = "main",
}
spoon.SpoonInstall:andUse("Ryoiki", {
	repo = "masaki39",
	start = true,
	hotkeys = { showChooser = { { "ctrl", "alt" }, "space" } },
})

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
		appPrefixOverrides = {
			{
				match = { bundleID = "com.google.Chrome" },
				prefix = "C",
			},
		},
		focusBackKey = "tab",
		directionKeys = {
			left = "h",
			down = "j",
			up = "k",
			right = "l",
			upLeft = "y",
			upRight = "u",
			downLeft = "b",
			downRight = "n",
		},
		hotkeyModifiers = { "alt", "shift", "cmd", "ctrl" },
		hotkeyKey = "j",
		iconSize = 72,
		titleMaxSize = 72,
		centerCursor = true,
		onError = function(err)
			hs.alert.show("Window Hints error: " .. tostring(err), 3)
		end,
	},
	focus_back = {
		hotkeyModifiers = { "option", "shift", "cmd", "ctrl" },
		hotkeyKey = "tab",
		centerCursor = true,
		stateSync = {
			interval = 0.15,
			targetApps = { "com.mitchellh.ghostty" },
			historyScope = "application",
		},
	},
})

-- Auto-switch to English IME on app focus change
local _imeAppWatcher = hs.application.watcher.new(function(_, event, _)
	if event == hs.application.watcher.activated then
		local src = hs.keycodes.currentSourceID()
		if src and src:find("Japanese") then
			hs.keycodes.currentSourceID("com.apple.keylayout.ABC")
		end
	end
end)
_imeAppWatcher:start()
