require("tokyonight").setup({
  style = "moon",
  transparent = true,
  styles = {
    comments = { italic = true },
    keywords = { italic = true },
  },
  lualine_bold = true,
})

vim.cmd[[colorscheme tokyonight]]

