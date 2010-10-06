# Set the default prompt command. Make sure that every terminal escape
# string has a newline before and after, so that fish will know how
# long it is.

# The bottleneck and tricks
#   BN: the most time consuming function seems to be prompt_git
#   TK: call it only when change working dir or invoke git command
#   BN: printf would consume some time
#   TK: save promt string in __promt var and call printf only once
# Most of the tricks break promt code into parts. Some are here and some are in
# ~/.config/fish/config.fish. It is dirty but no other solution yet...
function fish_prompt --description "Write out the prompt"
	set ost $status
	set -l __promt
	set -l __pmt_status_str
	if test $ost -ne 0
		set __pmt_status_str "$__pmt_status_cl(status: $ost)$__pmt_normal"
	else
		set __pmt_status_str
	end
	# user @ host
	set __promt "\n\t$__pmt_user_cl$USER@$__pmt_hostname$__pmt_normal"
	# git
	set __promt {$__promt}"  $__pmt_git_cl$__pmt_git_str$__pmt_normal"
	# jobs
	set jobn (count (jobs -c))
	if test $jobn -gt 0
		set __promt {$__promt}"  $__pmt_jobs_cl(jobs: $jobn)$__pmt_normal"
	end
	# return code
	set __promt {$__promt}"  $__pmt_status_str"
	# pwd
	set __promt {$__promt}"\n$__pmt_pwd_cl$__pmt_pwd_str>$__pmt_normal "
	printf $__promt
end
