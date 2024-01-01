vim.cmd([[
set nocompatible
set termguicolors
]])

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
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
      -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
    },
    config = function()
      vim.cmd("nnoremap B <cmd>Neotree toggle<CR>")
    end
  },
  {
    "willothy/nvim-cokeline",
    dependencies = {
      "nvim-lua/plenary.nvim",        -- Required for v0.4.0+
      "kyazdani42/nvim-web-devicons", -- If you want devicons
      "stevearc/resession.nvim"       -- Optional, for persistent history
    },
    config = true
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      -- add any options here
    },
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      "rcarriga/nvim-notify",
    }
  },
  {
    'voldikss/vim-floaterm',
    config = function()
      vim.cmd([[
        if has('win64') || has('win32')
          let &shell = executable('pwsh') ? 'pwsh' : 'powershell'
          let &shellcmdflag = '-NoLogo -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new();$PSDefaultParameterValues[''Out-File:Encoding'']=''utf8'';'
          let &shellredir = '2>&1 | %%{ "$_" } | Out-File %s; exit $LastExitCode'
          let &shellpipe  = '2>&1 | %%{ "$_" } | Tee-Object %s; exit $LastExitCode'
          set shellquote= shellxquote=

          let g:floaterm_shell='powershell'
        endif

        tnoremap <Esc> <C-\><C-n>
        nmap º :FloatermToggle<CR>
      ]])
    end
  },
  { "alec-gibson/nvim-tetris" }
}

local opts = {}

require("lazy").setup(plugins, opts)

-- Set two spaces indentation
vim.cmd([[
set expandtab
set tabstop=2
set shiftwidth=2
set autoindent
]])
