return {
  {
    "nvim-treesitter/nvim-treesitter",
    -- Pin to the last release before the 2025 core rewrite (which dropped
    -- `nvim-treesitter.configs`/`TSUpdate` in favor of a new setup/`:TSInstall`).
    tag = "v0.9.3",
    build = ":TSUpdate",
    opts = {
      ensure_installed = { "markdown", "markdown_inline" },
      highlight = { enable = true },
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
}
