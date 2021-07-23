# don't know why varibles doesn't work in PS1...
green='\e[0;32;1m'
ps1_green='\[\e[1;32m\]'
ps1_red='\[\e[1;31m\]'
ps1_yellow='\[\e[1;33m\]'
ps1_user='\[\e[43;30m\]'
ps1_nc='\[\e[0m\]'

GIT_PS1='$(__git_ps1 "(git:%s)")'
DATE_PS1='$(date +"%-x %A %R")'

export PS1="\n        ${ps1_user}\u${ps1_nc}@\h: ${ps1_red}${DATE_PS1} ${ps1_green}${GIT_PS1}${ps1_nc}\n
${ps1_yellow}\w${ps1_nc}\$ "
