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
        "ms-jpq/coq_nvim",
        branch = "coq",
    }

    use {
        "ms-jpq/coq.artifacts",
        branch = "artifacts",
    }

    use {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "neovim/nvim-lspconfig",
    }

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap then
        require("packer").sync()
    end
end)
