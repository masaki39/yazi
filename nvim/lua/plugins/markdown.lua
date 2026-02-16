return {
  -- render-markdown.nvim を無効化（インラインレンダリング不要）
  {
    "MeanderingProgrammer/render-markdown.nvim",
    enabled = false,
  },

  -- markdownlint を無効化（警告不要）
  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = {
      linters_by_ft = {
        markdown = {},
      },
    },
  },
}
