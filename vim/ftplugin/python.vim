set foldmethod=indent
set foldlevel=100

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

