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
"Plugin 'git@github.com:scrooloose/syntastic.git'
Plugin 'git@github.com:vim-scripts/taglist.vim.git'
Bundle 'tpope/vim-surround'
Plugin 'mileszs/ack.vim'
Plugin 'tpope/vim-repeat'
Plugin 'Raimondi/delimitMate'
Plugin 'Glench/Vim-Jinja2-Syntax'
Plugin 'vim-scripts/DrawIt'
Plugin 'Yggdroot/indentLine'
Plugin 'altercation/vim-colors-solarized'
Plugin 'davidhalter/jedi'
Plugin 'ctrlpvim/ctrlp.vim'

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
set listchars=eol:¬,tab:>·,trail:~,extends:>,precedes:<,space:␣
set nolist
"set cursorline

vnoremap <C-c> "*y"
set tags=tags;/

vnoremap <silent> * :call VisualSelection('f', '')<CR>
vnoremap <silent> # :call VisualSelection('b', '')<CR>

map j gj
map k gk

map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

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

autocmd BufWrite * :call DeleteTrailingWS()

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
let NERDTreeIgnore = ['\.pyc$']
autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let g:NERDTreeWinPos = "left"
map <leader>nn :NERDTreeToggle<CR>

" YouCompleteMe
let g:ycm_register_as_syntastic_checker = 0
let g:ycm_complete_in_comments = 1
let g:ycm_collect_identifiers_from_comments_and_strings = 1
let g:ycm_python_binary_path = 'python'
let g:ycm_min_num_of_chars_for_completion = 1
let g:ycm_always_populate_location_list = 0
let g:ycm_autoclose_preview_window_after_completion=1
let g:ycm_global_ycm_extra_conf = "~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py"
nnoremap ff :YcmCompleter GoTo<CR>
nnoremap fr :YcmCompleter GoToImplementationElseDeclaration<CR>

" Syntastic (syntax checker) ---> start
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*
"
"let g:syntastic_warning_symbol = "WW"
"let g:syntastic_error_symbol = "EE"
"let g:syntastic_style_warning_symbol = "SW"
"let g:syntastic_style_error_symbol = "SE"
"
"let g:syntastic_check_on_open = 1
"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_wq = 0
"
"let g:syntastic_lua_checkers = ["luacheck", "luac"]
"let g:syntastic_lua_luacheck_args = "--no-unused-args"
"
"let g:syntastic_python_checkers = ["pyflakes"]
"let g:syntastic_python_pylint_args='--disable=C0111,C0112,C0301,C0302,R0903'

"let g:syntastic_ignore_files=[".*\.py$", ".*\.lua$"]
"
" Syntastic (syntax checker) ---> end

" fugitive
set diffopt=vertical,filler
autocmd BufRead,BufNewFile *.zt set filetype=ztest

" delimitMate
let delimitMate_expand_space = 1
au FileType c,c++,python,lua let b:delimitMate_expand_space = 1

let delimitMate_expand_cr = 1
au FileType c,c++,python,lua let b:delimitMate_expand_cr = 1

" indentLine
autocmd Filetype json let g:indentLine_setConceal = 0

" ctrlp
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'
set wildignore+=*/tmp/*,*.so,*.swp,*.zip
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ 'link': 'some_bad_symbolic_links',
  \ }

if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
  let g:ctrlp_use_caching = 0
endif

" Ack
let g:ackprg = 'ag --nogroup --nocolor --column'
"map <c-y> :Ack<space>
map <c-y> :cs find g<space>

imap <expr> <CR> pumvisible() ? "\<c-y>" : "<Plug>delimitMateCR"
"set gcr=n-v-c:ver25-Cursor/lCursor,ve:ver35-Cursor,o:hor50-Cursor,i-ci:ver25-Cursor/lCursor

nnoremap <leader>p :set invpaste paste?<CR>
set pastetoggle=<leader>p
set showmode

augroup filetype_lua
    autocmd!
    autocmd FileType lua setlocal iskeyword+=:
augroup END

if has("cscope")
  set csprg=/usr/bin/cscope
  set csto=1
  "set cst
  set nocsverb
  " add any database in current directory
  if filereadable("cscope.out")
      cs add cscope.out
  endif
  set csverb
endif

map <C-\> :cs find c <C-R>=expand("<cword>")<CR><CR>
