function prompt_pwd --description "Print the current working directory, shortend to fit the prompt"
	switch "$PWD"
		case "$HOME"
		echo '~'

		case '*'
		set pwd_l (expr length $PWD)
		if [ $pwd_l -gt 35 ]
			echo $PWD | sed -e 's/.\{'(math $pwd_l - 32)'\}/\.\.\./'
		else
			echo $PWD
		end
	end
end
