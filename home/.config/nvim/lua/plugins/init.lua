local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.fn.system({"git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path})
    vim.cmd([[packadd packer.nvim]])
end

require("plugins.gruvbox")

require("packer").startup({
    function(use)
        use {"wbthomason/packer.nvim"}

        use {"tpope/vim-unimpaired"}

        use {
            "ellisonleao/gruvbox.nvim",
            requires = {"rktjmp/lush.nvim"},
        }

        use {
            "christoomey/vim-tmux-navigator",
            config = function() pcall(require, "plugins.vim-tmux-navigator") end,
        }

        use {
            "akinsho/bufferline.nvim",
            requires = {"kyazdani42/nvim-web-devicons"},
            config = function() pcall(require, "plugins.bufferline") end,
        }

        use {
            "ojroques/nvim-bufdel",
            config = function() pcall(require, "plugins.bufdel") end,
        }

        use {
            "hoob3rt/lualine.nvim",
            requires = {"kyazdani42/nvim-web-devicons"},
            config = function() pcall(require, "plugins.lualine") end,
        }

        use {
            "nvim-telescope/telescope.nvim",
            requires = {"nvim-lua/popup.nvim", "nvim-lua/plenary.nvim"},
            config = function() pcall(require, "plugins.telescope") end,
        }

        use {
            "nvim-telescope/telescope-project.nvim",
            config = function() pcall(require, "plugins.telescope-project") end,
        }

        use {
            "kyazdani42/nvim-tree.lua",
            requires = {"kyazdani42/nvim-web-devicons"},
            config = function() pcall(require, "plugins.nvim-tree") end,
        }

        use {
            "numtostr/FTerm.nvim",
            config = function() pcall(require, "plugins.fterm") end,
        }

        use {
            "lewis6991/gitsigns.nvim",
            requires = {"nvim-lua/plenary.nvim"},
            config = function() pcall(require, "plugins.gitsigns") end,
        }

        use {
            "lukas-reineke/indent-blankline.nvim",
            config = function() pcall(require, "plugins.indent_blankline") end,
        }

        use {
            "terrortylor/nvim-comment",
            config = function() pcall(require, "plugins.nvim_comment") end,
        }

        use {
            "kevinhwang91/nvim-hlslens",
            config = function() pcall(require, "plugins.hlslens") end,
        }

        use {
            "phaazon/hop.nvim",
            config = function() pcall(require, "plugins.hop") end,
        }

        use {
            "karb94/neoscroll.nvim",
            config = function() pcall(require, "plugins.neoscroll") end,
        }

        use {"enricobacis/paste.vim"}

        use {"tversteeg/registers.nvim"}

        use {"kshenoy/vim-signature"}

        use {"axelf4/vim-strip-trailing-whitespace"}

        use {
            "junegunn/vim-easy-align",
            config = function() pcall(require, "plugins.vim-easy-align") end,
        }

        use {
            "neovim/nvim-lspconfig",
            config = function() pcall(require, "plugins.lspconfig") end,
        }

        use {
            "williamboman/nvim-lsp-installer",
            config = function() pcall(require, "plugins.nvim-lsp-installer") end,
        }

        use {
            "hrsh7th/nvim-cmp",
            config = function() pcall(require, "plugins.cmp") end,
        }

        use {"hrsh7th/cmp-nvim-lsp"}

        use {"hrsh7th/vim-vsnip"}
    end,
    config = {
        display = {
            open_fn = require("packer.util").float,
        },
    },
})