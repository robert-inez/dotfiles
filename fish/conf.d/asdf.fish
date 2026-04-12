# ASDF configuration for Fish shell

if test -z "$ASDF_DATA_DIR"
    set _asdf_dir "$HOME/.asdf"
else
    set _asdf_dir "$ASDF_DATA_DIR"
end

# Add asdf bin + shims to PATH (in correct order)
if not contains "$_asdf_dir/bin" $PATH
    set -gx PATH "$_asdf_dir/bin" $PATH
end

if not contains "$_asdf_dir/shims" $PATH
    set -gx PATH "$_asdf_dir/shims" $PATH
end

set --erase _asdf_dir
