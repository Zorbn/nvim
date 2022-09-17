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
