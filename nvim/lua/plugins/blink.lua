return {
  "saghen/blink.cmp",
  opts = {
    enabled = function()
      return not vim.tbl_contains({ "markdown" }, vim.bo.filetype)
    end,
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
