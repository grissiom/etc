" local syntax file - set colors on a per-machine basis:
" vim: tw=0 ts=4 sw=4
" Vim color file
" Original Creator:	Ron Aaron <ron@ronware.org>
" Maintainer: Grissiom <chaos.proton@gmail.com>
" Last Change:	2009 Jan 30

set background=dark
hi clear
if exists("syntax_on")
  syntax reset
endif
let g:colors_name = "elflord2"
hi Normal       ctermbg=Black ctermfg=Gray
hi Comment		ctermfg=DarkCyan
hi Constant		ctermfg=Magenta
hi Special		ctermfg=DarkMagenta
hi Identifier   cterm=bold	ctermfg=Cyan
hi Statement    cterm=bold	ctermfg=DarkYellow
hi PreProc		ctermfg=LightBlue
hi Type	        ctermfg=LightGreen
hi Function	    cterm=bold ctermfg=LightBlue
hi Repeat		ctermfg=White
hi Operator		ctermfg=Red
hi Ignore		ctermfg=black
hi Error        ctermbg=Red ctermfg=White
hi Todo         ctermbg=Yellow ctermfg=Black guifg=Blue guibg=Yellow

" Common groups that link to default highlighting.
" You can specify other highlighting easily.
hi link String   	     Constant
hi link Character	     Constant
hi link Number	         Constant
hi link Boolean	         Constant
hi link Float		     Number
hi link Conditional	     Repeat
hi link Label		     Statement
hi link Keyword	         Statement
hi link Exception	     Statement
hi link Include	         PreProc
hi link Define	         PreProc
hi link Macro		     PreProc
hi link PreCondit	     PreProc
hi link StorageClass	 Type
hi link Structure	     Type
hi link Typedef	         Type
hi link Tag		         Special
hi link SpecialChar	     Special
hi link Delimiter	     Special
hi link SpecialComment   Special
hi link Debug		     Special

" configure the UI. Don't let the UI catch your eyes more than your code.
hi LineNr     ctermfg=DarkYellow
hi MatchParen cterm=underline ctermbg=Black

" I link in this way because I think the folded text is something that "When
" you want to ignore them, you won't see them, but when you want out, they can
" easily catch your eyes.". I think and hope the Comment is the same thing.
hi! link Folded Comment
hi FoldColumn   ctermfg=DarkGray

hi Pmenu    ctermbg=Green     ctermfg=Black
hi PmenuSel ctermbg=LightGray ctermfg=Black

hi TabLine cterm=bold ctermbg=LightGray ctermfg=white
hi TabLineFill        ctermbg=LightGray
hi TabLineSel         ctermbg=black     ctermfg=white
