return require('nvim-tree').setup({
    sort_by = "case_insensitive",
    view = {
        width = 35,
    },
    renderer = {
        group_empty = true,
    },
    filters = {
        dotfiles = false,
    },
    git = {
        ignore = false,
    },
})
