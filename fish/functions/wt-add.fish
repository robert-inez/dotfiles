function wt-add --description "Add a new git worktree"
    # Validate args
    if test (count $argv) -lt 1
        echo "Usage: wt-add <branch> [--env] [--base <branch>]"
        return 1
    end

    set branch $argv[1]
    set base dev
    set use_env false

    # Parse flags
    set i 2
    while test $i -le (count $argv)
        switch $argv[$i]
            case --env
                set use_env true
            case --base
                set i (math $i + 1)
                if test $i -le (count $argv)
                    set base $argv[$i]
                else
                    echo "Error: --base requires a branch name"
                    return 1
                end
            case '*'
                echo "Error: unknown flag '$argv[$i]'"
                return 1
        end
        set i (math $i + 1)
    end

    # Infer repo root from current directory
    if test -d (pwd)/.bare
        # We are at the container level
        set root (pwd)
    else if test -d (pwd)/../.bare
        # We are inside a worktree, walk up
        set root (pwd)/..
    else
        echo "Error: not in a worktree repo — cd into your repo directory first"
        return 1
    end

    # Check if branch exists on remote
    if git -C $root/.bare ls-remote --heads origin $branch | grep -q "refs/heads/$branch"'$'
        echo "Found existing remote branch '$branch' — checking out"
        git -C $root/.bare worktree add $root/$branch $branch
    else
        echo "No remote branch found — creating '$branch' off '$base'"
        git -C $root/.bare worktree add $root/$branch -b $branch $base
    end

    if test $status -ne 0
        echo "Error: failed to create worktree"
        return 1
    end

    # Handle --env flag
    if test $use_env = true
        if test -f $root/.env
            ln -s $root/.env $root/$branch/.env
            echo "✓ .env symlinked"
        else
            echo "Warning: no .env found at $root/.env — skipping symlink"
        end
    end

    echo "✓ worktree '$branch' ready at $root/$branch"
end
