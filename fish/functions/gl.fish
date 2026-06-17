function gl --wraps='git log --graph --decorate --pretty=oneline --abbrev-commit --color' --wraps='git log --graph --decorate --abbrev-commit --color --pretty=format:"%C(yellow)%h %C(cyan)%an %C(reset)%s %C(auto)%d"' --description 'alias gl=git log --graph --decorate --abbrev-commit --color --pretty=format:"%C(yellow)%h %C(cyan)%an %C(reset)%s %C(auto)%d"'
    git log --graph --decorate --abbrev-commit --color --pretty=format:"%C(yellow)%h %C(cyan)%an %C(reset)%s %C(auto)%d" $argv
end
