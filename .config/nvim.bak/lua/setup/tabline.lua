require'tabline'.setup {
    -- Defaults configuration options
    enable = true,
    options = {
        -- If lualine is installed tabline will use separators configured in
        -- lualine by default.
        -- These options can be used to override those settings.
        section_separators = {'', ''},
        component_separators = {'', ''},
        -- set to nil by default, and it uses vim.o.columns * 2/3
        max_bufferline_percent = 66,
        -- this shows tabs only when there are more than one tab or if the
        -- first tab is named
        show_tabs_always = false,
        show_devicons = true, -- this shows devicons in buffer section
        show_bufnr = true, -- this appends [bufnr] to buffer section,
        -- shows base filename only instead of relative path in filename
        show_filename_only = false,
        modified_icon = "+ ", -- change the default modified icon
        -- set to true by default; this determines whether the filename turns
        -- italic if modified
        modified_italic = true,
        -- this shows only tabs instead of tabs + buffers
        show_tabs_only = false
    }
}
vim.cmd [[
        " Use showtabline in gui vim
        set guioptions-=e
        " store tabpages and globals in session
        set sessionoptions+=tabpages,globals
      ]]
