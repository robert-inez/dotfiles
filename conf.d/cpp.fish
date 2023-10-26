if command -q brew
  set -xg CPLUS_INCLUDE_PATH $CPLUS_INCLUDE_PATH (brew --prefix)/include
end
