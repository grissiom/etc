" Vim syntax file
" Language:         Zsh shell script
" Maintainer:       Nikolai Weibull <now@bitwi.se>
" Latest Revision:  2008-07-17
" Modified by Grissiom

if exists("b:current_syntax")
  finish
endif

let s:cpo_save = &cpo
set cpo&vim

setlocal iskeyword+=-

syn keyword zshTodo             contained TODO FIXME XXX NOTE

syn region  zshComment          oneline start='\%(^\|\s\)#' end='$'
                                \ contains=zshTodo,@Spell

syn match   zshPreProc          '^\%1l#\%(!\|compdef\|autoload\).*$'

syn match   zshQuoted           '\\.'
syn region  zshString           matchgroup=zshStringDelimiter start=+"+ end=+"+
                                \ contains=zshQuoted,@zshDerefs,@zshSubst
syn region  zshString           matchgroup=zshStringDelimiter start=+'+ end=+'+
" XXX: This should probably be more precise, but Zsh seems a bit confused about it itself
syn region  zshPOSIXString      matchgroup=zshStringDelimiter start=+\$'+
                                \ end=+'+ contains=zshQuoted
syn match   zshJobSpec          '%\(\d\+\|?\=\w\+\|[%+-]\)'

syn keyword zshPrecommand       noglob nocorrect exec command builtin - time

syn keyword zshDelimiter        do done

syn keyword zshConditional      if then elif else fi case in esac select

syn keyword zshRepeat           while until repeat

syn keyword zshRepeat           for foreach nextgroup=zshVariable skipwhite

syn keyword zshException        always

syn keyword zshKeyword          function nextgroup=zshKSHFunction skipwhite

syn match   zshKSHFunction      contained '\k\+'
syn match   zshFunction         '^\s*\k\+\ze\s*()'

syn match   zshOperator         '||\|&&\|;\|&!\='

syn match   zshTestOper1        contained '=\|\(!=\)'
syn keyword zshTestOper1        contained -n -z
			        \ -eq -ge -gt -le -lt -ne
                                \ -ef -nt -ot -b -c -d -e -f -g -G -h -k -L -O -p -r -s -S -t -u -w -x
syn match   zshTestExp1         contained ' ! '
syn keyword zshTestExp1         contained -a -o
syn region  zshTest             matchgroup=zshTestDeli start='\[' skip='\\\\\|\\$\|\\\]' end='\]' 
			        \ contains=@zshSubst,@zshDerefs,zshTestOper1,zshTestExp1,zshString,zshNumber

syn match   zshTestOper2        contained '\(=\~\)\|\(==\)\|\(!=\)\|<\|>\|='
syn keyword zshTestOper2        contained
                                \ -a -b -c -d -e -f -g -h -k -n -o -p -r -s -t -u -w -x -z -L -O -G -S -N
			        \ -nt -ot -ef
                                \ -eq -ne -ge -gt -le -lt
syn match   zshTestExp2         contained '&&\|||\| ! \|(\|)'
syn region  zshTest2            matchgroup=zshTestDeli start='\[\[' skip='\\\\\|\\$' end='\]\]' 
			        \ contains=@zshSubst,@zshDerefs,zshString,zshNumber,zshTestOper2,zshTestExp2

hi link zshTestOper1 zshTestOper
hi link zshTestOper2 zshTestOper
hi link zshTestExp1 zshTestExp
hi link zshTestExp2 zshTestExp

syn match   zshRedir            '\d\=\(<\|<>\|<<<\|<&\s*[0-9p-]\=\)'
syn match   zshRedir            '\d\=\(>\|>>\|>&\s*[0-9p-]\=\|&>\|>>&\|&>>\)[|!]\='
syn match   zshRedir            '|&\='

syn region  zshHereDoc          matchgroup=zshRedir
                                \ start='<\@<!<<\s*\z([^<]\S*\)'
                                \ end='^\z1\>'
                                \ contains=@zshSubst
syn region  zshHereDoc          matchgroup=zshRedir
                                \ start='<\@<!<<\s*\\\z(\S\+\)'
                                \ end='^\z1\>'
                                \ contains=@zshSubst
syn region  zshHereDoc          matchgroup=zshRedir
                                \ start='<\@<!<<-\s*\\\=\z(\S\+\)'
                                \ end='^\s*\z1\>'
                                \ contains=@zshSubst
