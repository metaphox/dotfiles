-- ============================================================================
-- Minimal, plugin-free init.lua
-- Drop into any Neovim >= 0.12 (~/.config/nvim/init.lua) and start working.
-- Nothing here requires a plugin manager, external Lua module, or Nerd Font.
-- ============================================================================

vim.opt.termguicolors = true
vim.o.background = "dark"

local function set_transparent() -- set UI components to transparent
	local groups = {
		"Normal",
		"NormalNC",
		"EndOfBuffer",
		"NormalFloat",
		"FloatBorder",
		"SignColumn",
		"TabLine",
		"TabLineFill",
		"TabLineSel",
		"ColorColumn",
	}
	for _, g in ipairs(groups) do
		vim.api.nvim_set_hl(0, g, { bg = "none" })
	end
	vim.api.nvim_set_hl(0, "TabLineFill", { bg = "none", fg = "#767676" })
end

-- ============================================================================
-- OPTIONS
-- ============================================================================
vim.opt.number = true -- line number
vim.opt.relativenumber = true -- relative line numbers
vim.opt.cursorline = true -- highlight current line
vim.opt.wrap = false -- do not wrap lines by default
vim.opt.scrolloff = 10 -- keep 10 lines above/below cursor
vim.opt.sidescrolloff = 10 -- keep 10 lines to left/right of cursor

local number_toggle_group = vim.api.nvim_create_augroup("NumberToggle", { clear = true })
vim.api.nvim_create_autocmd({ "InsertLeave", "WinEnter", "FocusGained" }, {
	group = number_toggle_group,
	callback = function()
		vim.opt_local.number = true
		vim.opt_local.relativenumber = true
	end,
})
vim.api.nvim_create_autocmd({ "InsertEnter", "WinLeave", "FocusLost" }, {
	group = number_toggle_group,
	callback = function()
		vim.opt_local.number = true
		vim.opt_local.relativenumber = false
	end,
})

vim.opt.tabstop = 4 -- tabwidth
vim.opt.shiftwidth = 4 -- indent width
vim.opt.softtabstop = 4 -- soft tab stop not tabs on tab/backspace
vim.opt.expandtab = true -- use spaces instead of tabs
vim.opt.smartindent = true -- smart auto-indent
vim.opt.autoindent = true -- copy indent from current line

vim.opt.ignorecase = true -- case insensitive search
vim.opt.smartcase = true -- case sensitive if uppercase in string
vim.opt.hlsearch = true -- highlight search matches
vim.opt.incsearch = true -- show matches as you type

vim.opt.signcolumn = "yes" -- always show a sign column
vim.opt.colorcolumn = "100" -- show a column at 100 position chars
vim.opt.showmatch = true -- highlights matching brackets
vim.opt.cmdheight = 1 -- single line command line
vim.opt.completeopt = "menuone,noinsert,noselect" -- completion options
vim.opt.showmode = false -- do not show the mode, instead have it in statusline
vim.opt.pumheight = 10 -- popup menu height
vim.opt.pumblend = 10 -- popup menu transparency
vim.opt.winblend = 0 -- floating window transparency
vim.opt.synmaxcol = 300 -- syntax highlighting limit
vim.opt.fillchars = { eob = " " } -- hide "~" on empty lines

local undodir = vim.fn.expand("~/.vim/undodir")
if
	vim.fn.isdirectory(undodir) == 0 -- create undodir if nonexistent
then
	vim.fn.mkdir(undodir, "p")
end

vim.opt.backup = false -- do not create a backup file
vim.opt.writebackup = false -- do not write to a backup file
vim.opt.swapfile = false -- do not create a swapfile
vim.opt.undofile = true -- do create an undo file
vim.opt.undodir = undodir -- set the undo directory
vim.opt.updatetime = 300 -- faster completion
vim.opt.timeoutlen = 500 -- timeout duration
vim.opt.ttimeoutlen = 50 -- key code timeout
vim.opt.autoread = true -- auto-reload changes if outside of neovim
vim.opt.autowrite = false -- do not auto-save

vim.opt.hidden = true -- allow hidden buffers
vim.opt.errorbells = false -- no error sounds
vim.opt.backspace = "indent,eol,start" -- better backspace behaviour
vim.opt.autochdir = false -- do not autochange directories
vim.opt.iskeyword:append("-") -- include - in words
vim.opt.path:append("**") -- include subdirs in search
vim.opt.selection = "inclusive" -- include last char in selection
vim.opt.mouse = "" -- disable mouse support
vim.opt.clipboard = "" -- do not force system clipboard
vim.opt.modifiable = true -- allow buffer modifications

