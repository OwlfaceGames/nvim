return {
  "OwlfaceGames/issue-from-comment",
  -- dir = vim.fn.stdpath("config") .. "/lua/nick/plugins/issue-from-comment",
  config = function()
    require("issue_from_comment").setup({
      github_owner = "OwlfaceGames",
      github_repo = "earthen_heart",
      github_token = os.getenv("$GITHUB_TOKEN"),
      default_labels = { "focus" }, -- Set your default labels here
      -- default_assignees = { "your-username" }, -- Set default assignees
    })

    -- Set up keymaps
    vim.keymap.set("n", "<Leader>gi", ":GHIssueFromComment<CR>", { noremap = true, silent = true })
  end,
}
