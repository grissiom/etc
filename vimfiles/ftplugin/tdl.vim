" Vim ftplugin for tdl file
" Creator: Grissiom <chaos.proton AT gmail.com>

if exists("b:tdl_ftplugin")
	finish
endif
let b:tdl_ftplugin = 1

if exists("g:tdl_time_fmt")
	let s:ftmt = g:tdl_time_fmt
else
	let s:tfmt = " [%F %H:%M]"
endif

if exists("g:tdl_todo_prefix")
	let s:todop = g:tdl_todo_prefix
else
	let s:todop = "-> "
endif

if exists("g:tdl_done_prefix")
	let s:donep = g:tdl_done_prefix
else
	let s:donep = "== "
endif

if exists("g:tdl_rej_prefix")
	let s:rejp = g:tdl_rej_prefix
else
	let s:rejp = "xx "
endif

fu <SID>new_entry()
	if line('.') == line('$')
		exe "norm! o\<ESC>"
	elseif <SID>cnt_entry_type(line('.')) == 'todo'
		exe 'norm! :' . <SID>get_next_entry_ln(line('.'))
		exe "norm! o\<ESC>"
	endif
	call <SID>ins_todo_m()
	exe "norm! " . strlen(s:tstr) . "h"
endfu

fu <SID>done_entry()
	if <SID>cnt_entry_type(line('.')) == 'done'
		return
	endif

	let bgln = <SID>get_entry_top_ln(line('.'))

	let edln = <SID>get_next_entry_ln(bgln+1) - 1

	let done_top = <SID>get_top(edln, s:donep)

	call <SID>ins_done_m(bgln)
	call <SID>cut_to(bgln, edln, done_top-1)
endfu

fu <SID>undone_entry()
	if <SID>cnt_entry_type(line('.')) != 'done'
		return
	endif

	let bgln = <SID>get_entry_top_ln(line('.'))

	let edln = <SID>get_next_entry_ln(bgln+1) - 1

	call <SID>rev_done_m(bgln)
	call <SID>cut_to(bgln, edln, 0)
endfu

fu <SID>rej_entry()
	if <SID>cnt_entry_type(line('.')) == 'rej'
		return
	endif

	let bgln = <SID>get_entry_top_ln(line('.'))

	let edln = <SID>get_next_entry_ln(bgln+1) - 1

	let rej_top = <SID>get_top(edln, s:rejp)

	call <SID>ins_rej_m(bgln)
	call <SID>cut_to(bgln, edln, rej_top-1)
endfu

fu <SID>ins_todo_m()
	let s:tstr = strftime(s:tfmt)
	exe "norm! \<ESC>0i" . s:todop . "\<ESC>A" . s:tstr
endfu

fu <SID>ins_done_m(ln)
	let ppos = getpos('.')
	call cursor(a:ln, 1)
	exe 's/^\(' . s:todop . '\|' . s:rejp . '\)/' . s:donep . "/"
	call cursor(ppos)
endfu

fu <SID>rev_done_m(ln)
	let ppos = getpos('.')
	call cursor(a:ln, 1)
	exe 's/^' . s:donep . '/' . s:todop . "/"
	call cursor(ppos)
endfu

fu <SID>ins_rej_m(ln)
	let ppos = getpos('.')
	call cursor(a:ln, 1)
	exe 's/^\(' . s:todop . '\|' . s:donep . '\)/' . s:rejp . "/"
	call cursor(ppos)
endfu

fu <SID>cut_to(bg, ed, ln)
	call append(a:ln, getline(a:bg, a:ed))
	call <SID>delete_lines(a:bg, a:ed)
endfu

fu <SID>delete_lines(bg, ed)
	for i in range(a:bg, a:ed)
		exe 'norm :' . i
		norm dd
	endfo
endfu

fu <SID>cnt_entry_type(ln)
	for i in range(a:ln, 1, -1)
		if getline(i) =~ '^' . s:todop
			return 'todo'
		endif
		if getline(i) =~ '^' . s:donep
			return 'done'
		endif
		if getline(i) =~ '^' . s:rejp
			return 'rej'
		endif
	endfo
	return 'none'
endfu

fu <SID>get_entry_top_ln(ln)
	return <SID>loc_uw_in(a:ln, 1, '^\(' . s:todop . '\|' . s:donep . '\|' . s:rejp . '\)')
endfu

fu <SID>get_next_entry_ln(ln)
	return <SID>loc_dw_in(a:ln, line('$')+1, '^\(' . s:todop . '\|' . s:donep . '\|' . s:rejp . '\)')
endfu

fu <SID>get_top(ln, ep)
	return <SID>loc_dw_in(a:ln, line('$')+1, '^' . a:ep)
endfu

fu <SID>loc_dw_in(bg, ed, pat)
	return <SID>loc_in(a:bg, a:ed, 1, a:pat)
endfu

fu <SID>loc_uw_in(bg, ed, pat)
	return <SID>loc_in(a:bg, a:ed, -1, a:pat)
endfu

fu <SID>loc_in(bg, ed, sp, pat)
	let i = a:bg
	for i in range(a:bg, a:ed, a:sp)
		if getline(i) =~ a:pat
			break
		endif
	endfo
	return i
endfu

nmap <buffer> <silent> ,n :call <SID>new_entry()<CR>a
nmap <buffer> <silent> ,d :call <SID>done_entry()<CR>
nmap <buffer> <silent> ,r :call <SID>rej_entry()<CR>
nmap <buffer> <silent> ,u :call <SID>undone_entry()<CR>
