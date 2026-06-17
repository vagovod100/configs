function gs --wraps='git status --short --branch' --description 'alias gs=git status --short --branch'
    git status --short --branch $argv
end
