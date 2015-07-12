" ***
" Vundle setup begins
" ***
" be iMproved
set nocompatible
filetype off
" set the runtime path to include Vundle
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'docker/docker' , {'rtp': '/contrib/syntax/vim/'}
Plugin 'godlygeek/tabular'
Plugin 'tpope/vim-fugitive'
Plugin 'altercation/vim-colors-solarized'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'kballard/vim-swift'

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
set clipboard=unnamedplus
" show line numbers
set number
" set nocompatible with vi
" vi is suks!
set nocompatible

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
    let g:solarized_termtrans = 1
    if $TERM == "xterm-256color"
       let g:solarized_termcolors=256
    endif
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
set nowrap
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

"-----------------------------------------------------------------------
" autocmds
"-----------------------------------------------------------------------

" If we're in a wide window, enable line numbers.
fun! <SID>WindowWidth()
    if winwidth(0) > 90
        setlocal foldcolumn=0
        setlocal number
    else
        setlocal nonumber
        setlocal foldcolumn=0
    endif
endfun

" Force active window to the top of the screen without losing its
" size.
fun! <SID>WindowToTop()
    let l:h=winheight(0)
    wincmd K
    execute "resize" l:h
endfun

" Force active window to the bottom of the screen without losing its
" size.
fun! <SID>WindowToBottom()
    let l:h=winheight(0)
    wincmd J
    execute "resize" l:h
endfun

" Update .*rc header
fun! <SID>UpdateRcHeader()
    let l:c=col(".")
    let l:l=line(".")
    1,10s-\(Most recent update:\).*-\="Most recent update: ".strftime("%c")-e
    call cursor(l:l, l:c)
endfun

" autocmds
augroup devil
   autocmd!

   " Automagic line numbers
   autocmd BufEnter * :call <SID>WindowWidth()

   " Update header in .vimrc and .bashrc before saving
   autocmd BufWritePre *vimrc  :call <SID>UpdateRcHeader()
   autocmd BufWritePre *bashrc :call <SID>UpdateRcHeader()

   " Always do a full syntax refresh
   autocmd BufEnter * syntax sync fromstart

   " For help files, move them to the top window and make <Return>
   " behave like <C-]> (jump to tag)
   autocmd FileType help :call <SID>WindowToTop()
   autocmd FileType help nmap <buffer> <Return> <C-]>

   " bash-completion ftdetects
   autocmd BufNewFile,BufRead /*/*bash*completion*/*
               \ if expand("<amatch>") !~# "ChangeLog" |
               \     let b:is_bash = 1 | set filetype=sh |
               \ endif
augroup END

augroup myfiletypes
    " Clear old autocmds in group
    autocmd!
    " autoindent with two spaces, always expand tabs
    autocmd FileType ruby,eruby,yaml set ai sw=2 sts=2 et
augroup END

" content creation
augroup content
    autocmd BufNewFile *.php 0put = '?>'|
                \ 0put = '// vim: set sw=4 sts=4 et foldmethod=syntax :'|
                \ 0put = '<?'|
                \ set sw=4 sts=4 et tw=80 |
                \ norm G
    autocmd BufNewFile *.php5 0put = '?>'|
                \ 0put = '// vim: set sw=4 sts=4 et foldmethod=syntax :'|
                \ 0put = '<?'|
                \ set sw=4 sts=4 et tw=80 |
                \ norm G
    autocmd BufNewFile *.rb 0put ='# vim: set sw=2 sts=2 et tw=80 :' |
                \ 0put ='#!/usr/bin/env ruby' | set sw=2 sts=2 et tw=80 |
                \ norm G
    autocmd BufNewFile *.sh 0put ='# vim: set sw=4 sts=4 et tw=80 :' |
                \ 0put ='#!/usr/bin/bash' | set sw=4 sts=4 et tw=80 |
                \ norm G

    autocmd BufNewFile *.pl 0put ='# vim: set sw=4 sts=4 et tw=80 :' |
                \ 0put ='#!/usr/bin/perl' | set sw=4 sts=4 et tw=80 |
                \ norm G

    autocmd BufNewFile *.hh 0put ='/* vim: set sw=4 sts=4 et foldmethod=syntax : */' |
                \ 1put ='' | call MakeIncludeGuards() |
                \ 5put ='#include \"config.h\"' |
                \ set sw=4 sts=4 et tw=80 | norm G

    autocmd BufNewFile *.cc 0put ='/* vim: set sw=4 sts=4 et foldmethod=syntax : */' |
                \ 1put ='' | 2put ='' | call setline(3, '#include "' .
                \ substitute(expand("%:t"), ".cc$", ".hh", "") . '"') |
                \ set sw=4 sts=4 et tw=80 | norm G
augroup END

nmap   <F5>   :bprev<CR>
imap   <F5>   <Esc>:bprev<CR>
nmap   <F6>   :bnext<CR>
imap   <F6>   <Esc>:bnext<CR>
" tabs 
nmap <C-S-tab> :tabprevious<cr> 
nmap <C-tab> :tabnext<cr> 
map <C-S-tab> :tabprevious<cr> 
map <C-tab> :tabnext<cr> 
imap <C-S-tab> <ESC>:tabprevious<cr>i 
imap <C-tab> <ESC>:tabnext<cr>i 
nmap <C-t> :tabnew<cr> 
imap <C-t> <ESC>:tabnew<cr>

" автодополнение фигурной скобки (так, как я люблю :)
imap {<CR> {<CR>}<Esc>O<Tab>

" автодополнение по Control+Space
imap <C-Space> <C-N>
" 'умный' Home
nmap <Home> ^
imap <Home> <Esc>I

" выход
imap <F12> <Esc>:qa<CR>
nmap <F12> :qa<CR>

" сохранение текущего буфера
imap <F2> <Esc>:w<CR>a
nmap <F2> :w<CR>

" сохранение всех буферов
imap <S-F2> <Esc>:wa<CR>a
nmap <S-F2> :wa<CR>
" no search 
nmap <silent> <F3> :silent nohlsearch<CR>
imap <silent> <F3> <C-o>:silent nohlsearch<CR>
" список буферов
imap <S-F4> <Esc>:buffers<CR>
nmap <S-F4> :buffers<CR>

" закрыть буфер
imap <C-F4> <Esc>:bd<CR>a
nmap <C-F4> :bd<CR>

" перекодировка
map <F8> :execute RotateEnc()<CR>

" окно ниже и развернуть
imap <C-F8> <Esc><C-W>j<C-W>_a
nmap <C-F8> <C-W>j<C-W>_

" окно выше и развернуть
imap <C-F7> <Esc><C-W>k<C-W>_a
nmap <C-F7> <C-W>k<C-W>_

" окно левее
imap <S-F7> <Esc><C-W>ha
nmap <S-F7> <C-W>h

" окно правее
imap <S-F8> <Esc><C-W>la
nmap <S-F8> <C-W>l

" следующая ошибка
imap <C-F10> <Esc>:cn<CR>i
nmap <C-F10> :cn<CR>

" предыдущая ошибка
imap <S-F10> <Esc>:cp<CR>i
nmap <S-F10> :cp<CR>

" вкл/выкл отображения номеров строк
imap <F1> <Esc>:set<Space>nu!<CR>a
nmap <F1> :set<Space>nu!<CR>

" вкл/выкл отображения найденных соответствий
imap <S-F1> <Esc>:set<Space>hls!<CR>a
nmap <S-F1> :set<Space>hls!<CR>
