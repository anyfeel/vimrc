"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Vim-Plug Section
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible
call plug#begin('~/.vim/plugged')

Plug 'git@github.com:tpope/vim-surround.git'
Plug 'tpope/vim-fugitive'
Plug 'Valloric/YouCompleteMe'
Plug 'ervandew/supertab'
Plug 'git@github.com:scrooloose/nerdtree.git'
Plug 'git@github.com:majutsushi/tagbar.git'
Plug 'mileszs/ack.vim'
Plug 'tpope/vim-repeat'
Plug 'Raimondi/delimitMate'
Plug 'altercation/vim-colors-solarized'
Plug 'Yggdroot/LeaderF'
Plug 'iamcco/markdown-preview.vim'
Plug 'nsf/gocode', {'rtp': 'vim/'}
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'chr4/nginx.vim'
Plug 'junegunn/vim-easy-align'
Plug 'ludovicchabant/vim-gutentags'
Plug 'skywind3000/asyncrun.vim'
Plug 'w0rp/ale'
Plug 'mhinz/vim-signify'
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-indent'
Plug 'kana/vim-textobj-syntax'
Plug 'kana/vim-textobj-function', { 'for':['c', 'cpp', 'vim', 'java'] }
Plug 'sgur/vim-textobj-parameter'
Plug 'tpope/vim-unimpaired'
Plug 'justinmk/vim-dirvish'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

call plug#end()

filetype plugin indent on

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Setting Section
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let mapleader = ","
map <silent> <leader><cr> :noh<cr>

"let g:solarized_termcolors=256

syntax enable
set background=dark
colorscheme solarized

" alt meta key
function! Terminal_MetaMode(mode)
    set ttimeout
    if $TMUX != ''
        set ttimeoutlen=30
    elseif &ttimeoutlen > 80 || &ttimeoutlen <= 0
        set ttimeoutlen=80
    endif
    if has('nvim') || has('gui_running')
        return
    endif
    function! s:metacode(mode, key)
        if a:mode == 0
            exec "set <M-".a:key.">=\e".a:key
        else
            exec "set <M-".a:key.">=\e]{0}".a:key."~"
        endif
    endfunc
    for i in range(10)
        call s:metacode(a:mode, nr2char(char2nr('0') + i))
    endfor
    for i in range(26)
        call s:metacode(a:mode, nr2char(char2nr('a') + i))
        call s:metacode(a:mode, nr2char(char2nr('A') + i))
    endfor
    if a:mode != 0
        for c in [',', '.', '/', ';', '[', ']', '{', '}']
            call s:metacode(a:mode, c)
        endfor
        for c in ['?', ':', '-', '_']
            call s:metacode(a:mode, c)
        endfor
    else
        for c in [',', '.', '/', ';', '{', '}']
            call s:metacode(a:mode, c)
        endfor
        for c in ['?', ':', '-', '_']
            call s:metacode(a:mode, c)
        endfor
    endif
endfunc

call Terminal_MetaMode(0)

command W w
command WQ wq
command Wa wa
command Wq wq
command Q q
command QA qa
command Qa qa
command Wqa wqa
command WA wa
" async run with fugitive
command! -bang -nargs=* -complete=file Make AsyncRun -program=make @ <args>
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
set shiftwidth=4
set tabstop=4
set lbr
set tw=500
set tm=500
set laststatus=2
set t_Co=256
set listchars=eol:¬,tab:>·,trail:~,extends:>,precedes:<,space:␣
set nolist
set completeopt-=preview
set foldmethod=manual
set updatetime=100
set rtp+=/usr/local/opt/fzf
set rtp+=~/.vim/bundle/gocode/vim
set foldmethod=manual

au BufRead,BufNewFile Makefile* set noexpandtab

vnoremap <C-c> "*y"
set tags=./.tags;,.tags

vnoremap <silent> * :call VisualSelection('f', '')<CR>
vnoremap <silent> # :call VisualSelection('b', '')<CR>

map j gj
map k gk

map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

nnoremap <Up>    <C-W>k
nnoremap <Down>  <C-W>j
nnoremap <Left>  <C-W>h
nnoremap <Right> <C-W>l

nmap  w=  :resize +3<CR>
nmap  w-  :resize -3<CR>
nmap  w.  :vertical resize -3<CR>
nmap  w,  :vertical resize +3<CR>

inoremap ˙ <C-o>h
inoremap ∆ <C-o>j
inoremap ˚ <C-o>k
inoremap ¬ <C-o>l

noremap <M-1> 1gt
noremap <M-2> 2gt
noremap <M-3> 3gt
noremap <M-4> 4gt
noremap <M-5> 5gt
noremap <M-6> 6gt
noremap <M-7> 7gt
noremap <M-8> 8gt
noremap <M-9> 9gt
noremap <M-0> :tablast<CR>

" tagbar
map tt :TagbarToggle<CR>
let g:tagbar_left = 1
let g:tagbar_width = 30

autocmd BufNewFile,BufRead *.conf set syntax=nginx

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

" remember last edit position
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
"set statusline=%f%m%r%h\ \ \ \ %{tagbar#currenttag('[%s]\ ','')}\ \|%=\|\ %l,%c\ %p%%

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugin Section
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NERDtree
let NERDTreeIgnore = ['\.pyc$']
autocmd StdinReadPre * let s:std_in=1
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let g:NERDTreeWinPos = "left"
map <leader>nn :NERDTreeToggle<CR>

