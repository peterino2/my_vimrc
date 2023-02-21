local servers = {'zls'}

vim.g.coq_settings = { auto_start='shut-up', keymap = {
    jump_to_mark = "<c-n>"
} }

local coq = require "coq"

local capabilities = vim.lsp.protocol.make_client_capabilities()

local lspconfig = require('lspconfig')
for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup {
        on_attach = on_attach,
        capabilities = capabilities,
    }

    lspconfig[lsp].setup (coq.lsp_ensure_capabilities({capabilities = capabilities}))
end

local lsp_flags = {
-- This is the default in Nvim 0.7+
    debounce_text_changes = 500,
}

