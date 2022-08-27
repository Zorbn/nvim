local fn = vim.fn
local install_path = fn.stdpath("data").."/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    packer_bootstrap = fn.system({"git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path})
end

return require("packer").startup(function(use)
    use "wbthomason/packer.nvim"

    use {
        "ellisonleao/gruvbox.nvim",
        config = function()
            require("gruvbox").setup({
                contrast = "",
            })

            vim.cmd("colorscheme gruvbox")
        end
    }

    use {
        "nvim-treesitter/nvim-treesitter", run = ":TSUpdate", config = function()
            require("nvim-treesitter.configs").setup {
                ensure_installed = {
                    "c", "lua", "javascript",
                    "typescript", "c_sharp",
                    "go", "rust", "java",
                    "kotlin", "python", "cpp",
                },
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false,
                }
            }
        end
    }

    use {
        {
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-nvim-lsp",
        },
        {
            "hrsh7th/nvim-cmp",
            config = "require('config.cmp')",
        },
    }

    use {
        {
            "williamboman/mason.nvim",
            after = "nvim-cmp",
            config = "require('config.mason')",
        },
        {
            "neovim/nvim-lspconfig",
            requires = {
                "williamboman/mason-lspconfig.nvim"
            },
            after = "mason.nvim",
            config = "require('config.lsp')",
        },
        {
            "mfussenegger/nvim-dap",
            config = "require('config.dap')",
        },
        {
            "mfussenegger/nvim-lint",
            config = "require('config.lint')",
        },
        {
            "mhartington/formatter.nvim",
            config = "require('config.fmt')",
        },
    }

    if packer_bootstrap then
        require("packer").sync()
    end
end)
