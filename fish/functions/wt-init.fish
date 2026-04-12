function wt-init --description "Initialize a new git worktree repo"
    if test (count $argv) -lt 2
        echo "Usage: wt-init <org> <repo> [--personal]"
        return 1
    end

    set org $argv[1]
    set repo $argv[2]
    set root (pwd)/$repo
    set ssh_host github-work

    if contains -- --personal $argv
        set ssh_host github-personal
    end

    mkdir -p $root
    cd $root

    git clone --bare git@$ssh_host:$org/$repo.git .bare
    if test $status -ne 0
        echo "Error: failed to clone $org/$repo"
        cd ..
        rm -rf $root
        return 1
    end

    # Fix remote tracking refs
    git -C .bare fetch origin

    echo "gitdir: ./.bare" >.git

    # Fix missing fetch refspec
    git config --file $dir/.bare/config remote.origin.fetch "+refs/heads/*:refs/remotes/origin/*"

    # cd $dir
    git fetch --all
    echo "✓ Bare repo initialized at $dir"
    echo "  → add your .env then run: wt-add dev --env"
end
