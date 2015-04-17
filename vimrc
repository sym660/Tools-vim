set nocp
"don't ignore case when searching
set noic
"General Settings
:filetype plugin on
:syntax on
set cursorline
set showcmd
set nu
set autoread
set autowrite
set hlsearch
set incsearch
set ignorecase smartcase
set autoindent
set smartindent
set cindent
set cinkeys=0{,0},!^F,o,O,e " default is: 0{,0},0),:,0#,!^F,o,O,e
set iskeyword=a-z,A-Z,48-57,_
filetype plugin indent on
"tab Settings
set shiftwidth=4
set tabstop=4
set softtabstop=4
set expandtab
set backspace=2
"set statusline=\ %F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l/%L:%c
set laststatus=0
set ruler
set splitright
set splitbelow
autocmd BufReadPost *
\ if line("'\"") > 0 && line ("'\"") <= line("$") |
\ exe "normal g'\"" |
\ endif

"let search result always appear in middle
nnoremap n nzz
nnoremap N Nzz
let s:searchmode = 2

"imm ab
iab cpp_main #include <iostream>
\<CR>using namespace std;
\<CR>int main() {
\<CR>return 0;
\<CR>}
iab py_main #!/usr/local/bin/python
iab debug_print printf("mx: at %s(%d)\n", __FILE__, __LINE__);
cab tabe tabl\|tabe
cab fork :tabe %:p

"imm color
syntax on
set background=dark
let g:solarized_termcolors=256
let g:solarized_contrast="high"
colo solarized
"let g:zenburn_high_Contrast=1
"colo zenburn 
"let g:molokai_original = 1
"colo molokai
set diffopt=filler,context:1000000

"Key Mappings
nmap <F1> <C-W><C-W>
nmap <F2> :TlistToggle<CR>
nmap <F3> :set paste<CR>
nmap <F4> :set nopaste<CR>
nmap <C-G> :!echo %:p<cr>
nmap <C-H> :tabp<CR>
nmap <C-L> :tabn<CR> 
vmap <C-Y> "zy 
nmap <C-P> "zp
nmap <PageUp> :cp<cr>
nmap <PageDown> :cn<cr>
nmap ,p "zP
nmap ,nt :NERDTree<cr>
nmap ,t :tabe\|tag <C-R>=expand("<cword>")<CR><CR>
nmap ,tt :tabe\|tag
nmap ,. @: 
nmap cw "zyw
nmap tt :STags 
nmap tc :tabc<cr>
nmap to :tabo<cr>
nmap - [c
nmap = ]c
nmap + mn
nmap _ mp
nmap ca :tabo\|only\|q<cr>
nmap gu :!global -u<CR>
nmap gt :tabe\|Gtags
nmap gs :vsplit\|Gtags
nmap gp :Gtags -P 
nmap } :Gtags -r \b<C-R>=expand("<cword>")<CR>\b<CR>
nmap g} :Gtags -g \b<C-R>=expand("<cword>")<CR>\b<CR>
nmap t} :tabe\|Gtags -r \b<C-R>=expand("<cword>")<CR>\b<CR>
nmap tg} :tabe\|Gtags -g \b<C-R>=expand("<cword>")<CR>\b<CR>
nmap tp} :tabe\|Gtags -P <C-R>=expand("<cword>")<CR><CR>
nmap s} :call SPLIT_GTAG_R(expand("<cword>"))<cr>
nmap sg} :call SPLIT_GTAG_G(expand("<cword>"))<cr>
nmap stf :call OPEN_IN_TAB(expand("<cfile>"))<cr>

"fold
"set foldmethod=syntax
"let cpp_fold = 1
"let perl_fold = 1
let perl_nofold_packages = 1
nnoremap <space> @=((foldclosed(line( '.' )) < 0)? 'zc' : 'zO' )<CR>
set foldopen-=search "dont open folds when search
set foldopen-=undo

"omni-completion
set completeopt=longest,menu,preview
let OmniCpp_ShowScopeInAbbr=1
let OmniCpp_NamespaceSearch = 1
let OmniCpp_GlobalScopeSearch = 1
let OmniCpp_ShowAccess = 1
let OmniCpp_ShowPrototypeInAbbr = 1
let OmniCpp_MayCompleteDot = 1
let OmniCpp_MayCompleteArrow = 1
let OmniCpp_MayCompleteScope = 1
let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]
au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
set completeopt=menuone,menu,longest
autocmd FileType python set omnifunc=python3complete#Complete

"------------------------------------------------------------------------------------------------------
"------------------------------------------------------------------------------------------------------
"Plugin Settings
"taglist
let Tlist_Show_One_File=1
let Tlist_Exit_OnlyWindow=1
let Tlist_Use_Right_Window=0

"CScope
set cscopequickfix=s-,c-,d-,i-,t-,e-
cs kill -1
cab cs_s :tabe\|cs find s
cab cs_e :tabe\|cs find e
cab cs_g :tabe\|cs find g
cab cs_c :tabe\|cs find c
command! -nargs=1 SearchCurrentFile :call s:SearchCurrentFile(<q-args>)
cab scf SearchCurrentFile
cab cwd lcd %:p:h
function! s:SearchCurrentFile(pattern)
let searchcmd = 'vimgrep '. a:pattern . ' ' . expand("%")
exec searchcmd
endfunction

"NERDTree
let g:NERDTreeShowBookmarks=1
let g:NERDTreeDirArrows=0

"super tab
let g:SuperTabRetainCompletionType=2
let g:SuperTabDefaultCompletionType="<C-X><C-O>"

"gtags
function! SPLIT_GTAG_G(file)
    execute 'winc o'
    execute 'vsplit'
    execute 'Gtags -g' a:file
    execute 'ccl'
    execute 'cw'
    execute 'winc k'
endfunction
function! SPLIT_GTAG_R(file)
    execute 'winc o'
    execute 'vsplit'
    execute 'Gtags -r' a:file
    execute 'ccl'
    execute 'cw'
    execute 'winc k'
endfunction


"ctags/cscope switcher
set tags=./tags;
set cst
set csto=1
set csprg=cscope.sh"cscope.sh: #!/bin/sh     cscope -C "$@"
command! -nargs=1 STags :call SetTag(<q-args>)
function! SetTag(name)
    execute "set tags=~/tags/".a:name.".tags"
endfunction

"vim-bookmark
let g:bookmark_sign = '>>'
let g:bookmark_annotation_sign = '##'
let g:bookmark_auto_save = 1
"let g:bookmark_highlight_lines = 1
let g:bookmark_center = 1
