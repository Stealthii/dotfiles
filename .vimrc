set nocompatible

" Old vimrc config
" Kept for fun reference to my old setup, but since moved to NeoVim

" =======
" Plugins
" =======
call plug#begin()

" FZF
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Theme
Plug 'ryanoasis/vim-devicons'
Plug 'itchyny/lightline.vim'
Plug 'gruvbox-community/gruvbox'
"Plug 'shinchu/lightline-gruvbox.vim'

" Nerdtree
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'johnstef99/vim-nerdtree-syntax-highlight'

" Python
Plug 'wookayin/semshi', { 'do': ':UpdateRemotePlugins', 'tag': '*' }
Plug 'jeetsukumaran/vim-pythonsense'

" Other
Plug 'airblade/vim-gitgutter' " Git diff in gutter
Plug 'alfredodeza/coveragepy.vim'
Plug 'aprilwade/minibufexpl.vim'
Plug 'editorconfig/editorconfig-vim'
Plug 'preservim/tagbar'
Plug 'mattn/emmet-vim' " expanding abbreviations similar to emmet
Plug 'sheerun/vim-polyglot'
let g:polyglot_disabled = ['python.plugin']
Plug 'sickill/vim-pasta'
Plug 'tomtom/tcomment_vim'
Plug 'tomtom/tlib_vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-sensible'

" Github Copilot
Plug 'github/copilot.vim'

" ALE (Asynchronous Linting Engine)
Plug 'dense-analysis/ale'
Plug 'maximbaz/lightline-ale'
call plug#end()

" =======
" Options
" =======
let g:gruvbox_italic=1
autocmd vimenter * ++nested colorscheme gruvbox
colorscheme gruvbox
syntax enable
set background=dark
set directory=$HOME/.vim/swapfiles// "For swaps
set hidden "Keeps invisible buffers loaded
" set mouse=a "Enables mouse support
" if has("mouse_sgr")
"     set ttymouse=sgr
" elseif has("mouse_xterm2")
"     set ttymouse=xterm2
" end
set hlsearch "When searching, highlights all matches
set ignorecase "Case insensitive search
set smartcase  "Makes searching case-sensitive if you have a mixed case search
set nostartofline "Keeps the cursor at the same position on a line
set laststatus=2 "Always show the status line
set confirm "Ask for confirmation when changes have happened
set visualbell "Allows Vim to notify you through the terminal
set number "Shows line numbers
set noshowmode "Because Lightline does this for us
set clipboard+=unnamedplus

" The settings below refer to indentation of code.  To simplify:
" - Tabs are replaced with 4 spaces.
" - Indentation is (by default) always 4 spaces
" - If you have only got 8 space indentation, these will become tabs again
" editorconfig or vim lines in files will override these on a project basis
set shiftwidth=4 "The automatic indent amount
set tabstop=8 "How many columns relate to a tab
set softtabstop=8 "8 columns when you press tab
set expandtab "This replaces tab with spaces!

filetype plugin indent on
autocmd FileType javascript setlocal ts=4 sts=4 sw=4
highlight Comment cterm=italic
highlight Statement cterm=italic

" =============
" Plugin Config
" =============

" FZF
set rtp+=/opt/homebrew/opt/fzf
set rtp+=/usr/local/opt/fzf
set rtp+=~/.fzf
nmap ; :Buffers<CR>
nmap <Leader>r :Tags<CR>
nmap <Leader>t :Files<CR>
nmap <Leader>a :Ag<CR>

" ack.vim
let g:ackprg = 'ag --vimgrep' " Tell ack.vim to use ag instead

" MiniBufExplorer
let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1

" NERDTree
autocmd StdinReadPre * let s:std_in=1 "Detect stdin
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif "Auto-open if empty
map <C-n> :NERDTreeToggle<CR>|" Ctrl+N for opening

