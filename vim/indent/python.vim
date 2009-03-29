" Detect python shiftwidth
" Creator: Grissiom <chaos.proton@gmail.com>
" I have often switch between tow projects that use different indent policy.
" It's painful to set shiftwidth to either 8 or 4. So I write this script to
" detect the indent at run time.

" Only load this indent file when no other was loaded.
"if exists("b:did_indent")
"    finish
"endif

let i = 1
let flength = line('$')
while getline(i) !~ '^\(class\s.*:\|def\s\+\|try:\|if\|for\s\+\|while\s\+\)' && i <= flength
	let i = i + 1
endwhile
"echo i
if i < flength
	let ind = indent(nextnonblank(i+1))
else
	let ind = 8
endif
exe ":set shiftwidth=".ind

