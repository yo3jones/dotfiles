-- nmap  <Leader>wv <Plug>VimwikiVSplitLink
-- {{- if .ForTag "work-wiki" }}
vim.g.vimwiki_list = {
    {name = 'Work', path = '~/wiki/', syntax = 'markdown', ext = '.md'}
}
-- {{- else }}
vim.g.vimwiki_list = {
    {name = 'Work', path = '~/notes/work/', syntax = 'markdown', ext = '.md'}, {
        name = 'Personal',
        path = '~/notes/personal/',
        syntax = 'markdown',
        ext = '.md'
    }
}
-- {{- end }}
