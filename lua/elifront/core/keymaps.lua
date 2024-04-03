local keymap = vim.keymap -- for conciseness

-- lazy
keymap.set("n", "<leader>L", ":Lazy<CR>", { desc = "Lazy" })

-- set jj to exit insert mode
keymap.set("i", "jj", "<ESC>", { desc = "Exit insert mode with jj" })

-- set <leader>w to save
keymap.set("n", "<leader>w", ":w<CR>", { desc = "Save Buffer" })

-- set <leader>q to quit
keymap.set("n", "<leader>q", ":q<CR>", { desc = "Quit" })

-- <leader>th for terminal horizontal
keymap.set("n", "<leader>th", ":rightbelow split | terminal<CR>", { desc = "Horizontal" })

-- control ' to close current window
keymap.set({ "n", "i" }, "<C-'>", ":close<CR>", { desc = "Close Window" })

keymap.set("n", "<leader>bb", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })

-- glslView
keymap.set("n", "<leader>v", ":GlslView<CR>", { desc = "GlslView" })

-- copy / paste to clipboard
keymap.set("v", "<leader>cc", '"+y', { desc = "Copy to clipboard" })
keymap.set("n", "<leader>cp", '"+p', { desc = "Paste from clipboard" })
keymap.set("n", "<leader>cl", '"+yy', { desc = "Copy line to clipboard" })
keymap.set("n", "<leader>cb", ":%y+<CR>", { desc = "Copy buffer to clipboard" })

-- git vim-fugitive, diffview, gitsigns, vim-mergetool
keymap.set("n", "<leader>gs", ":G<CR>", { desc = "Git Status" })
keymap.set("n", "<leader>gc", ":Git commit<CR>", { desc = "Git Commit" })
keymap.set("n", "<leader>gp", ":Git push<CR>", { desc = "Git Push" })
keymap.set("n", "<leader>gf", ":Git fetch<CR>", { desc = "Git Fetch" })
keymap.set("n", "<leader>gl", ":Git pull<CR>", { desc = "Git Pull" })
keymap.set("n", "<leader>gm", ":MergetoolToggle<CR>", { desc = "Toggle Mergetool" })
keymap.set("n", "<leader>gds", ":Gvdiffsplit<CR>", { desc = "Git Diff" })
keymap.set("n", "<leader>gdv", ":DiffviewOpen<CR>", { desc = "Open Diffview" })
keymap.set("n", "<leader>gdc", ":DiffviewClose<CR>", { desc = "Close Diffview" })
keymap.set("n", "<leader>gdh", ":DiffviewFileHistory %<CR>", { desc = "File History" })

-- docker shortcuts
-- the current working directory is located within /Documents/kicker/...
local is_in_kicker = vim.fn.getcwd():find("kicker") ~= nil
local doppler = is_in_kicker and "doppler run -- " or ""
-- run bash command docker compose up -d or if in kicker run doppler run -- docker compose up -d
keymap.set("n", "<leader>dc", ":! " .. doppler .. "docker compose up -d<CR>", { desc = "Docker Compose Up" })
-- docker up build
keymap.set(
  "n",
  "<leader>db",
  ":! " .. doppler .. "docker compose up --build -d<CR>",
  { desc = "Docker Compose Up Build" }
)
-- docker compose down
keymap.set("n", "<leader>dd", ":! " .. doppler .. "docker compose down<CR>", { desc = "Docker Compose Down" })
-- docker prune
keymap.set("n", "<leader>dp", ":! docker system prune -f<CR>", { desc = "Docker Prune" })
