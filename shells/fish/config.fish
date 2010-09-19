function __update_promt_git
	set -g __pmt_git_str (prompt_git)
end

function __update_promt_pwd
	set -g __pmt_pwd_str (prompt_pwd)
end

function git
	command git $argv
	__update_promt_git
end

function cd
	set cd_status 0
	## copied and modified from share/fish/functions/cd.fish
	## we don't have function chaining features yet...
	# Skip history in subshells
	if status --is-command-substitution
		builtin cd $argv
		set cd_status $status
	else; if [ $argv[1] = - ] ^/dev/null
		if [ "$__fish_cd_direction" = next ] ^/dev/null
			nextd
		else
			prevd
		end
		set cd_status $status
	else
		# Avoid set completions
		set -l previous $PWD

		builtin cd $argv[1]
		set cd_status $status

		if [ $cd_status = 0 -a "$PWD" != "$previous" ]
			set -g dirprev $dirprev $previous
			set -e dirnext
			set -g __fish_cd_direction prev
		end
	end; end

	if [ $cd_status = 0 ]
		__update_promt_pwd
		__update_promt_git
	end
	return $cd_status
end

switch $USER
case root
	if set -q fish_color_cwd_root
		set -g __pmt_pwd_cl (set_color $fish_color_cwd_root)
	else
		set -g __pmt_pwd_cl (set_color $fish_color_cwd)
	end
case '*'
	set -g __pmt_pwd_cl (set_color $fish_color_cwd)
end

set -g __pmt_hostname (hostname|cut -d . -f 1)
set -g __pmt_pwd_str (prompt_pwd)
set -g __pmt_git_str (prompt_git)

set -g __pmt_user_cl (set_color cyan)
set -g __pmt_git_cl (set_color green)
set -g __pmt_jobs_cl (set_color yellow)
set -g __pmt_normal (set_color normal)
