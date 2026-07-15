-- my initial config
require("nick.core")
require("nick.lazy")

-- set colorscheme
vim.cmd.colorscheme('owly')

-- TODO: maybe put this in owly.nvim colorscheme

-- stop odin from being modifiable
vim.api.nvim_create_autocmd("BufRead", {
  pattern = "C:/Users/nickj/scoop/apps/odin/**", -- Changed to forward slashes for cross-platform matching
  callback = function()
    vim.bo.modifiable = false
  end,
})

-- set shell on windows
if vim.fn.has("win32") == 1 then
    vim.opt.shell = "pwsh"
    vim.opt.shellcmdflag = "-NoLogo -NonInteractive -NoProfile -ExecutionPolicy Bypass -Command"
    vim.opt.shellquote = ""
    vim.opt.shellxquote = ""
end

-- tree sitter
local status, treesitter = pcall(require, "nvim-treesitter.config")
if not status then
    -- Fallback for the older version still cached on your Mac
    treesitter = require("nvim-treesitter.configs")
end

treesitter.setup {
    ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline" },
    sync_install = false,
    auto_install = true,
    ignore_install = { "javascript" },

    highlight = {
        enable = true,
        disable = function(lang, buf)
            local max_filesize = 100 * 1024
            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
                return true
            end
        end,
        additional_vim_regex_highlighting = false,
    },
}

-- harpoon
local harpoon = require("harpoon")
harpoon:setup() -- required to setup harpoon

vim.keymap.set("n", "<leader>ha", function() harpoon:list():add() end)
vim.keymap.set("n", "<leader>he", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

vim.keymap.set("n", "<leader>h1", function() harpoon:list():select(1) end)
vim.keymap.set("n", "<leader>h2", function() harpoon:list():select(2) end)
vim.keymap.set("n", "<leader>h3", function() harpoon:list():select(3) end)
vim.keymap.set("n", "<leader>h4", function() harpoon:list():select(4) end)
vim.keymap.set("n", "<leader>h5", function() harpoon:list():select(5) end)
vim.keymap.set("n", "<leader>h6", function() harpoon:list():select(6) end)
vim.keymap.set("n", "<leader>h7", function() harpoon:list():select(7) end)
vim.keymap.set("n", "<leader>h8", function() harpoon:list():select(8) end)
vim.keymap.set("n", "<leader>h9", function() harpoon:list():select(9) end)

-- Toggle previous & next buffers stored within Harpoon list
vim.keymap.set("n", "<leader>hp", function() harpoon:list():prev() end)
vim.keymap.set("n", "<leader>hn", function() harpoon:list():next() end)

-- basic telescope configuration for harpoon
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

-- open harpoon keymap
vim.keymap.set("n", "<leader>ht", function() toggle_telescope(harpoon:list()) end,
{ desc = "Open harpoon window" })

-- oil
require("oil").setup()

-- require colorizer to color hex codes
require 'colorizer'.setup()

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
        vim.bo[bufnr].tabstop = 4
        vim.bo[bufnr].shiftwidth = 4
        vim.bo[bufnr].softtabstop = 4
        vim.bo[bufnr].expandtab = false
    end,
})
vim.lsp.enable('sourcekit')

-- Odin
vim.lsp.config('ols', {})
vim.lsp.enable('ols')
