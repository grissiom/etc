## Git PS1 prompt ##

function __fish_git_in_working_tree
  git rev-parse --is-inside-work-tree ^ /dev/null > /dev/null
end

function __fish_git_dirty
  begin
    not git diff --no-ext-diff --quiet --exit-code
    or not git diff-index --cached --quiet HEAD
    or count (git ls-files --others --exclude-standard)
  end ^ /dev/null > /dev/null
end

function __fish_git_current_head
  git symbolic-ref HEAD ^ /dev/null
  or git describe --contains --all HEAD
end

function __fish_git_current_branch
  __fish_git_current_head #| sed -e "s#^refs/heads/##"
end

function prompt_git
  if __fish_git_in_working_tree
    #if __fish_git_dirty
      #set_color red
    #else
      #set_color green
    #end
    echo (__fish_git_current_branch)
  end
end
