-- my initial config
require("nick.core")
require("nick.lazy")

-- set colorscheme
vim.cmd.colorscheme('melange')
-- vim.cmd.colorscheme('owl_zen_green_grey')

-- tree sitter
require 'nvim-treesitter.configs'.setup {
        -- A list of parser names, or "all" (the listed parsers MUST always be installed)
        ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline" },

        -- Install parsers synchronously (only applied to `ensure_installed`)
        sync_install = false,

        -- Automatically install missing parsers when entering buffer
        -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
        auto_install = true,

        -- List of parsers to ignore installing (or "all")
        ignore_install = { "javascript" },

        ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
        -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

        highlight = {
                enable = true,

                -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
                -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
                -- the name of the parser)
                -- list of language that will be disabled
                disable = { "c", "rust" },
                -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
                disable = function(lang, buf)
                        local max_filesize = 100 * 1024 -- 100 KB
                        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
                        if ok and stats and stats.size > max_filesize then
                                return true
                        end
                end,

                -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
                -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
                -- Using this option may slow down your editor, and you may see some duplicate highlights.
                -- Instead of true it can also be a list of languages
                additional_vim_regex_highlighting = false,
        },
}

-- harpoon
local harpoon = require("harpoon")
harpoon:setup() -- required to setup harpoon

-- harpoon keybinds
vim.keymap.set("n", "<leader>ha", function() harpoon:list():add() end)
vim.keymap.set("n", "<leader>he", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

vim.keymap.set("n", "<leader>h1", function() harpoon:list():select(1) end)
vim.keymap.set("n", "<leader>h2", function() harpoon:list():select(2) end)
vim.keymap.set("n", "<leader>h3", function() harpoon:list():select(3) end)
vim.keymap.set("n", "<leader>h4", function() harpoon:list():select(4) end)

-- Toggle previous & next buffers stored within Harpoon list
vim.keymap.set("n", "<leader>hn", function() harpoon:list():prev() end)
vim.keymap.set("n", "<leader>hp", function() harpoon:list():next() end)


-------------------------------------
-- use telescope as ui for harpoon --
-------------------------------------
local harpoon = require('harpoon')
harpoon:setup({})

-----------------------------------------------
-- basic telescope configuration for harpoon --
-----------------------------------------------
local conf = require("telescope.config").values
local function toggle_telescope(harpoon_files)
        local file_paths = {}
        for _, item in ipairs(harpoon_files.items) do
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
end

-------------------------
-- open harpoon keymap --
-------------------------
vim.keymap.set("n", "<leader>ht", function() toggle_telescope(harpoon:list()) end,
        { desc = "Open harpoon window" })

-- oil
require("oil").setup()

------------------------------------------
-- require colorizer to color hex codes --
------------------------------------------
require 'colorizer'.setup()

----------
-- LSPs --
----------

-- LSP Configurations
local lspconfig = require('lspconfig')

-- C/C++ (clangd)
lspconfig.clangd.setup {}

-- Lua
lspconfig.lua_ls.setup({
        settings = {
                Lua = {
                        runtime = { version = 'LuaJIT' },
                        diagnostics = { globals = { 'vim' } },
                        workspace = {
                                library = vim.api.nvim_get_runtime_file("", true),
                                checkThirdParty = false,
                        },
                        telemetry = { enable = false },
                },
        },
})

-- Python (pyright)
lspconfig.pyright.setup({
        settings = {
                python = {
                        analysis = {
                                typeCheckingMode = "basic",
                                autoSearchPaths = true,
                                useLibraryCodeForTypes = true,
                        },
                },
        },
})

-- TypeScript/JavaScript
lspconfig.ts_ls.setup({
        settings = {
                typescript = {
                        inlayHints = {
                                includeInlayParameterNameHints = 'all',
                                includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                                includeInlayFunctionParameterTypeHints = true,
                                includeInlayVariableTypeHints = true,
                                includeInlayPropertyDeclarationTypeHints = true,
                                includeInlayFunctionLikeReturnTypeHints = true,
                                includeInlayEnumMemberValueHints = true,
                        },
                },
                javascript = {
                        inlayHints = {
                                includeInlayParameterNameHints = 'all',
                                includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                                includeInlayFunctionParameterTypeHints = true,
                                includeInlayVariableTypeHints = true,
                                includeInlayPropertyDeclarationTypeHints = true,
                                includeInlayFunctionLikeReturnTypeHints = true,
                                includeInlayEnumMemberValueHints = true,
                        },
                },
        },
})

-- Rust
lspconfig.rust_analyzer.setup({
        settings = {
                ['rust-analyzer'] = {
                        checkOnSave = {
                                command = "clippy",
                        },
                        diagnostics = {
                                enable = true,
                                experimental = {
                                        enable = true,
                                },
                        },
                },
        },
})

-- Go
lspconfig.gopls.setup({
        settings = {
                gopls = {
                        analyses = {
                                unusedparams = true,
                        },
                        staticcheck = true,
                        gofumpt = true,
                },
        },
})

-- HTML
lspconfig.html.setup({
        settings = {
                html = {
                        format = {
                                indentInnerHtml = true,
                                wrapLineLength = 80,
                                wrapAttributes = 'auto',
                        },
                },
        },
})

-- CSS
lspconfig.cssls.setup({
        settings = {
                css = {
                        validate = true,
                        lint = {
                                unknownAtRules = "ignore"
                        },
                },
        },
})

-- JSON
lspconfig.jsonls.setup({
        settings = {
                json = {
                        schemas = require('schemastore').json.schemas(),
                        validate = { enable = true },
                },
        },
})

-- Ruby (solargraph)
lspconfig.solargraph.setup({
        settings = {
                solargraph = {
                        diagnostics = true,
                        completion = true,
                        hover = true,
                        formatting = true,
                },
        },
})


-- Tailwind CSS
lspconfig.tailwindcss.setup({
        settings = {
                tailwindCSS = {
                        classAttributes = { "class", "className", "class:list", "classList", "ngClass" },
                        lint = {
                                cssConflict = "warning",
                                invalidApply = "error",
                                invalidConfigPath = "error",
                                invalidTailwindDirective = "error",
                                invalidVariant = "error",
                                invalidScreen = "error",
                        },
                        validate = true,
                },
        },
        filetypes = { "html", "css", "scss", "javascript", "javascriptreact", "typescript", "typescriptreact", "vue", "svelte", "erb" },
})

-- Vue
lspconfig.volar.setup({
        settings = {
                vue = {
                        inlayHints = {
                                missingProps = true,
                                inlineHandlerLeading = true,
                                optionsWrapper = true,
                        },
                },
        },
        filetypes = { "vue" },
})

-- format these files on save
-- vim.api.nvim_create_autocmd({ "BufWritePost" }, {
--         pattern = {
--                 "*.c", "*.h", "*.cpp", "*.hpp", "*.lua", "*.json",
--                 "*.py", "*.ts", "*.js", "*.jsx", "*.tsx",
--                 "*.rs", "*.go", "*.html", "*.css"
--         },
--         desc = "formats code on save with lsp",
--         callback = function()
--                 vim.lsp.buf.format()
--         end,
-- })

-- Inverted selection highlighting
vim.api.nvim_set_hl(0, 'Visual', { bg = '#071afb' })
vim.api.nvim_set_hl(0, 'VisualNOS', { bg = '#071afb' })
