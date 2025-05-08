# ASDF configuration for Fish shell

# Set PATH for asdf shims
if test -z "$ASDF_DATA_DIR"
    set _asdf_shims "$HOME/.asdf/shims"
else
    set _asdf_shims "$ASDF_DATA_DIR/shims"
end

# Ensure shims are in PATH
if not contains $_asdf_shims $PATH
    set -gx PATH $_asdf_shims $PATH
end

# Add /usr/local/bin to PATH (optional, if you actually need it)
set -gx PATH /usr/local/bin $PATH

# Actually source asdf's script
if test -f "$HOME/.asdf/asdf.fish"
    source "$HOME/.asdf/asdf.fish"
end

# Clean up temporary variables
set --erase _asdf_shims
