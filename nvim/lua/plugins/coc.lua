return {
  {
    "neoclide/coc.nvim",
    branch = "release",
    event = { "BufReadPost", "BufNewFile" },
    init = function()
      vim.g.coc_global_extensions = { "coc-solargraph" }
    end,
    config = function()
      require("config.lsp")
    end,
  },
}
