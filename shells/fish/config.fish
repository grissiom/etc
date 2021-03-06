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

functions -c cd __cd

function cd
	__cd $argv
	set cd_status $status
	if test $cd_status = 0
		__update_promt_pwd
		__update_promt_git
	end
	return $cd_status
end

function wget
	set -e LC_ALL
	command wget $argv
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
set -g __pmt_status_cl (set_color red)
set -g __pmt_normal (set_color normal)

if test -r ~/.config/fish/config.local
	. ~/.config/fish/config.local
end