" YouCompleteMe
let g:ycm_auto_trigger = 99
let g:ycm_register_as_syntastic_checker = 0
let g:ycm_show_diagnostics_ui = 0
let g:ycm_enable_diagnostic_signs = 0
let g:ycm_enable_diagnostic_highlighting = 0
let g:ycm_complete_in_comments = 1
let g:ycm_collect_identifiers_from_comments_and_strings = 0
let g:ycm_python_binary_path = 'python'
let g:ycm_min_num_of_chars_for_completion = 2
let g:ycm_always_populate_location_list = 0
let g:ycm_add_preview_to_completeopt = 0
let g:ycm_autoclose_preview_window_after_completion=1
let g:ycm_key_list_select_completion = []
let g:ycm_key_list_previous_completion = []
let g:ycm_global_ycm_extra_conf = "~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py"
let g:ycm_filetype_whitelist = {'python':1, 'c':1, 'cpp':1, 'go':1, 'lua':1}
nnoremap ff :YcmCompleter GoTo<CR>

let g:ycm_semantic_triggers =  {
\   'c' : ['->', '.'],
\   'objc' : ['->', '.', 're!\[[_a-zA-Z]+\w*\s', 're!^\s*[^\W\d]\w*\s',
\             're!\[.*\]\s'],
\   'ocaml' : ['.', '#'],
\   'cpp,cuda,objcpp' : ['->', '.', '::'],
\   'perl' : ['->'],
\   'php' : ['->', '::'],
\   'cs,java,javascript,typescript,d,python,perl6,scala,vb,elixir,go' : ['.'],
\   'ruby' : ['.', '::'],
\   'lua' : ['.', ':'],
\   'erlang' : [':'],
\ }

" Supertab
let g:SuperTabDefaultCompletionType = "<c-n>"

" fugitive
set diffopt=vertical,filler

" zset highlight
autocmd BufRead,BufNewFile *.zt set filetype=ztest
autocmd BufRead,BufNewFile *.t set filetype=ztest

" leaderf
let g:Lf_ShortcutF = '<c-p>'
let g:Lf_ShortcutB = '<m-n>'
map <leader>ll :LeaderfFunction<CR>
noremap <c-n> :LeaderfMru<cr>
noremap <m-n> :LeaderfBuffer<cr>
noremap <m-m> :LeaderfTag<cr>
let g:Lf_StlSeparator = { 'left': '', 'right': '', 'font': '' }

let g:Lf_RootMarkers = ['.project', '.root', '.svn', '.git']
let g:Lf_WorkingDirectoryMode = 'Ac'
let g:Lf_WindowHeight = 0.30
let g:Lf_CacheDirectory = expand('~/.vim/cache')
let g:Lf_ShowRelativePath = 0
let g:Lf_HideHelp = 1
let g:Lf_StlColorscheme = 'powerline'
let g:Lf_PreviewResult = {'Function':0, 'BufTag':0}

" Ack
" let g:ackprg = 'ag --nogroup --nocolor --column'
let g:ackprg = 'ag --vimgrep'
map <c-y> :Ack <C-R><C-W><CR>

nnoremap <leader>p :set invpaste paste?<CR>
set pastetoggle=<leader>p
set showmode

augroup filetype_lua
    autocmd!
    autocmd FileType lua setlocal iskeyword+=:
augroup END

" cscope
if !has("mac")
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
endif

imap <C-\> <Plug>delimitMateS-Tab

"s: Find this C symbol
"g: Find this definition
"c: Find functions calling this function
"a: Find places where this symbol is assigned a value
"d: Find functions called by this function
map <leader>ss :cs find s <C-R>=expand("<cword>")<CR><CR>
map <leader>gg :cs find g <C-R>=expand("<cword>")<CR><CR>
map <leader>cc :cs find c <C-R>=expand("<cword>")<CR><CR>
map <leader>aa :cs find a <C-R>=expand("<cword>")<CR><CR>
map <leader>dd :scs find d <C-R>=expand("<cword>")<CR><CR>

function! g:CscopeDone()
	exec "cs add ".fnameescape(g:asyncrun_text)
endfunc

function! g:CscopeUpdate(workdir, cscopeout)
	let l:cscopeout = fnamemodify(a:cscopeout, ":p")
	let l:cscopeout = fnameescape(l:cscopeout)
	let l:workdir = (a:workdir == '')? '.' : a:workdir
	try | exec "cs kill ".l:cscopeout | catch | endtry
	exec "AsyncRun -post=call\\ g:CscopeDone() ".
				\ "-text=".l:cscopeout." "
				\ "-cwd=".fnameescape(l:workdir)." ".
				\ "cscope -b -R -f ".l:cscopeout
endfunc

noremap <F9> :call g:CscopeUpdate(".", "cscope.out")<cr>

" gutentags
let g:gutentags_project_root = ['.root', '.svn', '.git', '.hg', '.project']
let g:gutentags_ctags_tagfile = '.tags'
let s:vim_tags = expand('~/.cache/tags')
let g:gutentags_cache_dir = s:vim_tags

let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
let g:gutentags_ctags_extra_args += ['--c-kinds=+px']

if !isdirectory(s:vim_tags)
   silent! call mkdir(s:vim_tags, 'p')
endif

" async run
let g:asyncrun_open = 6
let g:asyncrun_bell = 1
nnoremap <F10> :call asyncrun#quickfix_toggle(6)<cr>

" ale

" signify
nnoremap <leader>gt :SignifyToggle<CR>
nnoremap <leader>gh :SignifyToggleHighlight<CR>
nnoremap <leader>gr :SignifyRefresh<CR>
nnoremap <leader>gd :SignifyDiff<CR>
nnoremap <F8> :SignifyDiff<CR>

" hunk jumping
nmap <leader>gj <plug>(signify-next-hunk)
nmap <leader>gk <plug>(signify-prev-hunk)
