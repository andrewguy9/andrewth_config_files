" Compatability
set nocompatible " Turn off vi compatability
"behave mswin

" Turn on Windows keynbindings
"source $VIMRUNTIME/mswin.vim

" Set tabs to 8 spaces. Force vim to use spaces over tabs.
set tabstop=8
set shiftwidth=8
set softtabstop=8
set expandtab

" Force lines to be no longer than 100 columns
set textwidth=100
set formatoptions=cqt
set wrapmargin=0
"set wrap!

" Make folding determined by syntax
set fdm=syntax

" Set tagging options
set csprg=gtags-cscope
set cscopetag

" Set the color
colorscheme desert

" Set options
set statusline=%<%f\ %h%m%r\ %y\ buf:%n\ line_format:%{&ff}%=(%l,%c%V)\ %P
set backspace=indent,eol,start " allow backspacing over everything in insert mode
set writebackup        " keep a backup file only while copying
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set rulerformat=(%l,%c%V)\ %P
set showcmd		" display incomplete commands
set incsearch		" do incremental searching
set ignorecase          " turn off case sensitivity
set cursorline          " highlight the current line.

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 100 characters.
  autocmd FileType text setlocal textwidth=100

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  " Highlight the ends of lines which are over 100 columns in length.
  "autocmd BufEnter * highlight OverLength ctermbg=darkgrey guibg=red
  highlight OverLength ctermbg=darkgrey guibg=red
  autocmd BufEnter * let mach2=matchadd('OverLength', '\%100v.*')

  " Highlight white space at end of lines
  highlight TailWhiteSpace ctermbg=darkgrey guibg=darkgrey
  autocmd BufEnter * let mach1=matchadd('TailWhiteSpace', '\s\+$')

  " Highlight tabs
  highlight TabHighlight ctermbg=red guibg=red
  autocmd BufEnter * let mach3=matchadd('TabHighlight', '\t')

  augroup END

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

