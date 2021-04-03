" Vim color file
"
" Name:       dark_light256.vim
" Version:    2.0
" Maintainer:	Grissiom <chaos.proton@gmail.com>
"
" Insipred by elflord and xoria256 and some other color themes.
" Should work in recent 256 color terminals or Gvim.  88-color terms like
" urxvt are unsupported.
"
" Don't forget to install 'ncurses-term' and set TERM to xterm-256color or
" similar value.
"
" Color numbers (0-255) see:
" http://www.calmar.ws/vim/256-xterm-24bit-rgb-color-chart.html

if (!has('gui_running')) && &t_Co != 256
  echomsg ""
  echomsg "err: please use a 256-color terminal (or set t_Co=256 in vimrc)"
  echomsg ""
  finish
endif

set background=dark
hi clear

if exists("syntax_on")
  syntax reset
endif

let colors_name = "dark_light256"

"""""""""""""""""""""""""""""""
" Start highlight configrations
"""""""""""""""""""""""""""""""
" let them could be accessed by functions easily.
" FIXME: or just set them to 'none' in other places?
let s:bg=0
let s:fg=249

" order: group, ctermfg, ctermbg, cterm, guifg, guibg, gui
let s:hi_conf=[]
"" Syntax highlighting {{{
let s:hi_conf += [
\['Normal',     s:fg, s:bg, 'none'],
\['Comment',    31],
\['Constant',   131],
\['Number',     68],
\['Identifier', 130, 'none'],
\['Operator',   178],
\['Statement',  111],
\['Special',    5],
\['Function',   32,   s:bg, 'bold'],
\['PreProc',    150],
\['Type',       34],
\['Special',    171],
\['Ignore',     238],
\['Error',      196,  52,   'bold'],
\['Todo',       0,    94],
\]
" }}}

"" Diff {{{
" TODO
let s:hi_conf += [
\['DiffAdded',   34],
\['DiffRemoved', 160],
\['DiffChange',  s:fg, 52],
\['DiffDelete',  s:fg, 240],
\['DiffText',    254,  160],
\]
"}}}

"" Spell {{{
let s:hi_conf += [
\['SpellBad',    196,  52,   'undercurl'],
\['SpellCap',    196,  s:bg, 'undercurl'],
\['SpellRare',   s:fg, 52,   'undercurl'],
\]
"}}}

""UI. {{{
"Don't let the UI catch your eyes more than your code.
let s:hi_conf += [
\['LineNr',      94],
\['MatchParen',  s:fg,  238,  'underline'],
\['Visual',      s:fg,  237],
\['IncSearch',   s:fg,  130],
\['Search',      s:fg,  58],
\
\['FoldColumn',  240,   s:bg, 'bold'],
\
\['TabLine',     246,   236,  'bold'],
\['TabLineFill', 236,   236],
\['TabLineSel',  254,   s:bg],
\['StatusLine',  246,   235],
\['StatusLineNC',238,   234],
\
\['Pmenu',       s:fg,  233],
\['PmenuSel',    s:fg,  238,  'bold'],
\['PmenuSbar',   253,   0],
\['PmenuThumb',  253,   0],
\['WildMenu',    253,   62,   'bold'],
\['SignColumn',  s:fg,  s:bg, 'none'],
\]
"}}}

""""""""""""""""""""""
" End of configrations
""""""""""""""""""""""

" map term color to gui rgb value {{{
let s:tg_cm=[
\'#000000', '#800000', '#008000', '#808000', '#000080', '#800080', '#008080', '#c0c0c0',
\'#808080', '#ff0000', '#00ff00', '#ffff00', '#0000ff', '#ff00ff', '#00ffff', '#ffffff',
\'#000000', '#00005f', '#000087', '#0000af', '#0000df', '#0000ff', '#005f00', '#005f5f',
\'#005f87', '#005faf', '#005fdf', '#005fff', '#008700', '#00875f', '#008787', '#0087af',
\'#0087df', '#0087ff', '#00af00', '#00af5f', '#00af87', '#00afaf', '#00afdf', '#00afff',
\'#00df00', '#00df5f', '#00df87', '#00dfaf', '#00dfdf', '#00dfff', '#00ff00', '#00ff5f',
\'#00ff87', '#00ffaf', '#00ffdf', '#00ffff', '#5f0000', '#5f005f', '#5f0087', '#5f00af',
\'#5f00df', '#5f00ff', '#5f5f00', '#5f5f5f', '#5f5f87', '#5f5faf', '#5f5fdf', '#5f5fff',
\'#5f8700', '#5f875f', '#5f8787', '#5f87af', '#5f87df', '#5f87ff', '#5faf00', '#5faf5f',
\'#5faf87', '#5fafaf', '#5fafdf', '#5fafff', '#5fdf00', '#5fdf5f', '#5fdf87', '#5fdfaf',
\'#5fdfdf', '#5fdfff', '#5fff00', '#5fff5f', '#5fff87', '#5fffaf', '#5fffdf', '#5fffff',
\'#870000', '#87005f', '#870087', '#8700af', '#8700df', '#8700ff', '#875f00', '#875f5f',
\'#875f87', '#875faf', '#875fdf', '#875fff', '#878700', '#87875f', '#878787', '#8787af',
\'#8787df', '#8787ff', '#87af00', '#87af5f', '#87af87', '#87afaf', '#87afdf', '#87afff',
\'#87df00', '#87df5f', '#87df87', '#87dfaf', '#87dfdf', '#87dfff', '#87ff00', '#87ff5f',
\'#87ff87', '#87ffaf', '#87ffdf', '#87ffff', '#af0000', '#af005f', '#af0087', '#af00af',
\'#af00df', '#af00ff', '#af5f00', '#af5f5f', '#af5f87', '#af5faf', '#af5fdf', '#af5fff',
\'#af8700', '#af875f', '#af8787', '#af87af', '#af87df', '#af87ff', '#afaf00', '#afaf5f',
\'#afaf87', '#afafaf', '#afafdf', '#afafff', '#afdf00', '#afdf5f', '#afdf87', '#afdfaf',
\'#afdfdf', '#afdfff', '#afff00', '#afff5f', '#afff87', '#afffaf', '#afffdf', '#afffff',
\'#df0000', '#df005f', '#df0087', '#df00af', '#df00df', '#df00ff', '#df5f5f', '#df5f87',
\'#df5faf', '#df5fdf', '#df5fff', '#df8700', '#df875f', '#df8787', '#df87af', '#df87df',
\'#df87ff', '#dfaf00', '#dfaf5f', '#dfaf87', '#dfafaf', '#dfafdf', '#dfafff', '#dfdf00',
\'#dfdf5f', '#dfdf87', '#df5f00', '#dfdfaf', '#dfdfdf', '#dfdfff', '#dfff00', '#dfff5f',
\'#dfff87', '#dfffaf', '#dfffdf', '#dfffff', '#ff0000', '#ff005f', '#ff0087', '#ff00af',
\'#ff00df', '#ff00ff', '#ff5f00', '#ff5f5f', '#ff5f87', '#ff5faf', '#ff5fdf', '#ff5fff',
\'#ff8700', '#ff875f', '#ff8787', '#ff87af', '#ff87df', '#ff87ff', '#ffaf00', '#ffaf5f',
\'#ffaf87', '#ffafaf', '#ffafdf', '#ffafff', '#ffdf00', '#ffdf5f', '#ffdf87', '#ffdfaf',
\'#ffdfdf', '#ffdfff', '#ffff00', '#ffff5f', '#ffff87', '#ffffaf', '#ffffdf', '#ffffff',
\'#080808', '#121212', '#1c1c1c', '#262626', '#303030', '#3a3a3a', '#444444', '#4e4e4e',
\'#585858', '#626262', '#626262', '#767676', '#808080', '#8a8a8a', '#949494', '#9e9e9e',
\'#a8a8a8', '#b2b2b2', '#bcbcbc', '#c6c6c6', '#d0d0d0', '#dadada', '#e4e4e4', '#eeeeee',
\]
"}}}

" functions {{{
func! s:__hi__(li)
	exec 'hi! ' . a:li[0]
	  \. ' ctermfg=' . a:li[1] . ' ctermbg=' . get(a:li, 2, s:bg) . ' cterm=' . get(a:li, 3, 'none')
	  \. ' guifg='   . get(a:li, 4, s:tg_cm[a:li[1]])
	  \. ' guibg='   . get(a:li, 5, s:tg_cm[get(a:li, 2, s:bg)])
	  \. ' gui='     . get(a:li, 6, 'none')
endf

for s:i in s:hi_conf
	call s:__hi__(s:i)
endfor
unlet s:i
"}}}

" hi links {{{
" I link in this way because I think the folded text is something that "When
" you ws to ignore them, you won't see them, but when you want out, they can
" easily catch your eyes.". I think and hope the Comment is the same thing.
hi! link Folded Comment
" Common groups that link to default highlighting.
" You can specify other highlighting easily.
hi link String         Constant
hi link Character      Constant
hi link Boolean	       Constant
hi link Float	       Number
hi link Repeat         Statement
hi link Conditional    Repeat
hi link Label	       Statement
hi link Keyword	       Statement
hi link Exception      Statement
hi link Include	       PreProc
hi link Define	       PreProc
hi link Macro	       PreProc
hi link PreCondit      PreProc
hi link StorageClass   Type
hi link Structure      Type
hi link Typedef	       Type
hi link Tag	       Special
hi link SpecialChar    Special
hi link Delimiter      Special
hi link SpecialComment Special
hi link Debug	       Special
" }}}
" vim: fdm=marker:
