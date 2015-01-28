" :help oneoftheseoptions for more info.
set backspace=indent,eol,start
set expandtab
set hlsearch
set ignorecase
set listchars=eol:$,tab:;.,trail:!,precedes:~,extends:~,nbsp:_
set noshowmatch
set ruler
set scrolloff=999
set shiftwidth=4
set softtabstop=4
set tabstop=4
set wildmenu
set wildmode=full
set winheight=999
set winminheight=0
set textwidth=0

" I don't like seeing .filename.swp files everywhere.
set backupdir=~/.vim/backup
set directory=~/.vim/swap

" Ctrl + hjkl moves to the window in that direction.
map <C-j> <C-W>j<C-W>_
map <C-k> <C-W>k<C-W>_
map <C-h> <C-W>h<C-W>_
map <C-l> <C-W>l<C-W>_

" So does just pressing an arrow key.
"map <Up> <C-W>k<C-W>_
"map <Down> <C-W>j<C-W>_
"map <Left> <C-W>h<C-W>_
"map <Right> <C-W>l<C-W>_

" But not in insert mode.
"imap <Up> <Nop>
"imap <Down> <Nop>
"imap <Left> <Nop>
"imap <Right> <Nop>

" Shift left and right will push a window to that side.
" Good for maintaining two-column views.
map <S-Left> <C-W>H<C-W>_
map <S-Right> <C-W>L<C-W>_

" > not doing this
" > 2011
" ISHYGDDT
map j gj
map k gk

" pressing escape is hard.
imap jj <Esc>

" kill highlights when I jump to insert mode. press n to see them again.
nnoremap i :noh<CR>i

" See this word I'm on? Global replace it with something.
nnoremap <Leader>s :%s/\<<C-r><C-w>\>//g<Left><Left>


nnoremap <Leader>n :NERDTreeToggle<CR>

syntax on
filetype on
filetype plugin on
set t_Co=256
colo koehler

" There's probably a better way to do this.
function! UpdateGitDiff()
	silent :%!git diff
endfunction

function! GitDiff()
	vnew
	setlocal buftype=nofile
	setlocal noswapfile
	file git-diff
	set filetype=diff
    call UpdateGitDiff()
endfunction

au BufEnter git-diff :call UpdateGitDiff()
nnoremap <Leader>g :call GitDiff()<CR>

" If you're not working on a fork of Openstack's Nova, disregard.
au BufRead *nova.log set ft=novalog
au BufRead *nova.log set autoread