syn region  zshHereDoc          matchgroup=zshRedir
                                \ start=+<\@<!<<\s*\(["']\)\z(\S\+\)\1+ 
                                \ end='^\z1\>'
syn region  zshHereDoc          matchgroup=zshRedir
                                \ start=+<\@<!<<-\s*\(["']\)\z(\S\+\)\1+
                                \ end='^\s*\z1\>'

syn match   zshVariable         '\<\h\w*' contained

syn match   zshVariableDef      '\<\h\w*\ze+\=='
" XXX: how safe is this?
syn region  zshVariableDef      oneline
                                \ start='\$\@<!\<\h\w*\[' end='\]\ze+\=='
                                \ contains=@zshSubst

syn cluster zshDerefs           contains=zshShortDeref,zshLongDeref,zshDeref

if !exists("g:zsh_syntax_variables")
  let s:zsh_syntax_variables = 'all'
else
  let s:zsh_syntax_variables = g:zsh_syntax_variables
endif

if s:zsh_syntax_variables =~ 'short\|all'
  syn match zshShortDeref       '\$[!#$*@?_-]\w\@!'
  syn match zshShortDeref       '\$[=^~]*[#+]*\d\+\>'
endif

if s:zsh_syntax_variables =~ 'long\|all'
  syn match zshLongDeref        '\$\%(ARGC\|argv\|status\|pipestatus\|CPUTYPE\|EGID\|EUID\|ERRNO\|GID\|HOST\|LINENO\|LOGNAME\)'
  syn match zshLongDeref        '\$\%(MACHTYPE\|OLDPWD OPTARG\|OPTIND\|OSTYPE\|PPID\|PWD\|RANDOM\|SECONDS\|SHLVL\|signals\)'
  syn match zshLongDeref        '\$\%(TRY_BLOCK_ERROR\|TTY\|TTYIDLE\|UID\|USERNAME\|VENDOR\|ZSH_NAME\|ZSH_VERSION\|REPLY\|reply\|TERM\)'
endif

if s:zsh_syntax_variables =~ 'all'
  syn match zshDeref            '\$[=^~]*[#+]*\h\w*\>'
else
  syn match zshDeref            transparent contains=NONE '\$[=^~]*[#+]*\h\w*\>'
endif

syn match   zshCommands         '\%(^\|\s\)[.:]\ze\s'
syn keyword zshCommands         alias autoload bg bindkey break bye cap cd
                                \ chdir clone comparguments compcall compctl
                                \ compdescribe compfiles compgroups compquote
                                \ comptags comptry compvalues continue dirs
                                \ disable disown echo echotc echoti emulate
                                \ enable eval exec exit export false fc fg
                                \ functions getcap getln getopts hash history
                                \ jobs kill let limit log logout popd print
                                \ printf pushd pushln pwd r read readonly
                                \ rehash return sched set setcap setopt shift
                                \ source stat suspend test times trap true
                                \ ttyctl type ulimit umask unalias unfunction
                                \ unhash unlimit unset unsetopt vared wait
                                \ whence where which zcompile zformat zftp zle
                                \ zmodload zparseopts zprof zpty zregexparse
                                \ zsocket zstyle ztcp

syn keyword zshTypes            float integer local typeset declare

" XXX: this may be too much
" syn match   zshSwitches         '\s\zs--\=[a-zA-Z0-9-]\+'

syn match   zshNumber           '[+-]\=\<\d\+\>'
syn match   zshNumber           '[+-]\=\<0x\x\+\>'
syn match   zshNumber           '[+-]\=\<0\o\+\>'
syn match   zshNumber           '[+-]\=\d\+#[-+]\=\w\+\>'
syn match   zshNumber           '[+-]\=\d\+\.\d\+\>'

" TODO: $[...] is the same as $((...)), so add that as well.
syn cluster zshSubst            contains=zshSubst,zshOldSubst,zshMathSubst
syn region  zshSubst            matchgroup=zshSubstDelim transparent
                                \ start='\$(' skip='\\)' end=')' contains=TOP
syn region  zshParentheses      transparent start='(' skip='\\)' end=')'
syn region  zshMathSubst        matchgroup=zshSubstDelim transparent
                                \ start='\$((' skip='\\)'
                                \ matchgroup=zshSubstDelim end='))'
                                \ contains=zshParentheses,@zshSubst,zshNumber,
                                \ @zshDerefs,zshString
syn region  zshBrackets         contained transparent start='{' skip='\\}'
                                \ end='}'
syn region  zshSubst            matchgroup=zshSubstDelim start='\${' skip='\\}'
                                \ end='}' contains=@zshSubst,zshBrackets,zshQuoted,zshString
syn region  zshOldSubst         matchgroup=zshSubstDelim start=+`+ skip=+\\`+
                                \ end=+`+ contains=TOP,zshOldSubst

syn sync    minlines=50
syn sync    match zshHereDocSync    grouphere   NONE '<<-\=\s*\%(\\\=\S\+\|\(["']\)\S\+\1\)'
syn sync    match zshHereDocEndSync groupthere  NONE '^\s*EO\a\+\>'

hi def link zshTodo             Todo
hi def link zshComment          Comment
hi def link zshPreProc          PreProc
hi def link zshQuoted           SpecialChar
hi def link zshString           String
hi def link zshStringDelimiter  zshString
hi def link zshPOSIXString      zshString
hi def link zshJobSpec          Special
hi def link zshPrecommand       Special
hi def link zshDelimiter        Keyword
hi def link zshTestOper         Keyword
hi def link zshConditional      Conditional
hi def link zshException        Exception
hi def link zshRepeat           Repeat
hi def link zshKeyword          Keyword
hi def link zshFunction         Function
hi def link zshKSHFunction      zshFunction
hi def link zshHereDoc          String
hi def link zshOperator         Operator
hi def link zshTestExp          Operator
hi def link zshTestDeli         Operator
hi def link zshRedir            Operator
hi def link zshVariable         None
hi def link zshVariableDef      zshVariable
hi def link zshDereferencing    PreProc
if s:zsh_syntax_variables =~ 'short\|all'
  hi def link zshShortDeref     zshDereferencing
else
  hi def link zshShortDeref     None
endif
if s:zsh_syntax_variables =~ 'long\|all'
  hi def link zshLongDeref      zshDereferencing
else
  hi def link zshLongDeref      None
endif
if s:zsh_syntax_variables =~ 'all'
  hi def link zshDeref          zshDereferencing
else
  hi def link zshDeref          None
endif
hi def link zshCommands         Keyword
hi def link zshTypes            Type
hi def link zshSwitches         Special
hi def link zshNumber           Number
hi def link zshSubst            PreProc
hi def link zshMathSubst        zshSubst
hi def link zshOldSubst         zshSubst
hi def link zshSubstDelim       zshSubst

let b:current_syntax = "zsh"

let &cpo = s:cpo_save
unlet s:cpo_save
