" For compatibility's sake, all defaults that are different between Vim and
" Neovim are excplicity specified again.

" Plugins
call plug#begin()
Plug 'vim-airline/vim-airline'
Plug 'morhetz/gruvbox'
Plug 'ctrlpvim/ctrlp.vim'
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'airblade/vim-gitgutter'
Plug 'APZelos/blamer.nvim'
call plug#end()

" Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)

" look and feel
set t_Co=256
set background=dark
colo gruvbox

if has("gui_running")
  set guioptions-=m  "menu bar
  set guioptions-=T  "toolbar
  set guioptions-=r  "scrollbar
  if has("gui_gtk2") || has("gui_gtk3")
    set guifont=Courier\ New\ 14
  elseif has("gui_photon")
    set guifont=Courier\ New:s14
  elseif has("gui_kde")
    set guifont=Courier\ New/14/-1/5/50/0/0/0/1/0
  elseif has("gui_macvim")
    set guifont=PragmataPro:h14
  elseif has("gui_win32")
    set guifont=Consolas:h14
  elseif has("x11")
    set guifont=-*-courier-medium-r-normal-*-*-180-*-*-m-*-*
  endif
endif

" Basics
" ======
set nocompatible
scriptencoding utf-8
filetype on
syntax on
set noshowmode
set showcmd
set rnu
set nu
set cursorline
set ruler
autocmd InsertLeave,WinEnter,FocusGained * :setlocal number relativenumber
autocmd InsertEnter,WinLeave,FocusLost   * :setlocal number norelativenumber

set backspace=indent,eol,start  " Backspace for dummies
set showmatch                   " Show matching brackets/parenthesis
set smartcase                   " Case sensitive when uc present
set incsearch                   " Find as you type search
set hlsearch                    " Highlight search terms
set wildmenu                    " Show list instead of just completing
set wildmode=list:longest,full  " Command <Tab> completion, list matches, then longest common part, then all.
set whichwrap=b,s,h,l,<,>,[,]   " Backspace and cursor keys wrap too
set scrolljump=5                " Lines to scroll when cursor leaves screen
set scrolloff=3                 " Minimum lines to keep above and below cursor
" set list                      " show white space
set nofoldenable                " disable folding
set splitbelow
set splitright
set synmaxcol=2048
set ttyfast 										" use fast terminal

set ts=4 sts=4 sw=4 expandtab 	"set tab to space, width 4
" Status Line
" ===========

set laststatus=2
set statusline=\ %<%f\                   " Filename
set statusline+=%w%h%m%r                 " Options
set statusline+=\ [%{&ff}/%Y]            " Filetype
set statusline+=\ [%{getcwd()}]          " Current dir
set statusline+=%=%-14.(%l,%c%V%)\ %p%%\ " Right aligned file nav info

" Misc
" ====
" change cursor shape based on mode
if exists('$TMUX')
    let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
"   let &t_SR = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=2\x7\<Esc>\\"
    let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
    if $TERM_PROGRAM ==# 'iTerm.app'
        let &t_SI = "\<Esc>]50;CursorShape=1\x7"
        let &t_SR = "\<Esc>]50;CursorShape=2\x7"
        let &t_EI = "\<Esc>]50;CursorShape=0\x7"
    endif
endif

"no clipboard mess
set clipboard=

" Key Mappings
" ============
let mapleader = " "

" disalbe F1
:nmap <F1> :echo<CR>
:imap <F1> <C-o>:echo<CR>

" Edit vimr configuration file
nnoremap <Leader>ve :e $MYVIMRC<CR>
" " Reload vimr configuration file
nnoremap <Leader>vr :source $MYVIMRC<CR>

" fzf
" Mapping selecting mappings
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

" Wrapped lines goes down/up to next row, rather than next line in file.
nnoremap j gj
nnoremap k gk

" Easier moving in tabs and windows
map <C-J> <C-W>j<C-W>_
map <C-K> <C-W>k<C-W>_
map <C-L> <C-W>l<C-W>_
map <C-H> <C-W>h<C-W>_

"Emacs-style movement keys for command line
:cnoremap <C-a>  <Home>
:cnoremap <C-b>  <Left>
:cnoremap <C-f>  <Right>
:cnoremap <C-d>  <Delete>
:cnoremap <M-b>  <S-Left>
:cnoremap <M-f>  <S-Right>
:cnoremap <M-d>  <S-right><Delete>
:cnoremap <Esc>b <S-Left>
:cnoremap <Esc>f <S-Right>
:cnoremap <Esc>d <S-right><Delete>
:cnoremap <C-g>  <C-c>

