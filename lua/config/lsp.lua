local mason_lsp = require("mason-lspconfig")
mason_lsp.setup()

local lspconfig = require("lspconfig")
local client_capabilities = vim.lsp.protocol.make_client_capabilities()
local coq = require("coq")

mason_lsp.setup_handlers({
    function(server)
        lspconfig[server].setup(coq.lsp_ensure_capabilities(client_capabilities))
    end
})