vim.opt.guicursor =
	"n-v-c:block,i-ci-ve:block,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175" -- cursor blinking and settings

-- Folding via Neovim's built-in treesitter. With no parser installed this
-- simply yields no folds (safe fallback); core parsers ship with Neovim 0.12.
vim.opt.foldmethod = "expr" -- use expression for folding
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()" -- use treesitter for folding
vim.opt.foldlevel = 99 -- start with all folds open

vim.opt.splitbelow = true -- horizontal splits go below
vim.opt.splitright = true -- vertical splits go right

vim.opt.wildmenu = true -- tab completion
vim.opt.wildmode = "longest:full,full" -- complete longest common match, full completion list, cycle through with Tab
vim.opt.diffopt:append("linematch:60") -- improve diff display
vim.opt.redrawtime = 10000 -- increase neovim redraw tolerance
vim.opt.maxmempattern = 20000 -- increase max memory

-- ============================================================================
-- STATUSLINE (self-contained, no plugins)
-- ============================================================================

-- File type (plain text, no icons)
local function file_type()
	local ft = vim.bo.filetype
	if ft == "" then
		return "[none]"
	end
	return ft
end

_G.file_type = file_type

-- Statusline highlight groups. Re-applied on every ColorScheme event because
-- loading a colorscheme runs `:highlight clear`, which wipes these custom groups.
local function set_statusline_hl()
	vim.api.nvim_set_hl(0, "StatusLine", { reverse = false })
	vim.api.nvim_set_hl(0, "StatusLineNC", { reverse = false })

	vim.api.nvim_set_hl(0, "StlMode_n", { fg = "#282828", bg = "#98971a", ctermfg = 0, ctermbg = 2, reverse = false, bold = true })
	vim.api.nvim_set_hl(0, "StlMode_i", { fg = "#282828", bg = "#458588", ctermfg = 0, ctermbg = 4, reverse = false, bold = true })
	vim.api.nvim_set_hl(0, "StlMode_v", { fg = "#282828", bg = "#b16286", ctermfg = 0, ctermbg = 5, reverse = false, bold = true })
	vim.api.nvim_set_hl(0, "StlMode_R", { fg = "#282828", bg = "#cc241d", ctermfg = 0, ctermbg = 1, reverse = false, bold = true })
	vim.api.nvim_set_hl(0, "StlMode_c", { fg = "#282828", bg = "#d79921", ctermfg = 0, ctermbg = 3, reverse = false, bold = true })
	vim.api.nvim_set_hl(0, "StlMode_t", { fg = "#282828", bg = "#689d6a", ctermfg = 0, ctermbg = 6, reverse = false, bold = true })
	vim.api.nvim_set_hl(0, "Stl_1", { fg = "#282828", bg = "#cc241d", ctermfg = 0, ctermbg = 1, reverse = false, bold = true })
	vim.api.nvim_set_hl(0, "Stl_2", { fg = "#ebdbb2", bg = "none", ctermfg = 7, ctermbg = "none", reverse = false })
	vim.api.nvim_set_hl(0, "Stl_3", { fg = "#fb4934", bg = "none", ctermfg = 9, ctermbg = "none", reverse = false, bold = true })
	vim.api.nvim_set_hl(0, "Stl_5", { fg = "#ebdbb2", bg = "none", ctermfg = 15, ctermbg = "none", reverse = false })
	vim.api.nvim_set_hl(0, "Stl_6", { fg = "#928374", bg = "none", ctermfg = 8, ctermbg = "none", reverse = false })
	vim.api.nvim_set_hl(0, "Stl_7", { fg = "#a89984", bg = "none", ctermfg = 7, ctermbg = "none", reverse = false })
	vim.api.nvim_set_hl(0, "Stl_8", { fg = "#282828", bg = "#458588", ctermfg = 0, ctermbg = 4, reverse = false, bold = true })
	vim.api.nvim_set_hl(0, "Stl_9", { fg = "#282828", bg = "#83a598", ctermfg = 0, ctermbg = 12, reverse = false })
end
vim.api.nvim_create_autocmd("ColorScheme", { callback = set_statusline_hl })
set_statusline_hl()

