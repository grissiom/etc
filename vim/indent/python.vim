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
while getline(i) !~ '^\(class\s.*:\|def\s\|if\|try:\)'
	let i = i + 1
endwhile
"echo i
let i = nextnonblank(i+1)
"echo i
exe ":set shiftwidth=".indent(i)

