set foldmethod=indent
set foldlevel=100
:map <silent> cm :call <SID>Comment('#')<cr>
:ounmap cm
:map <silent> dc :call <SID>DelComment('#')<cr>
:ounmap dc
function <SID>DelComment(char)
	call setline('.',substitute(getline("."), a:char, "", ""))
endf

function <SID>Comment(char)
	call setline('.', printf("%s%s", a:char, getline('.')))
endf

"python auto-complete code
"http://vim.sourceforge.net/scripts/download_script.php?src_id=2668
" Typing the following (in insert mode):
"   os.lis<Ctrl-n>
" will expand to:
"   os.listdir(
" Python 自动补全功能，用 Ctrl-N 调用
if has("autocmd")
  autocmd FileType python set complete+=k~/.vim/pydiction isk+=., 
endif

