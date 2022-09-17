require("util")

local mason_lsp = require("mason-lspconfig")
mason_lsp.setup()

local lspconfig = require("lspconfig")

local on_attach = function(client, bufnr)
    vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

    local bufopts = {
        noremap = true,
        silent = true,
        buffer = bufnr,
    }

    map("n", "gD", vim.lsp.buf.declaration, bufopts)
    map("n", "gd", vim.lsp.buf.definition, bufopts)
    map("n", "K", vim.lsp.buf.hover, bufopts)
    map("n", "gi", vim.lsp.buf.implementation, bufopts)
    map("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
    map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, bufopts)
    map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
    map("n", "<leader>wl", function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts)
    map("n", "<leader>D", vim.lsp.buf.type_definition, bufopts)
    map("n", "<leader>rn", vim.lsp.buf.rename, bufopts)
    map("n", "<leader>ca", vim.lsp.buf.code_action, bufopts)
    map("n", "gr", vim.lsp.buf.references, bufopts)
    map("n", "<leader>f", vim.lsp.buf.formatting, bufopts)
    map("n", "<leader>e", vim.diagnostic.open_float, bufopts)

    vim.opt.signcolumn = "yes"
end

vim.diagnostic.config {
    virtual_text = false,
}

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
        signs = true,
        update_in_insert = false,
        underline = true,
    }
)

local client_capabilities = vim.lsp.protocol.make_client_capabilities()
local capabilities = require("cmp_nvim_lsp").update_capabilities(client_capabilities)

mason_lsp.setup_handlers({
    function (server)
        lspconfig[server].setup {
            capabilities = capabilities,
            on_attach = on_attach,
        }
    end
})
