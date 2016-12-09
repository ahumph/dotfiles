""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Sections:
"	-> General
"	-> VIM UI
"	-> Colours and Fonts
"	-> Text, tab and indent
"	-> Visual mode
"	-> Command mode
"	-> Moving, tabs and buffers
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ---> General
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
execute pathogen#infect()

""" Vundle config
set nocompatible
filetype off

" set the runtime path to include Vundle and initialise
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/.vim/bundle/vundle')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
Plugin 'vim-scripts/ctrlp.vim'
"Plugin 'mileszs/ack.vim'
"Plugin 'scrooloose/nerdcommenter'
"Plugin 'tpope/vim-unimpaired'
Plugin 'scrooloose/nerdtree'
Plugin 'majutsushi/tagbar'
"Plugin 'ervandew/supertab'
Plugin 'airblade/vim-gitgutter'
"Plugin 'justinmk/vim-sneak'
"Plugin 'tommcdo/vim-lion'
"Plugin 'tpope/vim-surround'
Plugin 'xolox/vim-colorscheme-switcher'
Plugin 'flazz/vim-colorschemes'
"Plugin 'godlygeek/tabular'
"Plugin 'plasticboy/vim-markdown'
"Plugin 'tmhedberg/SimpylFold'

" Keep plugin commands between vundle#begin/end
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
" Plugin from http://vim-scripts.org/vim/scripts.html
"Plugin 'L9'
" Git plugin not hosted on GitHub
Plugin 'git://git.wincent.com/command-t.git'

" All of your Plugins must be added before the following line
call vundle#end()

filetype plugin indent on
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

""""""""""""""""""""""
" NERDTree
""""""""""""""""""""""

au VimEnter * NERDTree
au VimEnter * set winfixwidth

let NERDTreeQuitOnOpen=1

nmap <A-Left> <C-t>
nmap <A-Right> <C-]>
nmap <F9> :NERDTreeToggle<CR>
nmap <F10> :TagbarToggle<CR>

"Close NERDTree if it is the last open buffer
autocmd WinEnter * call s:CloseIfOnlyNerdTreeLeft()

" Close all open buffers on entering a window if the only
" buffer that's left is the NERDTree buffer
function! s:CloseIfOnlyNerdTreeLeft()
  if exists("t:NERDTreeBufName")
    if bufwinnr(t:NERDTreeBufName) != -1
      if winnr("$") == 1
        q
      endif
    endif
  endif
endfunction

autocmd VimEnter * NERDTreeClose
autocmd TabEnter * NERDTreeClose

""""""""""""""""""""""

""""""""""""""""""""""
" CtrlP
""""""""""""""""""""""

" Working directory by default
let g:ctrlp_working_path_mode = 'a'
let g:ctrlp_custom_ignore = {
    \ 'dir': '\v[\/]\.(git|hg|svn)$',
    \ 'file': '\v\.(exe|so|dll|o|swp|swo|out)$',
    \ 'link': '',
    \ }
