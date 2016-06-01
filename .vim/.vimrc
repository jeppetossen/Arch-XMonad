""" vimconf is not vi-compatible {{{
    set nocompatible
""" }}}
""" Automatically create needed files and folders on first run (*nix only) {{{
    call system("mkdir -p $HOME/.vim/{swap,undo}")
    if !filereadable($HOME."/.vim/.vimrc.plugins") | call system("touch $HOME/.vim/.vimrc.plugins") | endif
    """ }}}
    
""" Vundle plugin manager {{{
    """ Automatically setting up Vundle {{{
    """ http://www.erikzaadi.com/2012/03/19/auto-installing-vundle-from-your-vimrc/
        let has_vundle=1
        if !filereadable($HOME."/.vim/bundle/Vundle.vim/README.md")
            echo "Installing Vundle..."
            echo ""
            silent !mkdir -p $HOME/.vim/bundle
            silent !git clone https://github.com/VundleVim/Vundle.vim $HOME/.vim/bundle/Vundle.vim
            let has_vundle=0
        endif
    """ }}}
    
    """ Initialize Vundle {{{
        filetype off                                " required to init
        set rtp+=$HOME/.vim/bundle/Vundle.vim       " include vundle
        call vundle#begin()                         " init vundle
    """ }}}
    
    """ Github repos, uncomment to disable a plugin {{{
        Plugin 'VundleVim/Vundle.vim'

        """ Local plugins (and only plugins in this file!) {{{
            if filereadable($HOME."/.vim/.vimrc.plugins")
                source $HOME/.vim/.vimrc.plugins
            endif
        """ }}}
    """ }}}
    """ Finish Vundle stuff {{{
        call vundle#end()
    """ }}}
    
    """ Installing plugins the first time, quits when done {{{
        if has_vundle == 0
            :silent! PluginInstall
            :qa
        endif
    """ }}}
    
""" Keybindings
    if filereadable($HOME."/.vim/.vimrc.mappings")
        source $HOME/.vim/.vimrc.mappings
    endif
    
""" User interface {{{
    """ Syntax highlighting {{{
        filetype plugin indent on                   " detect file plugin+indent
        syntax on                                   " syntax highlighting
        set background=dark                         " we're using a dark bg
        colorscheme moonshine                      " colorscheme from plugin
        """ Force behavior and filetypes, and by extension highlighting {{{
            augroup FileTypeRules
                autocmd!
                autocmd BufNewFile,BufRead *.md set ft=markdown tw=79
                autocmd BufNewFile,BufRead *.tex set ft=tex tw=79
                autocmd BufNewFile,BufRead *.txt set ft=sh tw=79
            augroup END
        """ }}}
        """ 256 colors for maximum jellybeans bling. See commit log for info {{{
            "if (&term =~ "xterm") || (&term =~ "screen")
                set t_Co=256
            "endif
        """ }}}
        """ Custom highlighting, where NONE uses terminal background {{{
            function! CustomHighlighting()
                highlight Normal ctermbg=NONE
                highlight NonText ctermbg=NONE
                highlight LineNr ctermbg=NONE
                highlight SignColumn ctermbg=NONE
                highlight SignColumn guibg=#151515
                highlight CursorLine ctermbg=235
            endfunction

            call CustomHighlighting()
        """ }}}
    """ }}}
    """ Interface general {{{
        """ Airline Settings {{{
            "let g:airline_powerline_fonts=1
            let g:Powerline_symbols = 'fancy'
            let g:airline_left_sep = ''
            let g:airline_left_sep = ''
            let g:airline_right_sep = ''
            let g:airline_right_sep = ''
            set fillchars+=stl:\ ,stlnc:\
            let g:airline_theme = 'distinguished'
        set cursorline          " hilight cursor line
        set more                " ---more--- like less
        set number              " line numbers
        set scrolloff=3         " lines above/below cursor
        set showcmd             " show cmds being typed
        set title               " window title
        set vb t_vb=            " disable beep and flashing
        """ Depending on your setup you may want to enforce UTF-8. {{{
        """ Should generally be set in your environment LOCALE/$LANG
             set encoding=utf-8                    " default $LANG/latin1
             set fileencoding=utf-8                " default none
             set termencoding=utf-8
        """ }}}
    """ }}}
""" }}}
""" General settings {{{
    set ruler
    set nolazyredraw
    set completeopt=menu,preview,longest    " insert mode completion
    set hidden                              " buffer change, more undo
    set history=1000                        " default 20
    set iskeyword+=_,$,@,%,#                " not word dividers
    set laststatus=2                        " always show statusline
    set linebreak                           " don't cut words on wrap
    set listchars=tab:>\                    " > to highlight <tab>
    set list                                " displaying listchars
    set mouse=a                             " enable mouse
    set noshowmode                          " hide mode cmd line
    set noexrc                              " don't use other .*rc(s)
    set nostartofline                       " keep cursor column pos
    set nowrap                              " don't wrap lines
    set numberwidth=5                       " 99999 lines
    set shortmess+=I                        " disable startup message
    set splitbelow                          " splits go below w/focus
    set splitright                          " vsplits go right w/focus
    set ttyfast                             " for faster redraws etc
    "set ttymouse=xterm2                     " experimental
    """ Folding {{{
        set foldcolumn=0                    " hide folding column
        set foldmethod=indent               " folds using indent
        set foldnestmax=10                  " max 10 nested folds
        set foldlevelstart=99               " folds open by default
    """ }}}
    """ Search and replace {{{
        set gdefault                        " default s//g (global)
        set incsearch                       " "live"-search
    """ }}}
    """ Matching {{{
        set matchtime=2                     " time to blink match {}
        set matchpairs+=<:>                 " for ci< or ci>
        set showmatch                       " tmpjump to match-bracket
    """ }}}
    """ Wildmode/wildmenu command-line completion {{{
        set wildignore+=*.bak,*.swp,*.swo
        set wildignore+=*.a,*.o,*.so,*.pyc,*.class
        set wildignore+=*.jpg,*.jpeg,*.gif,*.png,*.pdf
        set wildignore+=*/.git*,*.tar,*.zip
        set wildmenu
        set wildmode=longest:full,list:full
    """ }}}
    """ Return to last edit position when opening files {{{
        augroup LastPosition
            autocmd! BufReadPost *
                \ if line("'\"") > 0 && line("'\"") <= line("$") |
                \     exe "normal! g`\"" |
                \ endif
        augroup END
    """ }}}
