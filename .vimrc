" Random settings for vim, mainly for Mac OS X.
set autoindent
filetype indent on
set tabstop=4
set shiftwidth=4
set expandtab
set term=builtin_ansi
syntax enable
set number

" markdown highlighting for files with .md
au BufRead,BufNewFile *.md set filetype=markdown