set wildignore+=*/tmp/*,*.so,*.swp,*.swo,*.o*,*.zip,*.exe

""""""""""""""""""""""

""""""""""""""""""""""
" Syntastic
""""""""""""""""""""""
let g:syntastic_c_checkers = ['gcc', 'make']
let g:syntastic_c_include_dirs = ['/mnt/ext/waf/', '/mnt/ext/buildroot/output/build/']
"""""""""""""""""""""""

" In case BS isn't set
set bs=2

" Set line numbers on
set number
set relativenumber

" Allow mouse usage
set mouse=a
set ttymouse=xterm2

" Allow filetype plugins
filetype plugin on

" Disable messages from Cscope
 set nocscopeverbose

" Set how many lines of history VIM has to remember
set history=3000

" Define extra key combinations with mapleader
let mapleader = "\<Space>"
let g:mapleader = "\<Space>"

" Fast Saving
nmap <leader>w :w!<cr>

" Vsplit windows
map <leader>v :vsplit

" Splits
set splitright
set splitbelow

" Scratch right
map <C-s> <CR>:Vscratch<CR>

" Reload vimrc after edit
" autocmd! bufwritepost vimrc source ~/.vimrc

let g:sneak#streak = 1
nmap s <Plug>Sneak_s
nmap S <Plug>Sneak_S
xmap s <Plug>Sneak_s
xmap S <Plug>Sneak_S
omap s <Plug>Sneak_s
omap S <Plug>Sneak_S

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ---> VIM UI
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set 7 lines to the cursors - moving vertical
set so=7

" Turn on Wild menu
set wildmode=longest,list,full
set wildmenu

" Always show position
set ruler

" Ignore case when searching
set ignorecase
set smartcase

" Highlight search terms
set hlsearch


" Make search like browser search
set incsearch

" Disable redraw while executing macros
set nolazyredraw

" Show matching braces
set showmatch

" How many tenths of a second to blink
"set mat=2

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ---> Colours and Fonts
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax enable
set synmaxcol=128

if has("gui_running")
  set guioptions=agiv
  "set guifont=Inconsolata\ 10
  "set guifont=Courier\ New\ 10
  set guifont=Liberation\ Mono\ 10
  "set t_Co=256
  "colorscheme synic
  "set background=dark
  colorscheme mustang
  set cursorline
  hi CursorLine term=bold cterm=bold guibg=black
  hi StatusLine guibg=Black guifg=DodgerBlue
  " Git Gutter
  highlight clear SignColumn
  highlight GitGutterAdd guifg=LimeGreen guibg=#202020
  highlight GitGutterChange guifg=orange guibg=#202020
  highlight GitGutterDelete guifg=Red guibg=#202020
  highlight GitGutterChangeDelete guifg=Red guibg=#202020
  "highlight GitGutterChangeDelete guibg=#202020
  " Vimdiff
  hi DiffAdd cterm=none ctermfg=Black ctermbg=Green gui=none guifg=Black guibg=Green
  hi DiffDelete cterm=none ctermfg=Black ctermbg=Red gui=none guifg=Black guibg=Red
  hi DiffChange cterm=none ctermfg=Black ctermbg=Yellow gui=none guifg=Black guibg=Orange
  hi DiffText cterm=none ctermfg=Black ctermbg=Magenta gui=none guifg=Black guibg=Magenta
else
  colorscheme delek
  set background=dark
  "set background="0;35"
  set cursorline
  hi CursorLine term=bold cterm=bold ctermbg=Black guibg=black
endif

nnoremap <silent> <Leader>0 :NextColorScheme<CR>
nnoremap <silent> <Leader>9 :PrevColorScheme<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ---> Text, tab, indent
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set expandtab
set shiftwidth=4
set tabstop=4
set smarttab

set lbr
set tw=500

" Auto indent, smart indent, wrap lines
set ai
set si
set wrap

" Highlight text over 80 columns
nnoremap <silent> <Leader>1 :match ErrorMsg '\%>80v.\+'<CR>
nnoremap <silent> <Leader>2 :match Normal '\%>80v.\+'<CR>
nnoremap <silent> <Leader>3 :match ErrorMsg '\%>130v.\+'<CR>
nnoremap <silent> <Leader>4 :match Normal '\%>130v.\+'<CR>

" Highlight trailing whitespace
:highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
nnoremap <silent> <Leader>5 :match ErrorMsg /\s\+$/<CR>
nnoremap <silent> <Leader>6 :match Normal /\s\+$/<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ---> Visual Mode
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Useful
" In visual mode pressing * or # searches current selection
vnoremap <silent> * :call VisualSearch('f')<CR>
vnoremap <silent> # :call VisualSearch('b')<CR>

" Pressing gv = vimgrep after selected text
vnoremap <silent> gv :call VisualSearch('gv')<CR>
map <leader>g :vimgrep // **/*.<left><left><left><left><left><left><left>

function! CmdLine(str)
  exe "menu Foo.Bar :" . a:str
  emenu Foo.Bar
  unmenu Foo
endfunction

