-- my initial config
require("nick.core")
require("nick.lazy")

-- set colorscheme
vim.cmd.colorscheme('owl-naysayer')

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

-- C/C++ (clangd)
vim.lsp.config('clangd', {})
vim.lsp.enable('clangd')

-- Lua
vim.lsp.config('lua_ls', {
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
vim.lsp.enable('lua_ls')

-- Python (pyright)
vim.lsp.config('pyright', {
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
vim.lsp.enable('pyright')

-- TypeScript/JavaScript
vim.lsp.config('ts_ls', {
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
vim.lsp.enable('ts_ls')

-- Rust
vim.lsp.config('rust_analyzer', {
        settings = {
                ['rust-analyzer'] = {
                        checkOnSave = true,
                        diagnostics = {
                                enable = true,
                                experimental = {
                                        enable = true,
                                },
                        },
                },
        },
})
vim.lsp.enable('rust_analyzer')

-- Go
vim.lsp.config('gopls', {
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
vim.lsp.enable('gopls')

-- HTML
vim.lsp.config('html', {
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
vim.lsp.enable('html')

-- CSS
vim.lsp.config('cssls', {
        settings = {
                css = {
                        validate = true,
                        lint = {
                                unknownAtRules = "ignore"
                        },
                },
        },
})
vim.lsp.enable('cssls')

-- JSON
vim.lsp.config('jsonls', {
        settings = {
                json = {
                        schemas = require('schemastore').json.schemas(),
                        validate = { enable = true },
                },
        },
})
vim.lsp.enable('jsonls')

-- Ruby (solargraph)
vim.lsp.config('solargraph', {
        settings = {
                solargraph = {
                        diagnostics = true,
                        completion = true,
                        hover = true,
                        formatting = true,
                },
        },
})
vim.lsp.enable('solargraph')

-- Tailwind CSS
vim.lsp.config('tailwindcss', {
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
vim.lsp.enable('tailwindcss')

-- Vue
vim.lsp.config('volar', {
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
vim.lsp.enable('volar')

-- Swift (sourcekit-lsp)
vim.lsp.config('sourcekit', {
        cmd = { "sourcekit-lsp" },
        filetypes = { "swift", "c", "cpp", "objective-c", "objective-cpp" },
        root_markers = { "Package.swift", ".git" },
        settings = {
                sourcekit = {
                        indexing = { enabled = true },
                        diagnostics = { enabled = true },
                        completion = { enabled = true },
                },
        },
        on_attach = function(client, bufnr)
                vim.bo[bufnr].tabstop = 8
                vim.bo[bufnr].shiftwidth = 8
                vim.bo[bufnr].softtabstop = 8
                vim.bo[bufnr].expandtab = false
        end,
})
vim.lsp.enable('sourcekit')

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

-- Highlights the current match as you type
vim.api.nvim_set_hl(0, 'IncSearch', { bg = '#ff6600', fg = '#ffffff' })

-- Highlights ALL matches after pressing Enter
vim.api.nvim_set_hl(0, 'Search', { bg = '#ffff00', fg = '#000000' })

-- Highlights the match your cursor is currently on when navigating with
vim.api.nvim_set_hl(0, 'CurSearch', { bg = '#ff1493', fg = '#ffffff' })

-- Highlights text being replaced during substitute operations
vim.api.nvim_set_hl(0, 'Substitute', { bg = '#8a2be2', fg = '#ffffff' })

---------------
-- debugging --
---------------
local dap = require('dap')

dap.adapters.codelldb = {
        type = 'server',
        port = "${port}",
        executable = {
                command = vim.fn.stdpath("data") .. '/mason/bin/codelldb',
                args = {"--port", "${port}"},
        }
}

dap.configurations.c = {
        {
                name = "Launch file",
                type = "codelldb",
                request = "launch",
                program = function()
                        return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
                end,
                cwd = '${workspaceFolder}',
                stopOnEntry = false,
                args = {},
        },
        {
                name = "Attach to process",
                type = "codelldb",
                request = "attach",
                pid = require('dap.utils').pick_process,
                args = {},
        }
}

-- go debugging
require('dap-go').setup()

dap.configurations.go = {
        {
                type = "go",
                name = "Debug",
                request = "launch",
                program = "${file}",
                showGlobalVariables = true,
        },
        {
                type = "go",
                name = "Debug Package",
                request = "launch",
                program = "${fileDirname}",
                showGlobalVariables = true,
        }
}

-- Rust debugging (minimal)
dap.configurations.rust = {
        {
                name = "Debug Rust",
                type = "codelldb",
                request = "launch",
                program = function()
                        return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/target/debug/', 'file')
                end,
                cwd = '${workspaceFolder}',
                stopOnEntry = false,
        }
}

-- Configure lldb-dap adapter
require('dap').adapters.lldb = {
        type = 'executable',
        command = '/Library/Developer/CommandLineTools/usr/bin/lldb-dap',
        name = 'lldb'
}


require('dap').configurations.swift = {
        {
                name = 'Launch Swift with Full Debug',
                type = 'lldb',
                request = 'launch',
                program = function()
                        local file = vim.fn.expand('%:p')
                        local executable = vim.fn.expand('%:p:r')
                        -- Compile with maximum debug info
                        local cmd = string.format(
                                'swiftc -g -Onone -debug-info-format=dwarf "%s" -o "%s"',
                                file, executable
                        )
                        print("Compile command: " .. cmd)
                        local result = vim.fn.system(cmd)
                        if vim.v.shell_error ~= 0 then
                                print("Compile error: " .. result)
                        end
                        return executable
                end,
                cwd = '${workspaceFolder}',
                stopOnEntry = false,
                args = {},
                sourceLanguages = { 'swift' },
                -- More comprehensive LLDB setup
                initCommands = {
                        'settings set target.language swift',
                        'settings set target.prefer-dynamic-value run-target',
                        'settings set target.enable-synthetic-value true',
                        'settings set symbols.enable-external-lookup true',
                        'command script import lldb.formatters.swift',
                },
                preRunCommands = {
                        'breakpoint set --file ' .. vim.fn.expand('%:t') .. ' --line ' .. vim.fn.line('.'),
                },
        },
}

local dapui = require('dapui')

dapui.setup()

dap.configurations.cpp = dap.configurations.c

-- Auto open/close dapui when debugging starts/stops
dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
end

dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
end

dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
end

