require("util")

map("n", "<leader>dc", "<cmd>lua require('dap').continue()<cr>",          { noremap = true })
map("n", "<leader>do", "<cmd>lua require('dap').step_over()<cr>",         { noremap = true })
map("n", "<leader>di", "<cmd>lua require('dap').step_into()<cr>",         { noremap = true })
map("n", "<leader>dO", "<cmd>lua require('dap').step_out()<cr>",          { noremap = true })
map("n", "<leader>db", "<cmd>lua require('dap').toggle_breakpoint()<cr>", { noremap = true })
map("n", "<leader>dr", "<cmd>lua require('dap').repl.open()<cr>",         { noremap = true })

local dap = require("dap")

dap.adapters.coreclr = {
    type = "executable",
    command = vim.fn.stdpath("data") .. "/mason/packages/netcoredbg/netcoredbg/netcoredbg",
    args = {"--interpreter=vscode"}
}

dap.configurations.cs = {
    {
        type = "coreclr",
        name = "launch - netcoredbg",
        request = "launch",
        program = function()
            return vim.fn.input("Path to dll: ", vim.fn.getcwd() .. "/bin/Debug/", "file")
        end,
    },
}
