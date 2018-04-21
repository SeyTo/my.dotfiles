set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" GIT wrapper
Plugin 'tpope/vim-fugitive'
" CODE pair brackets
Plugin 'jiangmiao/auto-pairs'
" SYNTAX
Plugin 'scrooloose/syntastic'
Plugin 'sekel/vim-vue-syntastic'
Plugin 'posva/vim-vue'
Plugin 'digitaltoad/vim-pug'
" AUTO-COMPLETE
Plugin 'Valloric/YouCompleteMe'
" TODO need to work on this
" Plugin 'ternjs/tern_for_vim'
" FUZZY-FINDER
Plugin 'junegunn/fzf.vim'
" FILE-EXPLORER
Plugin 'scrooloose/nerdtree'
" SNIPPETS
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
" ZEN-MODE
Plugin 'junegunn/goyo.vim'
Plugin 'junegunn/limelight.vim'
" LATEX
" Plugin 'xuhdev/vim-latex-live-preview'
" MISC
" Plugin 'chase/vim-ansible-yaml'

call vundle#end()
filetype plugin indent on
filetype plugin on
source ~/.vim/functions.vim

" EDITOR
set shiftwidth=2
set tabstop=2
set expandtab
set breakindent
set sts=2
syntax on
set title
set laststatus=2
set number
set ruler
set noswapfile
set backup
set autoread
set autowrite
set smartindent
set foldmethod=indent
set foldlevel=99
" Don't redraw while executing macros (good performance config)
set lazyredraw
" Show matching brackets when text indicator is over them
set showmatch
" How many tenths of a second to blink when matching brackets
set mat=2
" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500
" Add a bit extra margin to the left of number
" set nuw=8

set path+=**
set undodir=~/.vim/tmp/undo//
set backupdir=~/.vim/tmp/backup//
set directory=~/.vim/tmp/swap//
set hlsearch
set t_Co=256

" QUICK SAVE
" save this file and quit
nnoremap ZZ :wq!<enter>
" save current file
nmap ZS :w!<CR>
" save all open files 
nmap ZA :wa!<CR>

" yank to clipboard directly
vnoremap <silent> +y y:call ClipboardYank()<cr>
vnoremap <silent> +d d:call ClipboardYank()<cr>
nnoremap <silent> +D D:call ClipboardYank()<cr>
nnoremap <silent> +p :call ClipboardPaste()<cr>p

" MISC SHORTCUTS
" use jj instead of escape
inoremap jj <Esc>
" search and replace the selected text in V mode
vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>
"
" nerdtree
inoremap <F1> <Esc>:NERDTreeToggle<CR>
nnoremap <F1> :NERDTreeToggle<CR>

" goyo & limelight vim
nnoremap <F3><F3> :Goyo<enter>
nnoremap <F3><F4> :Limelight!!<cr>

" MOVEMENTS
" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l
" select next and previous TABS
map <silent> <C-o> :tabn<CR>
map <silent> <C-i> :tabp<CR>

" SETUPs
" powerline
python3 from powerline.vim import setup as powerline_setup
python3 powerline_setup()
python3 del powerline_setup

" latex
" autocmd BufRead,BufNewFile  *.tex set filetype=tex

" python ycm
" let g:ycm_python_binary_path = '/usr/bin/python3.6'

" YCM
let g:ycm_max_num_candidates = 10

" fuzzy find in a dir
" command Find execute "!find . -type f | fzf | xargs echo $1"

" eclim autocompleter
let g:EclimCompletionMethod = 'omnifunc'

" autoclose if only window left is nerdtree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" comments
nnoremap // :call ToggleComment()<cr>
vnoremap // :call ToggleComment()<cr>

" search for selected text
vnoremap <C-f> y/<C-R>"<CR>

" :W sudo saves the file
" (useful for handling the permission-denied error)
command W w !sudo tee % > /dev/null

" TODO remove autocmd
function! s:goyo_enter()
  silent !tmux set status off
  silent !tmux list-panes -F '\#F' | grep -q Z || tmux resize-pane -Z
  set noshowmode
  set noshowcmd
  set scrolloff=999
  Limelight
  let b:quitting = 0
  let b:quitting_bang = 0
  autocmd QuitPre <buffer> let b:quitting = 1
  cabbrev <buffer> q! let b:quitting_bang = 1 <bar> q!
  " ...
endfunction

function! s:goyo_leave()
  silent !tmux set status on
  silent !tmux list-panes -F '\#F' | grep -q Z && tmux resize-pane -Z
  set showmode
  set showcmd
  set scrolloff=5
  Limelight!
  " Quit Vim if this is the only remaining buffer
  if b:quitting && len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) == 1
    if b:quitting_bang
      qa!
    else
      qa
    endif
  endif
  " ...
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()

let g:goyo_height=80

" Limelight
" Color name (:help cterm-colors) or ANSI code
let g:limelight_conceal_ctermfg = 'gray'
let g:limelight_conceal_ctermfg = 240

" Color name (:help gui-colors) or RGB color
let g:limelight_conceal_guifg = 'DarkGray'
let g:limelight_conceal_guifg = '#777777'

" Default: 0.5
let g:limelight_default_coefficient = 0.7

" Number of preceding/following paragraphs to include (default: 0)
let g:limelight_paragraph_span = 4

" Beginning/end of paragraph
"   When there's no empty line between the paragraphs
"   and each paragraph starts with indentation
let g:limelight_bop = '^\s'
let g:limelight_eop = '\ze\n^\s'

" Highlighting priority (default: 10)
"   Set it to -1 not to overrule hlsearch
let g:limelight_priority = -1

" Syntastic 
" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
" let g:syntastic_check_on_open = 1
" let g:syntastic_check_on_wq = 0
" Syntastic for vue
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_vue_checkers = ['eslint']
let local_eslint = finddir('node_modules', '.;') . '/.bin/eslint'
if matchstr(local_eslint, "^\/\\w") == ''
    let local_eslint = getcwd() . "/" . local_eslint
endif
if executable(local_eslint)
    let g:syntastic_javascript_eslint_exec = local_eslint
    let g:syntastic_vue_eslint_exec = local_eslint
endif
" restart vim-vue on start
autocmd FileType vue syntax sync fromstart
autocmd BufRead,BufNewFile *.vue setlocal filetype=vue.pug.html.javascript.css.stylus.styl.scss

" Disable pre checking for pre-processor language
" let g:vue_disable_pre_processors=1

" Pylint
let g:syntastic_python_checkers = ['flake8']


" vim-snippets
" Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="!!"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
