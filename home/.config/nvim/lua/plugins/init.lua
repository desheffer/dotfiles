local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.fn.system({"git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path})
    vim.cmd "packadd packer.nvim"
end

require("packer").startup({function()
    use {"wbthomason/packer.nvim"}

    use {"tpope/vim-unimpaired"}

    use {
        "ellisonleao/gruvbox.nvim",
        requires = {"rktjmp/lush.nvim"},
        config = function() require("plugins.gruvbox") end,
    }

    use {
        "akinsho/bufferline.nvim",
        requires = {"kyazdani42/nvim-web-devicons"},
        config = function() require("plugins.bufferline") end,
    }

    use {
        "ojroques/nvim-bufdel",
        config = function() require("plugins.bufdel") end,
    }

    use {
        "hoob3rt/lualine.nvim",
        requires = {"kyazdani42/nvim-web-devicons"},
        config = function() require("plugins.lualine") end,
    }

    use {
        "nvim-telescope/telescope.nvim",
        requires = {"nvim-lua/popup.nvim", "nvim-lua/plenary.nvim"},
        config = function() require("plugins.telescope") end,
    }

    use {
        "kyazdani42/nvim-tree.lua",
        requires = "kyazdani42/nvim-web-devicons",
        config = function() require("plugins.nvim-tree") end,
    }

    use {
        "lewis6991/gitsigns.nvim",
        requires = {"nvim-lua/plenary.nvim"},
        config = function() require("plugins.gitsigns") end,
    }

    use {"lukas-reineke/indent-blankline.nvim"}

    use {
        "terrortylor/nvim-comment",
        config = function() require("plugins.nvim_comment") end,
    }

    use {"easymotion/vim-easymotion"}

    use {
        "karb94/neoscroll.nvim",
        config = function() require("plugins.neoscroll") end,
    }

    use {"enricobacis/paste.vim"}
end,
config = {
    display = {
        open_fn = require('packer.util').float,
    },
}})