" ALE
let g:ale_sign_warning = '▲'
let g:ale_sign_error = '✗'
let g:ale_linters = {'python': ['mypy', 'ruff'], 'javascript': ['eslint']}
let g:ale_fixers = {'rust': ['rustfmt'], 'python': ['black', 'ruff'], 'sh': ['shfmt'], 'perl': ['perltidy'], 'xml': ['xmllint'], 'javascript': ['eslint'], 'yaml': ['yamlfix'], 'lua': ['stylua']}
let g:ale_javascript_prettier_use_local_config = 1
let g:ale_lsp_suggestions = 1
let g:ale_fix_on_save = 0
" highlight link ALEWarningSign String
" highlight link ALEErrorSign Title

" Lightline
let g:lightline = {
\ 'colorscheme': 'gruvbox',
\ 'separator': { 'left': '', 'right': '' },
\ 'subseparator': { 'left': '', 'right': '' },
\ 'active': {
\   'left': [['mode', 'paste'], ['filename', 'modified']],
\   'right': [ [ 'readonly', 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_infos', 'linter_ok' ],
\              [ 'lineinfo' ],
\              [ 'percent' ],
\              [ 'fileformat', 'fileencoding', 'filetype'] ]
\ },
\ 'component_expand': {
\   'linter_checking': 'lightline#ale#checking',
\   'linter_infos': 'lightline#ale#infos',
\   'linter_warnings': 'lightline#ale#warnings',
\   'linter_errors': 'lightline#ale#errors',
\   'linter_ok': 'lightline#ale#ok',
\ },
\ 'component_type': {
\   'readonly': 'error',
\   'linter_checking': 'right',
\   'linter_errors': 'error',
\   'linter_warnings': 'warning',
\   'linter_infos': 'right',
\   'linter_ok': 'right',
\ },
\ }

let g:lightline#ale#indicator_checking = "\uf110 "
let g:lightline#ale#indicator_infos = "\uf129 "
let g:lightline#ale#indicator_warnings = "\uf071 "
let g:lightline#ale#indicator_errors = "\uf05e "
let g:lightline#ale#indicator_ok = "\uf00c "

" function! LightlineLinterWarnings() abort
"   let l:counts = ale#statusline#Count(bufnr(''))
"   let l:all_errors = l:counts.error + l:counts.style_error
"   let l:all_non_errors = l:counts.total - l:all_errors
"   return l:counts.total == 0 ? '' : printf('%d ◆', all_non_errors)
" endfunction
"
" function! LightlineLinterErrors() abort
"   let l:counts = ale#statusline#Count(bufnr(''))
"   let l:all_errors = l:counts.error + l:counts.style_error
"   let l:all_non_errors = l:counts.total - l:all_errors
"   return l:counts.total == 0 ? '' : printf('%d ✗', all_errors)
" endfunction
"
" function! LightlineLinterOK() abort
"   let l:counts = ale#statusline#Count(bufnr(''))
"   let l:all_errors = l:counts.error + l:counts.style_error
"   let l:all_non_errors = l:counts.total - l:all_errors
"   return l:counts.total == 0 ? '✓ ' : ''
" endfunction

" autocmd User ALELint call s:MaybeUpdateLightline()
"
" " Update and show lightline but only if it's visible (e.g., not in Goyo)
" function! s:MaybeUpdateLightline()
"   if exists('#lightline')
"     call lightline#update()
"   end
" endfunction

" Semshi
let g:semshi#excluded_hl_groups = ['local']
"let g:semshi#simplify_markup = v:true

" ========
" Bindings
" ========

" Quit all
nmap <F2>      :qa <CR>| " F2 Get the fuck out
vmap <F2> <Esc>:qa <CR>
omap <F2> <Esc>:qa <CR>
imap <F2> <Esc>:qa <CR>

" Tagbar
nmap <F3>      :TagbarToggle <CR>| " F3 Tagbar
vmap <F3> <Esc>:TagbarToggle <CR>
omap <F3> <Esc>:TagbarToggle <CR>
imap <F3> <Esc>:TagbarToggle <CR>

" VimDiff funkyness
nnoremap <S-Left>  <c-w>h   |" move cursor to the left window  (Shift + Left Arrow)
nnoremap <S-Right> <c-w>l   |" move cursor to the right window (Shift + Right Arrow)

" http://stackoverflow.com/questions/1005/getting-root-permissions-on-a-file-inside-of-vi
cmap w!! w !sudo tee >/dev/null %
