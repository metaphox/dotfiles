#!/bin/sh

FORMULAE=$(cat << 'EOF'
# Daily Tools
coreutils
neovim
fzf
zoxide
git
jq
go
ripgrep
fd
tig
mole
bat
glow
duckdb
luajit
pandoc
task
uv
btop

# Neovim Dependencies
tree-sitter-cli
EOF)

EXTRA=$(cat << 'EOF'
ffmpeg
EOF)

CASK=$(cat << 'EOF'
visual-studio-code
EOF)

brew update
brew upgrade

echo "$FORMULAE" | grep -v '^\s*#' | grep -v '^\s*$' | while IFS= read -r f; do
	brew install "$f"
done

echo "$CASK" | grep -v '^\s*#' | grep -v '^\s*$' | while IFS= read -r f; do
	brew install --cask "$f"
done
