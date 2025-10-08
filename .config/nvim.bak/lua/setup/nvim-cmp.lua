vim.opt.completeopt = {'menu', 'menuone', 'noselect'}

local luasnip = require('luasnip')
local cmp = require('cmp')
cmp.setup({
    snippet = {expand = function(args) luasnip.lsp_expand(args.body) end},
    mapping = {
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.close(),
        ['<CR>'] = cmp.mapping.confirm({behavior = cmp.ConfirmBehavior.Replace}),
        ['<Tab>'] = function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end,
        ['<S-Tab>'] = function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end
    },
    sources = {
        {name = 'nvim_lsp'}, {name = 'luasnip'}, {name = 'buffer'},
        {name = 'nvim_lsp_signature_help'}
    }
})

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
        {name = 'cmp_git'} -- You can specify the `cmp_git` source if you were installed it.
    }, {
        --
        {name = 'buffer'}
    })
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        --
        {name = 'buffer'}
    }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        --
        {name = 'path'}
    }, {
        --
        {name = 'cmdline'}
    })
})

require('luasnip.loaders.from_vscode').lazy_load()
luasnip.snippets = require('luasnip_snippets').load_snippets()
