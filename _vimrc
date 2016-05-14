set nocompatible              " be iMproved, required

"{{{ OS detection function
if !exists("g:os")
    if has("win64") || has("win32") || has("win16")
        let g:os = "Windows"
    else
        let g:os = substitute(system('uname'), '\n', '', '')
    endif
endif
"}}}


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"{{{                            Plug Settings                                "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if has("gui_running")
    if g:os == "Windows"
        " silent is to depress git message...
        silent call plug#begin('~/vimfiles/plugged')
    else
        call plug#begin('~/.vim/plugged')
        Plug 'vim-scripts/taglist.vim'
        Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
        Plug 'junegunn/fzf.vim' "for macvim, install XQuartz
        " python mode not working in windows for some reason
        Plug 'klen/python-mode', { 'for': 'python' }
        Plug 'ctrlpvim/ctrlp.vim'
    endif
endif

" Color Scheme
Plug 'tomasr/molokai'
Plug 'chriskempson/vim-tomorrow-theme'
Plug 'altercation/vim-colors-solarized'
" syntax power pack
Plug 'sheerun/vim-polyglot'
" HTML and CSS
Plug 'mattn/emmet-vim', { 'for': ['html','css'] }
Plug 'tmhedberg/matchit', { 'for': ['html','xml'] }
Plug 'vim-scripts/closetag.vim', { 'for': 'html' }
Plug 'Raimondi/delimitmate' "automatic closing of quotes, parenthesis, brackets, etc
" Syntax Check
Plug 'scrooloose/syntastic', { 'for': ['php', 'python', 'javascript', 'css', 'html'] }
" Snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'vim-scripts/YankRing.vim'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-repeat'
Plug 'ervandew/supertab'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'easymotion/vim-easymotion'

Plug 'terryma/vim-multiple-cursors'
Plug 'vim-scripts/BufOnly.vim'

Plug 'lervag/vimtex'

