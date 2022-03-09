local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.fn.system({"git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path})
    vim.cmd([[packadd packer.nvim]])
end

require("packer").startup({
    function (use)
        -- Load configuration hooks based on the name of the plugin.
        local function load_config(name)
            for _, re in ipairs({"^n?vim[-.]", "[-.]n?vim$", "[-.]lua$"}) do
                name = name:gsub(re, "")
            end
            require("plugins." .. name)
        end

        -- Load commit hashes from the lock file (lock.lua) to maximize plugin
        -- stability. To force an upgrade, clear out the lock file.
        local function use_lock(...)
            local spec = ...
            local short_name = spec["as"] or spec[1]:gsub("^.*/", "")
            local _, lock = pcall(require, "plugins.lock")
            if type(lock) == "table" then
                spec["commit"] = lock[short_name]
            end
            use(spec)
        end

        use_lock {"wbthomason/packer.nvim"}

        -- Colorscheme:
        use_lock {"sainnhe/gruvbox-material", config = load_config}

        -- Interface:
        use_lock {"glepnir/dashboard-nvim", config = load_config}
        use_lock {"akinsho/bufferline.nvim", requires = {"kyazdani42/nvim-web-devicons"}, config = load_config}
        use_lock {"hoob3rt/lualine.nvim", requires = {"kyazdani42/nvim-web-devicons"}, config = load_config}

        -- Telescope:
        use_lock {"nvim-telescope/telescope.nvim", requires = {"nvim-lua/popup.nvim", "nvim-lua/plenary.nvim"}, config = load_config}
        use_lock {"rmagatti/session-lens", config = load_config}

        -- Sessions:
        use_lock {"rmagatti/auto-session", config = load_config}

        -- Explorer:
        use_lock {"kyazdani42/nvim-tree.lua", requires = {"kyazdani42/nvim-web-devicons"}, config = load_config}

        -- Treesitter:
        use_lock {"nvim-treesitter/nvim-treesitter", config = load_config}
        use_lock {"lewis6991/spellsitter.nvim", config = load_config}
        use_lock {"romgrk/nvim-treesitter-context", config = load_config}

        -- Language server:
        use_lock {"neovim/nvim-lspconfig", config = load_config}
        use_lock {"williamboman/nvim-lsp-installer", config = load_config}
        use_lock {"ray-x/lsp_signature.nvim", config = load_config}

        -- Completion:
        use_lock {"hrsh7th/nvim-cmp", config = load_config}
        use_lock {"hrsh7th/cmp-buffer"}
        use_lock {"hrsh7th/cmp-nvim-lsp"}
        use_lock {"L3MON4D3/LuaSnip", config = load_config}
        use_lock {"saadparwaiz1/cmp_luasnip"}
        use_lock {"rafamadriz/friendly-snippets"}
        use_lock {"windwp/nvim-autopairs", config = load_config}

        -- Navigation:
        use_lock {"phaazon/hop.nvim", config = load_config}
        use_lock {"karb94/neoscroll.nvim", config = load_config}
        use_lock {"kshenoy/vim-signature"}

        -- Search:
        use_lock {"haya14busa/vim-asterisk", config = load_config}
        use_lock {"kevinhwang91/nvim-hlslens"}

        -- Clipboard:
        use_lock {"enricobacis/paste.vim"}
        use_lock {"tversteeg/registers.nvim", config = load_config}

        -- Editing:
        use_lock {"numToStr/Comment.nvim", config = load_config}
        use_lock {"tpope/vim-unimpaired", requires = {"tpope/vim-repeat"}}
        use_lock {"tpope/vim-surround", requires = {"tpope/vim-repeat"}}
        use_lock {"junegunn/vim-easy-align"}
        use_lock {"PeterRincker/vim-argumentative"}

        -- Git:
        use_lock {"lewis6991/gitsigns.nvim", requires = {"nvim-lua/plenary.nvim"}, config = load_config}

        -- Whitespace:
        use_lock {"axelf4/vim-strip-trailing-whitespace"}
        use_lock {"lukas-reineke/indent-blankline.nvim", config = load_config}

        -- Terminal:
        use_lock {"christoomey/vim-tmux-navigator", config = load_config}
        use_lock {"numtostr/FTerm.nvim"}

        -- Firenvim:
        use_lock {"glacambre/firenvim", config = load_config, run = function ()
            vim.fn["firenvim#install"](0)
        end}

        -- Dependencies (to install using lock file):
        use_lock {"kyazdani42/nvim-web-devicons"}
        use_lock {"nvim-lua/plenary.nvim"}
        use_lock {"nvim-lua/popup.nvim"}
        use_lock {"tpope/vim-repeat"}
    end,
    config = {
        display = {
            open_fn = require("packer.util").float,
        },
    },
})
