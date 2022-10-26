syntax on "likes to be on the top for some reason

" Force a different directory to store temp files so it doesn't mess with git
set directory="~/.vim/swap//"
" make is so sessions properly load the vimrc
"set sessionoptions+=globals
"set sessionoptions+=localoptions
"set sessionoptions+=options

" press Space to toggle the current fold open/closed. However, if the cursor is not in a fold, move to the right (the default behavior). In addition, with the manual fold method, you can create a fold by visually selecting some lines, then pressing Space. 
nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
vnoremap <Space> zf

autocmd BufWinLeave *.* mkview
autocmd BufWinEnter *.* silent loadview

setlocal suffixesadd+=.yml
setlocal suffixesadd+=.yaml
setlocal suffixesadd+=.fj
autocmd BufNewFile,BufRead *.fj set syntax=c
autocmd BufNewFile,BufRead *.fj set filetype=c


" F5 to maximize window size
map <F5> <C-W>_<C-W><Bar>
" F1 to copy filename
map <F1> :let @+=@%<CR>
"F2 to replace spaces with _ in the last insert
map <F2> mz`[v`]:s/ /_/g<CR>`z 
"cntrl-/ to comment code (like other editors; doesn't take syntax into account)
map <C-/> <Esc>mz`<0<C-V>`>0I#<Esc>`z


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

"nnoremap z/ :if AutoHighlightToggle()<Bar>set hls<Bar>endif<CR>
"function! AutoHighlightToggle()
"   let @/ = ''
"   if exists('#auto_highlight')
"     au! auto_highlight
"     augroup! auto_highlight
"     setl updatetime=4000
"     echo 'Highlight current word: off'
"     return 0
"  else
"    augroup auto_highlight
"    au!
"    "au CursorHold * let @/ = '\V\<'.escape(expand('<cword>'), '\').'\>'
"    exec 'match' 'Search' '/\V\<'.expand('<cword>').'\>/' 
"    augroup end
"    setl updatetime=10
"    echo 'Highlight current word: ON'
"  return 1
" endif
"endfunction


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



" stop exiting on cntrl z
nnoremap <c-z> <nop>

" Commands for runnings scripts or programs from command line.
"% gives current filename. ; seperates commands. <CR> carriage return.
"nnoremap <c-m> :w <Enter> :!make <Enter>
nnoremap <c-p> <Esc>:w<CR>:!clear;python3 %<CR>

au FileType py map <C-M> :!clear;python3 % <CR>
au FileType cpp map <C-M> :!clear;make % <CR>

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

" Type kl or lk to exit insert mode
inoremap kl <ESC>
inoremap lk <ESC>

" Set searching to be case insensitive (unless there's a caps)
set ignorecase
set smartcase
set incsearch


" This is currently in the vim syntax file and it works, but it's here for possible future use. Highlits functions (cpp)
syn match    cCustomParen    "(" contains=cParen,cCppParen
syn match    cCustomFunc     "\w\+\s*(" contains=cCustomParen
syn match    cCustomScope    "::"
syn match    cCustomClass    "\w\+\s*::" contains=cCustomScope
hi def link cCustomFunc  Function
hi def link cCustomClass Function

set formatoptions-=cro

":highlight MyGroup ctermfg=green
":match MyGroup /cout/ 

" Make todo not the same color as searches
hi Todo term=bold,reverse ctermfg=0 ctermbg=2 gui=bold guifg=bg guibg=DarkGreen
":hi Search term=bold,reverse ctermfg=0 ctermbg=2 gui=bold guifg=bg guibg=DarkGreen
set hlsearch
hi IncSearch cterm=NONE ctermfg=Red ctermbg=Red

set background=dark
color desert
hi CursorLine   cterm=NONE ctermbg=DarkBlue ctermfg=NONE guibg=NONE guifg=NONE
set cursorline "Make a dark blue visible cursorline

