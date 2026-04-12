function wt-repair
    # Run from anywhere inside the worktree project
    set bare (git rev-parse --git-common-dir)

    git config --file $bare/config remote.origin.fetch "+refs/heads/*:refs/remotes/origin/*"
    git fetch --all
    echo "✓ Repaired fetch refspec in $bare"
end
