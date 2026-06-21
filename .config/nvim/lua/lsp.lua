require("mason").setup()

vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = "Go to definition" })
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, { desc = "Format Local buffer" })
vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { desc = "Show line diagnostics" })
vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration" })                           -- go to declaration
vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Show LSP definitions" })                         -- show lsp definitions
vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "See available code actions" }) -- see available code actions, in visual mode will apply to selection
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Smart rename" })                             -- smart rename
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic" })                  -- jump to previous diagnostic in buffer
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic" })                      -- jump to next diagnostic in buffer
vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Show documentation for what is under cursor" })        -- show documentation for what is under cursor

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = vim.tbl_deep_extend("force", capabilities, require("mini.completion").get_lsp_capabilities())

vim.lsp.config("*", { capabilities = capabilities })

vim.lsp.config("lua_ls", {
    settings = {
        Lua = {
            diagnostics = { globals = { "vim" } },
        },
    },
})

vim.lsp.enable({
    "lua_ls",
    "gopls",
    "rust_analyzer",
    "clangd",
    "jdtls",
    "ts_ls",
    "svelte",
    "bashls",
    "cssls",
    "jsonls",
    "html",
    "tailwindcss",
    "marksman",
})

vim.lsp.config("gopls", {
    capabilities = {
        workspace = {
            didChangeWatchedFiles = {
                dynamicRegistration = true,
            },
            workspaceFolders = true,
        },
    },
    settings = {
        gopls = {
            completeUnimported = true,
            usePlaceholders = true,
            analyses = {
                unusedparams = true,
            },
        },
    },
})

vim.lsp.config("rust_analyzer", {
    settings = {
        ["rust-analyzer"] = {
            check = {
                command = "clippy",
                extraArgs = { "--tests" },
                features = "all",
            },
        },
    },
})

vim.diagnostic.config({
    underline = true,
    virtual_text = true,
    update_in_insert = true,
    severity_sort = true,

    float = {
        severity_sort = true,
        header = "Diagnostics",
        source = "if_many",
        prefix = "• ",
        -- border = "single",
    },
})