local mode_map = {
	["n"] = "NORMAL",
	["no"] = "O-PENDING",
	["nov"] = "O-PENDING",
	["noV"] = "O-PENDING",
	["i"] = "INSERT",
	["ic"] = "INSERT",
	["ix"] = "INSERT",
	["v"] = "VISUAL",
	["V"] = "V-LINE",
	["\22"] = "V-BLOCK",
	["s"] = "SELECT",
	["S"] = "S-LINE",
	["\19"] = "S-BLOCK",
	["R"] = "REPLACE",
	["Rc"] = "REPLACE",
	["Rv"] = "V-REPLACE",
	["Rx"] = "REPLACE",
	["c"] = "COMMAND",
	["cv"] = "EX",
	["ce"] = "EX",
	["r"] = "REPLACE",
	["rm"] = "MORE",
	["r?"] = "CONFIRM",
	["!"] = "SHELL",
	["t"] = "TERMINAL",
}

local function get_mode_hl()
	local m = vim.api.nvim_get_mode().mode
	local label = mode_map[m] or "UNKNOWN"
	local hl = "StlMode_n"
	if m:find("^i") then
		hl = "StlMode_i"
	elseif m:find("^[vV\22sS\19]") then
		hl = "StlMode_v"
	elseif m:find("^R") then
		hl = "StlMode_R"
	elseif m:find("^c") then
		hl = "StlMode_c"
	elseif m:find("^t") then
		hl = "StlMode_t"
	end
	return "%#" .. hl .. "# " .. label .. " "
end
_G.get_mode_hl = get_mode_hl

-- Git branch (cached, refreshes on BufEnter/FocusGained) via plain git CLI
local git_branch = ""
local function update_git_branch()
	local handle = io.popen("git -C " .. vim.fn.expand("%:p:h") .. " branch --show-current 2>/dev/null")
	if handle then
		git_branch = handle:read("*l") or ""
		handle:close()
	end
end
vim.api.nvim_create_autocmd({ "BufEnter", "FocusGained" }, { callback = update_git_branch })
update_git_branch()

_G.get_git_branch = function()
	return git_branch
end

local function stl_cond_1()
	if vim.bo.readonly or not vim.bo.modifiable then
		return "%#Stl_1# %r "
	end
	return ""
end
_G.stl_cond_1 = stl_cond_1

local function stl_cond_9()
	if _G.get_git_branch() ~= "" then
		return "%#Stl_9# %{v:lua.get_git_branch()} "
	end
	return ""
end
_G.stl_cond_9 = stl_cond_9

vim.o.statusline =
	"%{%v:lua.get_mode_hl()%}%{%v:lua.stl_cond_1()%}%#Stl_2# %t %#Stl_3# %m %#StatusLine#%=%#Stl_5# %{v:lua.file_type()}%#Stl_6# │ %#Stl_7# %l:%c %#Stl_8# %p%% %{%v:lua.stl_cond_9()%}"

-- ============================================================================
-- KEYMAPS
-- ============================================================================
vim.g.mapleader = " " -- space for leader
vim.g.maplocalleader = " " -- space for localleader

vim.keymap.set("n", "<F1>", "<cmd>echo<CR>", { desc = "Disable help" })
vim.keymap.set("i", "<F1>", "<C-o><cmd>echo<CR>", { desc = "Disable help" })

vim.keymap.set("n", "<leader>ve", "<cmd>edit $MYVIMRC<CR>", { desc = "Edit config" })
vim.keymap.set("n", "<leader>vr", "<cmd>source $MYVIMRC<CR>", { desc = "Reload config" })

vim.keymap.set("c", "<C-a>", "<Home>", { desc = "Command line start" })
vim.keymap.set("c", "<C-b>", "<Left>", { desc = "Command line left" })
vim.keymap.set("c", "<C-f>", "<Right>", { desc = "Command line right" })
vim.keymap.set("c", "<C-d>", "<Delete>", { desc = "Command line delete" })
vim.keymap.set("c", "<M-b>", "<S-Left>", { desc = "Command line word left" })
vim.keymap.set("c", "<M-f>", "<S-Right>", { desc = "Command line word right" })
vim.keymap.set("c", "<M-d>", "<S-Right><Delete>", { desc = "Command line delete word" })
vim.keymap.set("c", "<Esc>b", "<S-Left>", { desc = "Command line word left" })
vim.keymap.set("c", "<Esc>f", "<S-Right>", { desc = "Command line word right" })
vim.keymap.set("c", "<Esc>d", "<S-Right><Delete>", { desc = "Command line delete word" })
vim.keymap.set("c", "<C-g>", "<C-c>", { desc = "Cancel command line" })
vim.keymap.set("c", "%%", function()
	return vim.fn.expand("%:h") .. "/"
end, { expr = true, desc = "Expand current file directory" })
vim.keymap.set("c", "cwd", "lcd %:p:h", { desc = "Local cd to current file directory" })
vim.keymap.set("c", "cd.", "lcd %:p:h", { desc = "Local cd to current file directory" })
vim.keymap.set("c", "w!!", "w !sudo tee % >/dev/null", { desc = "Write with sudo" })

