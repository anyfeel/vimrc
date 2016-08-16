"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Vundle Section
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible            
filetype off               
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'git@github.com:vim-scripts/sessionman.vim.git'
Plugin 'L9'
Plugin 'git://git.wincent.com/command-t.git'
Plugin 'Valloric/YouCompleteMe' 
Plugin 'git@github.com:scrooloose/nerdtree.git'
Plugin 'git@github.com:scrooloose/syntastic.git'
Plugin 'git@github.com:vim-scripts/taglist.vim.git'
Bundle 'tpope/vim-surround'
Plugin 'mileszs/ack.vim'
Plugin 'tpope/vim-repeat'
Plugin 'Raimondi/delimitMate'

call vundle#end()           
filetype plugin indent on 

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Setting Section
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let mapleader = ","
map <silent> <leader><cr> :noh<cr>

syntax enable
set background=dark
colorscheme solarized

command W w 
command WQ wq
command Wa wa
command Wq wq
command Q q 
command QA qa
command Qa qa
command Wqa wqa
command WA wa
cnoremap w!! w !sudo tee % >/dev/null

set nu
set ai 
set si 
set wrap 
set history=500
set autoread
set so=8
set mat=2
let $LANG='en' 
set langmenu=en
set wildmenu
set wildignore=*.o,*~,*.pyc
set ruler
set hid
set backspace=eol,start,indent
set whichwrap+=<,>,h,l
set ignorecase
set smartcase
set hlsearch
set incsearch 
set lazyredraw 
set magic
set showmatch 
set noerrorbells
set novisualbell
set t_vb=
set foldcolumn=1
set encoding=utf8
set ffs=unix,dos,mac
set nobackup
set nowb
set noswapfile
set expandtab
"set smarttab
set shiftwidth=4
set tabstop=4
set lbr
set tw=500
set tm=500
set laststatus=2
set t_Co=256

vnoremap <silent> * :call VisualSelection('f', '')<CR>
vnoremap <silent> # :call VisualSelection('b', '')<CR>

map j gj
map k gk

map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l


noremap <Up> <NOP>
inoremap <Down> <NOP>
inoremap <Right> <NOP>
inoremap <Left> <NOP>

noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Right> <NOP>
noremap <Left> <NOP>

nmap  w=  :resize +3<CR>
nmap  w-  :resize -3<CR>
nmap  w.  :vertical resize -3<CR>
nmap  w,  :vertical resize +3<CR>

inoremap ˙ <C-o>h
inoremap ∆ <C-o>j
inoremap ˚ <C-o>k
inoremap ¬ <C-o>l

" togglelist
map tt :TlistToggle<CR>
let Tlist_WinWidth = 45

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! CmdLine(str)
	exe "menu Foo.Bar :" . a:str
	emenu Foo.Bar
	unmenu Foo
endfunction 

function! VisualSelection(direction, extra_filter) range
	let l:saved_reg = @"
	execute "normal! vgvy"

	let l:pattern = escape(@", '\\/.*$^~[]')
	let l:pattern = substitute(l:pattern, "\n$", "", "")

	if a:direction == 'b'
		execute "normal ?" . l:pattern . "^M"
	elseif a:direction == 'gv'
		call CmdLine("Ag \"" . l:pattern . "\" " )
	elseif a:direction == 'replace'
		call CmdLine("%s" . '/'. l:pattern . '/')
	elseif a:direction == 'f'
		execute "normal /" . l:pattern . "^M"
	endif

	let @/ = l:pattern
	let @" = l:saved_reg
endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Misc functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

if has("autocmd")
	au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

func! DeleteTrailingWS()
	exe "normal mz"
	%s/\s\+$//ge
	exe "normal `z"
endfunc

autocmd BufWrite *.py :call DeleteTrailingWS()
autocmd BufWrite *.coffee :call DeleteTrailingWS()

function! CurDir()
	let curdir = substitute(getcwd(), $HOME, "~", "g")
	return curdir
endfunction
"set statusline=[%n]\ %f%m%r%h\ \|\ \ \ %{CurDir()}\ \ \|%=\|\ %l,%c\ %p%%\ \ 
set statusline=[%n]\ %f%m%r%h\\|%=\|\ %l,%c\ %p%%\ 


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugin Section
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NERDtree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let g:NERDTreeWinPos = "left"
map <leader>nn :NERDTreeToggle<CR>

" YouCompleteMe
let g:ycm_register_as_syntastic_checker = 0
let g:ycm_python_binary_path = 'python'
let g:ycm_min_num_of_chars_for_completion = 1
let g:ycm_always_populate_location_list = 0
let g:ycm_global_ycm_extra_conf = "~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py"
nnoremap ff :YcmCompleter GoTo<CR> 
nnoremap fr :YcmCompleter GoToReferences<CR> 

" Syntastic (syntax checker)
"let g:syntastic_check_on_open = 1
"let g:syntastic_always_populate_loc_list = 0
"let g:syntastic_auto_loc_list = 0 
"let g:syntastic_check_on_wq = 1
"let g:syntastic_lua_checkers = ["luac", "luacheck"]
"let g:syntastic_lua_luacheck_args = "--no-unused-args" 

" fugitive
set diffopt=vertical,filler
autocmd BufRead,BufNewFile *.zt set filetype=ztest

" delimitMate 
let delimitMate_expand_space = 1
au FileType c,c++,python,lua let b:delimitMate_expand_space = 1

let delimitMate_expand_cr = 1
au FileType c,c++,python,lua let b:delimitMate_expand_cr = 1

" Ack 
map <c-j> :Ack<space>
