" Compatability
set nocompatible " Turn off vi compatability
behave mswin

" Turn off c++ curly bracket errors until vim gets fixed to work with c++ lambdas.
hi link cErrInParen Normal

" Font
set guifont=monospace\ 8

" Turn on Windows keynbindings
source $VIMRUNTIME/mswin.vim

" Set tabs to 8 spaces. Force vim to use spaces over tabs.
set tabstop=8
set shiftwidth=8
set softtabstop=8
set expandtab

" Make folding determined by syntax
set fdm=syntax
set nofoldenable

" Set the color
colorscheme desert

" Set options
set statusline=%<%f\ %h%m%r\ %y\ buf:%n\ line_format:%{&ff}%=(%l,%c%V)\ %P
set backspace=indent,eol,start " allow backspacing over everything in insert mode
set writebackup                " keep a backup file only while copying
set history=50                 " keep 50 lines of command line history
set ruler                      " show the cursor position all the time
set rulerformat=(%l,%c%V)\ %P
set showcmd                    " display incomplete commands
set incsearch                  " do incremental searching
set ignorecase                 " turn off case sensitivity
set cursorline                 " highlight the current line.
set number                     " Add line numbers
set wildmode=longest,list,full " Bash like tab completion
set wildmenu                   " Enable menu for tab completion

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

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

function! StyleOn()
        let w:style = 1
        " Highlight the ends of lines which are over 100 columns in length.
        if ! exists('w:matchLongLines') || ! w:matchLongLines
                highlight OverLength ctermbg=darkgrey guibg=darkgrey
                let w:matchLongLines=matchadd('OverLength', '\%102v.*', -1)
        endif

        " Highlight white space at end of lines
        if ! exists('w:matchTailWhiteSpace') || ! w:matchTailWhiteSpace
                highlight TailWhiteSpace ctermbg=darkgrey guibg=darkgrey
                let w:matchTailWhiteSpace=matchadd('TailWhiteSpace', '[^\s]\s\+$', -1)
        endif

        " Highlight tabs
        if ! exists('w:matchTabs') ||  ! w:matchTabs 
                highlight TabHighlight ctermbg=darkgrey guibg=darkgrey
                let w:matchTabs=matchadd('TabHighlight', '\t', -1)
        endif
endfunction

function! StyleOff()
        let w:style = 0
        if exists('w:matchLongLines') && w:matchLongLines
                call matchdelete(w:matchLongLines)
                let w:matchLongLines = !w:matchLongLines
        endif
        if exists('w:matchTailWhiteSpace') && w:matchTailWhiteSpace
                call matchdelete(w:matchTailWhiteSpace)
                let w:matchTailWhiteSpace = !w:matchTailWhiteSpace
        endif
        if exists('w:matchTabs') && w:matchTabs
                call matchdelete(w:matchTabs)
                let w:matchTabs = !w:matchTabs
        endif
endfunction

function! StyleToggle()
        let w:style = exists('w:style') ? !w:style : 1

        if w:style
                call StyleOn()
        else
                call StyleOff()
        endif
endfunction

nmap s :call StyleToggle()<CR>

augroup END

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
                  \ | wincmd p | diffthis
endif

