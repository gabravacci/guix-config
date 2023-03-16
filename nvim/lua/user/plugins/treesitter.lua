-- import nvim-treesitter plugin safely
local status, treesitter = pcall(require, "nvim-treesitter.configs")
if not status then
  return
end

-- require to compile parsers (for c, cpp and python)
-- require 'nvim-treesitter.install'.compilers = { 'clang++' }

-- configure treesitter
treesitter.setup({
  -- enable syntax highlighting
  highlight = {
    enable = true,
    -- additional_vim_regex_highlighting = { "latex" },
    disable = { "nix", "latex" }
  },
  -- enable indentation
  indent = { enable = true },
  -- enable autotagging (w/ nvim-ts-autotag plugin)
  autotag = { enable = true },
  -- ensure these language parsers are installed
  ensure_installed = {
    "bash",
    "c",
    "cpp",
    "elixir",
    "go",
    "json",
    "lua",
    "python",
    "rust",
  },
  -- auto install above language parsers
  auto_install = true,
})
