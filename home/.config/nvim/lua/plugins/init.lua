local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.fn.system({"git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path})
    vim.cmd([[packadd packer.nvim]])
end

require("packer").startup({
    function (use)
        local function load_config(name)
            for _, re in ipairs({"^n?vim[-.]", "[-.]n?vim$", "[-.]lua$"}) do
                name = name:gsub(re, "")
            end
            require("plugins." .. name)
        end

        use {"wbthomason/packer.nvim"}

        -- Colorscheme:
        use {"sainnhe/gruvbox-material", config = load_config}

        -- Interface:
        use {"glepnir/dashboard-nvim", config = load_config}
        use {"akinsho/bufferline.nvim", requires = {"kyazdani42/nvim-web-devicons"}, config = load_config}
        use {"hoob3rt/lualine.nvim", requires = {"kyazdani42/nvim-web-devicons"}, config = load_config}

        -- Telescope:
        use {"nvim-telescope/telescope.nvim", requires = {"nvim-lua/popup.nvim", "nvim-lua/plenary.nvim"}, config = load_config}
        use {"rmagatti/session-lens", config = load_config}

        -- Sessions:
        use {"rmagatti/auto-session", config = load_config}

        -- Explorer:
        use {"kyazdani42/nvim-tree.lua", requires = {"kyazdani42/nvim-web-devicons"}, config = load_config}

        -- Treesitter:
        use {"nvim-treesitter/nvim-treesitter", config = load_config}
        use {"lewis6991/spellsitter.nvim", config = load_config}
        use {"romgrk/nvim-treesitter-context", config = load_config}

        -- Language server:
        use {"neovim/nvim-lspconfig", config = load_config}
        use {"williamboman/nvim-lsp-installer", config = load_config}
        use {"ray-x/lsp_signature.nvim", config = load_config}

        -- Completion:
        use {"hrsh7th/nvim-cmp", config = load_config}
        use {"hrsh7th/cmp-buffer"}
        use {"hrsh7th/cmp-nvim-lsp"}
        use {"hrsh7th/cmp-path"}
        use {"L3MON4D3/LuaSnip", config = load_config}
        use {"saadparwaiz1/cmp_luasnip"}
        use {"rafamadriz/friendly-snippets"}
        use {"windwp/nvim-autopairs", config = load_config}

        -- Navigation:
        use {"phaazon/hop.nvim", config = load_config}
        use {"karb94/neoscroll.nvim", config = load_config}
        use {"kshenoy/vim-signature"}

        -- Search:
        use {"haya14busa/vim-asterisk", config = load_config}
        use {"kevinhwang91/nvim-hlslens"}

        -- Clipboard:
        use {"enricobacis/paste.vim"}
        use {"tversteeg/registers.nvim", config = load_config}

        -- Editing:
        use {"numToStr/Comment.nvim", config = load_config}
        use {"tpope/vim-unimpaired", requires = {"tpope/vim-repeat"}}
        use {"tpope/vim-surround", requires = {"tpope/vim-repeat"}}
        use {"junegunn/vim-easy-align"}
        use {"PeterRincker/vim-argumentative"}

        -- Git:
        use {"lewis6991/gitsigns.nvim", requires = {"nvim-lua/plenary.nvim"}, config = load_config}

        -- Whitespace:
        use {"axelf4/vim-strip-trailing-whitespace"}
        use {"lukas-reineke/indent-blankline.nvim", config = load_config}

        -- Terminal:
        use {"christoomey/vim-tmux-navigator", config = load_config}
        use {"numtostr/FTerm.nvim"}

        -- Firenvim:
        use {"glacambre/firenvim", config = load_config, run = function ()
            vim.fn["firenvim#install"](0)
        end}
    end,
    config = {
        display = {
            open_fn = require("packer.util").float,
        },
    },
})