function! VisualSearch(direction) range
  let l:saved_reg = @"
  execute "normal! vgvy"

  let l:pattern = escape(@", '\\/.*$^~[]')
  let l:pattern = substitute(l:pattern, "\n$", "", "")

  if a:direction == 'b'
	execute "normal ?" . l:pattern > "^M"
  elseif a:direction == 'gv'
	call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*')
  elseif a:direction == 'f'
	execute "normal /" . l:pattern . "^M"
  endif

  let @/ = l:pattern
  let @" = l:saved_reg
endfunction

vnoremap <silent><leader>R :<C-U>call HighlightRegion('Red')<CR>
vnoremap <silent><leader>G :<C-U>call HighlightRegion('Green')<CR>
vnoremap <silent><leader>B :<C-U>call HighlightRegion('Blue')<CR>
vnoremap <silent><leader>C :<C-U>call HighlightRegion('Clear')<CR>

function! HighlightRegion(color)
  hi Red guibg=#8E2018
  hi Blue guibg=#3399FF
  hi Green guibg=#00CC00
  hi Clear guibg=#000000
  let l_start = line("'<")
  let l_end = line("'>") + 1
  execute 'syntax region '.a:color.' start=/\%'.l_start.'l/ end=/\%'.l_end.'l/'
  if a:color == 'Clear'
  	execute 'syntax on'
  endif
endfunction


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ---> Command Mode
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Smart mappings on command line
cno $h e ~/
cno $d e ~/Desktop/
cno $j e ./
cno $c e <C-\>eCurrentFileDir("e")<cr>

" $q useful when browsing command line
cno $q <C-\>eDeleteTillSlash()<cr>

" Bash like keys for command line
cnoremap <C-A>	<Home>
cnoremap <C-E>	<End>
cnoremap <C-K>	<C-U>

cnoremap <C-P>	<Up>
cnoremap <C-N>	<Down>

func! Cwd()
  let cwd = getcwd()
  return "e " . cwd
endfunc

func! DeleteTillSlash()
  let g:cmd = getcmdline()
  let g:cmd_edited = substitute(g:cmd, "\\(.*\[/\]\\).*", "\\1", "")
  if g:cmd == g:cmd_edited
	let g:cmd_edited = substitute(g:cmd, "\\(.*\[/\]\\).*/", "\\1", "")
  endif
  return g:cmd_edited
endfunc

func! CurrentFileDir(cmd)
  return a:cmd . " " . expand("%:p:h") . "/"
endfunc

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ---> Moving, tabs, buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Map space to / and c-space to ? (search forward and back)
map <c-space> *
"map <c-space> #

" Open in new tab
nnoremap <silent><Leader>h :q<bar>tabnew#<CR>

" Disable highlight for search with <leader>Enter 
map <c-cr> :noh<cr>

" Move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Quicker line jumps
"nmap <CR> G

" Tab config
map <leader>tn :tabnew<cr>
map <leader>te :tabedit
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove

" Ctags in Vsplit
"map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
"map <C-}> :sp <CR>:exec("tag ".expand("<cword>"))<CR>

" Cscope jump to new tab
nnoremap <silent> <Leader>] <C-w><C-]><C-w>T

" Split sizing
nnoremap <silent> <Leader>d :exe "vertical resize " . (winwidth(0) * 3/2)<CR>
nnoremap <silent> <Leader>a :exe "vertical resize " . (winwidth(0) * 2/3)<CR>
nnoremap <silent> <Leader>x :exe "vertical resize " . (winwidth(0) * 1/2)<CR>
nnoremap <silent> <Leader>s <C-W>=

nnoremap <silent> <Leader>q :exe "resize " . (winheight(0) * 3/2)<CR>
nnoremap <silent> <Leader>z :exe "resize " . (winheight(0) * 2/3)<CR>

" System clipboard
vmap <Leader>y "+y
vmap <Leader>d "+d
nmap <Leader>p "+p
nmap <Leader>P "+P
vmap <Leader>p "+p
vmap <Leader>P "+P

" Region expanding
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

" Session manager
let g:session_autosave = 'no'
let g:session_autosave_periodic = 0
let g:session_verbose_messages = 0
let g:session_default_to_last = 1

let g:NERDTreeWinSize = 40

" Quickfix jumping
nmap cn :cn<CR>
nmap cp :cp<CR>

" Quicker tag jumping
nmap <Leader>t :ta<CR>
