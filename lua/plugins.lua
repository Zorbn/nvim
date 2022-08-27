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
        "ms-jpq/coq.artifacts",
        branch = "artifacts",
    }

    use {
        "ms-jpq/coq_nvim",
        branch = "coq",
        requires = "coq.artifacts",
        config = [[require("config.cmp")]],
    }

    use {
        {
            "williamboman/mason.nvim",
            config = [[require("config.mason")]],
        },
        {
            "williamboman/mason-lspconfig.nvim",
            "neovim/nvim-lspconfig",
            after = { "mason", "coq_nvim" },
            config = [[require("config.lsp")]],
        },
        {
            "mfussenegger/nvim-dap",
            config = [[require("config.dap")]],
        },
        {
            "mfussenegger/nvim-lint",
            config = [[require("config.lint")]],
        },
    }

    if packer_bootstrap then
        require("packer").sync()
    end
end)
