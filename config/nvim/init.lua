-- init.lua
-- Converted from .vimrc for Neovim (Lua config)

-- ============================================================
-- Plugin Manager: lazy.nvim (replaces vim-plug)
-- ============================================================
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    spec = {
      { "morhetz/gruvbox", lazy = false, priority = 1000 },
    },
    performance = { rtp = { reset = false, }, },
})

-- ============================================================
-- Look and Feel
-- ============================================================
vim.o.background = "dark"
vim.cmd("silent! colorscheme gruvbox")

if vim.fn.has("gui_running") == 1 then
  vim.o.guifont = "PragmataPro:h14"
end

-- ============================================================
-- Basics
-- ============================================================
-- nocompatible / scriptencoding not needed in Neovim
vim.cmd("filetype on")
vim.cmd("syntax on")
vim.o.showmode       = true
vim.o.showcmd        = true
vim.o.relativenumber = true
vim.o.ruler          = true
vim.o.number         = true
vim.o.cursorline     = true

-- Toggle relative/absolute numbers based on mode and focus
local num_grp = vim.api.nvim_create_augroup("NumberToggle", { clear = true })
vim.api.nvim_create_autocmd({ "InsertLeave", "WinEnter", "FocusGained" }, {
  group = num_grp,
  callback = function()
    vim.opt_local.number = true
    vim.opt_local.relativenumber = true
  end,
})
vim.api.nvim_create_autocmd({ "InsertEnter", "WinLeave", "FocusLost" }, {
  group = num_grp,
  callback = function()
    vim.opt_local.number = true
    vim.opt_local.relativenumber = false
  end,
})

vim.opt.backspace = { "indent", "eol", "start" }
vim.o.showmatch   = true
vim.o.smartcase   = true
vim.o.incsearch   = true
vim.o.hlsearch    = true
vim.o.wildmenu    = true
vim.opt.wildmode  = { "list:longest", "full" }
vim.opt.whichwrap = "b,s,h,l,<,>,[,]"
vim.o.scrolljump  = 5
vim.o.scrolloff   = 3
vim.o.list        = false
vim.o.foldenable  = false
vim.o.splitbelow  = true
vim.o.splitright  = true
-- ttyfast: not applicable in Neovim (always fast)
-- vim.o.synmaxcol = 2048  -- uncomment if needed

-- Indentation: 4-space tabs
vim.o.tabstop     = 4
vim.o.softtabstop = 4
vim.o.shiftwidth  = 4
vim.o.expandtab   = true

-- ============================================================
-- Status Line
-- ============================================================
vim.o.laststatus = 2
vim.o.statusline = " %<%f %w%h%m%r [%{&ff}/%Y] [%{getcwd()}]%=%-14.(%l,%c%V%) %p%% "

-- ============================================================
-- Clipboard
-- ============================================================
vim.o.clipboard = ""

-- ============================================================
-- Leader
-- ============================================================
vim.g.mapleader = " "

-- ============================================================
-- Key Mappings
-- ============================================================

-- Disable F1 help
vim.keymap.set("n", "<F1>", "<cmd>echo<CR>")
vim.keymap.set("i", "<F1>", "<C-o><cmd>echo<CR>")

-- Edit / reload init.lua
vim.keymap.set("n", "<Leader>ve", "<cmd>e $MYVIMRC<CR>")
vim.keymap.set("n", "<Leader>vr", "<cmd>source $MYVIMRC<CR>")

-- Visual-line-aware j/k
vim.keymap.set("n", "j", "gj")
vim.keymap.set("n", "k", "gk")

-- Window navigation with pane maximization
vim.keymap.set("", "<C-J>", "<C-W>j<C-W>_")
vim.keymap.set("", "<C-K>", "<C-W>k<C-W>_")
vim.keymap.set("", "<C-L>", "<C-W>l<C-W>_")
vim.keymap.set("", "<C-H>", "<C-W>h<C-W>_")

-- Emacs-style command-line navigation
vim.keymap.set("c", "<C-a>", "<Home>")
vim.keymap.set("c", "<C-b>", "<Left>")
vim.keymap.set("c", "<C-f>", "<Right>")
vim.keymap.set("c", "<C-d>", "<Delete>")
vim.keymap.set("c", "<M-b>", "<S-Left>")
vim.keymap.set("c", "<M-f>", "<S-Right>")
vim.keymap.set("c", "<M-d>", "<S-Right><Delete>")
vim.keymap.set("c", "<Esc>b", "<S-Left>")
vim.keymap.set("c", "<Esc>f", "<S-Right>")
vim.keymap.set("c", "<Esc>d", "<S-Right><Delete>")
vim.keymap.set("c", "<C-g>", "<C-c>")

-- Toggle list chars / spell check / line wrap
vim.keymap.set("n", "<leader>l", "<cmd>set list!<CR>")
vim.keymap.set("n", "<leader>s", "<cmd>set spell!<CR>")
vim.keymap.set("n", "<leader>w", "<cmd>set wrap!<CR>")

