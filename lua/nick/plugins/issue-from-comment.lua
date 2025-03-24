-- In your plugins configuration
return {
  "OwlfaceGames/issue-from-comment.nvim",
  config = function()
    require("issue_from_comment").setup({
      github_owner = "OwlfaceGames",
      github_repo = "earthen_heart",
      default_labels = { "focus" },
      create_key = '<Leader>gc', -- Custom key to create the issue
      cancel_key = 'q',          -- Custom key to cancel
    })

    -- Keymapping to open the issue creation buffer
    vim.keymap.set("n", "<Leader>gi", ":GHIssueFromComment<CR>", { noremap = true, silent = true })
  end,
}
