local mason_lsp = require("mason-lspconfig")
mason_lsp.setup()

local lspconfig = require("lspconfig")
local client_capabilities = vim.lsp.protocol.make_client_capabilities()
local capabilities = require("cmp_nvim_lsp").update_capabilities(client_capabilities)

mason_lsp.setup_handlers({
    function (server)
        lspconfig[server].setup {
            capabilities = capabilities,
        }
    end
})
