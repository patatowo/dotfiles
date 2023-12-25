local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
  {
    "cocopon/iceberg.vim",
    config = function()
      vim.cmd("colorscheme iceberg")
    end
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      --require 'nvim-treesitter.install'.compilers = {"clang"} -- Must use llvm `scoop install llvm` https://github.com/nvim-treesitter/nvim-treesitter/issues/1897

      require 'nvim-treesitter.configs'.setup {
        ensure_installed = {
          "c",
          "lua",
          "vim",
          "vimdoc",
          "query",
          "javascript",
          "typescript",
          "vue",
          "java",
          "php",
          "html",
          "css",
          "scss",
          "json",
          "yaml",
          "toml",
          "bash",
          "python",
          "rust",
          "dockerfile",
          "latex",
        },

        auto_install = true,

        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
          disable = {
            "latex", -- Vimtex already does this
          },
        },
      }
    end
  },
  {
    "neoclide/coc.nvim",
    branch = "release",
    config = function()
      vim.g["coc_global_extensions"] = {
        "coc-sumneko-lua",
        "coc-json"
      }

      vim.cmd([[
	    	inoremap <silent><expr> <tab> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<TAB>"
		inoremap <silent><expr> <cr> "\<c-g>u\<CR>"
		nnoremap <silent> K :call ShowDocumentation()<CR>
	    ]])
    end
  }
}

local opts = {}

require("lazy").setup(plugins, opts)

vim.cmd([[
set expandtab
set tabstop=2
set shiftwidth=2
set autoindent
]])
