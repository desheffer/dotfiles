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
            config = [[pcall(require, "plugins.vim-tmux-navigator")]],
        }

        use {
            "akinsho/bufferline.nvim",
            requires = {"kyazdani42/nvim-web-devicons"},
            config = [[pcall(require, "plugins.bufferline")]],
        }

        use {
            "ojroques/nvim-bufdel",
            config = [[pcall(require, "plugins.bufdel")]],
        }

        use {
            "hoob3rt/lualine.nvim",
            requires = {"kyazdani42/nvim-web-devicons"},
            config = [[pcall(require, "plugins.lualine")]],
        }

        use {
            "nvim-telescope/telescope.nvim",
            requires = {"nvim-lua/popup.nvim", "nvim-lua/plenary.nvim"},
            config = [[pcall(require, "plugins.telescope")]],
        }

        use {
            "nvim-telescope/telescope-project.nvim",
            config = [[pcall(require, "plugins.telescope-project")]],
        }

        use {
            "kyazdani42/nvim-tree.lua",
            requires = {"kyazdani42/nvim-web-devicons"},
            config = [[pcall(require, "plugins.nvim-tree")]],
        }

        use {
            "numtostr/FTerm.nvim",
            config = [[pcall(require, "plugins.fterm")]],
        }

        use {
            "lewis6991/gitsigns.nvim",
            requires = {"nvim-lua/plenary.nvim"},
            config = [[pcall(require, "plugins.gitsigns")]],
        }

        use {
            "lukas-reineke/indent-blankline.nvim",
            config = [[pcall(require, "plugins.indent_blankline")]],
        }

        use {
            "terrortylor/nvim-comment",
            config = [[pcall(require, "plugins.nvim_comment")]],
        }

        use {
            "kevinhwang91/nvim-hlslens",
            config = [[pcall(require, "plugins.hlslens")]],
        }

        use {
            "phaazon/hop.nvim",
            config = [[pcall(require, "plugins.hop")]],
        }

        use {
            "karb94/neoscroll.nvim",
            config = [[pcall(require, "plugins.neoscroll")]],
        }

        use {"enricobacis/paste.vim"}

        use {"tversteeg/registers.nvim"}

        use {"kshenoy/vim-signature"}

        use {"axelf4/vim-strip-trailing-whitespace"}

        use {
            "junegunn/vim-easy-align",
            config = [[pcall(require, "plugins.vim-easy-align")]],
        }

        use {
            "neovim/nvim-lspconfig",
            config = [[pcall(require, "plugins.lspconfig")]],
        }

        use {
            "williamboman/nvim-lsp-installer",
            config = [[pcall(require, "plugins.nvim-lsp-installer")]],
        }

        use {
            "hrsh7th/nvim-cmp",
            config = [[pcall(require, "plugins.cmp")]],
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
