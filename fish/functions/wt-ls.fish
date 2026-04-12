function wt-ls --description "List git worktrees for current repo"
    # Infer repo root from current directory
    if test -d (pwd)/.bare
        set root (pwd)
    else if test -d (pwd)/../.bare
        set root (pwd)/..
    else
        echo "Error: not in a worktree repo — cd into your repo directory first"
        return 1
    end

    git -C $root/.bare worktree list
end
