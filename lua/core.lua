function map(mode, keybind, action)
    vim.api.nvim_set_keymap(mode, keybind, action, { noremap = true })
end

function set_leader(leader)
    vim.g.mapleader = leader
    map("n", leader, "<nop>") -- Make sure leader isn't bound elsewhere
end

function set_colorscheme(scheme)
    vim.cmd("colorscheme " .. scheme)
end

function packer_bootstrap(usages)
    local fn = vim.fn
    local install_path = fn.stdpath("data").."/site/pack/packer/start/packer.nvim"
    if fn.empty(fn.glob(install_path)) > 0 then
        first_boot = fn.system({"git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path})
    end

    return require("packer").startup(function(use)
        usages(use)

        if first_boot then
            require("packer").sync()
        end
    end)
end

function configure_lsp_windows(border)
    local win = require("lspconfig.ui.windows")
    local _default_opts = win.default_opts

    win.default_opts = function(options)
      local opts = _default_opts(options)
      opts.border = border 
      return opts
    end

    local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
    function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
      opts = opts or {}
      opts.border = opts.border or border
      return orig_util_open_floating_preview(contents, syntax, opts, ...)
    end
end

function configure_lsp_signs(signs)
    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
    end
end

function remove_excess_text()
    vim.cmd("let &fcs='eob: '") -- Hides ~ on empty lines
    vim.o.shortmess       = "I" -- Hides welcome text
end

function set_tab_width(width, use_spaces)
    vim.o.tabstop     = width
    vim.o.expandtab   = use_spaces
    vim.o.softtabstop = -1
    vim.o.shiftwidth  = 0
end
