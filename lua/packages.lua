require("core")

packer_bootstrap(function(use)
    use "wbthomason/packer.nvim"
    
    ---- Completion
    use {
        "ms-jpq/coq_nvim",
        branch = "coq",
        requires = {
            { "ms-jpq/coq.thirdparty", branch = "3p"        },
            { "ms-jpq/coq.artifacts",  branch = "artifacts" },
        },
        config = function()
            vim.g.coq_settings = {
                ["auto_start"] = "shut-up",
                ["display.pum.fast_close"] = false,
            }
        end
    }

    use {
        "windwp/nvim-autopairs",
        config = function()
            require("nvim-autopairs").setup{}
        end
    }

    ---- LSP
    use {
        "williamboman/nvim-lsp-installer",
        requires = { "neovim/nvim-lspconfig" },
        after = "coq_nvim",
        config = function()
            map("n", "<leader>ld", "<cmd>lua vim.lsp.buf.definition()                   <cr>")
            map("n", "<leader>li", "<cmd>lua vim.lsp.buf.implementation()               <cr>")
            map("n", "<leader>lR", "<cmd>lua vim.lsp.buf.references()                   <cr>")
            map("n", "<leader>lD", "<cmd>lua vim.lsp.buf.declaration()                  <cr>")
            map("n", "<leader>lf", "<cmd>lua vim.lsp.buf.formatting()                   <cr>")
            map("n", "<leader>lr", "<cmd>lua vim.lsp.buf.rename()                       <cr>")
            map("n", "<leader>la", "<cmd>lua vim.lsp.buf.code_action()                  <cr>")
            map("n", "<leader>ls", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics() <cr>")
            map("n", "K",          "<cmd>lua vim.lsp.buf.hover()                        <cr>")

            require("nvim-lsp-installer").settings({
                ui = {
                    icons = {
                        server_installed   = "",
                        server_pending     = "",
                        server_uninstalled = "",
                    }
                }
            })

            local lsp_installer = require("nvim-lsp-installer")
            local client_capabilities = vim.lsp.protocol.make_client_capabilities()
            local capabilities = require("coq").lsp_ensure_capabilities(client_capabilities)
            local opts = { capabilities = capabilities }

            lsp_installer.on_server_ready(function (server)
                server:setup(opts)
            end) 

            -- Disable in-line errors
            vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
                vim.lsp.diagnostic.on_publish_diagnostics, {
                    virtual_text = false
                }
            )
        end
    }

    ---- Navigation
    use {
        "kyazdani42/nvim-tree.lua",
        requires = { "kyazdani42/nvim-web-devicons" },
        config = function()
            map("n", "<leader>tt", "<cmd>NvimTreeToggle   <cr>")
            map("n", "<leader>tr", "<cmd>NvimTreeRefresh  <cr>")
            map("n", "<leader>tf", "<cmd>NvimTreeFindFile <cr>")

            require("nvim-tree").setup {
                disable_netrw = true,
                update_cwd = true,
                view = {
                    preserve_window_proportions = true,
                },
                actions = {
                    open_file = {
                        resize_window = true,
                    },
                },
            }
        end
    }

    use {
        "nvim-telescope/telescope-file-browser.nvim",
        requires = {
            { "nvim-lua/plenary.nvim" },
            { "nvim-telescope/telescope.nvim" }
        },
        config = function()
            map("n", "<leader>fs", "<cmd>lua require('telescope.builtin').find_files(require('telescope.themes').minimal_theme())                   <cr>")
            map("n", "<leader>fb", "<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').minimal_theme())                      <cr>")
            map("n", "<leader>ff", "<cmd>lua require('telescope').extensions.file_browser.file_browser(require('telescope.themes').minimal_theme()) <cr>")

            local telescope = require("telescope")
            require("telescope.themes").minimal_theme = function()
                return require('telescope.themes').get_ivy({
                    borderchars = {
                        prompt  = { "─", " ", " ", " ", '─', '─', " ", " "  },
                        results = { " ",                                    },
                        preview = { '─', '│', '─', '│', '┌', '┐', '┘', '└'  },
                    },
                    layout_config = { height = 15 },
                    width         = 0.8,
                    previewer     = false,
                    prompt_title  = false,
                    results_title = false,
                })
            end

            telescope.setup {
                pickers = {
                    buffers = {
                        mappings = {
                            -- Enable buffer deletion
                            i = { ["<c-d>"] = "delete_buffer" },
                            n = { ["dd"] = "delete_buffer"    },
                        },
                    },
                },
            }

            telescope.load_extension "file_browser"
        end
    }

    -- Decor
    use {
        "nvim-lualine/lualine.nvim",
        requires = { "kyazdani42/nvim-web-devicons", opt = true },
        config = function()
            require("lualine").setup {
                options = {
                    theme = "auto",
                    component_separators = { left = "", right = "" },
                    section_separators   = { left = "", right = "" },
                    globalstatus = true,
                },
            }
        end
    }

    use "Th3Whit3Wolf/one-nvim"
end)