""" }}}
""" Files {{{
    set autochdir                           " always use curr. dir.
    set autoread                            " refresh if changed
    set confirm                             " confirm changed files
    set noautowrite                         " never autowrite
    set nobackup                            " disable backups
    """ Persistent undo. Requires Vim 7.3 {{{
        if has('persistent_undo') && exists("&undodir")
            set undodir=$HOME/.vim/undo/    " where to store undofiles
            set undofile                    " enable undofile
            set undolevels=500              " max undos stored
            set undoreload=10000            " buffer stored undos
        endif
    """ }}}
    """ Swap files, unless vim is invoked using sudo {{{
    """ https://github.com/tejr/dotfiles/blob/master/vim/vimrc
        if !strlen($SUDO_USER)
            set directory^=$HOME/.vim/swap//    " default cwd, // full path
            set swapfile                        " enable swap files
            set updatecount=50                  " update swp after 50chars
            """ Don't swap tmp, mount or network dirs {{{
                augroup SwapIgnore
                    autocmd! BufNewFile,BufReadPre /tmp/*,/mnt/*,/media/*
                        \ setlocal noswapfile
                augroup END
            """ }}}
        else
            set noswapfile                  " dont swap sudo'ed files
        endif
    """ }}}
""" }}}
""" Text formatting {{{
    set autoindent                          " preserve indentation
    set backspace=indent,eol,start          " smart backspace
    set cinkeys-=0#                         " don't force # indentation
    set expandtab                           " no real tabs
    set ignorecase                          " by default ignore case
    set nrformats+=alpha                    " incr/decr letters C-a/-x
    set shiftround                          " be clever with tabs
    set shiftwidth=4                        " default 8
    set smartcase                           " sensitive with uppercase
    set smarttab                            " tab to 0,4,8 etc.
    set softtabstop=4                       " "tab" feels like <tab>
    set tabstop=4                           " replace <TAB> w/4 spaces
    """ Only auto-comment newline for block comments {{{
        augroup AutoBlockComment
            autocmd! FileType c,cpp setlocal comments -=:// comments +=f://
        augroup END
    """ }}}
    """ Take comment leaders into account when joining lines, :h fo-table {{{
    """ http://ftp.vim.org/pub/vim/patches/7.3/7.3.541
        if has("patch-7.3.541")
            set formatoptions+=j
        endif
    """ }}}
""" }}}
    """ Functions and/or fancy keybinds {{{
        """ Toggle syntax highlighting {{{
            function! ToggleSyntaxHighlighthing()
                if exists("g:syntax_on")
                    syntax off
                else
                    syntax on
                    call CustomHighlighting()
                endif
            endfunction

            nnoremap <leader>s :call ToggleSyntaxHighlighthing()<CR>
        """ }}}
        """ Highlight characters past 79, toggle with <leader>h {{{
        """ You might want to override this function and its variables with
        """ your own in .vimrc.last which might set for example colorcolumn or
        """ even the textwidth. See https://github.com/timss/vimconf/pull/4
            let g:overlength_enabled = 0
            highlight OverLength ctermbg=238 guibg=#444444

            function! ToggleOverLength()
                if g:overlength_enabled == 0
                    match OverLength /\%79v.*/
                    let g:overlength_enabled = 1
                    echo 'OverLength highlighting turned on'
                else
                    match
                    let g:overlength_enabled = 0
                    echo 'OverLength highlighting turned off'
                endif
            endfunction

            nnoremap <leader>h :call ToggleOverLength()<CR>
        """ }}}
        """ Toggle relativenumber using <leader>r {{{
            function! NumberToggle()
                if(&relativenumber == 1)
                    set number
                else
                    set relativenumber
                endif
            endfunction

            nnoremap <leader>r :call NumberToggle()<CR>
        """ }}}
        """ Toggle text wrapping, wrap on whole words {{{
        """ For more info see: http://stackoverflow.com/a/2470885/1076493
            function! WrapToggle()
                if &wrap
                    set list
                    set nowrap
                else
                    set nolist
                    set wrap
                endif
            endfunction

            nnoremap <leader>w :call WrapToggle()<CR>
        """ }}}
        """ Remove multiple empty lines {{{
            function! DeleteMultipleEmptyLines()
                g/^\_$\n\_^$/d
            endfunction

            nnoremap <leader>ld :call DeleteMultipleEmptyLines()<CR>
        """ }}}
        """ Split to relative header/source {{{
            function! SplitRelSrc()
                let s:fname = expand("%:t:r")

                if expand("%:e") == "h"
                    set nosplitright
                    exe "vsplit" fnameescape(s:fname . ".cpp")
                    set splitright
                elseif expand("%:e") == "cpp"
                    exe "vsplit" fnameescape(s:fname . ".h")
                endif
            endfunction

            nnoremap <leader>le :call SplitRelSrc()<CR>
        """ }}}
        """ Strip trailing whitespace, return to cursor at save {{{
            function! StripTrailingWhitespace()
                let l = line(".")
                let c = col(".")
                %s/\s\+$//e
                call cursor(l, c)
            endfunction

            augroup StripTrailingWhitespace
                autocmd!
                autocmd FileType c,cpp,cfg,conf,css,html,perl,python,sh,tex,yaml
                    \ autocmd BufWritePre <buffer> :call
                    \ StripTrailingWhitespace()
            augroup END
        """ }}}
    """ }}}
    """ Plugins {{{
        " Toggle tagbar (definitions, functions etc.)
        map <F1> :TagbarToggle<CR>

        " Syntastic - toggle error list. Probably should be toggleable.
        noremap <silent><leader>lo :Errors<CR>
        noremap <silent><leader>lc :lclose<CR>
    """ }}}
""" }}}
""" Plugin settings {{{
    """ Startify {{{
        let g:startify_bookmarks = [
            \ $VIMRC, "~/.vim/.vimrc.plugins",
            \ $ZSHRC, "~/.xmonad/xmonad.hs"
            \ ]
            "\ $HOME . "/.vimrc", $HOME . "/.vimrc.first",
            "\ $HOME . "/.vimrc.last", $HOME . "/.vimrc.plugins"
            "\ ]
        let g:startify_custom_header = [
            \ '   http://github.com/timss/vimconf',
            \ ''
            \ ]
        let g:startify_files_number = 5
    """ }}}
    """ CtrlP {{{
        " Don't recalculate files on start (slow)
        let g:ctrlp_clear_cache_on_exit = 0
        let g:ctrlp_working_path_mode = 'ra'

        " Don't split in Startify
        let g:ctrlp_reuse_window = 'startify'
    """ }}}
    """ TagBar {{{
        set tags=tags;/

        " Proportions
        let g:tagbar_left = 0
        let g:tagbar_width = 30

        " Used in lightline.vim
        let g:tagbar_status_func = 'TagbarStatusFunc'
    """ }}}
    """ Syntastic {{{
        " Automatic checking for active, only when :SyntasticCheck for passive
        " NOTE: override these in $HOME/.vimrc.last as needed!
        let g:syntastic_mode_map = {
            \ 'mode': 'passive',
            \ 'active_filetypes':
                \ ['c', 'cpp', 'perl', 'python'] }

        " Skip check on :wq, :x, :ZZ etc
        let g:syntastic_check_on_wq = 0
    """ }}}
    """ Netrw {{{
        let g:netrw_banner = 0
        let g:netrw_list_hide = '^\.$'
        let g:netrw_liststyle = 3
    """ }}}
    """ Supertab {{{
        " Complete based on context (compl-omni, compl-filename, ..)
        let g:SuperTabDefaultCompletionType = "context"

        " Longest common match, e.g. 'b<tab>' => 'bar' for 'barbar', 'barfoo'
        let g:SuperTabLongestEnhanced = 1
        let g:SuperTabLongestHighlight = 1
    """ }}}
    """ SnipMate {{{
        " Disable '.' => 'self' Python snippet
        " Breaks SuperTab with omnicomplete (e.g. module.<Tab>)
        function! DisablePythonSelfSnippet()
            let l:pysnip = $HOME."/.vim/after/snippets/python.snippets"
            if !filereadable(l:pysnip)
                call system("echo 'snippet!! .' > " . l:pysnip)
            endif
        endfunction

        augroup DisablePythonSelfSnippet
            autocmd!
            autocmd BufNewFile,BufRead *.py :call DisablePythonSelfSnippet()
        augroup END
    """ }}}
    """ Automatically remove preview window after autocomplete {{{
    """ (mainly for clang_complete)
        augroup RemovePreview
            autocmd!
            autocmd CursorMovedI * if pumvisible() == 0 | pclose | endif
            autocmd InsertLeave * if pumvisible() == 0 | pclose | endif
        augroup END
    """ }}}

        function! MyMode()
            let fname = expand('%:t')
            return fname == '__Tagbar__' ? 'Tagbar' :
                \ fname == 'ControlP' ? 'CtrlP' :
                \ winwidth('.') > 60 ? lightline#mode() : ''
        endfunction

        function! MyFugitive()
            try
                if expand('%:t') !~? 'Tagbar' && exists('*fugitive#head')
                    let mark = '± '
                    let _ = fugitive#head()
                    return strlen(_) ? mark._ : ''
                endif
            catch
            endtry
            return ''
        endfunction

        function! MyReadonly()
            return &ft !~? 'help' && &readonly ? '≠' : '' " or ⭤
        endfunction

        function! CtrlPMark()
            if expand('%:t') =~ 'ControlP'
                call lightline#link('iR'[g:lightline.ctrlp_regex])
                return lightline#concatenate([g:lightline.ctrlp_prev, g:lightline.ctrlp_item
                    \ , g:lightline.ctrlp_next], 0)
            else
                return ''
            endif
        endfunction

        " https://github.com/itchyny/lightline.vim/issues/36
        function! MyBufferline()
            call bufferline#refresh_status()
            let b = g:bufferline_status_info.before
            let c = g:bufferline_status_info.current
            let a = g:bufferline_status_info.after
            let alen = strlen(a)
            let blen = strlen(b)
            let clen = strlen(c)
            let w = winwidth(0) * 4 / 11
            if w < alen+blen+clen
                let whalf = (w - strlen(c)) / 2
                let aa = alen > whalf && blen > whalf ? a[:whalf] : alen + blen < w - clen || alen < whalf ? a : a[:(w - clen - blen)]
                let bb = alen > whalf && blen > whalf ? b[-(whalf):] : alen + blen < w - clen || blen < whalf ? b : b[-(w - clen - alen):]
                return (strlen(bb) < strlen(b) ? '...' : '') . bb . c . aa . (strlen(aa) < strlen(a) ? '...' : '')
            else
                return b . c . a
            endif
        endfunction

        function! MyFileformat()
            return winwidth('.') > 90 ? &fileformat : ''
        endfunction

        function! MyFileencoding()
            return winwidth('.') > 80 ? (strlen(&fenc) ? &fenc : &enc) : ''
        endfunction

        function! MyFiletype()
            return winwidth('.') > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
        endfunction

        let g:ctrlp_status_func = {
            \ 'main': 'CtrlPStatusFunc_1',
            \ 'prog': 'CtrlPStatusFunc_2',
            \ }

        function! CtrlPStatusFunc_1(focus, byfname, regex, prev, item, next, marked)
            let g:lightline.ctrlp_regex = a:regex
            let g:lightline.ctrlp_prev = a:prev
            let g:lightline.ctrlp_item = a:item
            let g:lightline.ctrlp_next = a:next
            return lightline#statusline(0)
        endfunction

        function! CtrlPStatusFunc_2(str)
            return lightline#statusline(0)
        endfunction

        function! TagbarStatusFunc(current, sort, fname, ...) abort
            let g:lightline.fname = a:fname
            return lightline#statusline(0)
        endfunction

        function! s:syntastic()
            SyntasticCheck
            call lightline#update()
        endfunction

        augroup AutoSyntastic
            autocmd!
            execute "autocmd FileType " .
                \join(g:syntastic_mode_map["active_filetypes"], ",") .
                \" autocmd BufWritePost <buffer> :call s:syntastic()"
        augroup END
    """ }}}
""" }}}