function wt-rm --description "Remove a git worktree"
    # Validate args
    if test (count $argv) -lt 1
        echo "Usage: wt-rm <branch>"
        return 1
    end

    set branch $argv[1]

    # Infer repo root from current directory
    if test -d (pwd)/.bare
        set root (pwd)
    else if test -d (pwd)/../.bare
        set root (pwd)/..
    else
        echo "Error: not in a worktree repo — cd into your repo directory first"
        return 1
    end

    # Validate worktree exists
    if not test -d $root/$branch
        echo "Error: worktree '$branch' not found at $root/$branch"
        return 1
    end

    # Remove the worktree
    git -C $root/.bare worktree remove $root/$branch
    if test $status -ne 0
        # Force remove if it has uncommitted changes
        echo "Worktree has uncommitted changes — force removing"
        git -C $root/.bare worktree remove --force $root/$branch
        if test $status -ne 0
            echo "Error: failed to remove worktree"
            return 1
        end
    end

    # Prune stale refs
    git -C $root/.bare worktree prune

    # Clean up directory if still present
    if test -d $root/$branch
        rm -rf $root/$branch
        echo "✓ directory cleaned up"
    end

    echo "✓ worktree '$branch' removed"
end