" fast toggle listchars
nmap <leader>l :set list!<CR>

" fast toggle spell checking
nmap <leader>s :set spell!<CR>

" fast toggle linewrapping
nmap <leader>w :set wrap!<CR>

" so that c-u can be undone by <Esc>u
inoremap <c-u> <c-g>u<c-u>
inoremap <c-w> <c-g>u<c-w>

" Stupid shift key fixes
if has("user_commands")
    command! -bang -nargs=* -complete=file E e<bang> <args>
    command! -bang -nargs=* -complete=file W w<bang> <args>
    command! -bang -nargs=* -complete=file Wq wq<bang> <args>
    command! -bang -nargs=* -complete=file WQ wq<bang> <args>
    command! -bang Wa wa<bang>
    command! -bang WA wa<bang>
    command! -bang Q q<bang>
    command! -bang QA qa<bang>
    command! -bang Qa qa<bang>
endif

" Yank from the cursor to the end of the line, to be consistent with C and D.
nnoremap Y y$

" replay @q by pressing space
nnoremap <Space> @q

" Code folding options
nmap <leader>f0 :set foldlevel=0<CR>
nmap <leader>f1 :set foldlevel=1<CR>
nmap <leader>f2 :set foldlevel=2<CR>
nmap <leader>f3 :set foldlevel=3<CR>
nmap <leader>f4 :set foldlevel=4<CR>
nmap <leader>f5 :set foldlevel=5<CR>
nmap <leader>f6 :set foldlevel=6<CR>
nmap <leader>f7 :set foldlevel=7<CR>
nmap <leader>f8 :set foldlevel=8<CR>
nmap <leader>f9 :set foldlevel=9<CR>

" Toggle search highlighting
" nmap <silent> <leader>/ :set invhlsearch<CR>
noremap <leader>/ :nohls<cr><c-l>

"fast new tab
nmap <leader>t :tabnew<CR>

"fast buffer switch
nmap <leader>n :bn<CR>
nmap <leader>p :bp<CR>

" Shortcuts
" Change Working Directory to that of the current file
cmap cwd lcd %:p:h
cmap cd. lcd %:p:h

" Visual shifting (does not exit Visual mode)
vnoremap < <gv
vnoremap > >gv

" For when you forget to sudo.. Really Write the file.
cmap w!! w !sudo tee % >/dev/null

" Some helpers to edit mode
" http://vimcasts.org/e/14
cnoremap %% <C-R>=expand('%:h').'/'<cr>
map <leader>ew :e %%
map <leader>es :sp %%
map <leader>ev :vsp %%
map <leader>et :tabe %%

" Adjust viewports to the same size
map <leader>= <C-w>=

" Map <Leader>ff to display all lines with keyword under cursor
" and ask which one to jump to
nmap <leader>ff [I:let nr = input("Which one: ")<Bar>exe "normal " . nr ."[\t"<CR>

" Easier horizontal scrolling
map zl zL
map zh zH


" Functions etc
" =============

" Set tabstop, softtabstop and shiftwidth to the same value
command! -nargs=* Stab call Stab()
function! Stab()
  let l:tabstop = 1 * input('set tabstop = softtabstop = shiftwidth = ')
  if l:tabstop > 0
    let &l:sts = l:tabstop
    let &l:ts = l:tabstop
    let &l:sw = l:tabstop
  endif
  call SummarizeTabs()
endfunction

function! SummarizeTabs()
  try
    echohl ModeMsg
    echon 'tabstop='.&l:ts
    echon ' shiftwidth='.&l:sw
    echon ' softtabstop='.&l:sts
    if &l:et
      echon ' expandtab'
    else
      echon ' noexpandtab'
    endif
  finally
    echohl None
  endtry
endfunction

function! SetCursorLineColor(mode)
  if a:mode == 'i'
    hi CursorLine ctermbg=194
    hi CursorLineNr ctermbg=190
  elseif a:mode == 'r'
    hi CursorLine ctermbg=224
    hi CursorLineNr ctermbg=218
  else
    hi CursorLine ctermbg=229
    hi CursorLineNr ctermbg=226
  endif
endfunction

function! InsertLeaveSetCursorLineColor()
    hi CursorLine ctermbg=229
    hi CursorLineNr ctermbg=226
endfunction

" au InsertEnter * call SetCursorLineColor(v:insertmode)
" au InsertLeave * call InsertLeaveSetCursorLineColor()

" to handle exiting insert mode via a control-C
" inoremap <c-c> <c-o>:call InsertLeaveSetCursorLineColor()<cr><c-c>
