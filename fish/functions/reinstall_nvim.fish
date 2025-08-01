function reinstall_nvim
    # Fetch the latest release version
    set nvim_version (curl -s https://api.github.com/repos/neovim/neovim/releases/latest | jq -r .tag_name)
    echo "Fetched version: $nvim_version"

    # Construct the tarball URL using the version tag
    set tarball_url "https://github.com/neovim/neovim/releases/download/$nvim_version/nvim-linux-x86_64.tar.gz"
    echo "Tarball URL: $tarball_url"

    # Download the tarball
    echo "📦 Downloading Neovim $nvim_version tarball..."
    curl -LO "$tarball_url"

    # Verify if the tarball is downloaded
    if not test -f "nvim-linux-x86_64.tar.gz"
        echo "❌ Failed to download the tarball. Aborting."
        return 1
    end

    # Remove old Neovim installation (if exists)
    echo "🧹 Removing old Neovim installation..."
    sudo rm -rf /opt/nvim

    # Extract the tarball to /opt
    echo "📂 Extracting Neovim $nvim_version tarball..."
    sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz

    # Rename the extracted folder
    echo "📁 Renaming folder to /opt/nvim..."
    sudo mv /opt/nvim-linux-x86_64 /opt/nvim

    # Clean up the tarball file
    echo "🧼 Cleaning up the tarball..."
    sudo rm nvim-linux-x86_64.tar.gz

    echo "✅ Neovim $nvim_version has been installed successfully!"
end
