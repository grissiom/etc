switch $USER
case root
	if set -q fish_color_cwd_root
		set -g __fish_prompt_cwd_color (set_color $fish_color_cwd_root)
	else
		set -g __fish_prompt_cwd_color (set_color $fish_color_cwd)
	end
case '*'
	set -g __fish_prompt_cwd_color (set_color $fish_color_cwd)
end

set -g __fish_prompt_pwd_str (prompt_pwd)
set -g __fish_prompt_hostname (hostname|cut -d . -f 1)
set -g __fish_prompt_normal (set_color normal)
set -g __fish_prompt_git (set_color green)
set -g __fish_prompt_jobs (set_color yellow)

