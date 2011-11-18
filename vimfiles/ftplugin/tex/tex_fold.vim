" Fold environments and sections in tex file
" Source:
" Last Change: 2010-11-29
" Author: Grissiom

if &filetype != 'tex'
    finish
endif

setlocal foldmethod=expr
setlocal foldexpr=Get_tex_fd(v:lnum)
setlocal foldtext=Get_tex_ft()

" sections and their folding levels
let s:fdl = [['^\\section', 1],
            \['^\\bibliography{', 1],
            \['^\\subsection', 2],
	    \['^\\subsubsection', 3]
	    \]

func! Get_tex_fd(lnum)
	let cln = getline(a:lnum)
	let nln = getline(a:lnum+1)

	" don't add a fold level for the obvious document env
	if cln =~ '\\begin{document}'
		return 0
	elseif cln =~ '\\end{document}'
		return 0
	elseif cln =~ '\\begin'
		return 'a1'
	elseif cln =~ '\\end'
		return 's1'
	endif

	for i in s:fdl
		if nln =~ i[0]
			return '<' . i[1]
		elseif cln =~ i[0]
			return '>' . i[1]
		endif
	endfor

	return '='
endfunc

func! Get_tex_ft()
	let lth = v:foldend - v:foldstart
	" AFAIS, there is no way to know how many columns ware used to display
	" line numbers on the fly.(numberwidth is the 'minimum' amount of
	" columns to display line numbers) So assume 8 is enough here. Mail me
	" if it's not enough for you ;)
	let wth = winwidth(0) - &foldcolumn - (&number ? 8 : 0)

	let lnst = getline(v:foldstart)
	let lnnd = ' ' . lth . ' lines'

	let stuff = ' '
	let stuffth = wth - strdisplaywidth(lnst) - strdisplaywidth(lnnd)
	if stuffth < 0
		let ep = '...'
		let new_lnstlen = wth-strdisplaywidth(lnnd) - strdisplaywidth(ep)
		let i = 0
		while strdisplaywidth(lnst[0:i]) < new_lnstlen
			let i += 1
		endwh
		return lnst[0:i] . '...' . lnnd
	endif
	while len(stuff) < stuffth
		let stuff = stuff . stuff[0]
	endwh

	return lnst . stuff . lnnd
endfunc
