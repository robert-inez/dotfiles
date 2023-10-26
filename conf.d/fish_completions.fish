if command -q brew
    set -gx fish_complete_path (brew --prefix)/share/fish/completions
end
