function ghpr --description "Create a PR with team reviewers"
    set --local base dev
    set --local reviewers $SPARQTUBE_REVIEWERS # default team

    # allow overriding reviewer group
    if contains -- --team $argv
        set --local team_index (contains --index -- --team $argv)
        set --local team_name $argv[(math $team_index + 1)]
        switch $team_name
            case sparq_tube
                set reviewers $SPARQTUBE_REVIEWERS
            case other
                set reviewers $OTHER_TEAM_REVIEWERS
        end
        # remove --team and team_name from argv before passing to gh
        set --erase argv[$team_index]
        set --erase argv[$team_index] # index shifts after first erase
    end

    if contains -- --base $argv
        gh pr create \
            --reviewer $reviewers \
            --assignee @me \
            $argv
    else
        gh pr create \
            --base $base \
            --reviewer $reviewers \
            --assignee @me \
            $argv
    end
end
