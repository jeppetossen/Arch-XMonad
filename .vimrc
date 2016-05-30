" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages.
runtime! archlinux.vim

let g:airline_powerline_fonts=1

" Plugins - Vundle Plugin Manager {{{
  set rtp+=~/.vim/bundle/Vundle.vim/
  call vundle#rc()
    " Github Repos
  Bundle 'VundleVim/Vundle.vim'

  Bundle 'scrooloose/syntastic'
    " vim-scripts Repos
  Bundle 'jellybeans.vim'

  Bundle 'bling/vim-airline'
  Bundle 'chriskempson/base16-vim'
  Bundle 'tpope/vim-fugitive'
  Bundle 'tpope/vim-rails'
  Bundle 'tpope/vim-haml'
  Bundle 'tpope/vim-endwise'
  Bundle 'tpope/vim-surround'
  Bundle 'tpope/vim-ragtag'
  Bundle 'tpope/vim-markdown'
  Bundle 'tpope/vim-unimpaired'
  Bundle 'msanders/snipmate.vim'
  "Bundle 'ervandew/supertab'
  Bundle 'tomtom/tlib_vim'
  Bundle 'scrooloose/nerdtree'
  Bundle 'Xuyuanp/nerdtree-git-plugin'
  Bundle 'tomtom/tcomment_vim'
  Bundle 'tomtom/tselectbuffer_vim'
  Bundle 'jwhitley/vim-matchit'
  Bundle 'vim-scripts/taglist.vim'
  Bundle 'Townk/vim-autoclose'
  Bundle 'trapd00r/x11colors.vim'
  Bundle 'lilydjwg/colorizer'
  Bundle 'fholgado/minibufexpl.vim'
  Bundle 'shemerey/vim-project'
  Bundle 'Twinside/vim-codeoverview'
  Bundle 'neovimhaskell/haskell-vim'
  Plugin 'alvan/vim-closetag'
  Plugin 'airblade/vim-gitgutter'
  Plugin 'itchyny/lightline.vim'

" Themes
  Plugin 'vim-airline/vim-airline-themes'
  Bundle 'KKPMW/moonshine-vim'
  Bundle 'hewo/vim-colorscheme-deepsea'
  Bundle 'thomd/vim-wasabi-colorscheme'
  Bundle 'ivan-cukic/vim-colors-penultimate'
  Bundle 'orthecreedence/void.vim'
  Bundle 'kreeger/benlight'
  Bundle 'altercation/vim-colors-solarized'
  Bundle 'NLKNguyen/papercolor-theme'

" Nerdtree
    map <F3> :NERDTreeToggle<CR>
    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ "Unknown"   : "?"
    \ }

    "autocmd vimenter * NERDTree

" Supertab
    au FileType python set omnifunc=pythoncomplete#Complete
    let g:SuperTabDefaultCompletionType = "context"
    set completeopt=menuone,longest,preview

" Powerline
    set guifont="Source Code Pro"
    let g:Powerline_symbols = 'fancy'
" }}}

" General Settings {{{
    syntax on
    filetype on
    filetype plugin indent on 
    set encoding=utf-8
    set nocompatible               " Be improved
    set mouse=a                    " Enable mouse
    set hidden                     " Quick buffer switching
    set ruler                      " Show cursor position
    set noshowmode
" }}}

" Syntax
    let g:haskell_enable_quantification = 1
    let g:haskell_enable_recursivedo = 1
    let g:haskell_enable_arrowsyntax = 1
    let g:haskell_enable_pattern_synonyms = 1
    let g:haskell_enable_typeroles = 1
    let g:haskell_enable_static_pointers = 1

    
" Appearance Settings {{{
    set laststatus=2               " Show statusline even when no window split 
    set background=dark
    colorscheme PaperColor
    set gfn="Droid Sans Mono for Powerline"
    set number                     " Line numbers
    set cursorline                 " Highlights cursor line
    set scrolloff=2                " Keep 2 scroll lines above/below cursor
    set fillchars=vert:\           " Remove ugly | in seperators
    highlight OverLength ctermbg=darkgray ctermfg=black
"    match OverLength /\%101v.\+/    " Highlight text exceeding 80 character limit
" }}}

" Gvim Settings {{{
    if has('gui_running')
        map <S-Insert> <MiddleMouse>
        map! <S-Insert> <MiddleMouse>
        set guicursor+=a:blinkon0    " Cursor doesn't blink
        set guioptions-=m            " Remove menu bar
        set guioptions-=T            " Remove toolbar
        set guioptions-=r            " Remove right-hand scroll bar
    endif
" }}}
    
" Bell {{{
    set noerrorbells               " Disable annoying beeps
    set visualbell                 " Visual bell instead of beeping
" }}}
 
"" Code Folding {{{
    set foldenable                 " Enable code folding
    set foldmethod=manual          " But do it manually
" }}}
    
" Tab Settings {{{
    set noexpandtab                " Tab -> Space
    set tabstop=4                  " Tabs count for 4 columns
    set softtabstop=4              " Tab == 4 spaces
    set shiftwidth=4               " 4 Columns with reindent options
    set backspace=indent,eol,start " Smart backspace 
    set autoindent                 " Ignore case
    set smartindent                " Except with capitals
    set pastetoggle=<F2>           " Disabling autoindent while pasting
" }}}

" Searching and History Settings {{{
    set nohlsearch
    set incsearch                  " Increment search
    set ignorecase                 " Case-insensitive search;
    set smartcase                  " Search becomes case sensitive if caps used
    set nobackup                   " Don't keep backups
    set noswapfile                 " Don't create a swap file
    set history=50                 " Keep 50 lines of command line history
" }}}
"
" Other settings {{{
    set shortmess+=I               " No startup message
    set nolazyredraw               " Turn off lazy redraw
    set spelllang=en               " Set default language to English 
" }}}

" Suffixes that get lower priority when doing tab completion for filenames.
" These are files we are not likely to want to edit or read.
set suffixes=.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc

let g:closetag_filenames = "*.html,*.xhtml,*.phtml"
