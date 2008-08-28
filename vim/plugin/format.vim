if exists('g:format_vim_done')
	finish
endif

let g:format_vim_done=1

function s:Goback()
	exec "normal ".s:cursorline."G".s:cursorcol."|"
endfunction

" really go back (including the screen position)
function s:ReallyGoback()
    exec "normal ".s:topline."Gzt"
	exec "normal ".s:cursorline."G".s:cursorcol."|"
endfunction

" Check whether this line can join the previous line
function s:CanJoin(str)
	if &filetype=='tex'
		let checks=['\section', '\subsection', '\subsubsection', '\chapter', '\paragraph', '\clearpage', '\include', '\biblio', '\usepack', '\def', '\table', '\psfrag', '\thanks', '\label',  '\caption', '\document', '\listoffigures', '\DeclareMathOperator', '\begin', '\end', '\bi', '\ei']
		let regex=join(checks, '\|')
		let regex=substitute(regex, '\zs\\\ze[^|]', '^\\\\', 'g')
		let regex.='\|^%\|^\s'
	else
		let regex='^\s'
	endif
		return (match(a:str, regex)==-1)
endfunction

" check if it is the start of a verbatim block (eg. equation)
function s:BlockStart(str)
	if &filetype=='tex'
		let checks=['\[', '\begin{equation', '\begin{align', ]
		let regex=join(checks, '\|')
		let regex=substitute(regex, '\zs\\\ze[^|]', '^\\\\', 'g')
		let regex=substitute(regex, '\(\[\|\]\)', '\\\1', 'g')
		return match(a:str, regex)==0
	else
		return 0
	endif
endfunction

" check if it is the end of a verbatim block (eg. equation)
function s:BlockEnd(str)
	if &filetype=='tex'
		let checks=['\]', '\end{equation', '\end{align']
		let regex=join(checks, '\|')
		let regex=substitute(regex, '\zs\\\ze[^|]', '^\\\\', 'g')
		let regex=substitute(regex, '\(\[\|\]\)', '\\\1', 'g')
		return match(a:str, regex)==0
	else
		return 0
	endif
endfunction

" Output str verbatimly, after finishing half-line business
function s:Verbatim(str)
		if s:halfline!=""
			let s:newlines+=[s:halfline]
		endif
		let s:newlines+=[a:str]
		let s:halfline=""
endfunction

" Format a single line
function s:FormatLine(line)
	if &textwidth>0
		let s:textwidth=&textwidth
	else
		let s:textwidth=80
	endif

	let str=getline(a:line)

	if s:BlockStart(str)
		let s:inblock=1
		call s:Verbatim(str)
		return
	endif

	if s:BlockEnd(str)
		let s:inblock=0
		call s:Verbatim(str)
		return
	endif

	" empty line
	if match(str, '^\s*$')>=0 
		if s:prevempty==1
			return	
		else
			call s:Verbatim("")
			let s:prevempty=1
			return
		endif
	else
		let s:prevempty=0
	endif

	" in a block or cannot join previously
	if s:inblock==1 || !s:CanJoin(str) 
		call s:Verbatim(str)
		return
	endif 

	" join with the previous line
	let words = split(str, '\s\+')
	for word in words
		if s:halfline==""
			let s:halfline=word
		else 
			if (strlen(word)+strlen(s:halfline)+1)>s:textwidth
				let s:newlines+=[s:halfline]
				let s:halfline=word
			else
				let s:halfline.= ' '.word
			endif
		endif
	endfor
endfunction

" format a range of lines
function s:FormatLines(startl, endl)

	let s:newlines=[]
	let s:halfline=""
	let s:inblock=0
	let s:prevempty=0

	let index=a:startl
	while index<=a:endl
		call s:FormatLine(index)
		let index+=1
	endwhile

	"flush the last half line if necessary
	if s:halfline!=""
		let s:newlines+=[s:halfline]
	endif

	"deal with the stupid/elusive vim undo cursor placement
	" Do some change so that VIM will undo to this point
	call s:Goback()
	normal rx

	" delete the old ones
	exec ':'.a:startl.','.a:endl.'d'

	" insert the new lines
	call append(a:startl-1, s:newlines)
endfunction

" format a paragraph
function s:FormatParagraph()
	let s:cursorline=line(".")
	let s:cursorcol=col(".")
	let cursorchar=strpart(getline("."), col(".") - 1, 1)
    normal! H
    let s:topline = line(".")
	call s:Goback()

	normal }{
	let startl=nextnonblank('.')
	if startl>s:cursorline "we are on a blank line
		call s:ReallyGoback()
		return
	endif
	normal }
	let endl=prevnonblank('.')
	call s:Goback()

	" compute logical position (num chars) relative to start of paragraph
	let index=startl
	let old_pos=0
	while index < s:cursorline
		let old_pos+=strlen(substitute(getline(index), '\s', '', 'g'))
		let index+=1
	endwhile
	let old_pos+=strlen(substitute(strpart(getline(index),0,col('.')), '\s', '', 'g'))

	" format 
	call s:FormatLines(startl, endl)

	" restore cursor position
	exec ':'.startl
	normal 0

	if old_pos>1
		call search('^\%(\_s*\S\)\{'.(old_pos).'}', 'e', endl+len(s:newlines))
		if match(cursorchar, '\s')==0
			call search('\_s', '', line('$'))
		endif
	endif

	" restore screen position
	let tmpline=line('.')
	let tmpcol=col('.')
    execute "normal! ".s:topline."Gzt"
	exec "normal ".tmpline."G".tmpcol."|"
endfunction

silent! unmap K 
nnoremap <silent><buffer> K :silent call <SID>FormatParagraph()<CR>
