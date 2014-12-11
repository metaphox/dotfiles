set nocompatible
scriptencoding utf-8
filetype on

" statusline
set laststatus=2
set statusline=\ %.20F    " Full path to the file
set statusline+=\ %y        " File type
set statusline+=%=        " Switch to the right side
set statusline+=%l        " Current line
set statusline+=/         " Separator
set statusline+=%-4L      " Total lines

"" color stuff
" a 256 color terminal is assumed.
" Skip the name alias, just use number index.
" http://www.calmar.ws/vim/256-xterm-24bit-rgb-color-chart.html
set t_Co=256

hi clear
syntax reset

" change cursor shape based on mode
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"
" reset the cursor when exit
autocmd VimLeave * silent !echo -ne "\033]112\007"

" Mode Indication -Prominent!
function! InsertStatuslineColor(mode)
  if a:mode == 'i'
    hi statusline ctermfg=green
  elseif a:mode == 'r'
    hi statusline ctermfg=green
  else
    hi statusline ctermfg=green
  endif
endfunction

function! InsertLeaveActions()
  hi statusline ctermfg=green
endfunction

au InsertEnter * call InsertStatuslineColor(v:insertmode)
au InsertLeave * call InsertLeaveActions()

" to handle exiting insert mode via a control-C
inoremap <c-c> <c-o>:call InsertLeaveActions()<cr><c-c>

" default the statusline to green when entering Vim
hi statusline ctermfg=green cterm=NONE

set cursorline
hi CursorLine   cterm=NONE ctermbg=229


