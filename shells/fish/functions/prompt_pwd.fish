function prompt_pwd --description "Print the current working directory, shortend to fit the prompt"
	switch "$PWD"
	case "$HOME"
		echo '~'
	case '*'
		set -l LPWD (echo $PWD | sed -e "s|$HOME|~|")
		set pwd_l (expr length $LPWD)
		if test $pwd_l -gt 35
			echo $LPWD | sed -e 's/.\{'(math $pwd_l - 32)'\}/\.\.\./'
		else
			echo $LPWD
		end
	end
end
