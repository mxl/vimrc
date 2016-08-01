" ***
" Vundle setup begins
" ***
" be iMproved
set nocompatible
filetype off
" set the runtime path to include Vundle
set rtp+=~/.vim/bundle/vundle
call vundle#begin()

Plugin 'gmarik/vundle'
Plugin 'docker/docker' , {'rtp': '/contrib/syntax/vim/'}
Plugin 'godlygeek/tabular'
Plugin 'tpope/vim-fugitive'
Plugin 'altercation/vim-colors-solarized'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'kballard/vim-swift'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'mustache/vim-mustache-handlebars' 
Plugin 'leafgarland/typescript-vim'
Plugin 'derekwyatt/vim-scala'

call vundle#end()
" ***
" Vundle setup ends
"

" Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0


" encoding of config
scriptencoding utf-8
set encoding=utf-8

"-----------------------------------------------------------------------
" terminal setup
"-----------------------------------------------------------------------
"
" Extra terminal things
if ($TERM == "rxvt-unicode") && (&termencoding == "")
    set termencoding=utf-8
endif

if &term =~ "xterm" || &term == "rxvt-unicode"
    if exists('&t_SI')
        let &t_SI = "\<Esc>]12;lightgoldenrod\x7"
        let &t_EI = "\<Esc>]12;grey80\x7"
    endif
endif

"-----------------------------------------------------------------------
" settings
"-----------------------------------------------------------------------
" use system clipboard
set clipboard=unnamed
" show line numbers
set number

" Enable a nice big viminfo file
set viminfo='1000,f1,:1000,/1000

" Make backspace delete lots of things
set backspace=indent,eol,start

" Create backups
set backup
set backupdir=~/.vim/backup

" Show us the command we're typing
set showcmd

" Highlight matching parens
set showmatch

" Search options: incremental search, do clever case things, highlight
" search
set incsearch
set ignorecase
set smartcase
set infercase
set hlsearch

" Show full tags when doing search completion
set showfulltag

" Speed up macros
set lazyredraw

" No annoying error noises
set noerrorbells
set visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=

" Try to show at least three lines and two columns of context when
" scrolling
set scrolloff=3
set sidescrolloff=2

" Wrap on these
set whichwrap+=<,>,[,]

" Use the cool tab complete menu
set wildmenu
set wildignore=*.o,*~

" Allow edit buffers to be hidden
set hidden

" 1 height windows
set winminheight=1

" Enable syntax highlighting and apply color scheme
syntax enable
set background=dark
if !has('gui')
    set t_Co=256
    let g:solarized_termtrans = 1
    let g:solarized_termcolors=256
endif
colorscheme solarized

" By default, go for an indent of 4
set shiftwidth=4

" Do clever indent things. Don't make a # force column zero.
set autoindent
set smartindent
inoremap # X<BS>#

" Enable folds
set foldenable
set foldmethod=syntax
set foldlevelstart=5

" Enable filetype settings
filetype plugin indent on

" set tab to 4 spaces
set tabstop=4
set shiftwidth=4
set smarttab
set expandtab

"c indent style
set cindent

set modeline
set wrap
set listchars+=precedes:<,extends:>
set sidescroll=5
set sidescrolloff=5
set backspace=indent,eol,start
set showmatch " проверка скобок
set history=1000 " увеличение истории команд
set undolevels=1000
set ttyfast

" Syntax when printing
set popt+=syntax:y

" Enable modelines only on secure vim versions
if (v:version == 603 && has("patch045")) || (v:version > 603)
    set modeline
else
    set nomodeline
endif

set ruler
set magic
set autoread

" Set our fonts
set guifont=Monaco:h11

" No icky toolbar, menu or scrollbars in the GUI
if has('gui')
    set guioptions-=m
    set guioptions-=T
    set guioptions-=l
    set guioptions-=L
    set guioptions-=r
    set guioptions-=R
end


set statusline=%=%f\ \"%F\"\ %m%R\ [%4l(%3p%%):%3c-(0x%2B,\0%2b),%Y,%{&encoding}]

" Include $HOME in cdpath
let &cdpath=','.expand("$HOME").','.expand("$HOME").'/work'


"-----------------------------------------------------------------------
" completion
"-----------------------------------------------------------------------
set dictionary=/usr/share/dict/words
" php function completion
set tags+=/home/devil/php-tags/tags

" tabs 
nmap <C-S-tab> :tabprevious<cr> 
nmap <C-tab> :tabnext<cr> 
map <C-S-tab> :tabprevious<cr> 
map <C-tab> :tabnext<cr> 
imap <C-S-tab> <ESC>:tabprevious<cr>i 
imap <C-tab> <ESC>:tabnext<cr>i 
nmap <C-t> :tabnew<cr> 
imap <C-t> <ESC>:tabnew<cr>

" add closing } automatically
imap {<CR> {<CR>}<Esc>O<Tab>

" автодополнение по Control+Space
imap <C-Space> <C-N>

" unset the "last search pattern" register by hitting return 
nnoremap <CR> :noh<CR><CR>

" map cyrillic characters to latin
let rumap = 'йцукенгшщзхъфывапролджэёячсмитьбюЙЦУКЕНГШЩЗХЪФЫВАПРОЛДЖЭЯЧСМИТЬБЮ'
let enmap = 'qwertyuiop[]asdfghjkl;''\zxcvbnm,.QWERTYUIOP{}ASDFGHJKL:"ZXCVBNM<>' 
let mapLen = strchars(rumap)
let i = 0
while i < mapLen
    let ruChar = matchstr(rumap, ".", byteidx(rumap, i))
    let enChar = enmap[i]
    "echo 'map '.ruChar.' '.enChar
    "echo 'cmap '.ruChar.' '.enChar
    execute 'map '.ruChar.' '.enChar
    execute 'cmap '.ruChar.' '.enChar
    let i += 1
endwhile

map Ё \|
cmap Ё \|
