"most part of this awesome vimrc file was shamelessly copied from Riobard (
"github.com/riobard
set nocompatible               " be iMproved
filetype off                   " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required!

" GitHub repos
Bundle 'gmarik/vundle'
"auto close () [] etc
Bundle 'Townk/vim-autoclose'
"remaps . in a way that plugins can tap into it.
Bundle 'tpope/vim-repeat'
"Vim runtime files for Haml, Sass, and SCSS
Bundle 'tpope/vim-haml'
"adds CoffeeScript support to the vim
Bundle 'kchmck/vim-coffee-script'
"line up text by character
Bundle 'godlygeek/tabular'
"FS browser
Bundle 'scrooloose/nerdtree'
"Markdown support
Bundle 'plasticboy/vim-markdown'
"syntax checking
Bundle 'scrooloose/syntastic'
"Grab some text and send it to a GNU Screen / tmux session.
Bundle 'jpalardy/vim-slime'

Bundle 'wincent/command-t'

"Rio's black magic with python keywords
"Bundle 'riobard/vim-cute-python'
"scala support
"Bundle 'riobard/scala.vim'
"not that good on putty tho
Bundle 'altercation/vim-colors-solarized'
"Git wrapper...
Bundle 'tpope/vim-fugitive'

" Vim-scripts repos
""surroundings editing, http://www.vim.org/scripts/script.php?script_id=1697
Bundle 'surround.vim'
"configure % to match more than just single characters
Bundle 'matchit.zip'
"highlights configuration files for nginx
Bundle 'nginx.vim'
"plugin for Cocoa/Objective-C
Bundle 'cocoa.vim'
"plugin for applescript
Bundle 'applescript.vim'
Bundle 'httplog'
"needs ctags
Bundle 'taglist.vim'


set t_Co=256
set background=dark
colo solarized

" Go-lang support
if !empty($GOROOT)
    set rtp+=$GOROOT/misc/vim
endif

filetype plugin indent on " required by Vundle


"let g:AutoCloseProtectedRegions = []
"let g:AutoCloseProtectedRegions = ["Comment", "String", "Character"]


" Shortcuts
"  use w!! to 'sudo' save after you opened the file without 'sudo' first
cmap w!! w !sudo tee % >/dev/null

" clear search highlights easily
nmap <silent> ,/ :let @/=""<CR>



" Use Q for formatting the current paragraph (or selection)
vmap Q gq
nmap Q gqap

" set tab gleich wie soft tab gleich wie shiftwidth
set ts=4 sts=4 sw=4 noexpandtab
" c.f. Stab for a quick setting function


" speed up Vim command typing by using ; (no shift key) as : (=shift+;)
nnoremap ; :

set wildignore=*.swp,*.bak,*.pyc,*.class " ignore some file extensions when completing names by pressing Tab
set title                " change the terminal's titl

" Silent mode. No beeping.
set visualbell noerrorbells


" Read modelines
set modeline modelines=5

set background=dark
" Hightlight cursor position
set cursorline  "cursorcolumn