-- Make <C-u>/<C-w> in insert mode undoable
vim.keymap.set("i", "<C-u>", "<C-g>u<C-u>")
vim.keymap.set("i", "<C-w>", "<C-g>u<C-w>")

-- Yank to end of line (consistent with C and D)
vim.keymap.set("n", "Y", "y$")

-- Replay @q macro with Space (coexists with <leader> prefix mappings)
vim.keymap.set("n", "<Space>", "@q")

-- Fold level shortcuts
for i = 0, 9 do
  vim.keymap.set("n", "<leader>f" .. i, "<cmd>set foldlevel=" .. i .. "<CR>")
end

-- Clear search highlight
vim.keymap.set("n", "<leader>/", "<cmd>nohls<CR><C-l>")

-- Tab and buffer navigation
vim.keymap.set("n", "<leader>t", "<cmd>tabnew<CR>")
vim.keymap.set("n", "<leader>n", "<cmd>bn<CR>")
vim.keymap.set("n", "<leader>p", "<cmd>bp<CR>")

-- Visual indent: stay in visual mode
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- Horizontal scrolling
vim.keymap.set("", "zl", "zL")
vim.keymap.set("", "zh", "zH")

-- Equalize window sizes
vim.keymap.set("", "<leader>=", "<C-w>=")

-- Expand %% to current file's directory in command mode
vim.keymap.set("c", "%%", function()
  return vim.fn.expand("%:h") .. "/"
end, { expr = true })

-- Edit-in-directory helpers (noremap=false so %% cnoremap fires)
vim.keymap.set("", "<leader>ew", ":e %%",    { noremap = false })
vim.keymap.set("", "<leader>es", ":sp %%",   { noremap = false })
vim.keymap.set("", "<leader>ev", ":vsp %%",  { noremap = false })
vim.keymap.set("", "<leader>et", ":tabe %%", { noremap = false })

-- Change working directory to current file's directory
vim.keymap.set("c", "cwd", "lcd %:p:h")
vim.keymap.set("c", "cd.", "lcd %:p:h")

-- Sudo write
vim.keymap.set("c", "w!!", "w !sudo tee % >/dev/null")

-- Jump to nth occurrence of keyword under cursor
vim.keymap.set("n", "<leader>ff",
  [[[I:let nr = input("Which one: ")<Bar>exe "normal " . nr ."[\t"<CR>]],
  { noremap = false })

-- ============================================================
-- User Commands (shift-key typo fixes)
-- ============================================================
vim.api.nvim_create_user_command("E",  function(o) vim.cmd("e"  .. (o.bang and "!" or "") .. " " .. o.args) end, { bang = true, nargs = "*", complete = "file" })
vim.api.nvim_create_user_command("W",  function(o) vim.cmd("w"  .. (o.bang and "!" or "") .. " " .. o.args) end, { bang = true, nargs = "*", complete = "file" })
vim.api.nvim_create_user_command("Wq", function(o) vim.cmd("wq" .. (o.bang and "!" or "") .. " " .. o.args) end, { bang = true, nargs = "*", complete = "file" })
vim.api.nvim_create_user_command("WQ", function(o) vim.cmd("wq" .. (o.bang and "!" or "") .. " " .. o.args) end, { bang = true, nargs = "*", complete = "file" })
vim.api.nvim_create_user_command("Wa", function(o) vim.cmd("wa" .. (o.bang and "!" or "")) end, { bang = true })
vim.api.nvim_create_user_command("WA", function(o) vim.cmd("wa" .. (o.bang and "!" or "")) end, { bang = true })
vim.api.nvim_create_user_command("Q",  function(o) vim.cmd("q"  .. (o.bang and "!" or "")) end, { bang = true })
vim.api.nvim_create_user_command("QA", function(o) vim.cmd("qa" .. (o.bang and "!" or "")) end, { bang = true })
vim.api.nvim_create_user_command("Qa", function(o) vim.cmd("qa" .. (o.bang and "!" or "")) end, { bang = true })

-- ============================================================
-- Functions
-- ============================================================

-- Print current tab settings with highlighting
local function summarize_tabs()
  local msg = string.format(
    "tabstop=%d shiftwidth=%d softtabstop=%d%s",
    vim.bo.tabstop,
    vim.bo.shiftwidth,
    vim.bo.softtabstop,
    vim.bo.expandtab and " expandtab" or " noexpandtab"
  )
  vim.api.nvim_echo({ { msg, "ModeMsg" } }, false, {})
end

-- Interactively set tabstop, softtabstop, and shiftwidth together
local function stab()
  local input = vim.fn.input("set tabstop = softtabstop = shiftwidth = ")
  local n = tonumber(input)
  if n and n > 0 then
    vim.bo.tabstop     = n
    vim.bo.softtabstop = n
    vim.bo.shiftwidth  = n
  end
  summarize_tabs()
end

vim.api.nvim_create_user_command("Stab", stab, {})
