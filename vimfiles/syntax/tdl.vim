if exists("b:current_syntax")
  finish
endif

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

exec 'syn match todo_pre ' . '"^' . s:todop . '"'
exec 'syn region done_entry ' . 'start="^\(' . s:donep . '\|' . s:rejp . '\)"' . ' end="\%$"'

hi link todo_pre Special
hi link done_entry Comment

let b:current_syntax = "tdl"
