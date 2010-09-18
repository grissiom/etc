# Set the default prompt command. Make sure that every terminal escape
# string has a newline before and after, so that fish will know how
# long it is.

function -v PWD __update_promt_pwd
	set -g __fish_prompt_pwd_str (prompt_pwd)
end

function fish_prompt --description "Write out the prompt"
	set ost $status
	if [ $ost -ne 0 ]
		set -g __fish_prompt_status_str (set_color red)'(status '$ost')'(set_color normal)
	else
		set -g __fish_prompt_status_str
	end
	# user @ host
	printf '\n\t%s@%s%s' $USER $__fish_prompt_hostname "$__fish_prompt_normal"
	# git
	printf '  %s%s%s' "$__fish_prompt_git" (prompt_git) "$__fish_prompt_normal"
	# jobs
	printf '  %s(jobs:%2s)%s' "$__fish_prompt_jobs" (count (jobs -c)) "$__fish_prompt_normal"
	# return code
	printf '  %s' "$__fish_prompt_status_str"
	# pwd
	printf '\n%s%s%s> ' "$__fish_prompt_cwd_color" $__fish_prompt_pwd_str "$__fish_prompt_normal"
end