vim.keymap.set("i", "<C-u>", "<C-g>u<C-u>", { desc = "Undoable delete before cursor" })
vim.keymap.set("i", "<C-w>", "<C-g>u<C-w>", { desc = "Undoable delete word" })

-- better movement in wrapped text
vim.keymap.set("n", "j", function()
	return vim.v.count == 0 and "gj" or "j"
end, { expr = true, silent = true, desc = "Down (wrap-aware)" })
vim.keymap.set("n", "k", function()
	return vim.v.count == 0 and "gk" or "k"
end, { expr = true, silent = true, desc = "Up (wrap-aware)" })

vim.keymap.set("n", "<leader>c", ":nohlsearch<CR>", { desc = "Clear search highlights" })
vim.keymap.set("n", "<leader>/", "<cmd>nohlsearch<CR><C-l>", { desc = "Clear search highlights" })
vim.keymap.set("n", "<leader>l", "<cmd>set list!<CR>", { desc = "Toggle list chars" })
vim.keymap.set("n", "<leader>s", "<cmd>set spell!<CR>", { desc = "Toggle spell" })
vim.keymap.set("n", "<leader>w", "<cmd>set wrap!<CR>", { desc = "Toggle wrap" })

vim.keymap.set("n", "n", "nzzzv", { desc = "Next search result (centered)" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous search result (centered)" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Half page down (centered)" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Half page up (centered)" })

vim.keymap.set("x", "<leader>p", '"_dP', { desc = "Paste without yanking" })
vim.keymap.set({ "n", "v" }, "<leader>x", '"_d', { desc = "Delete without yanking" })

vim.keymap.set("n", "<leader>bn", ":bnext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<leader>bp", ":bprevious<CR>", { desc = "Previous buffer" })
vim.keymap.set("n", "<leader>tn", "<cmd>tabnew<CR>", { desc = "New tab" })

-- Native window navigation (replaces vim-tmux-navigator)
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to bottom window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to top window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })
vim.keymap.set("n", "<leader>mh", "<C-w>h<C-w>_", { desc = "Focus left and maximize height" })
vim.keymap.set("n", "<leader>mj", "<C-w>j<C-w>_", { desc = "Focus down and maximize height" })
vim.keymap.set("n", "<leader>mk", "<C-w>k<C-w>_", { desc = "Focus up and maximize height" })
vim.keymap.set("n", "<leader>ml", "<C-w>l<C-w>_", { desc = "Focus right and maximize height" })

vim.keymap.set("n", "<leader>sv", ":vsplit<CR>", { desc = "Split window vertically" })
vim.keymap.set("n", "<leader>sh", ":split<CR>", { desc = "Split window horizontally" })
vim.keymap.set("", "<leader>=", "<C-w>=", { desc = "Equalize windows" })
vim.keymap.set("n", "<C-Up>", ":resize +2<CR>", { desc = "Increase window height" })
vim.keymap.set("n", "<C-Down>", ":resize -2<CR>", { desc = "Decrease window height" })
vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", { desc = "Decrease window width" })
vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", { desc = "Increase window width" })

vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", { desc = "Move line down" })
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", { desc = "Move line up" })
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

