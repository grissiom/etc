" Vim color file
"
" Name:       dark_light256.vim
" Version:    1.0
" Maintainer:	Grissiom <chaos.proton@gmail.com>
"
" Insipred by elflord and xoria256.
" Should work in recent 256 color terminals.  88-color terms like urxvt are
" unsupported.
"
" Don't forget to install 'ncurses-term' and set TERM to xterm-256color or
" similar value.
"
" Color numbers (0-255) see:
" http://www.calmar.ws/vim/256-xterm-24bit-rgb-color-chart.html

if &t_Co != 256
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

hi Normal       ctermfg=250    ctermbg=0    cterm=none
"" Syntax highlighting
hi Comment      ctermfg=31
hi Constant     ctermfg=131
hi Number       ctermfg=68
hi Identifier   ctermfg=182
hi Operator	ctermfg=178
hi Statement    ctermfg=111
hi Special	ctermfg=5
hi Function	ctermfg=32              cterm=bold
hi PreProc      ctermfg=150
hi Type         ctermfg=34
hi Special      ctermfg=171
hi Ignore       ctermfg=238
hi Error        ctermfg=196  ctermbg=52   cterm=bold
hi Todo         ctermfg=0    ctermbg=184

"" Diff
" TODO
hi DiffAdded    ctermfg=34
hi DiffRemoved  ctermfg=160
hi DiffChange                ctermbg=52
hi DiffDelete                ctermbg=240
hi DiffText     ctermfg=254  ctermbg=160

"" Spell
hi SpellBad     ctermfg=196  ctermbg=52  cterm=undercurl
hi SpellCap     ctermfg=196  ctermbg=bg  cterm=undercurl
hi SpellRare    ctermfg=fg   ctermbg=52  cterm=undercurl

""UI.
"Don't let the UI catch your eyes more than your code.
hi LineNr       ctermfg=94
hi MatchParen                ctermbg=238  cterm=underline
hi Visual                    ctermbg=237
hi IncSearch    ctermfg=fg   ctermbg=8
hi Search       ctermfg=fg   ctermbg=8

" I link in this way because I think the folded text is something that "When
" you want to ignore them, you won't see them, but when you want out, they can
" easily catch your eyes.". I think and hope the Comment is the same thing.
hi! link Folded Comment
hi FoldColumn   ctermfg=240  ctermbg=bg   cterm=bold

hi Pmenu        ctermfg=0    ctermbg=28
hi PmenuSel     ctermfg=0    ctermbg=34

hi TabLine      ctermfg=246  ctermbg=236  cterm=bold
hi TabLineFill  ctermfg=236  ctermbg=236
hi TabLineSel   ctermfg=254  ctermbg=bg
hi StatusLine                ctermbg=236

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
