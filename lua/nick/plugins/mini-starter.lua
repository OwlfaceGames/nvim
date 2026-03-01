return {
    {
        'echasnovski/mini.starter',
        config = function()
            local starter = require('mini.starter')
            local harpoon = require("harpoon")
            local conf = require("telescope.config").values

            starter.setup({
                header = [[⢰⣶⣤⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀
⠀⣿⣿⣿⣷⣤⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣤⣶⣾⣿
⠀⠘⢿⣿⣿⣿⣿⣦⣀⣀⣀⣄⣀⣀⣠⣀⣤⣶⣿⣿⣿⣿⣿⠇
⠀⠀⠈⠻⣿⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠋⠀
⠀⠀⠀⠀⣰⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣟⠋⠀⠀⠀
⠀⠀⠀⢠⣿⣿⡏⠆⢹⣿⣿⣿⣿⣿⣿⠒⠈⣿⣿⣿⣇⠀⠀⠀
⠀⠀⠀⣼⣿⣿⣷⣶⣿⣿⣛⣻⣿⣿⣿⣶⣾⣿⣿⣿⣿⡀⠀⠀
⠀⠀⠀⡁⠀⠈⣿⣿⣿⣿⢟⣛⡻⣿⣿⣿⣟⠀⠀⠈⣿⡇⠀⠀
⠀⠀⠀⢿⣶⣿⣿⣿⣿⣿⡻⣿⡿⣿⣿⣿⣿⣶⣶⣾⣿⣿⠀⠀
⠀⠀⠀⠘⣿⣿⣿⣿⣿⣿⣿⣷⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡆⠀
⠀⠀⠀⠀⣼⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⠀]],
                items = {
                    { action = 'TodoTelescope', name = 'T: Todos', section = '' },
                    {
                        name = "H: Harpoon",
                        action = function()
                            local file_paths = {}
                            for _, item in ipairs(harpoon:list().items) do
                                table.insert(file_paths, item.value)
                            end
                            require("telescope.pickers").new({}, {
                                prompt_title = "Harpoon",
                                finder = require("telescope.finders").new_table({
                                    results = file_paths,
                                }),
                                previewer = conf.file_previewer({}),
                                sorter = conf.generic_sorter({}),
                            }):find()
                        end,
                        section = "",
                    },
                    { action = 'Telescope live_grep', name = 'S: Search', section = '' },
                    { action = 'Telescope find_files', name = 'F: Find Files', section = '' },
                    { action = "Oil", name = "O: File Manager", section = "" },
                    { action = 'qall!', name = 'Q: Quit', section = '' },
                },
                footer = vim.fn.fnamemodify(vim.fn.getcwd(), ":~"),
                content_hooks = {
                    starter.gen_hook.adding_bullet(),
                    starter.gen_hook.aligning('center', 'center'),
                },
            })

            local function set_highlights()
                vim.api.nvim_set_hl(0, 'MiniStarterHeader',     { fg = '#E6DB74' })
                vim.api.nvim_set_hl(0, 'MiniStarterItemBullet', { fg = '#FD971F' })
                vim.api.nvim_set_hl(0, 'MiniStarterItem',       { fg = '#ffffff' })
                vim.api.nvim_set_hl(0, 'MiniStarterSection',    { fg = '#3ad0b5' })
                vim.api.nvim_set_hl(0, 'MiniStarterFooter',     { fg = '#4B5345' })
                vim.api.nvim_set_hl(0, 'MiniStarterQuery',      { fg = '#53d549' })
            end

            set_highlights()

            vim.api.nvim_create_autocmd('ColorScheme', {
                callback = set_highlights,
            })
        end
    }
}
