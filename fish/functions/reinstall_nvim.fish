function reinstall_nvim
    echo "📦 Downloading the latest Neovim..."
    curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz

    echo "🧹 Removing old Neovim installation..."
    sudo rm -rf /opt/nvim

    echo "📂 Extracting new Neovim version..."
    sudo tar -C /opt -xzf nvim-linux64.tar.gz

    echo "📁 Renaming folder to /opt/nvim..."
    sudo mv /opt/nvim-linux64 /opt/nvim

    echo "🧼 Cleaning up archive..."
    rm nvim-linux64.tar.gz

    echo "✅ Neovim has been reinstalled successfully!"
end