"set laststatus=2 statusline=%F%m%r%h%w%y%=[%l,%c][%P/%L]
set laststatus=2    " always show the status line
set statusline=%{fugitive#statusline()}\ %<%F\ %y%h%m%r%=%-14.(%l,%c%V%)\ [%P/%L]
set titlestring=%<%F

set tabstop=4 softtabstop=4 shiftwidth=4 expandtab shiftround
set autoindent copyindent smartindent
set fenc=utf8 fencs=utf8,gb2312,big5
set fileformat=unix fileformats=unix,dos,mac

"set shellcmdflag=-ic       " use an interactive login shell for $PATH

set showmatch     " set show matching parenthesis

syntax enable

set fo+=m   " break lines at multibyte chars (for asian chars)
set fo+=M   " do not insert a space before/after multibyte char when joining

" intuitive backspacing in insert mode
set backspace=indent,eol,start
 " allow backspacing over everything in insert mode

" Turn on hidden.  Don’t worry about the name. What this does is allow Vim to
" manage multiple buffers effectively.  * The current buffer can be put to the
" background without writing to disk; * When a background buffer becomes
" current again, marks and undo-history are remembered.
set hidden

" Remap ` to '.  These are very similar keys. Typing 'a will jump to the line
" in the current file marked with ma. However, `a will jump to the line and
" column marked with ma. It is more useful in any case I can imagine, but it
" is located way off in the corner of the keyboard. The best way to handle
" this is just to swap them:
nnoremap ' `
nnoremap ` '


" Map leader to ','.  The leader character is your own personal modifier key,
" as g is Vim’s modifier key (when compared to vi). The default leader is \,
" but this is not located standardly on all keyboards and requires a pinky
" stretch in any case.
let mapleader = ","
" <SPACE> is also a good choice. Note: you can of course have several “
" personal modifier keys” simply by mapping a sequence, but the leader key is
" handled more formally.

" shortcut to rapidly toggle `set list`
nmap <leader>l :set list!<CR>

" Use these symbols for tab and EOL
" set listchars=tab:▸\ ,trail:·,eol:¶
set listchars=tab:⇥\ ,trail:␣,eol:↩,nbsp:␣,extends:…,precedes:…


" Keep a longer history By default, Vim only remembers the last 20 commands
" and search patterns entered. It’s nice to boost this up:
set history=1000
set undolevels=1000      " use many levels of undo


" Set the terminal title.  A running gvim will always have a window title, but
" when vim is run within an xterm, by default it inherits the terminal’s
" current title.  This gives e.g. | page.html (~) - VIM |.
set title


" use CSS stylesheet and XHTML for TOhtml
let html_use_css = 1
let use_xhtml = 1


" By default, pressing <TAB> in command mode will choose the first possible
" completion with no indication of how many others there might be. The
" following configuration lets you see what your other options are:
set wildmenu

" To have the completion behave similarly to a shell, i.e. complete only up to
" the point of ambiguity (while still showing you what your options are), also
" add the following:
set wildmode=full

" Use case-smart searching. These two options, when set together, will make
" /-style searches case-sensitive only if there is a capital letter in the
" search expression. *-style searches continue to be consistently
" case-sensitive.

set ignorecase  " ignore case when searching
set smartcase   " ignore case if search pattern is all lowercase,
                " case-sensitive otherwise



" Maintain more context around the cursor.  When the cursor is moved outside
" the viewport of the current window, the buffer is scrolled by a single line.
" Setting the option below will start the scrolling three lines before the
" border, keeping more context around where you’re working.
set scrolloff=3
" Typing zz is also handy; it centers the window on the cursor without moving
" the cursor. (But watch out for ZZ!)



" Enable limited line numbering
" It’s often useful to know where you are in a buffer, but full line
" numbering is distracting. Setting the option below is a good compromise:
set ruler
" Now in the bottom right corner of the status line there will be something
" like: 529, 35 68%, representing line 529, column 35, about 68% of the way to
" the end.


" Stifle many interruptive prompts: The “Press ENTER or type command to
" continue” prompt is jarring and usually unnecessary. You can shorten
" command-line text and other info tokens with, e.g.:
set shortmess=atI
" See :help shortmess for the breakdown of what this changes. You can also
" pare things down further if you like.


set incsearch   " incremental search (search as you type)
set hlsearch    " highlight search result


" Put syntastic into passive mode by default
let g:syntastic_mode_map = { 'mode': 'active',
                            \ 'active_filetypes': ['ruby'],
                            \ 'passive_filetypes':  ['php'] }


" OS X default ctags version is too old
let Tlist_Ctags_Cmd='/usr/local/bin/ctags'
let Tlist_Use_Split_Window = 1
com TT NERDTree | TlistToggle

" Trigger tag auto hightlight every second. Note this is done by writing swap
" file to trigger the CursorHold event. Low values will incur more disk I/O.
set updatetime=1000

autocmd FileType nerdtree setlocal norelativenumber
autocmd FileType taglist  setlocal norelativenumber


" Move by screen line
" Normal node
map <Up>    gk
map <Down>  gj
" Insert mode
imap <Up>   <C-o>gk
imap <Down> <C-o>gj
" Visual mode
vmap <D-j> gj
vmap <D-k> gk
vmap <D-0> g0   " head of line
vmap <D-6> g^   " beginning of line
vmap <D-4> g$   " end of line
" Normal mode
nmap <D-j> gj
nmap <D-k> gk
nmap <D-4> g$
nmap <D-6> g^
nmap <D-0> g0

" Switch between diferent split windows
" Ctrl- prefix is overly used by other plugins.
"map <C-j> <C-w>j
"map <C-k> <C-w>k
"map <C-h> <C-w>h
"map <C-l> <C-w>l

" Option key as prefix. NOTE: iTerm 2 sends Option key as +Esc. Meta doesn't
" work properly.
map <Esc>j <C-w>j
map <Esc>k <C-w>k
map <Esc>h <C-w>h
map <Esc>l <C-w>l


" Resize window
if bufwinnr(1)
    map - <C-W>+
    map _ <C-W>-
    map + <C-W><
    map = <C-W>>
endif

" moving windows
"map <S-j> <C-w>J
"map <S-k> <C-w>K
"map <S-h> <C-w>H
"map <S-l> <C-w>L


" Switch tabs
" Normal mode
map <C-tab>   :tabnext<CR>
map <C-S-tab> :tabprev<CR>
" Insert mode
imap <C-tab>   <Esc>:tabnext<CR>i
imap <C-S-tab> <Esc>:tabprev<CR>i


" show softwarpped continuing line
"set showbreak=…    " UTF8 causing problem in Linux
"set showbreak=...
"set showbreak=>\ "
set showbreak=-



" Emacs keybinding for command line mode editing
cnoremap <C-A> <Home>
cnoremap <C-B> <Left>
cnoremap <C-D> <Del>
cnoremap <C-E> <End>
cnoremap <C-F> <Right>



" Vim-slime
let g:slime_target = "tmux"


" Tabularize plugin: align equal signs and friends
"if exists(":Tabularize") " TODO: for some reason this test fails at startup
    nmap <Leader>a= :Tabularize /=<CR>
    vmap <Leader>a= :Tabularize /=<CR>

    nmap <Leader>a: :Tabularize /:<CR>
    vmap <Leader>a: :Tabularize /:<CR>

    nmap <Leader>a/ :Tabularize /\/\/<CR>
    vmap <Leader>a/ :Tabularize /\/\/<CR>

    nmap <Leader>a# :Tabularize /#<CR>
    vmap <Leader>a# :Tabularize /#<CR>

    "Alternative style: spaces after colons
    "nmap <Leader>a: :Tabularize /:\zs<CR>
    "vmap <Leader>a: :Tabularize /:\zs<CR>
"endif



if exists("+autochdir")
    " change working directory to the one containing the file opened
    set autochdir
endif


" General GUI settings. I don't like keeping an additional .gvimrc file.
if has("gui_running")
    set guioptions-=T       " no toolbar
    set go-=r               " no right scrollbar
    set go-=l               " no left scrollbar
    set go-=b               " no bottom scrollbar
    set go-=L               " no scrollbar even if split
    set go-=R               " no scrollbar even if split


    " Make MacVim looks cool
    if has("gui_macvim")
        "set guifont=Monaco:h12
        set guifont=Menlo:h14

        " Enable meta- kind binding for GUI
        set macmeta

        map <M-j> <C-w>j
        map <M-k> <C-w>k
        map <M-h> <C-w>h
        map <M-l> <C-w>l

        " transparent background
        "set bg=dark
        if &background == "dark"
            "hi normal guibg=black
            "set transparency=5
        endif
    endif
endif

"enable 'bracketed paste mode' in OS X > 10.7
"http://stackoverflow.com/questions/5585129/pasting-code-into-terminal-window-into-vim-on-mac-os-x

if &term =~ "xterm.*"
    let &t_ti = &t_ti . "\e[?2004h"
    let &t_te = "\e[?2004l" . &t_te
    function XTermPasteBegin(ret)
        set pastetoggle=<Esc>[201~
        set paste
        return a:ret
    endfunction
    map <expr> <Esc>[200~ XTermPasteBegin("i")
    imap <expr> <Esc>[200~ XTermPasteBegin("")
    cmap <Esc>[200~ <nop>
    cmap <Esc>[201~ <nop>
endif

"quick toggle absolute and relative line number

function! NumberToggle()
  if(&relativenumber == 1)
    set number
  else
    set relativenumber
  endif
endfunc

nnoremap <C-n> :call NumberToggle()<cr>

"Go all line number craziness
set relativenumber
autocmd InsertEnter * :set number
autocmd InsertLeave * :set relativenumber


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


" Invisible char colours
highlight NonText ctermfg=0 guifg=#4a4a59
highlight SpecialKey ctermfg=0 guifg=#4a4a59
" highlight group for whitespace highlighting
" 234 = 1c1c1c
" highlight ExtraWhitespace ctermbg=10 guibg=darkblue
" match ExtraWhitespace /\s\+$/
" autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
" autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
" autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()
