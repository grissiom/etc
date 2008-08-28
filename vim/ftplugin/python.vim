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

