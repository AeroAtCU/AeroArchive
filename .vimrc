" F5 to maximize a buffer
map <F5> <C-W>_<C-W><Bar>

" Highlight word under cursor during searches purple (rarely works)
set updatetime=10
function! HighlightWordUnderCursor()
    if getline(".")[col(".")-1] !~# '[[:punct:][:blank:]]' 
        exec 'match' 'Search' '/\V\<'.expand('<cword>').'\>/' 
    else 
        match none 
    endif
endfunction
autocmd! CursorHold,CursorHoldI * call HighlightWordUnderCursor()

" Highlight the word under the cursor when searching for better visibility
 augroup procsearch
   autocmd!
   au CmdLineLeave * let b:cmdtype = expand('<afile>') | if (b:cmdtype == '/' || b:cmdtype == '?') | call timer_start(200, 'ProcessSearch') | endif
 augroup END
 function! ProcessSearch(timerid)
     let l:patt = '\%#' . @/
     if &ic | let l:patt = '\c' . l:patt | endif
     exe 'match SpellRare /' . l:patt . '/'
 endfunc

" mess with cursor settings
highlight Cursor guifg=white guibg=black
highlight iCursor guifg=white guibg=steelblue
set guicursor=n-v-c:block-Cursor
set guicursor+=i:ver100-iCursor
set guicursor+=n-v-c:blinkon0
set guicursor+=i:blinkwait1
set nu
let &t_ti.="\e[1 q"
let &t_SI.="\e[5 q"
let &t_EI.="\e[1 q"
let &t_te.="\e[0 q"

filetype plugin on
filetype plugin indent on
" show existing tab with 4 spaces width
set tabstop=2
" when indenting with '>', use 4 spaces width
set shiftwidth=2
" On pressing tab, insert 4 spaces
set expandtab

syntax on

set formatoptions-=cro

:highlight MyGroup ctermfg=green
:match MyGroup /cout/ 

" This is currently in the vim syntax file and it works, but it's here for possible future use. Highlits functions (cpp)
syn match    cCustomParen    "(" contains=cParen,cCppParen
syn match    cCustomFunc     "\w\+\s*(" contains=cCustomParen
syn match    cCustomScope    "::"
syn match    cCustomClass    "\w\+\s*::" contains=cCustomScope
hi def link cCustomFunc  Function
hi def link cCustomClass Function
set background=dark

" stop exiting on cntrl z
nnoremap <c-z> <nop>
set pastetoggle=<F2>

" Commands for runnings scripts or programs from command line.
"% gives current filename. ; seperates commands. <CR> carriage return.
"nnoremap <c-m> :w <Enter> :!make <Enter>
nnoremap <c-p> <Esc>:w<CR>:!clear;python3 %<CR>

au FileType py map <C-M> :!clear;python3 % <CR>
au FileType cpp map <C-M> :!clear;make % <CR>

:command W w
:command Q q

"Use TAB to complete when typing words, else inserts TABs as usual.
function! Tab_Or_Complete()
  if col('.')>1 && strpart( getline('.'), col('.')-2, 3 ) =~ '^\w'
    return "\<C-N>"
  else
    return "\<Tab>"
  endif
endfunction
:inoremap <Tab> <C-R>=Tab_Or_Complete()<CR>
:set dictionary="/usr/dict/words"

" Force a different directory to store temp files so it doesn't mess with git
:set directory="~/.vim/swap//"
" No idea what this does
vmap \q c()<ESC>P
      \
" Type kl or lk to exit insert mode
inoremap kl <ESC>
inoremap lk <ESC>
