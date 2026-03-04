return {
  "saghen/blink.cmp",
  opts = {
    keymap = {
      ["<Tab>"] = { "select_and_accept", "fallback" },
      ["<CR>"] = { "fallback" },
    },
    completion = {
      list = {
        selection = {
          auto_insert = false,
        },
      },
    },
  },
}
