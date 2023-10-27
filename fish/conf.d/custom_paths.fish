set -gx PATH bin $PATH
set -gx PATH ~/bin $PATH
set -gx PATH ~/.local/bin $PATH
if command -q brew
set -xg LIBRARY_PATH $LIBRARY_PATH (brew --prefix)/lib
end