call plug#end()
"}}}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"{{{                            Basic Setting                                "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set fileencoding=utf-8
set ts=4 sts=4 sw=4 expandtab "tabstop/softtabstop/shiftwidth
set number
set scrolloff=3
set wrap
set spelllang=en_us
set clipboard=unnamed
let g:indentline_char='|'
set linebreak " break line not words when wrap
set showcmd " show cmd you type
set backspace=indent,eol,start
set laststatus=2 " always show status line
" commond line autocomplete
set wildmenu
set wildmode=full
set modelines=0 " turn off mode line
set ruler " show row, column position
set hidden
set history=100
set visualbell

" indent option
set smartindent
set autoindent

" Search Related
set ignorecase
set smartcase
set incsearch
set gdefault " always global search
set showmatch
set hlsearch

" Appearance
set background=dark
colorscheme Tomorrow-Night
" colorscheme solarized
set gfn=Courier:h15
" set cursor color
autocmd InsertEnter,InsertLeave * set cul!
au InsertLeave * hi Cursor guibg=red
au InsertEnter * hi Cursor guibg=green
set cursorline cursorcolumn
" resize focused window
set winwidth=84
set winheight=5
set winminheight=5
set winheight=999

" folder setting
set foldmethod=marker
set foldmarker={{{,}}}
hi Folded guibg=#234495

" Backup option
set nowritebackup
set noswapfile
set nobackup

" Add dictionary
set dictionary+=/usr/share/dict/words
"}}}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"{{{                               Mapping                                   "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let mapleader=","
let maplocalleader="\\"

" change dir to local/home
nnoremap ,cd :cd %:p:h<CR>:pwd<CR>
nnoremap ,ho :cd ~/<CR>:pwd<CR>

" Insert Mode
" Mapping Autocomplete Keys buffer/omni
inoremap <C-b> <C-x><C-n>
inoremap <C-o> <C-x><C-o>
inoremap <C-f> <C-x><C-f>
inoremap <C-k> <C-x><C-k>
inoremap jj <ESC>:w<CR>
" exit insert, dd line, enter insert
inoremap <C-d> <ESC>ddO

"Multi-window
" Open new buffers
nmap <leader>s<left>   :leftabove  vnew<cr>
nmap <leader>s<right>  :rightbelow vnew<cr>
nmap <leader>s<up>     :leftabove  new<cr>
nmap <leader>s<down>   :rightbelow new<cr>
"only this window
nnoremap <leader>o :only<cr>
" close window
nnoremap <leader>c <C-w>c
" kill current window
nnoremap <leader>k :bd<cr>
" kill all other buffers
nnoremap <leader>oo :BufOnly<cr>

" fixing up moving line by line in the paragraph
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

" Reload syntax highlight
noremap <F12> <Esc>:syntax sync fromstart<CR>
" Fix Spelling
nnoremap <Leader>x 1z=
" Open VIMRC
nnoremap <Leader>rc :e $MYVIMRC<CR>

map <leader>s <ESC>:w <Bar> source%<CR>
"" re-hardwrap paragraphs of text
nnoremap <leader>p gqip
" Q to apply Macro
nnoremap Q @q
vnoremap Q :norm @q<cr>

nnoremap <tab> >>
nnoremap <s-tab> <<
vnoremap <tab> >
vnoremap <s-tab> <
" copy current files relative path to clipboard
nmap cp :let @+ = expand("%") <cr>
" space to toggle folds.
nnoremap <space> za
vnoremap <space> za
" select last pasted
nnoremap gs `[v`]
" movement in help file
nnoremap <F1> <ESC>:exec "help ".expand("<cword>")<CR>
nmap <buffer> <CR> <C-]>
nmap <buffer> <BS> <C-T>
" open file. if it does not exist, then open a new empty buffer
map gf :edit <cfile><CR>
" no jump when use *
nmap * *``

if has("gui_running")
    if g:os == "Windows"
        map <M-c> "*y
        map <M-x> "+x
        nnoremap <M-SPACE> "+gP
        inoremap <M-SPACE> <C-r><C-p>*
        autocmd filetype python map <c-c><c-c> :!python %<cr>
        autocmd filetype python map <c-c><c-i> :!idle   %<cr>
        autocmd filetype python map <c-c><c-i> :!idle   %<cr>
        autocmd filetype python colorscheme desert

    endif
endif


"}}}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"{{{                               NerdTree                                  "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let NERDTreeMapActivateNode='<right>'
let NERDTreeShowHidden=1
let NERDTreeIgnore=['\.DS_Store$', '\~$', '\.swp$','tmp', '.yardoc', 'pkg']
nmap <leader>n :NERDTreeToggle<CR>
" find current file in directory
nmap <leader>f :NERDTreeFind<CR>
nmap <leader>ff :NERDTree%<CR>cd
function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
exec 'autocmd FileType nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
exec 'autocmd FileType nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
endfunction
call NERDTreeHighlightFile('css', 'NONE', 'NONE', '#1dff00', 'NONE')
call NERDTreeHighlightFile('html', 'NONE', 'NONE', '#00fdff', 'NONE')
call NERDTreeHighlightFile('js', 'NONE', 'NONE', '#ffa500', 'NONE')
call NERDTreeHighlightFile('python', 'NONE', 'NONE', '#df00ff', 'NONE')
"}}}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                   CtrlP                                    "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if has("gui_running")
    if g:os == "Windows"
        set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pdf,*.mov,*.mp4,*.plist,*.epub,*.mp3,.DS_Store
        set wildignore+=*/tmp/*,*.pyc,*.vsd
        let g:ctrlp_working_path_mode = 0
        nnoremap <silent> t :CtrlP ~/<cr>
        nnoremap <silent> m ::CtrlPMRU<cr>
        let g:ctrlp_by_filename = 0
        let g:ctrlp_max_depth = 10
        let g:ctrlp_max_files=0
        let g:ctrlp_mruf_max = 250
        let g:ctrlp_mruf_case_sensitive = 0
        let g:ctrlp_show_hidden = 1
        let g:ctrlp_clear_cache_on_exit = 0
    else
" CTRL-T / CTRL-X / CTRL-V key bindings to open in a new tab, a new split, or
" in a new vertical split
        nnoremap <silent> t :Files~<cr>
        nnoremap <silent> m :History<cr>
        map <c-x><c-l> <plug>(fzf-complete-line)

    endif
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                   Pymode                                   "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:pymode_python = 'python' " or python3
let g:pymode_indent = 1
let g:pymode_folding = 1
let g:pymode_lint_on_write = 0 "not checking code every saving
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                   emmet                                    "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable just for html/css
let g:user_emmet_install_global = 0
autocmd FileType html,css EmmetInstall
let g:user_emmet_leader_key='<C-Z>'
let g:user_emmet_prev_key = '<c-j>'
let g:user_emmet_next_key = '<c-k>'
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                  Yankring                                  "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <Leader>y :YRShow<CR>
let g:yankring_enabled = 1  " Disables the yankring
let g:yankring_max_history = 20
if has("gui_running")
    if g:os == "Windows"
        let g:yankring_history_dir = '~/vimfiles/'
    else
        let g:yankring_history_dir = '~/.vim/'
    endif
endif
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                  Airline                                   "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 0
if has("gui_running")
    if g:os != "Windows"
        let g:airline_powerline_fonts = 1
        if !exists('g:airline_symbols')
              let g:airline_symbols = {}
        endif
        let g:airline_theme = 'bubblegum'
        set guifont=DejaVu_Sans_Mono_for_Powerline:h14
        " airline symbols
        let g:airline_left_sep = ''
        let g:airline_left_alt_sep = ''
        let g:airline_right_sep = ''
        let g:airline_right_alt_sep = ''
        let g:airline_symbols.branch = ''
        let g:airline_symbols.readonly = ''
        let g:airline_symbols.linenr = ''
    else
    endif
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                 Syntastics                                 "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                  HTML/CSS                                  "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" save html and open to view
nnoremap <Leader>w :w! <Bar> !open %<CR>
" autocmd BufRead,BufWritePre *.html normal gg=G''zz
" Automatic formatting
autocmd BufRead *.html normal gg=G''zz
autocmd BufRead,BufWritePre *.css normal gg=G''zz
"remove trailing whitespace characters
autocmd BufWritePre *.html :%s/\s\+$//e
autocmd BufWritePre * :%s/\s\+$//e
" set - as keywork, so * will include -
au FileType html set isk+=-


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                  Snippets                                  "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"
nnoremap <Leader>ue :UltiSnipsEdit<CR>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                Other Setting/Mapping                       "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete


" " autocomplete brackets
" inoremap ( ()<Esc>i
" inoremap { {}<Esc>i
" inoremap [ []<Esc>i
" inoremap < <><Esc>i
" inoremap ' ''<Esc>i
" inoremap " ""<Esc>i


" vmap <C-c> y:call system("pbcopy", getreg("\""))<CR>
" nmap <C-v> :call setreg("\"",system("pbpaste"))<CR>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                  Latex                                     "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vimtex Setting
" forward search
nmap <localleader>s :VimtexCompile<CR>
nmap <localleader>v :VimtexView<CR>

"
let g:vimtex_view_general_viewer
      \ = '/Applications/Skim.app/Contents/SharedSupport/displayline'
let g:vimtex_view_general_options = '-r @line @pdf @tex'

" This adds a callback hook that updates Skim after compilation
let g:vimtex_latexmk_callback_hooks = ['UpdateSkim']
function! UpdateSkim(status)
  if !a:status | return | endif

  let l:out = b:vimtex.out()
  let l:cmd = [g:vimtex_view_general_viewer, '-r']
  if !empty(system('pgrep Skim'))
    call extend(l:cmd, ['-g'])
  endif
  if has('nvim')
    call jobstart(l:cmd + [line('.'), l:out])
  elseif has('job')
    call job_start(l:cmd + [line('.'), l:out])
  else
    call system(join(l:cmd + [line('.'), shellescape(l:out)], ' '))
  endif
endfunction

