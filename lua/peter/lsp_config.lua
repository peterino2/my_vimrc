require 'cmp'.setup{
    sources = {
        {name = "nvim_lsp"}
    }
}


local servers = {'zls'}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

local lspconfig = require('lspconfig')
for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup {
        on_attach = on_attach,
        capabilities = capabilities,
    }
end

local lsp_flags = {
-- This is the default in Nvim 0.7+
    debounce_text_changes = 500,
}


-- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..

