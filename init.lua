-- my initial config
require("nick.core")
require("nick.lazy")

-- luatab
require('luatab').setup {}

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


-- disable neocodium on startup
vim.api.nvim_create_autocmd({ "BufNew" },
  {
    command = "NeoCodeium disable"
  })


------------------------
-- neocodeium keymaps --
------------------------
-- remap the accept key to <C-f> while in insert mode
vim.keymap.set("i", "<C-f>", function()
  require("neocodeium").accept()
end)
-- remap the accept word key to <C-w> while in insert mode
vim.keymap.set("i", "<C-w>", function()
  require("neocodeium").accept_word()
end)

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

-- Update your format-on-save autocmd to include these file types
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  pattern = {
    "*.c", "*.h", "*.cpp", "*.hpp", "*.lua", "*.json",
    "*.py", "*.ts", "*.js", "*.jsx", "*.tsx",
    "*.rs", "*.go", "*.html", "*.css"
  },
  desc = "formats code on save with lsp",
  callback = function()
    vim.lsp.buf.format()
  end,
})
------------------------------------
-- My custom color scheme owl_zen --
------------------------------------
-- vim.cmd("colorscheme owl_zen")
-- vim.cmd("colorscheme owl_zen_blue")
-- vim.cmd("colorscheme owl_zen_black")
-- vim.cmd("colorscheme owl_zen_green_black")
-- vim.cmd("colorscheme owl_zen_green_grey")
-- vim.cmd("colorscheme owl_zen_green_grey_invert_selection")
-- vim.cmd("colorscheme owl_zen_light")
-- vim.cmd("colorscheme onehalfdark")

-------------------------
-- Custom vim terminal --
-------------------------
vim.api.nvim_create_autocmd('TermOpen', {
  group = vim.api.nvim_create_augroup('custom-term-open', { clear = true }),
  callback = function()
    vim.opt.number = false
    vim.opt.relativenumber = false
  end,
})

local job_id = 0

-- create small terminal
vim.keymap.set("n", "<space>stb", function()
  vim.cmd.vnew()
  vim.cmd.term()
  vim.cmd.wincmd("J")
  vim.api.nvim_win_set_height(0, 10)

  job_id = vim.bo.channel
end)

-- create small terminal
vim.keymap.set("n", "<space>stt", function()
  vim.cmd.vnew()
  vim.cmd.term()
  vim.cmd.wincmd("K")
  vim.api.nvim_win_set_height(0, 10)

  job_id = vim.bo.channel
end)


-- create small terminal
vim.keymap.set("n", "<space>str", function()
  vim.cmd.vnew()
  vim.cmd.term()
  vim.cmd.wincmd("L")
  vim.api.nvim_win_set_width(0, 55)

  job_id = vim.bo.channel
end)

-- create small terminal
vim.keymap.set("n", "<space>stl", function()
  vim.cmd.vnew()
  vim.cmd.term()
  vim.cmd.wincmd("H")
  vim.api.nvim_win_set_width(0, 55)

  job_id = vim.bo.channel
end)

-- create small terminal
vim.keymap.set("n", "<space>stl", function()
  vim.cmd.vnew()
  vim.cmd.term()
  vim.cmd.wincmd("H")
  vim.api.nvim_win_set_width(0, 55)

  job_id = vim.bo.channel
end)

-- create fullscreen terminal
vim.keymap.set("n", "<space>stf", function()
  vim.cmd.term()
  job_id = vim.bo.channel
end)



-- make c proj
vim.keymap.set("n", "<space>mm", function()
  vim.fn.chansend(job_id, { "make\r\n" })
end)

-- run make c proj
vim.keymap.set("n", "<space>mr", function()
  vim.fn.chansend(job_id, { "make run\r\n" })
end)

-- make zig c proj
vim.keymap.set("n", "<space>zm", function()
  vim.fn.chansend(job_id, { "zig build\r\n" })
end)

-- run zig make c proj
vim.keymap.set("n", "<space>zr", function()
  vim.fn.chansend(job_id, { "zig build run\r\n" })
end)

-- tweak colors
-- vim.cmd [[hi @variable guifg=#dcdfe4]]
-- vim.cmd [[hi @operator guifg=#dcdfe4]]
-- vim.cmd [[hi @punctuation guifg=#dcdfe4]]
-- vim.cmd [[hi @string guifg=#D9AA1A]]
-- vim.cmd [[hi @type.builtin guifg=#DBDE7]]

-- set conceal level for markdown files for use with obsidian vault
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.opt_local.conceallevel = 1
  end
})

-- HACK: markdown headline - this is kinda hacked together the queries were erroring that i got from the github config so i just deleted all queries from the config and it now works how i want
require("headlines").setup {
  markdown = {

    headline_highlights = { "Headline" },
    bullet_highlights = {
      "@text.title.1.marker.markdown",
      "@text.title.2.marker.markdown",
      "@text.title.3.marker.markdown",
      "@text.title.4.marker.markdown",
      "@text.title.5.marker.markdown",
      "@text.title.6.marker.markdown",
    },
    bullets = { "◉", "○", "✸", "✿" },
    codeblock_highlight = "CodeBlock",
    dash_highlight = "Dash",
    dash_string = "-",
    quote_highlight = "Quote",
    quote_string = "┃",
    fat_headlines = true,
    fat_headline_upper_string = "▄",
    fat_headline_lower_string = "▀",
  },
  rmd = {

    treesitter_language = "markdown",
    headline_highlights = { "Headline" },
    bullet_highlights = {
      "@text.title.1.marker.markdown",
      "@text.title.2.marker.markdown",
      "@text.title.3.marker.markdown",
      "@text.title.4.marker.markdown",
      "@text.title.5.marker.markdown",
      "@text.title.6.marker.markdown",
    },
    bullets = { "◉", "○", "✸", "✿" },
    codeblock_highlight = "CodeBlock",
    dash_highlight = "Dash",
    dash_string = "-",
    quote_highlight = "Quote",
    quote_string = "┃",
    fat_headlines = true,
    fat_headline_upper_string = "▄",
    fat_headline_lower_string = "▀",
  },
  norg = {

    headline_highlights = { "Headline" },
    bullet_highlights = {
      "@neorg.headings.1.prefix",
      "@neorg.headings.2.prefix",
      "@neorg.headings.3.prefix",
      "@neorg.headings.4.prefix",
      "@neorg.headings.5.prefix",
      "@neorg.headings.6.prefix",
    },
    bullets = { "◉", "○", "✸", "✿" },
    codeblock_highlight = "CodeBlock",
    dash_highlight = "Dash",
    dash_string = "-",
    doubledash_highlight = "DoubleDash",
    doubledash_string = "=",
    quote_highlight = "Quote",
    quote_string = "┃",
    fat_headlines = true,
    fat_headline_upper_string = "▄",
    fat_headline_lower_string = "▀",
  },
  org = {

    headline_highlights = { "Headline" },
    bullet_highlights = {
      "@org.headline.level1",
      "@org.headline.level2",
      "@org.headline.level3",
      "@org.headline.level4",
      "@org.headline.level5",
      "@org.headline.level6",
      "@org.headline.level7",
      "@org.headline.level8",
    },
    bullets = { "◉", "○", "✸", "✿" },
    codeblock_highlight = "CodeBlock",
    dash_highlight = "Dash",
    dash_string = "-",
    quote_highlight = "Quote",
    quote_string = "┃",
    fat_headlines = true,
    fat_headline_upper_string = "▄",
    fat_headline_lower_string = "▀",
  },
}