vim.keymap.set("v", "<", "<gv", { desc = "Indent left and reselect" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent right and reselect" })

vim.keymap.set("n", "J", "mzJ`z", { desc = "Join lines and keep cursor position" })

vim.keymap.set("n", "<leader>pa", function() -- show file path
	local path = vim.fn.expand("%:p")
	vim.fn.setreg("+", path)
	print("file:", path)
end, { desc = "Copy full file path" })

vim.keymap.set("", "<leader>ew", ":edit %%", { noremap = false, desc = "Edit in current file directory" })
vim.keymap.set("", "<leader>es", ":split %%", { noremap = false, desc = "Split in current file directory" })
vim.keymap.set("", "<leader>ev", ":vsplit %%", { noremap = false, desc = "Vsplit in current file directory" })
vim.keymap.set("", "<leader>et", ":tabedit %%", { noremap = false, desc = "Tabedit in current file directory" })

vim.keymap.set("n", "Y", "y$", { desc = "Yank to end of line" })
vim.keymap.set("", "zl", "zL", { desc = "Scroll right" })
vim.keymap.set("", "zh", "zH", { desc = "Scroll left" })

-- ============================================================================
-- DIAGNOSTICS (native, works without an LSP installed)
-- ============================================================================
local diagnostic_signs = {
	Error = "E",
	Warn = "W",
	Hint = "H",
	Info = "I",
}

vim.diagnostic.config({
	virtual_text = { prefix = "●", spacing = 4 },
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = diagnostic_signs.Error,
			[vim.diagnostic.severity.WARN] = diagnostic_signs.Warn,
			[vim.diagnostic.severity.INFO] = diagnostic_signs.Info,
			[vim.diagnostic.severity.HINT] = diagnostic_signs.Hint,
		},
	},
	underline = true,
	update_in_insert = false,
	severity_sort = true,
	float = {
		border = "rounded",
		source = true,
		header = "",
		prefix = "",
		focusable = false,
		style = "minimal",
	},
})

vim.keymap.set("n", "<leader>td", function()
	vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end, { desc = "Toggle diagnostics" })
vim.keymap.set("n", "<leader>q", function()
	vim.diagnostic.setloclist({ open = true })
end, { desc = "Open diagnostic list" })
vim.keymap.set("n", "<leader>D", function()
	vim.diagnostic.open_float({ scope = "line" })
end, { desc = "Show line diagnostics" })
vim.keymap.set("n", "<leader>d", function()
	vim.diagnostic.open_float({ scope = "cursor" })
end, { desc = "Show cursor diagnostics" })
vim.keymap.set("n", "<leader>nd", function()
	vim.diagnostic.jump({ count = 1 })
end, { desc = "Next diagnostic" })
vim.keymap.set("n", "<leader>pd", function()
	vim.diagnostic.jump({ count = -1 })
end, { desc = "Prev diagnostic" })

-- ============================================================================
-- USER COMMANDS
-- ============================================================================
vim.api.nvim_create_user_command("E", function(o)
	vim.cmd("edit" .. (o.bang and "!" or "") .. " " .. o.args)
end, { bang = true, nargs = "*", complete = "file" })
vim.api.nvim_create_user_command("W", function(o)
	vim.cmd("write" .. (o.bang and "!" or "") .. " " .. o.args)
end, { bang = true, nargs = "*", complete = "file" })
vim.api.nvim_create_user_command("Wq", function(o)
	vim.cmd("wq" .. (o.bang and "!" or "") .. " " .. o.args)
end, { bang = true, nargs = "*", complete = "file" })
vim.api.nvim_create_user_command("WQ", function(o)
	vim.cmd("wq" .. (o.bang and "!" or "") .. " " .. o.args)
end, { bang = true, nargs = "*", complete = "file" })
vim.api.nvim_create_user_command("Wa", function(o)
	vim.cmd("wall" .. (o.bang and "!" or ""))
end, { bang = true })
vim.api.nvim_create_user_command("WA", function(o)
	vim.cmd("wall" .. (o.bang and "!" or ""))
end, { bang = true })
vim.api.nvim_create_user_command("Q", function(o)
	vim.cmd("quit" .. (o.bang and "!" or ""))
end, { bang = true })
vim.api.nvim_create_user_command("QA", function(o)
	vim.cmd("qall" .. (o.bang and "!" or ""))
end, { bang = true })
vim.api.nvim_create_user_command("Qa", function(o)
	vim.cmd("qall" .. (o.bang and "!" or ""))
end, { bang = true })

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

vim.api.nvim_create_user_command("Stab", function()
	local input = vim.fn.input("set tabstop = softtabstop = shiftwidth = ")
	local n = tonumber(input)
	if n and n > 0 then
		vim.bo.tabstop = n
		vim.bo.softtabstop = n
		vim.bo.shiftwidth = n
	end
	summarize_tabs()
end, {})

