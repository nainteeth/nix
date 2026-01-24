# NixOS Configuration with Hyprland and Doom Emacs

This repository contains my NixOS configuration using Hyprland, `mkOutOfStoreSymlinks`, and Doom Emacs.

## Setup Instructions

1. Clone the repository:
    ```bash
    git clone https://github.com/nainteeth/nix
    cd nix
    ```

2. Build and switch to the NixOS configuration:
    ```bash
    sudo nixos-rebuild switch --flake .#laptop # or use desktop
    ```

3. Reboot the system:
    ```bash
    systemctl reboot
    ```

## Configure GitHub SSH Access

1. Generate a new SSH key for GitHub:
    ```bash
    ssh-keygen -t ed25519 -C "CHANGEME@PLEASE.com" -f ~/.ssh/github
    ```

2. Display the public key:
    ```bash
    cat ~/.ssh/github.pub
    ```

3. Copy the public key and add it to your GitHub account under SSH keys.

4. Update the repository origin to use SSH:
    ```bash
    git remote set-url origin git@github.com:nainteeth/nix.git
    ```

5. If Git does not work immediately, reboot the system.

## Installing Doom Emacs

1. Remove any existing `.emacs.d` directory:
    ```bash
    rm -rf ~/.emacs.d
    ```

2. Clone the Doom Emacs repository:
    ```bash
    git clone --depth 1 https://github.com/doomemacs/doomemacs ~/.emacs.d
    ```

3. Install Doom Emacs:
    ```bash
    ~/.emacs.d/bin/doom install
    ```

4. Rebuild Doom Emacs periodically:
    ```bash
    doom sync
    ```