-- ============================================================================
-- AUTOCMDS
-- ============================================================================
local augroup = vim.api.nvim_create_augroup("UserConfig", { clear = true })

-- highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
	group = augroup,
	callback = function()
		vim.hl.on_yank()
	end,
})

-- return to last cursor position
vim.api.nvim_create_autocmd("BufReadPost", {
	group = augroup,
	desc = "Restore last cursor position",
	callback = function()
		if vim.o.diff then -- except in diff mode
			return
		end

		local last_pos = vim.api.nvim_buf_get_mark(0, '"') -- {line, col}
		local last_line = vim.api.nvim_buf_line_count(0)

		local row = last_pos[1]
		if row < 1 or row > last_line then
			return
		end

		pcall(vim.api.nvim_win_set_cursor, 0, last_pos)
	end,
})

-- wrap, linebreak and spellcheck on markdown and text files
vim.api.nvim_create_autocmd("FileType", {
	group = augroup,
	pattern = { "markdown", "text", "gitcommit" },
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.linebreak = true
		vim.opt_local.spell = true
	end,
})

-- ============================================================================
-- FLOATING TERMINAL
-- ============================================================================
vim.api.nvim_create_autocmd("TermClose", {
	group = augroup,
	callback = function()
		if vim.v.event.status == 0 then
			vim.api.nvim_buf_delete(0, {})
		end
	end,
})

vim.api.nvim_create_autocmd("TermOpen", {
	group = augroup,
	callback = function()
		vim.opt_local.number = false
		vim.opt_local.relativenumber = false
		vim.opt_local.signcolumn = "no"
	end,
})

local terminal_state = { buf = nil, win = nil, is_open = false }

local function FloatingTerminal()
	if terminal_state.is_open and terminal_state.win and vim.api.nvim_win_is_valid(terminal_state.win) then
		vim.api.nvim_win_close(terminal_state.win, false)
		terminal_state.is_open = false
		return
	end

	if not terminal_state.buf or not vim.api.nvim_buf_is_valid(terminal_state.buf) then
		terminal_state.buf = vim.api.nvim_create_buf(false, true)
		vim.bo[terminal_state.buf].bufhidden = "hide"
	end

	local width = math.floor(vim.o.columns * 0.8)
	local height = math.floor(vim.o.lines * 0.8)
	local row = math.floor((vim.o.lines - height) / 2)
	local col = math.floor((vim.o.columns - width) / 2)

	terminal_state.win = vim.api.nvim_open_win(terminal_state.buf, true, {
		relative = "editor",
		width = width,
		height = height,
		row = row,
		col = col,
		style = "minimal",
		border = "rounded",
	})

	vim.wo[terminal_state.win].winblend = 0
	vim.wo[terminal_state.win].winhighlight = "Normal:FloatingTermNormal,FloatBorder:FloatingTermBorder"
	vim.api.nvim_set_hl(0, "FloatingTermNormal", { bg = "none" })
	vim.api.nvim_set_hl(0, "FloatingTermBorder", { bg = "none" })

	local has_terminal = vim.bo[terminal_state.buf].buftype == "terminal"
	if not has_terminal then
		vim.fn.termopen(os.getenv("SHELL"))
	end

	terminal_state.is_open = true
	vim.cmd("startinsert")

	local term_augroup = vim.api.nvim_create_augroup("FloatingTermLeave_" .. terminal_state.win, { clear = true })
	vim.api.nvim_create_autocmd("BufLeave", {
		group = term_augroup,
		buffer = terminal_state.buf,
		callback = function()
			if terminal_state.is_open and terminal_state.win and vim.api.nvim_win_is_valid(terminal_state.win) then
				vim.api.nvim_win_close(terminal_state.win, false)
				terminal_state.is_open = false
			end
		end,
		once = true,
	})
end

vim.keymap.set("n", "<leader>t", FloatingTerminal, { noremap = true, silent = true, desc = "Toggle floating terminal" })
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { noremap = true, silent = true, desc = "Terminal normal mode" })
vim.keymap.set("t", "<C-q>", function()
	if terminal_state.is_open and terminal_state.win and vim.api.nvim_win_is_valid(terminal_state.win) then
		vim.api.nvim_win_close(terminal_state.win, false)
		terminal_state.is_open = false
	end
end, { noremap = true, silent = true, desc = "Close floating terminal" })

-- Apply transparency last so it sits on top of the default colorscheme.
set_transparent()
